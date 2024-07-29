Return-Path: <linux-kernel+bounces-266286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1745B93FD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D1BB22423
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFE18734B;
	Mon, 29 Jul 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GbGHhenI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917D8061C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278541; cv=none; b=gi6FIbD9aE72Hl4Gx81ZhzdK3+wm/uv/KtMXtqG7adyh9XEG0iwFPIS4cuxpk+wrxugn4mOvcQfd1J3rqy76z+RawOf0wiLPmZN4KzH9Zo1Oq2A+baNOC+9g/S1gQtjhvA1eyXg1HXCS+9sD3XIUvbma5lCsrBkSgRnK7373xW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278541; c=relaxed/simple;
	bh=unNEJBSNZl8c6hb823gGumAEfjr/onUrnN1stss1aq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUUCfUnNbPweNivoDd+2nQbZo/S4L7Nr4Ng1S74aZd99nlsbOIFn8DTXeAHp2qHHwg52qUFRVwriOPHs5JS8HRES/7OL/btWx5wl1ZmS5ItguHX17KElQa//LiFyPaRWs9ZWbP1DB9GuMhBy5m0Tq4JhxKaS54ElvVnBK0QfCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GbGHhenI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5591216a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722278538; x=1722883338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XDj4us5e5J6V09EbQPW2TDQPIfHZ6uBuhUg+jXxPP+c=;
        b=GbGHhenIVi46QwAlC7kBnr5q5pcpnU8vWJK8jSQjLN7grgmwfDAZR9gQrglm6Q3HfI
         3g1qdZodH+32qdQzoyXy8QGL19YW4qpedU0rdlM4zItm7tyCFXr6TDUDgEVOWg2TWVeT
         ZsgPZHCGQ1ECys0yK71p0tUez0A+7gm+Ethik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278538; x=1722883338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDj4us5e5J6V09EbQPW2TDQPIfHZ6uBuhUg+jXxPP+c=;
        b=WMihkiqzynIz2cAQBO/K/3OOsRH2kYW92Aq6oWewzIfOxNpWtmHt6sIHPGD+f91S2B
         k4b7rpYpDO0R+yGL2glYcwixnZBKqhw92BzigGsOCqrI2RdOW3Xut4EoCJdcQKPo9d/w
         EV+3zaNDKrjwkNapO9KaypsQAkEB/4xzJQIMw5v2PDEz1jdr7pQaw/ODGm5IBc80tgAs
         QK4fCC8A5WilOgtPsmrkcKYwkdUmMDZ8e4C60lo6itQ0mt1qMaRA6AqDYY1uYYrvEW+j
         hqEV5i0xopY5rLvX8FST+rDgYAfv5ELRTyY8QOXFh/iXevpNAxQ89l9v3nnCrlYtWktG
         jttg==
X-Forwarded-Encrypted: i=1; AJvYcCUc7W3EobVFFuD/+PRJRWJ3neIK7fb5hIqGIv1QRJ8pftWbEHJUoNBvp3xJRj184mOqV1sptOzEoa0SCLStXH8NXTE5p4mwootYLiTO
X-Gm-Message-State: AOJu0YzEksSw9cMPvZ89BIJKTi1uj55SXxfyANNq1BxkPs1zod5Shp+5
	hh28MbJi4W08k0r5WuuO6A41cvrTaCDKywme46ve3kegUVRD4HJfl8QjJ2LFRQMGcRW3xnP7wOe
	+wO/Qug==
X-Google-Smtp-Source: AGHT+IFM2nd2hdaK19kJrOAh2oQqnBr45+AP/JBPkTp/PseEU4KQsEoVwMOM1lxKHk6Lb1rx9QuPrA==
X-Received: by 2002:a50:c30d:0:b0:5a2:6502:b2ff with SMTP id 4fb4d7f45d1cf-5b020009c86mr6301228a12.3.1722278537558;
        Mon, 29 Jul 2024 11:42:17 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3111sm6113728a12.69.2024.07.29.11.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:42:16 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so2532041a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+5Zn57VDqbxTK5uG3AgZIXtSyni2y1UXzKfHbYd5324uJcjoHXBduNX0HSJqormxImwH0MFAsLng8Qmw/jQqaSkwboS//EyldFIkE
X-Received: by 2002:a05:6402:5113:b0:57c:c3aa:6c68 with SMTP id
 4fb4d7f45d1cf-5b020ba5bb5mr7729634a12.20.1722278536394; Mon, 29 Jul 2024
 11:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7eb34e0-28cf-4e18-b642-ea8d7959f0c7@I-love.SAKURA.ne.jp>
 <2024072944-appraisal-panning-a0b1@gregkh> <f9b4ff23-ee3e-418f-b65d-c40fe28fbba8@I-love.SAKURA.ne.jp>
 <2024072930-badge-trilogy-c041@gregkh> <Zqe76gATYUcDVLaG@google.com>
 <CAHk-=wgweFg4hOus9rhDEa437kpkdV88cvmOHeZWwhgSa5ia1g@mail.gmail.com>
 <ZqfYfIp3n7Qfo1-Q@google.com> <CAHk-=wiT8RzFUVXe=r3S9dfCpV+FhARgtb5SxLDSOKCJKCLOZA@mail.gmail.com>
 <Zqfg8FW-SFFedebo@google.com>
In-Reply-To: <Zqfg8FW-SFFedebo@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 11:41:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4peLPGB+Lyvdtwxe6nVeprvTbZiO8_=E8-R_M+VyWow@mail.gmail.com>
Message-ID: <CAHk-=wg4peLPGB+Lyvdtwxe6nVeprvTbZiO8_=E8-R_M+VyWow@mail.gmail.com>
Subject: Re: [PATCH (resend)] Input: MT - limit max slots
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Henrik Rydberg <rydberg@bitmath.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 11:35, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> What exactly did you do? Limit size of data userspace can request to be
> written? What is the max allowed size then? Can I stick a warning in the
> code to complain when it is "too big"?

Look up MAX_RW_COUNT.


> So does this mean that we should disallow any and all allocations above
> 4k because they can potentially fail, depending on the system state? Or
> maybe we should be resilient and fail gracefully instead?

We are resilient and fail gracefully.

But there's very a limit to that.

Dmitry - none of this is at all new. The kernel has a *lot* of
practical limits. Many of them actually come from very traditional
sources indeed.

Things like NR_OPEN, PATH_MAX, lots of arbitrary limits because arrays
don't get to grow too big. Things that are *so* basic that you don't
even think about them, because you think they are obvious.

In fact, you should start from the assumption that *EVERYTHING* is limited.

So get off your idiotic high horse. The input layer is not so special
that you should say "I can't have any limits".

                Linus

