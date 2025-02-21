Return-Path: <linux-kernel+bounces-526687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE5A40200
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C819C71E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31620127D;
	Fri, 21 Feb 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKd3PWwv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783536AF5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173075; cv=none; b=qURWRh1iR8Hdrif7CLpJn4Ll0YoZdoOrcd2nBUmgZR1maZ5Nfbd003lvuORh5/f2/HjnKJK5xuZITSDdRfhQmYd2K56QuhNTGkh3tKe61dDR5CXs5+m6lIobz3NGmnfeFjvmRkN7yES6bMhX+Vco6QGatgEFmH7x0pxVZYVg1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173075; c=relaxed/simple;
	bh=1762NVQXdGje3dlNxOQSEQN5RBB3Nw2JuPPfR11IEIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOrLMZ6ixp6Qu6VLZcz5bONfsnhuQ7614yVfVwyY6ohVX5aat4vjPxIs2m0gOMp2uRRDi2p2Z08BFdFn7wTL8YRGbygRKYSM2g6qf7xomHr1oSd3E3iwx41JTg1afwchC8Xc5pGGED1zlWsdk1lQBcGPjYfdO5HJ67IH3clgSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKd3PWwv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3182875a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740173072; x=1740777872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1762NVQXdGje3dlNxOQSEQN5RBB3Nw2JuPPfR11IEIw=;
        b=WKd3PWwvPVfjGUDESAF6DHLUQgG/7XN4oe7j2jT3hih6Jc6hCDLxJIqxxu5beMZYIC
         hTzv7n0c876gTYp7XBiXhF0v1RI41A7l3yqsyfFabXrMJ4ZWaZcSa+rMpiTHF2Jzy5nZ
         symdJseml2e8H0+5OTSIgVPF3S6dTytk2ZPjdN4Jwmt8XZjVHwXC3NiyZUSO5bCL9g9q
         I509DsxTAc04a0WqMZT22lGT8j675DoEcfiHVUtFcWgVgpE1oaa8sM2CdDnZIPorqmY5
         mbVpL9EPyWDgB8pJpyvkF8JOPpYRn+4Aj2xcufHMfCaZeJ+tKaBDW26nelyiESiWlp10
         4OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173072; x=1740777872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1762NVQXdGje3dlNxOQSEQN5RBB3Nw2JuPPfR11IEIw=;
        b=BeIXzDl324x2JMlJwH8i6zyYQX0plFSeW6kXQYCCzShHJRH4yOZ50Pty+xbmMC/ZFE
         vEspXlBMzmb8i1kAyeo6TgrV8DJFmIMbsGw+ouMXP0j+YylEf6065Wt6Ub41yT8ppBPI
         MZ/hCTCPQ6lC+tNeqjQveU+XbqYqZdIRi1k4gSaITHXu4gobn/PRPG5OEqwr2QQdgUdv
         jXidAusz71Y7abET0CB+kR+lNYPTTuQNutSFilkcLsZDWhIm2d+bEojU/G3BkFzSZfnb
         nXZCWS/8/ESCRf3ZGpyGmF59L8OYuItHwqMiQ+A3BPL3VvVlFFK8MWBOeKwaW2OYO8SL
         iKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Uh/a1ByVqqnXAydboXiC2U/Y7okx6HDSiuV9xsHVPK1rFhaAZo0v/1IaNfVsaal4vGxgIOHLb6Btjw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxI4trzaUatVqWuV9Uo01bcoMm6HSf+I57CXDLBHVpDjM31kH
	MMpPDOWjEo67qLh8z5yOuIpRtMrZZz+YPXJu1n6hRWdhrkzg5pUmGSpSGqgseAWGDuPyBrezFc3
	n8StOo5YbnQOxL/xttxxQvWPppkDNgA==
X-Gm-Gg: ASbGncs7Y/MFhKFarrGInxkGi9ryiTUuuywDIttkV132AlQ8fz1YmEDW3wF9UE3Inhx
	jh5q3IZhq9Ou3xtt0SurxX5Lmrr4AQm6DI8W+hyLWPoHUTeeaGNb5xR+aJjkjfgZogKl/N5KlGM
	ak6E0a7A==
X-Google-Smtp-Source: AGHT+IGHZ3p0Yhcy1NooWckT7km21FHzEsXX7wdW6PJ+zdzWXhvCub+62TXotrdDn5kDSCkT35k7Jp72jwVmVlApND0=
X-Received: by 2002:a05:6402:51d2:b0:5e0:9250:435a with SMTP id
 4fb4d7f45d1cf-5e0b7252eb7mr10284527a12.20.1740173072026; Fri, 21 Feb 2025
 13:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
 <CAHk-=wiJYQwSMoor__B-8D71S8=Dn5BeAY6tOzSL4u3MEZrtcw@mail.gmail.com>
In-Reply-To: <CAHk-=wiJYQwSMoor__B-8D71S8=Dn5BeAY6tOzSL4u3MEZrtcw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 22 Feb 2025 07:24:20 +1000
X-Gm-Features: AWEUYZmZnwC1hboMSOHw37C9Yg-dylJMTIImEuvQIZT68-vvD-BB6UCjp2DW_C8
Message-ID: <CAPM=9txwcTE048cOGnSNfXqX+ykADgqDHRZmyfnLQGQ_9oRZTA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.14-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 07:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Side note: I think you do something while editing or
> cutting-and-pasting that loses indentation.
>
> I sometimes have to guess at what the intended grouping is.
>
> In this case, notice the "More catalog fixes" entry for the msm driver.
>
> I *think* it refers to all the following bullet points up until the
> "Core/GPU" grouping, but that is literally nothing but an edumacated
> guess.
>
> So when you write (or copy) the description, can I ask you to not drop
> indentation like this?

I rewrite the MSM bits usually to align with others as they
subcategorise and nobody else does, but I can keep the indentation if
it doesn't look like noise on your end.

Dave.

