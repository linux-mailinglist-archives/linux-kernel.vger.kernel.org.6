Return-Path: <linux-kernel+bounces-252739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E593177E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F111F2268A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911818F2EA;
	Mon, 15 Jul 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaRaQc2l"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6718FC82
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056766; cv=none; b=mlvKVW0wJ9Ip6oec8FQQkeYWH0A2/aOsesW74VUseq27wZZ0jV6TDOE3bt0pRCZlde8hk0/+8kIJGfMT/gj6itlJJwslpLWXiK2k4kJYG57icZa/lNkSKSB+OsTT9GRZmnXSBenv1vcqI2AJaE5DaK+X8/FdJmhIv+avF201p5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056766; c=relaxed/simple;
	bh=R3BKZwcGacglQfainyOw0qqmGJnXyHfILiRT0yJE6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+vkiawiYCCz2lpnQGG1VAF2Dvv+qFEjSugRXqSa0n96VQU9Sy+qOJSmdC0tti35pNnLCdjyzez+XOViKHURncYld1u6tntgp0EnmXBUDxGuArR1Hlm+CCyK0PaIha0k7ZA1auFBXqk0Z2wRHlQaCTB5H4Dnxfsi8hWC2n+9kn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaRaQc2l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso30357885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721056763; x=1721661563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6/9yVcqNk+yc1ku2qgMlldOlCtEZ34pcOU7mb/yg20=;
        b=HaRaQc2lFyBCHnAnJM7qyubK175BndbYfamjqvUZ+ZI1AkkWMxX2uIAWa7WGIOev01
         ZVTi6CzMj3MxbX+z28A/J6TuTYxE1QQKFeerrSGHUYmc9ohDqzbcZQXso3FIW+hn0rdD
         bYbvNHLvcfwNj03tl+ZTfEbPwd6wGRdz1dKV/qTCTmyZAhFkp+9g9WfdpVulX9uwJSc4
         pBxGQdnSxXBjNmodkNsJEttAMebiTwdCdIHM9O+T0fSNLC3xKjT7Q+gUROHjZcN0V5Uo
         9VpyXPPWmEFf0LaonC9lVW0vEWFuAVQxNgo1M4NrVh8qaQrsxDBLMNc3wETtBmAS31Md
         aKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056763; x=1721661563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6/9yVcqNk+yc1ku2qgMlldOlCtEZ34pcOU7mb/yg20=;
        b=bjFWNUhT9Pi63DmQVTeCqKu94T6b8pegO5XK7BfzDzrAeVr3SJHUPlwYDXL0/LHkNP
         Uduq9J63YA15J7qJSXILIyNYscYkEU86znOJyR+SJ3DdRIGiMvhYcPfNeIUBW4fURvdH
         isyxn6vbbMTxSmktNsT9iIUTutv05py91FqaPrDPWOrciLBjipOZc9os5Ecx8s4a8aw7
         H2NBbfwD7ciKTc/Rmw3kUVNnHwKoM4MkAwfh3hRfdkaGBFeKMSSiXXmPRkv+LQ7KyFTH
         vnXtW+yQV1if/69EtEzIYDFEcthwO3XNojzsU22Ggp9gZFT3y0G3m/hdw/WBJumzEglr
         hVuA==
X-Forwarded-Encrypted: i=1; AJvYcCUxqU82pN+7MISBMLVpA5+UDzJXn49E/ZUr2es+bZxsXZOxYTTBnGiCF90cVOUP4azfxJ9QJtrC3NjXC/HAsPcd3Y7dKC+ohMKONOdQ
X-Gm-Message-State: AOJu0YzlJJR/KqJsgZqQOW2xnjo7n+Z16Ot7dLlc1ISIiwTL+W9jUPBR
	GkbdCm0J+dZzBT+rXm+yqocVzXaAfU0SzJHd2fcQkkuiLV55PhLw
X-Google-Smtp-Source: AGHT+IHV2Yw/R6G9b0Iv22/E5dwI7sAeswLR3PWDkJc3VOB2IcAqBSAmi7O4wVvuyRNX14LLniZvKA==
X-Received: by 2002:a05:600c:1788:b0:426:61fc:fc22 with SMTP id 5b1f17b1804b1-426707cbf40mr117915785e9.3.1721056762656;
        Mon, 15 Jul 2024 08:19:22 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44b4sm91134755e9.42.2024.07.15.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:19:22 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:19:20 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, louis.chauvet@bootlin.com
Subject: Re: [PATCH] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Message-ID: <ZpU9-Oa8quyfA0Gq@fedora>
References: <20240712161656.7480-1-jose.exposito89@gmail.com>
 <bef8086b-754e-4260-b3b5-e45744a714ab@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bef8086b-754e-4260-b3b5-e45744a714ab@suse.de>

On Sun, Jul 14, 2024 at 09:41:10PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.07.24 um 18:16 schrieb José Expósito:
> > Building with Sparse enabled prints this warning for cpu_to_le16()
> > calls:
> > 
> >      warning: incorrect type in assignment (different base types)
> >          expected unsigned short [usertype]
> >          got restricted __le16 [usertype]
> > 
> > And this warning for le16_to_cpu() calls:
> > 
> >      warning: cast to restricted __le16
> > 
> > Add casts to fix both warnings.
> > 
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 32 ++++++++++++++---------------
> >   1 file changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 36046b12f296..053fa6ce41a9 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -77,10 +77,10 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
> >   {
> >   	u16 *pixels = (u16 *)src_pixels;
> 
> You should rather declare pixels as __le16 pointer. Same for the other
> changes. See [1] for an example.

Thanks a lot for the quick review Thomas.

v2 is available here:
https://lore.kernel.org/dri-devel/20240715151625.6968-2-jose.exposito89@gmail.com/T/#u

> Best regards
> Thomas
> 
> [1] https://elixir.bootlin.com/linux/v6.9/source/drivers/gpu/drm/drm_format_helper.c#L420
> 
> > -	out_pixel->a = le16_to_cpu(pixels[3]);
> > -	out_pixel->r = le16_to_cpu(pixels[2]);
> > -	out_pixel->g = le16_to_cpu(pixels[1]);
> > -	out_pixel->b = le16_to_cpu(pixels[0]);
> > +	out_pixel->a = le16_to_cpu((__force __le16)pixels[3]);
> > +	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
> > +	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
> > +	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
> >   }
> >   static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > @@ -88,9 +88,9 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
> >   	u16 *pixels = (u16 *)src_pixels;
> >   	out_pixel->a = (u16)0xffff;
> > -	out_pixel->r = le16_to_cpu(pixels[2]);
> > -	out_pixel->g = le16_to_cpu(pixels[1]);
> > -	out_pixel->b = le16_to_cpu(pixels[0]);
> > +	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
> > +	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
> > +	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
> >   }
> >   static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > @@ -100,7 +100,7 @@ static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> >   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> >   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> > -	u16 rgb_565 = le16_to_cpu(*pixels);
> > +	u16 rgb_565 = le16_to_cpu((__force __le16)*pixels);
> >   	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> >   	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> >   	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
> > @@ -180,10 +180,10 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
> >   {
> >   	u16 *pixels = (u16 *)dst_pixels;
> > -	pixels[3] = cpu_to_le16(in_pixel->a);
> > -	pixels[2] = cpu_to_le16(in_pixel->r);
> > -	pixels[1] = cpu_to_le16(in_pixel->g);
> > -	pixels[0] = cpu_to_le16(in_pixel->b);
> > +	pixels[3] = (__force u16)cpu_to_le16(in_pixel->a);
> > +	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
> > +	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
> > +	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
> >   }
> >   static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > @@ -191,9 +191,9 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
> >   	u16 *pixels = (u16 *)dst_pixels;
> >   	pixels[3] = 0xffff;
> > -	pixels[2] = cpu_to_le16(in_pixel->r);
> > -	pixels[1] = cpu_to_le16(in_pixel->g);
> > -	pixels[0] = cpu_to_le16(in_pixel->b);
> > +	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
> > +	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
> > +	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
> >   }
> >   static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > @@ -211,7 +211,7 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> >   	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
> >   	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
> > -	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
> > +	*pixels = (__force u16)cpu_to_le16(r << 11 | g << 5 | b);
> >   }
> >   void vkms_writeback_row(struct vkms_writeback_job *wb,
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

