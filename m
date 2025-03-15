Return-Path: <linux-kernel+bounces-562313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B0A622A5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E1917F637
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA902946C;
	Sat, 15 Mar 2025 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YQrXfnQ8"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649363CB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997834; cv=none; b=KJS2rBlFUCdVy6i1JryECSp5Ial3ipMz3I3XwNcfjb5me0Gw1PitDq5Y9jp/ZBtEujiZKa/NhGBi1JcgkklEJUcQxAEFOseVqqcEpK3IKIUQ5ii6/jIGEf44DzxoDYjj399OwYeGpEuXOp8WrP933zYfd2x3Bb/xsakckqPkRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997834; c=relaxed/simple;
	bh=Oucj8mn9SuivoD33tz/S4ru2IxTCjZYbepFQgVU3QYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Feclvb2b1HlbExcsnCNuH5CRfFtxa8iVuagixltMPIO6ICyrXJRGy47hnoAI0ntI+3RxyekziRS4Ey5Go/hsETjuf7AkL6A0xACk7X6PfyM0BCG8+dpKxXdWyG75TMPInPFAfTDmQdbKElGXK1o2WBphrry7MSxIoZZXiTrr67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YQrXfnQ8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so358113166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741997830; x=1742602630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTXswEN1s8nxLgznB62YLFkIu8PB0+DrF6qSHWwK+Xw=;
        b=YQrXfnQ8KcN/XOH9lAZtgQ7HBP2xvZSK8aVVJdyrlve16qBxg2DWe5rkMmThHXaZyM
         Kj5mdwE6T47PuNFMXC7vmvpLeNPHIxjJl16p1Ukpa1BAtL+qOYSZcJZZDWmREjEPStlW
         /Pv6SJfP4EibdFToJ5iaC1XybyCxbLdBq4bww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741997830; x=1742602630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTXswEN1s8nxLgznB62YLFkIu8PB0+DrF6qSHWwK+Xw=;
        b=fXBJaBdTyGeID6ubx4elikBASJRTwnfaBW+M9vjeDBawJ4cBpdcMcVog/Xd6nqODfh
         iCon91CpMxegswK+i4T7BiIY2F6yNwl8YkVkNf3LiMXcouRPhYn09rb/0xDiQM48ih1s
         AlQQ9aPy/phioyrlwyjEHo7GoxkW2RNcU3FBUw2wpx1VN3hwOn/jFXAl7Q/0Q+ybRw7a
         C8+RwzRRyIdwkteiFULO5Bp4HrioB6vH7k+ygx9zbBMaQUuymVIXSyyTgtBsyMsUYMvZ
         BKlI09qXeuNDF25inkqiBbXNvtdG/UhLvj2i8kmHs+j8xrnRh2l+mrav6dyZC7KUEk4l
         HUjA==
X-Forwarded-Encrypted: i=1; AJvYcCWQigDaK/kkYUXHUnCymeHOb1jrDWNSweDKmzrQ8KnBi1cxM9CB4Uu603WCZw0A74OKmBezAHmsIrRqR0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQ8bPUm5Ikcy6dSHa3ZQUIE2iNUoVIf2Jsvdt/xqKbkvqTFJG
	OI9wsi3uzCA//95Igywuj7h07WCz8vfzxJ91CBFGL4/HqjRFLhrtJp95DNUWXhnNsDT0A3j+JuU
	gdK8=
X-Gm-Gg: ASbGncvyLya6zQ/hNHnPWgtMUzZmCa8/aevS2geMHkQw/KsUuZUuUjQZMfBrNFbCkRC
	vMVr439RLv3P5Z9/qtrrWwa8Qicj6P5bKoqyYYugbU2VjR/VCA7hxD4a99SE1lnzM8tWm+iUurR
	cqbsb6wvcVvjsE+X00A7GACWxLr+9VfSghnT/4k4fEx4wsw1N7gbuFum/UfsLn8ujivVH74ghq4
	+TONwjXqZk3qSSbm++XbugXCZdQ8rrUE+x3jUzKzKHcc+LegqepdAkbxj0/+WDFKaicJBM23dfg
	2v/kWTuZDHUGDkpfh8cTTEFzWGMfXL3tusFlsWoSbztI2wsbM/JcwLD5D15/PKU2MvvCMp5YoX6
	sy3DLEutK5Fq/tROwLG0=
X-Google-Smtp-Source: AGHT+IFMp/O5r56QIuyuerUW5y0gKvZRzeFkWz7rKoTBdQqj/zK4r5Y7tGEQmNIr8c6prV3Nlq5gFw==
X-Received: by 2002:a17:906:7308:b0:ac2:e059:dc03 with SMTP id a640c23a62f3a-ac3303f75d1mr485962266b.38.1741997829946;
        Fri, 14 Mar 2025 17:17:09 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a4a2b3sm291908466b.139.2025.03.14.17.17.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 17:17:08 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so453514266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVblK97WxZsWUiWExjroIfA4vk9QVRQuHxxneSvs7NBg6zO4dODYtNQvNz0JFWp1Q4OMUbjmPuGjLzPMfs=@vger.kernel.org
X-Received: by 2002:a17:907:d92:b0:ac2:a473:416c with SMTP id
 a640c23a62f3a-ac33044eb28mr541321766b.47.1741997827525; Fri, 14 Mar 2025
 17:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com> <jdcd4zoezsi7beoak43dqzkxnel7hqdhtyqbf4cqr6rvs3qfyf@i2qhxrld5p5l>
In-Reply-To: <jdcd4zoezsi7beoak43dqzkxnel7hqdhtyqbf4cqr6rvs3qfyf@i2qhxrld5p5l>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 14:16:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj_F4_uTMQ2w7M7TRJqn9dx+LEifuvkvqd_ODSbMU-U3g@mail.gmail.com>
X-Gm-Features: AQ5f1JqcrMKkhGXhj0GNTbnM5UKcEtmyOEtwaMXZOrhR4bfBVAvFdDAyrYEKv3Q
Message-ID: <CAHk-=wj_F4_uTMQ2w7M7TRJqn9dx+LEifuvkvqd_ODSbMU-U3g@mail.gmail.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit barrier functions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 14:09, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> Thing is, we still have alternative(), which is also an asm wrapper, but
> it's for when the caller doesn't care about adding any constraints.
>
> So the "_io()" distinguishes from that.

.. but I think it does so very badly because "io" really means
something else entirely in absolutely all other contexts.

And it really makes no sense as "io", since it doesn't take inputs and
outputs, it takes inputs, outputs AND CLOBBERS.

So it would make more sense to call it "ioc", but that's just obvious
nonsense, and "ioc" is already taken as a globally recognized
shorthand for "corruption in sports".

So "ioc" is bad too, but that should make you go "Oh, 'io' is _doubly_
nonsensical".

Ergo: I think "asm" would be a better distinguishing marker, withg the
plain "alternative()" being used for particularly simple asms.

              Linus

