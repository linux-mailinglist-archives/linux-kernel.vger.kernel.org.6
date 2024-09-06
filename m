Return-Path: <linux-kernel+bounces-319422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C189C96FC6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED16C1C23F25
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EE1D54FC;
	Fri,  6 Sep 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HPyV9lx4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BC1E86F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652643; cv=none; b=WdpU96FeVOOVHTUeGu842QdQtcUnJhqfg+7gAti9MMcqqz+tnx3dN9qBLSXcQue2oFqAR3mYW7dKxjKtikO7ahx0vodnSyxrHJZlR6hzxT6cdqrgEAJv3KeJklWsGwcJq8sfO2wZXh6YSLl839jnqbi3C2/ouSRk2sv7YMQO3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652643; c=relaxed/simple;
	bh=YE4UCqb5sUF/TvNyfmZoEwImAYjajpYidg3OroDYLHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvl1u+f3eY6FFGPYfT3sRFlmUlluFoZsyVauFmUtqhJrg6+RnMxImh+2/Txy+eUjUbEATCiS7jPJU5kPLUwn4hzf0u8V0fBOx8i0nMd55G6gD0etM3XxPDEbCc+yK7w9c2ULBXozJR/fkJsNc3MzCizBubsJzOoJcKvFBTNM6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HPyV9lx4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8692bbec79so327974166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725652639; x=1726257439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iWQmjvgGehAkfMiXMASjrzXv69auHMxCkzvxZZ2Yp7U=;
        b=HPyV9lx4xtSh9/VdZiANkIHh8IXbrQbyt4RuZWMlK73/uM+5wL5yeGU3XtKMCmPSWq
         hCIlekCtG0oXTMIrD2WbF/2YXCa0i+sefPjTCWkP7nk8TgL5WcKMAhIpXA5j4WU46A3v
         CPDaDelVHSv5fy+2jqN7AYpCBNyyuyNc0IbBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652639; x=1726257439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWQmjvgGehAkfMiXMASjrzXv69auHMxCkzvxZZ2Yp7U=;
        b=aPTcmnlCantQ2Q/Ivw7khYnIEPvhogeK8KBLFk0DQ4a5XRJqSWB51j7Usov/xNUUgj
         eiIhtD8kMesdkNsFuBONghj61wqR287csYQeL02e8GJ8gxW1Z63yQxqPmRm7/EsQJouL
         UaERoLykbDl1nE74ffdvsbzQUCBFWH2xzSHkkuMVH+ooQiqR4mlP8k15UBV0AsAke9bn
         M2vmnChLAO7D/DiGJDKF4xd0ul/CJYUhFexPf5EyOpXsb65pjUGWQbpyhTzZo4Hz/U/p
         TnUUDOuKvCjfFfeKNucpk2yzJWoWQos1IeEvYoRZ6wcykVCgNr191VYwCVE13L9sc6Jq
         fR6w==
X-Forwarded-Encrypted: i=1; AJvYcCUixaMJEfIZZAi2FGrWUEgDvWOs4i9B6Siz7PN7817/naMqzMDYFPCa5aMTdO3PKp5Z0D8NyWO4ji/IjT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQRQ1A9IrXivSbNa+K3qvMTZgD45tuXyyeeuas1JIl6mMZijkv
	vDZxHxy/HFoT1FzDcBvdDH0EaVhgDCccBtPDYuLA9T/lyMCzQhrmzrNuORUwIOZNrXJSF4HagvN
	KgdBYMg==
X-Google-Smtp-Source: AGHT+IErs/+say2l/qTPncMoW8aRBwwHeAv9L3+uk6fwnBlRsoaua5ZqAOXTdAmyL4o2zKDnV/onwg==
X-Received: by 2002:a17:907:930e:b0:a8a:3ece:d073 with SMTP id a640c23a62f3a-a8a885bfdbfmr309337566b.10.1725652639241;
        Fri, 06 Sep 2024 12:57:19 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a8c4cccc6sm131314166b.148.2024.09.06.12.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:57:18 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8692bbec79so327968666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfkcbGkr+SNjev+rkz5GjdF3iYPvRT3IK+YwhQqefSvZc4AbJzBKQSewa24AgzQXoxaiELJNMlLhW0oic=@vger.kernel.org
X-Received: by 2002:a17:906:eec7:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a8a885bfd06mr276682266b.8.1725652638201; Fri, 06 Sep 2024
 12:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ttet3rz9.fsf@mail.lhotse>
In-Reply-To: <87ttet3rz9.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 12:57:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6L6Qb10jVk+eHH2D3oHFathTc2nnZRpKKbqKuO3Rkow@mail.gmail.com>
Message-ID: <CAHk-=wj6L6Qb10jVk+eHH2D3oHFathTc2nnZRpKKbqKuO3Rkow@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-3 tag
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 05:08, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull some more powerpc fixes for 6.11:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-3

Hmm. New pgp key? Please don't take me by surprise like this.

The key looks fine, I see the signature by Stephen Rothwell, but I get
worried when I suddenly see a new signature with no notice and then
have to go looking around for it.

                   Linus

