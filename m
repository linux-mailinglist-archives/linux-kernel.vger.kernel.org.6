Return-Path: <linux-kernel+bounces-516302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095DA36F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9853AEED5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D918B467;
	Sat, 15 Feb 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+367ews"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135FD529
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637309; cv=none; b=tGa346SWCeQk73KlY6Y7y0YZ3+0N74SK8mCmeGypkYH+rF9MNH9Dxj5RKMLXUBAK5d5GnVKdjLOCePFGJuvXeLrOFvrD3ze/PXGhFdowvZGcuGWzUiw2VHfxLMZ8DWRsGEY7OoatFQGM0ZMfhQKsM3U/UrjPNhtAHcWqDc+e2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637309; c=relaxed/simple;
	bh=lJIwTVvN/M1i6c5xdNoYEy97F3SDCETAmXkpLS6/CV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn85/IQVmCJzu9+ju/HWf6oCsnCRIAtXN3CSZQJCNalQT+U/PeZPqNqcPQTSur+yzdzzWMILAz+83abF4cFC1wo/q12kJaoHz/dqFtS2bOOFczyfNBbN0thu4b57shPCXnvB1W2qLinqAKCVGVsRMbB47O5/EBUvKTxBaQCvSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+367ews; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471963ae31bso33839621cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739637306; x=1740242106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTDjCGRpUNKDDvAUL0WPoPLyp3KWBVbd5boILJywKts=;
        b=g+367ewsAoM4nhXmRcRl3NrQSiRlgkr5Pm3k3j7O7VD7zAO+jkruUb5lR6VmomuT8G
         wrT9DTaLRjdl+iQDiYFKhGZuNdkV747F5j73A400ouuVKNxLjJV8S4EwgxpecZurnkcw
         mxWLBx6WrZHDTnAHwPH7VboF7JNY1E7gnU5Rw6T2zjX90me/vor83r4ptkt9kjIy2vLQ
         4ydmSCOlBXiZHVjCP6bWvsVHA0QOJVFRXN2pAJ6NZds+IOA5xJsiL5M9KhZAlNCAXEbI
         NtflpujfuUiQAkY2QJ83VXJ9EXirlm90GkJRiJ9Z5TPYSuj5eE75+hU5UJXRu8RH3O2k
         qwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739637306; x=1740242106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTDjCGRpUNKDDvAUL0WPoPLyp3KWBVbd5boILJywKts=;
        b=g/mgk8AvCkLRhTCODulU28pZ0x2uC887PFE2qLIhZPzbnv26/N7TeRpg1/IqvKckW7
         qY5x29TZDAm5hlv2pwdlDY0/FMziiyMZ6YETNikoOTOwBkf2uKCGOV0Vfbr31CBxeulb
         yWY9SqIIvP1O2Nho5ATefrh0ZNuPzXNnv4qNa9pd6QWpEu97ewTyGSg4Mg5jMMk/ch1l
         +xXrTJhEMiH0XGoIWkrsfUkU4P7l1j7UImD94AoG+CBEhJGXiNZvlQzPR9XmxGLrR9s7
         G7qz/WO5LAwyEjNGcaMeIzR1aFxxvFi31ILlqAEQsJK6E6oibjMG2T2wURzof8rnxbkO
         4Zag==
X-Forwarded-Encrypted: i=1; AJvYcCX59H9z/vEjUWEywZzgUbYBkXjT65PSWCkYhDhIWYbvSGRaY5ZZ1AzhyV7nQh8zy/AXu5FmSOBSRKLkMaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmvc1cVJdolW0mdaJNO65ALR3mdttZ7xh0AjOu/jJOolKUBl8l
	lP2iqCvzjAHk614Dpl/Uus/CEpVjsTZk/xVvgSWM0fJVFP3sLfdL
X-Gm-Gg: ASbGncvt8xBjsSKT89OZpH+eSYNrn1DIhNW3j4ZkE8VbwfKbMsLQ7ev00QCbJVQiv0c
	jvK+6H+IDw0G7GjFFaIRR53kqVDksP2GdLCFhclg7eLw6bfz8PrGxd1TKtqVY7WFmEMEcyNveZh
	KeaTfHpXaiDaATY14mvO5P5X9RDiF2yfIGRr/w3iHnCKfMzO10wD/7EhtEsKdu/eJWpVGGRAYRz
	rW6dpW2P+0iS/BkvTImmjsdmYi6FvOe/N5lPY6JxBbiTmfrwg0ActWvF0BgNgXVhVrSyYJ9Sclw
	AiJYlOKOGBu0RNZjOcqM2AsUpjUeeLojriIUdNeJIK7Z16rvoWh9
X-Google-Smtp-Source: AGHT+IE5ndOLlJRNvl0FnbJw+hM9GbE588rdpBwbd0mV/9012KSspZa9WM3VBWjd+245FTni/WeHRg==
X-Received: by 2002:ac8:7c45:0:b0:471:a17c:ceca with SMTP id d75a77b69052e-471dbd22bb5mr46825011cf.13.1739637306251;
        Sat, 15 Feb 2025 08:35:06 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b049b8sm28801181cf.76.2025.02.15.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 08:35:05 -0800 (PST)
Date: Sat, 15 Feb 2025 11:35:03 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
	Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <igbvobwlcofadqtqxmlwr56tvzekdx6nqr4t7uxbgnxo56yiu3@fzyhaeyqqn3m>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
 <ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
 <20250214132910.2611f9cd@pumpkin>
 <cx4efp5kx3hahymdtgrjwu64373du4vg2v7errm3t34exrgezn@weo6exjuq2fu>
 <20250215114800.5c8d8d2b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215114800.5c8d8d2b@pumpkin>

On Sat, Feb 15, 2025 at 11:48:00AM +0000, David Laight wrote:
> On Fri, 14 Feb 2025 20:02:01 -0500
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > On Fri, Feb 14, 2025 at 01:29:10PM +0000, David Laight wrote:
> > > On Thu, 13 Feb 2025 20:54:59 -0500
> > > Alex Lanzano <lanzano.alex@gmail.com> wrote:
> > >   
> > > > On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:  
> > > > > There are conditions, albeit somewhat unlikely, under which right hand
> > > > > expressions, calculating the end of time period in functions like
> > > > > repaper_frame_fixed_repeat(), may overflow.
> > > > > 
> > > > > For instance, if 'factor10x' in repaper_get_temperature() is high
> > > > > enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> > > > > resulting value of 'end' will not fit in unsigned int expression.
> > > > > 
> > > > > Mitigate this by casting 'epd->factored_stage_time' to wider type before
> > > > > any multiplication is done.
> > > > > 
> > > > > Found by Linux Verification Center (linuxtesting.org) with static
> > > > > analysis tool SVACE.
> > > > > 
> > > > > Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > > > > ---
> > > > >  drivers/gpu/drm/tiny/repaper.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> > > > > index 77944eb17b3c..d76c0e8e05f5 100644
> > > > > --- a/drivers/gpu/drm/tiny/repaper.c
> > > > > +++ b/drivers/gpu/drm/tiny/repaper.c
> > > > > @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
> > > > >  				       enum repaper_stage stage)
> > > > >  {
> > > > >  	u64 start = local_clock();
> > > > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > > > >  
> > > > >  	do {
> > > > >  		repaper_frame_fixed(epd, fixed_value, stage);
> > > > > @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
> > > > >  				      const u8 *mask, enum repaper_stage stage)
> > > > >  {
> > > > >  	u64 start = local_clock();
> > > > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > > > >  
> > > > >  	do {
> > > > >  		repaper_frame_data(epd, image, mask, stage);    
> > > > 
> > > > It might be best to change the underlying type in the struct instead of
> > > > type casting  
> > > 
> > > That'll just make people think there is a different overflow.  
> > The commit message should describe which overflow this applies to regardless.
> > 
> > > It'd also force the compiler to use a wider multiply.
> > > 
> > > A more subtle approach is to change the type of the first 1000 to 1000ull.
> > >   
> > My reasoning for favoring the type change route is as follows:
> > 
> > 1. I'm not a big fan of using the standard C integer types especially
> > mixing them with the fixed sized kernel integer types for these kinds of
> > overflow scenarios
> 
> I'm not sure whether the code is converting seconds to us or ms to ns.
> But in either case 32bit is plenty for the configured timeout.
> Whether that is 'unsigned int' or 'u32' doesn't really matter.
> If you change the type to u64 someone is going to decide that the
> multiply needs an overflow check.
> 
> OTOH use of 'unsigned long' is often an 'accident waiting to happen'.
> There are far too many of them used for clock frequencies and similar.
> I'm sure 'long' has been used because of worries that 'int' might be 16bit.
> Even when Linux was started that was never going to be true.

Fair enough. I don't want to delay this patch further. Maybe down the
road this can be can be refactored a bit to add units as you said and change types
if need be to mitigate future issues. I'll add it to my TODO list.

Best regards,
Alex

> > 
> > 2. It would remove the chances of this field causing the same overflow
> > issues in future development
> > 
> > > Personally I like to see the units on variables containing times (x_s, _ms, _ns)
> > > since it makes off-by-1000 errors less likely and you can more easily tell
> > > whether overflow if likely.  
> > Agreed but this is out of scope of this patch
> > 
> > Best regards,
> > Alex
> 

