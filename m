Return-Path: <linux-kernel+bounces-528248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C9A41569
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EAA172611
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA321C6FF7;
	Mon, 24 Feb 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nm843gOU"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DC1AC44D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378868; cv=none; b=Z0Avbur8WcYpxlYQs1fGknbBiPMXbhHyV3Zy6DLQQjrO2TzERmzzLwTcPfFKd6OGyADunpcD2UDBt1PAoZOIQuvLA0U8xqO85Rn10+ETCyPvvW2w4/Dbc+TOEjJ3Hjwih3yNg/hqSVvN0MJkir01LRxmtvJkXiTh0MNHXYMS/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378868; c=relaxed/simple;
	bh=fQDRfw3EhrfUd3Fny4Nab7kzxfYkmF1PMtyrdiyxXes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmDrdsLIzHugI69vh95fhYnAUgm416qngpEpWacARuMZScFC/ZLe5ufvR6xSvAZEuugtQU7lTg0PqWF34gSe2GFPlush+WwB+HVj/6KXZFICNb2IsPO6gwpliGKe9rfKIdxPFMOLsqkBkZAthoEAK2bWwAG820dcPvTc9g02OIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nm843gOU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30738a717ffso30800711fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740378864; x=1740983664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDmIbBVBrmOqaPqtm3OIVdTs+1YkPggGmmD9ociAVJQ=;
        b=nm843gOU0GyxgL53MM5WT0+hRAwGjF1VlVecRrIxqHYHyE1L9LCMuiXHmOLiQHubLb
         h1Qqvy+EaoCO1v9g5RBTGXerTWTvfAfONoywf3SLJWUKPvRX9jAa2Yxxvn9Loja79qw/
         VXxY0hOl4MYk/Ozuw3Qaap+li+YSiod4YEeHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378864; x=1740983664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDmIbBVBrmOqaPqtm3OIVdTs+1YkPggGmmD9ociAVJQ=;
        b=L596DK75e+C6vZiJFzOYRR2rFYnL31PdC1dN5MbskGzFVd80jiQLJ9PbOthEpg1z4y
         HvrD27NURfoXaxplu9wVMq5AMkdV5XEMlDqgJphchHWxwxiQKmiNgFjiCYlHt68p8fjI
         IXr79l8Rmh5gO5Maj2fUNtNbdySsq2pSf/rf9szwrW7qO6DSskKSB3fDAnajbG8gTy6D
         IUaL0ishxNnsy7AQR9DctABUY5+dIlu3UwXb2fis3CaILEmVr/zLbgkFzWcn2UWMdIaG
         PHp1jSFsOZJo4Tu1E1D6xnG11ZDnZD9xMoxGsg2VsFDqTQGgLjNRHqfcRF52AucA20va
         aGzg==
X-Forwarded-Encrypted: i=1; AJvYcCXKfLWxAtYOV/SlT6n0WRXx3vSUXoL0/hHdLGsWjWKVSgC/qTvZZkx/tJDl2ye65oYw/Y7grikI0g1p/mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5/vFaHf5D2uogSxnfiENaRrLDbw4O8oGw5K4LCboszu0RyKA
	f11v6FPjnvsbl38q8PP7J+Fsn3YZmimie+JE02Q7+qDOGLg/jIA5bVEKyi45XB/7xXT3VZfrXFI
	QHw==
X-Gm-Gg: ASbGncvl2DIyVUpaf3RYmR1FwsTL89YgnHJdYmJLQM7UJfJnQ0MgxtDdDWqX8YXXXZ3
	VNwuXmsWW4m2laHTMPxD3uRzHMeRvrWcg3VEDTOV8wfCvWRizo4F6Bq+T9W9WNC/NHtBDcwFQq3
	hBCIydF1t7GoTzNhJZy59tdaAYcuszV5tMDOxTjnihaPoA4DdhvvSb1K/E7Uin7UCTfEY2nUdgs
	7VEbYfilBs5qeUuAPqYv37gR2wgHCRF8lojkffb19CChfL1mH07B8S/r21NgpwvcENU0JAkTHFr
	LIYIfWj8oq6ic1TvpB3UR1atsAwI3y9AKx0tLfGbNqqoLiC+KacI+4hXJmkiEkWS
X-Google-Smtp-Source: AGHT+IFT0OBuHbFy4DdJ+lqukepQInlYMfDXh3hXiuKCcSB7pcap8b78GB0Wgpct4srpynQw/En2rw==
X-Received: by 2002:a05:6512:3e20:b0:545:2f5d:d5ab with SMTP id 2adb3069b0e04-54838f4c9cdmr5220208e87.37.1740378864465;
        Sun, 23 Feb 2025 22:34:24 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54529502dd9sm3026668e87.245.2025.02.23.22.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 22:34:22 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-547bcef2f96so4006134e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVukLUk1/GbKx6wk/EdByoO36H/M3Qo1agk+ZFmAT77WCA+8lmCMrjlbsE/FY9IKAvJnbnYO20d77Itg40=@vger.kernel.org
X-Received: by 2002:a05:6512:3ca5:b0:545:2ee6:84a8 with SMTP id
 2adb3069b0e04-54838ee76c0mr4652920e87.14.1740378861858; Sun, 23 Feb 2025
 22:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
 <20250121-nuvoton-v1-1-1ea4f0cdbda2@chromium.org> <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
 <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl> <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
 <2025022426-lilly-next-72e0@gregkh>
In-Reply-To: <2025022426-lilly-next-72e0@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 07:34:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCvr5Fz2CE7Vx5gk_r=JFHwpT-w=7GGgZ-MN8FkjQyp+yA@mail.gmail.com>
X-Gm-Features: AWEUYZneujeUqRzowTHsCuBd_481VOXalvBfDTLy1Zv-JKeySU-2ECz97LHUiDc
Message-ID: <CANiDSCvr5Fz2CE7Vx5gk_r=JFHwpT-w=7GGgZ-MN8FkjQyp+yA@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: nuvoton: Fix reference handling of ece_pdev
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Joseph Liu <kwliu@nuvoton.com>, 
	Marvin Lin <kflin@nuvoton.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, sashal@kernel.or
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 06:52, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 23, 2025 at 07:34:30PM +0100, Ricardo Ribalda wrote:
> > On Fri, 21 Feb 2025 at 10:18, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > >
> > > On 21/02/2025 10:04, Hans Verkuil wrote:
> > > > Hi Ricardo,
> > > >
> > > > On 21/01/2025 22:14, Ricardo Ribalda wrote:
> > > >> When we obtain a reference to of a platform_device, we need to release
> > > >> it via put_device.
> > > >>
> > > >> Found by cocci:
> > > >> ./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >
> > > > This driver uses this construct:
> > > >
> > > >                 struct device *ece_dev __free(put_device) = &ece_pdev->dev;
> > > >
> > > > to automatically call put_device. So this patch would 'put' the device twice.
> > > >
> > > > Does cocci understand constructs like this? If I hadn't looked closely at the
> > > > code first, I would just have merged it.
> > >
> > > Oh wait, now that I am reading the following patches I see that it was those later
> > > patches that add the __free code.
> > >
> > > This is far too confusing. Please post a v2 that just combines the 'fix references'
> > > and 'use cleanup.h macros' in a single patch. It makes no sense to have this two-phase
> > > approach.
> >
> > I believe this is discouraged.
> >
> > cleanup.h macros does not exist in old kernel versions, so makes it
> > impossible to backport the fix to them.
>
> That's not a problem, fix things properly in the main tree and let the
> stable/lts kernels work it out on their own.
>
> > This is an example of other series following this policy:
> > https://lore.kernel.org/lkml/173608125422.1253657.3732758016133408588.stgit@devnote2/
> >
> > They also mention the same here:
> > https://hackerbikepacker.com/kernel-auto-cleanup-1 .... I am pretty
> > sure that I read the policy in a more official location... but I
> > cannot find it right now :)
>
> No, it is NOT official policy at all.  Otherwise you would be saying
> that no one could use these new functions for 6 years just because of
> really old kernels still living around somewhere.  That's not how kernel
> development works, thankfully.

No, I am not saying that we cannot use cleanup.h for 6 years.

What I am saying is that first we fix the errors without it, and then
we move to cleanup.h. All in the same series:
1/2 Fix reference handling (cc: stable)
2/2 Use cleanup.h

That way the fix (1/2) can be applied without changes to all the
stable trees, and 2/2 can be ignored by them.

The alternative is a patch that cannot be applied to stable and either
you, the author or the maintainer have to backport to stable
(basically implementing 1/2).  So no, we do not save work by just
posting a cleanup.h version of the fix to the mailing list.

The even better alternative is that cleanup.h is backported to all the
stable trees.


Anyway, it is up to you and Sasha to decide. I will repost the series
only using cleanup.h

Best regards!


>
> thanks,
>
> greg k-h



-- 
Ricardo Ribalda

