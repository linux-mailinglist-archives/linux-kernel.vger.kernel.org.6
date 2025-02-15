Return-Path: <linux-kernel+bounces-515928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D266A36A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E59F1897957
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381B81732;
	Sat, 15 Feb 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwbvlEDJ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6351B59A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581330; cv=none; b=TObYs76VYPgTYnDMrXRv3OJglhR7leN5n+NxJlKF+NmGrJM7gPtPjIztVFc9l8kSYbBTsMRpaj3I5rvXr0s+gEN+oCVSkPmWmKhlQ0Zhuhr62zGcfD3F1foRv2PoEhs3Nu/tr7GfxIgRRFGbehhuasf7RcB5BSPbrAMC6cN5udY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581330; c=relaxed/simple;
	bh=5Qh1imnxfftD3w8x3qFyaDLoHriyjLO/8aj6Nq+bklQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9puZqI+7Ule5ieYSs/HrXUWp+3wNw/60tf4Ku2IOS2Zd2ODSnK2LW0GPD3tD+SVQq7BBVSYKshKb2DNzZixPr6HWO9e9uDxTadFLU8BNq4VSvBJBtp6Rn2x+hMBK3wVjmCzc3L0wRIYHM77NXuP/mLsIzUpU3EIHJHnpKGC550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwbvlEDJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e451fdcae2so25893966d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739581327; x=1740186127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqj7o49OtvRT5iEEonYD4OZw5LtydwFI4sGb/0Fu3BU=;
        b=lwbvlEDJ+ZMDDhi7LrHTmXuFUVwyLbftk6Dh9bGv9jUL3UDYdURW+Gi/Yv69bJPkeU
         la0IklX+MmbQquy0VUNnrlSg+ciAz+m+UGVtYEa6csf5BmL0RU2FOR7lQmpiaorPoGtI
         IaPnjjdimB6PG8MO2n7NDfxktOvv5pu0n+Jr4n4XLG/RvbOkUpWYNOFJS19Jcx505EmA
         7dOc2QPKZT3jP7dPzzbSX07+Kukak3pHWrOpFVwudLHlXDwPaFb60g3pL67vdT/M8cHK
         Tb3o5FSUw5fyzjfFtSCs6wQBJzbr+Y4mnhDJ9bRXx/b5JFmkRBfLcy+PBaT+jK62Vqdf
         Hy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581327; x=1740186127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqj7o49OtvRT5iEEonYD4OZw5LtydwFI4sGb/0Fu3BU=;
        b=JpdmyW0OO7l/2BKnPsI12EoW3VJ5g2B+qmKEWHbDqv9zHD/D+2NW26W6ep7rAoFOoR
         tum+VYk7nGh7UMydHcQ68zCQyIdRIuFYMAlM5MUyqyc3Od3ddungsSaRBAocRzrUfJDn
         DR3EiadZxRT5L54ZwPJrsw6UQwx9IhcTg1xMgjGbXiS9dFna9Is15viXDba1m+BsC4Z0
         SIeHMCyMG5/KDUIVDl3t6/c6ElHONKWhgKDetFoL8pXSLY7A6qpQlxU0CWg2RBgd3e/K
         qdLhc3eFVaa3zwT2F/cgkgCDWh1ZwVDp55hrG9wOLhBXxAG+ISNGiIpuZSvdxsVguhmR
         cvFA==
X-Forwarded-Encrypted: i=1; AJvYcCWR0VzvSYytmnigUf1sVGzjloVo+HKzIuVQr/hr9UFSoK/Pg2tAcDRe6tmHTLutQJIQvOJ8kQRkFvWPsC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTGrPI5Vr9jGreWk2nDC1ZlsT4mGUj6aKer+2BOryvfCn4tKW
	bhgyKcuZN3q+Y8vGnjHgzJgU5cgxh3LS0sgEn9pImD+Yf9RJQvFx
X-Gm-Gg: ASbGnct9msUgYiNuWwUM9FSvSwWbWXePM7G+AifyxIVOmA9Q0wWuTHLQdFS774bEbII
	XVZqos0+l0PlxYX+KAuLtrDuuc3buDQpv7pZt6TePshRy27dm920HBcC6me7tC0B4IEjc+MJNn0
	+bTtnSM3zSTJh6DeNG0x9dNDMtHV9scDXEQKu/6Rie/F6op5ih/SybWKJKV0/IgFLRIseDKUG0Y
	7eHHGVEzCuQWofXAjM66VB90ecKYnGW6YB5H4b+H9DFh5eEywrWBdLAeDOSHGLhkQcI4r66UXyx
	OJ2wF74Ut+LfORKrSsMEpKTZY+4vShZWO+FsxPGcVa0bh24ys08N
X-Google-Smtp-Source: AGHT+IH7l3+IZX/ugOgcY6A74TGp0xIfa8Wyi4jjlu0EfUXnGzlNsMg/wysPtqN1cyANXGt8N8uQlg==
X-Received: by 2002:a05:6214:d07:b0:6e6:62fb:3503 with SMTP id 6a1803df08f44-6e66ccbcb4cmr17810096d6.12.1739581327183;
        Fri, 14 Feb 2025 17:02:07 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b048e7sm23215831cf.74.2025.02.14.17.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 17:02:06 -0800 (PST)
Date: Fri, 14 Feb 2025 20:02:01 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
	Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <cx4efp5kx3hahymdtgrjwu64373du4vg2v7errm3t34exrgezn@weo6exjuq2fu>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
 <ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
 <20250214132910.2611f9cd@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214132910.2611f9cd@pumpkin>

On Fri, Feb 14, 2025 at 01:29:10PM +0000, David Laight wrote:
> On Thu, 13 Feb 2025 20:54:59 -0500
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:
> > > There are conditions, albeit somewhat unlikely, under which right hand
> > > expressions, calculating the end of time period in functions like
> > > repaper_frame_fixed_repeat(), may overflow.
> > > 
> > > For instance, if 'factor10x' in repaper_get_temperature() is high
> > > enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> > > resulting value of 'end' will not fit in unsigned int expression.
> > > 
> > > Mitigate this by casting 'epd->factored_stage_time' to wider type before
> > > any multiplication is done.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with static
> > > analysis tool SVACE.
> > > 
> > > Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > > ---
> > >  drivers/gpu/drm/tiny/repaper.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> > > index 77944eb17b3c..d76c0e8e05f5 100644
> > > --- a/drivers/gpu/drm/tiny/repaper.c
> > > +++ b/drivers/gpu/drm/tiny/repaper.c
> > > @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
> > >  				       enum repaper_stage stage)
> > >  {
> > >  	u64 start = local_clock();
> > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > >  
> > >  	do {
> > >  		repaper_frame_fixed(epd, fixed_value, stage);
> > > @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
> > >  				      const u8 *mask, enum repaper_stage stage)
> > >  {
> > >  	u64 start = local_clock();
> > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > >  
> > >  	do {
> > >  		repaper_frame_data(epd, image, mask, stage);  
> > 
> > It might be best to change the underlying type in the struct instead of
> > type casting
> 
> That'll just make people think there is a different overflow.
The commit message should describe which overflow this applies to regardless.

> It'd also force the compiler to use a wider multiply.
> 
> A more subtle approach is to change the type of the first 1000 to 1000ull.
> 
My reasoning for favoring the type change route is as follows:

1. I'm not a big fan of using the standard C integer types especially
mixing them with the fixed sized kernel integer types for these kinds of
overflow scenarios

2. It would remove the chances of this field causing the same overflow
issues in future development

> Personally I like to see the units on variables containing times (x_s, _ms, _ns)
> since it makes off-by-1000 errors less likely and you can more easily tell
> whether overflow if likely.
Agreed but this is out of scope of this patch

Best regards,
Alex

