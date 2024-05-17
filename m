Return-Path: <linux-kernel+bounces-181666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D508C7F64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03B4282338
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E841811;
	Fri, 17 May 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/60Q3pQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6310622
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908102; cv=none; b=CdN8BDtlKDyQiUOlylH759ks48btDodELGR9+T8MEMRs367URigJgL1UHGRqJUPdBQ3ivmAz2E5/jHGYEOeU01JEu36/Qp14EYnKx+KMw96/n66THm9Brc8wQe0eziK6z2r2xqrMpHBxOupMd0/6xZ2isFn3R37cmgRX9OOX/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908102; c=relaxed/simple;
	bh=czWvvFaMk9bvlBTDKT/n/qEoQNIBEys935Xzs55orSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEH0eoZ7WbBUQppQNZyf+q6j1VHTThbOpAgoNRqaBrtlbJMtY2mAxsdYzUdDsPD7Kn4DTsqEoNQr2QD9VpTFcC4Z9h15DN79ktXi6dR8vK9kCXw/bSwHhk/83jjDHSMOa/NMT0Gbu7j0p/EgpyiWX/hwy+iIXA1LhAW9/E8/KwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/60Q3pQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so376122966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715908099; x=1716512899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HKmYG8xCXUNt8KM3AI9ihqZhXFfndGJhx62ZDLuNUm0=;
        b=i/60Q3pQF5Ys5PiSFFJaT2tzxJilmF7eW5t0GkPJjLb1AjVEECvyseVSIFRThEQEUe
         sHU8uLAPSR0K9ge/ZLQaVU33VUqb95rHysasWQr5kNNSTK7JC9iJEDi6DfNG5TQEaw3h
         6MMSct9vQ1JgUvbKhZ4Q+yAtTM4lD51F2qNDNIGnhXJRPObdIv5BLMB6kOm5Imnjeq4C
         FxVvMySvCpx2wdCo1g9Tacn0Wcu4gD+CRSMWPXUZ6fOlNhrqgq9qDW1D4Z6GO4VzcEI0
         V7FAE416pya4OgRPkKUC8+ppylVPa/vFfXF9A4G3v7ABp5QgJU0giLsYeaaGUCCvYaM4
         atEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715908099; x=1716512899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKmYG8xCXUNt8KM3AI9ihqZhXFfndGJhx62ZDLuNUm0=;
        b=G1owf/QZBEuLskm2BNykX9V28eC0IDGDTaW2sxu66w95TZLcRa0ebWTjBkvgT8jL4X
         hZYn88sQatWRpHPMSu7ouubQBanUus0D24ijGSaXTpzVnAx67Hr5/QO8lxNyhN3RF0dH
         j3qMUyKMlSjww3GIjrs60bDmOHaY6xMXWrZiIngiogYx96WAy3rKLoCMd7+Z+sgAlPpD
         IYZYqmJfzC8UmynXKuZtO7j5UDCIKZYbRvAdA8XpPkl0mJOjciO6bE/vMZ9VbfnBjpKz
         o5lWBPDN4ipFQ94AvmPpkgMfhERvnaHOPYfqPgikbx5kfdFQbzuXhx22H7grO5fB3a5C
         9bsw==
X-Forwarded-Encrypted: i=1; AJvYcCX/QYLneJK4hucdnBN4kUtiWFo8X06L5G6085hANO1tnO/p7X36AkIY+Opac4ewjKSLxNoE6X7DvaeNK1knsRAhcW+V4nCeb2JIHHSv
X-Gm-Message-State: AOJu0YzWbx2FRjfxvp3GF6Sk68q/1uRb4Nbf8fgQ95jZif3lyN41LeC8
	Id5q9xTDHK70GTmem2qYYGS8Te3AMEav8xsUNOTC4wGliK93jXmXEEe6J1I1xtBCHJ3GYvNzb7r
	+pPWF/jz2vvFqpNK2iMT0Xc6L+38=
X-Google-Smtp-Source: AGHT+IF0+yGmXXW46xFjjfGuDr19Y9YP8gbVSUnKUsgiu/201syTbQ+og4I51pzcxuN8vpMXdciwjKUIRK3J8YUSjY0=
X-Received: by 2002:a17:906:9815:b0:a5a:c194:b53d with SMTP id
 a640c23a62f3a-a5ac194b61fmr496160666b.20.1715908099037; Thu, 16 May 2024
 18:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
 <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
 <CADnq5_NmC9bYkPFUD35gBtxsk_9jYhOTugni-q4WGXggf6=rLA@mail.gmail.com> <6225ecf4-f4ca-4ed7-a316-69c86f4ade7f@amd.com>
In-Reply-To: <6225ecf4-f4ca-4ed7-a316-69c86f4ade7f@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 17 May 2024 11:08:07 +1000
Message-ID: <CAPM=9tyJCJ+D4h7BZ3dBpm6R33gTfwtigDtmt6g9KX25Jun9Hg@mail.gmail.com>
Subject: Re: [git pull] drm urgent for 6.10-rc1
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> >>
> >> (And that kernel version of "6.9.0-08295-gfd39ab3b5289" that is quoted
> >> in the WARN isn't some official kernel, I have about ten private
> >> patches that I keep testing in my tree, so if you wondered what the
> >> heck that git version is, it's not going to match anything you see,
> >> but the ~ten patches also aren't relevant to this).
> >>
> >> Nothing unusual in the config, although this is clang-built. Shouldn't
> >> matter, never has before.
> > Arun is investigating and trying to repro it.  You still have a
> > polaris based GPU right?
> We haven't been able to reproduce it across variety of GPU's. Would it
> please be possible
> to send your dmesg logs and kernel config, I will check this on the same
> GPU you are using.

I just installed my RX480 polaris card in my AMD test machine, and
with current origin/master
I'm not seeing this at all.

Running an F40 GNOME desktop, doing firefox etc.

Linus, do you see it a boot straight away?

Dave.

