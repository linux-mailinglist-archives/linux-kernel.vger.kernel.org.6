Return-Path: <linux-kernel+bounces-515054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4DA35F15
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83377A1830
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17661264A62;
	Fri, 14 Feb 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjeTYpa1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531782AF16
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539756; cv=none; b=ex+yAJCFkY6OAEBwgstDYsq8IyM52kgWeP29zAXRzpnAi+TFR0Cyo2wROgEeagXtNd/SqyDU+G8b18AeNFcUHTEEi4ztPZXWXmnUPuFdk2Lb3IMZn3Nm8amoeGNeNstBQybW0NSjrVpSVo/BFVrsvDU6ynHFmaemtCnW/b8P75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539756; c=relaxed/simple;
	bh=f5QImxHyukLj6RECAm1dEo3TCWzIupOla0PIgml801I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mADbMp6dBc0B5Q4kS7feh19t/ZFZga/gY+dyFmzON0xYvah3WmpWTNMGeNhjfrOCD2Ft5BiRsOED5F68xqpl8SasXMczWAQ+Kryp1waRGhbIWjJUb/QBO16EmC7+E05c/mK4rY//jTAtkdHpCajLE1uwKVgBZCaW4D9m4OyRC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjeTYpa1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so1098240f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739539752; x=1740144552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWvbnHy+eruaNnpFjCJCWrVsj6FgpclpeKV+qjRmKSY=;
        b=NjeTYpa1v3Wifqk+cUBmMCMirvbbeT1lS5JwcGp+EJ/HYORzoIUACLdPJZKWOcbCWd
         LpchwIxo3CKZlNS1Eu2CzdLr7shsiObdxj8OPxrFbADhWGl8H1bkKNeLMafr9OM4k1cA
         kc7kLrsQXT1g+1Df/gG0qrWSJvWt5/VmGK1NZlfVegaKZjYNpUYuiqm3S9cXiHCqRcJA
         xxTWoEZPr/FCeoibpn1rll43AhK5k6CAKD3NA6sYJRY9lQPoWF0Cyl6QPkDXmPUgjFBv
         D1TtRACJXQi+1/SNhAZQU00IBulr+6ccOZkpGIakl3y3rKdzNrtDZ+5op8MEOYTk0Bi8
         X7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539752; x=1740144552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWvbnHy+eruaNnpFjCJCWrVsj6FgpclpeKV+qjRmKSY=;
        b=R0TVX/brmK72airdlgv2WN/UkQPSy/CKixPqKkyaSJDPmc4JpXPdvprTfS1nV9GuBf
         Y3gde3ux1nkQ+P/TQAmmZ0rK2wn5JAlti738/stm6vVVbvK03nroWBbdqPL9Qpt/nIom
         rFgguxUKIqjl8B6GKkaFa1TXnZttXjmcLok/x0vuBBpiMPoBjJSHoEf5nFEm6ddCRMah
         ws2wxee5GM4bLbMJubcvqCYYpcTX3HwQoZYYe+aYetnaYbuM0x/Zk7oQ/ROeSdxVmm9X
         iJhZi+izIilIWYgfHspv5Sb7NQB2hAs0wxqk6C2nZwtmvVvVfpzo8pxwGlPzJMAFQXdb
         GWJA==
X-Forwarded-Encrypted: i=1; AJvYcCWwOmZhyrS+1VK+c0icesEzuLUuBpHtqQYOC17X8J5gjJJGHQRwR56jrraxaIoKNEeTpHZqHC4GesQXAhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4u+4Hm51Ybru0yY5Eq3N7f5IRk6apcQxwALogaDOx7M9B7bUG
	rUFDPeBmLrDxjfinArT7VyDOHAgEzuUnR9HbaQV/rwDNN5brhUY8
X-Gm-Gg: ASbGnctW1RdPGxVZiNb4ulOSfZ7ZurR9q2uB0YrJUh/vaFhEp1HcgzB3GJpxIF0epw2
	WF3jsEGKt9kCQjgnAgC0brWNqA8qMP4tC4WrlP1CdtAwE2/aEL58qW4GtC2sGDtziXY79Xa2ijT
	DmGi50ZCtDEHaquPWA4ipHGFQsn1zqhXF0pb/l0ToOX47FScDZkQMOt+9iG8Q68ixZOiAVG/1t2
	MKiSCKpn/GFHVu+zADg+J8KauLs5ov8LcBhZAnWnZKhI2aXBrIpvl2CSnMs8pPAGCSv9iFr2lTf
	vPJCodpJj5dNLGcScg9r5Qt8RIYyngO3W2Z4QOMOylCKI61l9UjVmA==
X-Google-Smtp-Source: AGHT+IE/R0eXpSQdfNv8gz8NRaW1uh9+V+AeTS/4r/DrR2DWuIssTfwwnBlOlf91MqFEjlffVrFhSw==
X-Received: by 2002:a5d:6382:0:b0:38d:d18e:8811 with SMTP id ffacd0b85a97d-38f244e960amr7186462f8f.25.1739539751489;
        Fri, 14 Feb 2025 05:29:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396180f199sm44329255e9.15.2025.02.14.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:29:11 -0800 (PST)
Date: Fri, 14 Feb 2025 13:29:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Noralf =?UTF-8?B?VHI=?=
 =?UTF-8?B?w7hubmVz?= <noralf@tronnes.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <20250214132910.2611f9cd@pumpkin>
In-Reply-To: <ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
	<ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 20:54:59 -0500
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:
> > There are conditions, albeit somewhat unlikely, under which right hand
> > expressions, calculating the end of time period in functions like
> > repaper_frame_fixed_repeat(), may overflow.
> > 
> > For instance, if 'factor10x' in repaper_get_temperature() is high
> > enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> > resulting value of 'end' will not fit in unsigned int expression.
> > 
> > Mitigate this by casting 'epd->factored_stage_time' to wider type before
> > any multiplication is done.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
> > 
> > Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > ---
> >  drivers/gpu/drm/tiny/repaper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> > index 77944eb17b3c..d76c0e8e05f5 100644
> > --- a/drivers/gpu/drm/tiny/repaper.c
> > +++ b/drivers/gpu/drm/tiny/repaper.c
> > @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
> >  				       enum repaper_stage stage)
> >  {
> >  	u64 start = local_clock();
> > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> >  
> >  	do {
> >  		repaper_frame_fixed(epd, fixed_value, stage);
> > @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
> >  				      const u8 *mask, enum repaper_stage stage)
> >  {
> >  	u64 start = local_clock();
> > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> >  
> >  	do {
> >  		repaper_frame_data(epd, image, mask, stage);  
> 
> It might be best to change the underlying type in the struct instead of
> type casting

That'll just make people think there is a different overflow.
It'd also force the compiler to use a wider multiply.

A more subtle approach is to change the type of the first 1000 to 1000ull.

Personally I like to see the units on variables containing times (x_s, _ms, _ns)
since it makes off-by-1000 errors less likely and you can more easily tell
whether overflow if likely.

	David 

> 
> Best regards,
> Alex
> 


