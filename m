Return-Path: <linux-kernel+bounces-279069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C278194B899
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491991F24A71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B771891D2;
	Thu,  8 Aug 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USJ7rTqs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697B13CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104552; cv=none; b=bP5oAB/EziMJ6UrVkkRTi0W+2cFI/H0T2Ebs1bDXkgF7c01/sVmeXrqlq47XOKxX7y5LumHB8WtITX7npILKEFiTf+/kxCR8AbLdoC5E7ei7poMpvbz4nSv8GDqEbLSXvyRV9r/8xtDtxx6ZQBh+v0t8Wc+8Ni2xkcF5pg2gPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104552; c=relaxed/simple;
	bh=SdXlOnE0GfJztDOAYn9R9b/2ZqeUxLAxhKWL9Gj0G9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEIHgNBUM75seNqDtlXtN+CGRzom1OWqp8QZekkaJMrxLR4LnVxAiNUEiP92NSUxDaL2pV1oyHFPID3NoIanUnvOIfdO7v81YsHC3ZPh00QSqdkRW6e8ybKai1Dm3ltzUsiY0gQY/o8UaLA/bOd4DxO/edLbQYmiF9ajj6j5QkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USJ7rTqs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso6901635e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723104549; x=1723709349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zNylQ6r6tzWOpIxo2dSSJXNR2tVraIPoTch3dKn0+U=;
        b=USJ7rTqsskSvRp1at8GnrdJe9AJAQkc7KwUuvYwjui6ahVXWw3Iuds+7gu+BvqU9nn
         pv2IbrPTV03ZI6kvDnroawvFMui+LUeIPjgLzWlmlJbEzwLXPI3zBXKuilwU8qB799il
         B0/ukeF9Qnjw6PXEGdlST5NAJBV6e02X13/EmE49VI7OEakHdV1rR6adpbxZgZgVW1pI
         ib36PMF8DJuXH9lQkAEQUGVXevQzDp3XxG022g3/go9VTWnZDgD4x97rNif+wsAN6/V4
         4s5C7+rXKvrvsd9hTtdNeK1KlAZyP/tnA+WojTR9WSwtLBhOAIw8MfkgaNAwWMA0tNZ9
         L2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104549; x=1723709349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zNylQ6r6tzWOpIxo2dSSJXNR2tVraIPoTch3dKn0+U=;
        b=rAKn4qTWNOQuXQ7vKBE9IPlZJriClTRI5h7Gzko5i+zxAFRfUxyJq6MtoxJvsJUN4x
         cTKFZ+uNgaGmnjPJHc1LtTuwWOrrJ8eZwa4Xn1gvg2kcc8fUEvqVZPAx559lst2bJSun
         deJxSSXfDKOBh0YWX8CWgAwoAqqVqkN72eoR4Lvr0iTo2IZkuSsjJxMbix8OXuVgeAKj
         zeVLilsPUunbwahajFeYaNRIhKpeYLcmT7H1K4Fd7vNSQXjOvZZ0p/hkrg5t0sODWXUf
         gw3GRm6kpJ/WMqq8WZuz8ygfcmnd/+Klnk4MZuNA18zYqsEXumU6i77EYEi5HH9kfvM2
         breQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3SdBXEDn5nhHEhQrLteEbBTkdcBSX+24YpvA8qZWKKDq5HfLqROZidomP1lydpguKt5aEYDMNdb/T8kXlod5h4Ja8M/5agag0I2Ez
X-Gm-Message-State: AOJu0YxZcxF27VvLFVo0kHySFiIOHUWTxMQc1/xNI/3ezOpL9bBEb3bJ
	fQipQd79ubt7rxIdTPw/je3iobPhgm9Etz8RKDmZmdNMe8htON3IjPxx+IVv
X-Google-Smtp-Source: AGHT+IHIM8wXBahqOwgKzjcoQdcYhjqSDLtYmrBYsWVI1x3jxLkh/PyMNyugYuaHW1wapDhY4Gj7lw==
X-Received: by 2002:a05:600c:4f95:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-4290aeee05bmr13418635e9.9.1723104548324;
        Thu, 08 Aug 2024 01:09:08 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738e01sm9640885e9.11.2024.08.08.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:09:07 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:09:06 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com
Subject: Re: [PATCH v3] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Message-ID: <ZrR9IliUJB3mQi4l@fedora>
References: <20240716161725.41408-2-jose.exposito89@gmail.com>
 <Zq-29RHgywzw96xz@fedora>
 <e6913c12-14a3-4c00-bf07-90a72313dd39@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6913c12-14a3-4c00-bf07-90a72313dd39@igalia.com>

On Sun, Aug 04, 2024 at 05:46:55PM -0300, Maíra Canal wrote:
> Hi José,
> 
> On 8/4/24 14:14, José Expósito wrote:
> > On Tue, Jul 16, 2024 at 06:17:26PM +0200, José Expósito wrote:
> > > Building with Sparse enabled prints this warning for cpu_to_le16()
> > > calls:
> > > 
> > >      warning: incorrect type in assignment (different base types)
> > >          expected unsigned short [usertype]
> > >          got restricted __le16 [usertype]
> > > 
> > > And this warning for le16_to_cpu() calls:
> > > 
> > >      warning: cast to restricted __le16
> > > 
> > > Declare the target buffer as __le16 to fix both warnings.
> > > 
> > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > 
> > > ---
> > > 
> > > v1 -> v2: https://lore.kernel.org/dri-devel/20240712161656.7480-1-jose.exposito89@gmail.com/T/
> > > 
> > >   - Thomas Zimmermann: Declare "pixels" cariable as __le16 instead of
> > >     multiple casting.
> > > 
> > > v2 -> v3: https://lore.kernel.org/dri-devel/20240715151625.6968-2-jose.exposito89@gmail.com/
> > > 
> > >   - Thomas Zimmermann: Use cpu_to_le16() instead of casting 0xffff
> > >   - Reviewed-by Thomas and Louis
> > > ---
> > 
> > Would it be possible to get an ACK from the maintainers? It is a very simple patch
> > and it already has 2 reviewed-by, hopefully we can get it merged.
> 
> Acked-by: Maíra Canal <mcanal@igalia.com>
> 
> Could you please apply it to drm-misc-next?

Applied, thanks a lot for the ack Maíra.

Jose

> 
> Best Regards,
> - Maíra
> 
> > 
> > Thanks a lot in advance!
> > 
> > >   drivers/gpu/drm/vkms/vkms_formats.c | 14 +++++++-------
> > >   1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > > index 36046b12f296..040b7f113a3b 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > > @@ -75,7 +75,7 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
> > >   static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)src_pixels;
> > > +	__le16 *pixels = (__force __le16 *)src_pixels;
> > >   	out_pixel->a = le16_to_cpu(pixels[3]);
> > >   	out_pixel->r = le16_to_cpu(pixels[2]);
> > > @@ -85,7 +85,7 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
> > >   static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)src_pixels;
> > > +	__le16 *pixels = (__force __le16 *)src_pixels;
> > >   	out_pixel->a = (u16)0xffff;
> > >   	out_pixel->r = le16_to_cpu(pixels[2]);
> > > @@ -95,7 +95,7 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
> > >   static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)src_pixels;
> > > +	__le16 *pixels = (__force __le16 *)src_pixels;
> > >   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> > >   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> > > @@ -178,7 +178,7 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
> > >   static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)dst_pixels;
> > > +	__le16 *pixels = (__force __le16 *)dst_pixels;
> > >   	pixels[3] = cpu_to_le16(in_pixel->a);
> > >   	pixels[2] = cpu_to_le16(in_pixel->r);
> > > @@ -188,9 +188,9 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
> > >   static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)dst_pixels;
> > > +	__le16 *pixels = (__force __le16 *)dst_pixels;
> > > -	pixels[3] = 0xffff;
> > > +	pixels[3] = cpu_to_le16(0xffff);
> > >   	pixels[2] = cpu_to_le16(in_pixel->r);
> > >   	pixels[1] = cpu_to_le16(in_pixel->g);
> > >   	pixels[0] = cpu_to_le16(in_pixel->b);
> > > @@ -198,7 +198,7 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
> > >   static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > >   {
> > > -	u16 *pixels = (u16 *)dst_pixels;
> > > +	__le16 *pixels = (__force __le16 *)dst_pixels;
> > >   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> > >   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> > > -- 
> > > 2.45.2
> > > 

