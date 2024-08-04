Return-Path: <linux-kernel+bounces-273946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462B946FFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6CE2812FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1C13699B;
	Sun,  4 Aug 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxHxxWiA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7571EEE3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791675; cv=none; b=ccW76EziHE1wr2EydOv3jvwuh47fqFt1BNuPfJ/ns4zawmcQ3c6R5ZYWYs4/DpLrwD/84WwJChO+/Sjm2gQj4abbo9RLLFzIe47MvZB6gCvXYWdjv2bfWXooQTpyYr8fzgPA4tjmhQ6f1l2n2/JPFZKW9qOSBR/ZDWnJmyyzkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791675; c=relaxed/simple;
	bh=nDXev3bBzvYDjacE8JnKe/sOKx1fOLIenf3flfS7Wyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of/IfC2YmX6sj1u/2cA61RjU72AasYSH7YJweuC7whpaucjEyTswZc3Od9T9aPlQmyTsXAi1vCk4dsCReKOXCb3NJmOVZpei0XL6+ehJAPIBCdqbd8FxuKMk9EO0sq+HKiLAMsiDxY39GwnzwjQ3sEKRaRi2my/v5VZKBVFyu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxHxxWiA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42812945633so68128075e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722791672; x=1723396472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p/4bczz6CJr9dhiOX7HKYOe1viOeV19Z0JANISgbZEs=;
        b=KxHxxWiAFn7gxYl6J88k2YxfdhlGjZTGlr251RxLXVCPzxAmxI0JzC4XMXuygSguA8
         bt5K2BCkTHt6G+fDdsrIgZN2wJKLMvS3rD3+cRbUJltKe8vZJqGgWrPG7yC+Pn4BitOk
         4tcIto0DGIKGziGA4lDIWdFkE7D3HizRmIXdl2/aLGbqHdLgwPammmHhVZedFYGIM4ek
         NDu8Fi0VF/WrE5ridhaS/egM31LaEvEQiRk/3tR4ojzTSqpkJZ4soPOQnRdlONkP/i32
         UcIaeipSOJynsKT91/63zFciiZLrSEWgIUFy0MnsggHFjkptgfSPEWyAb3HBmbyy9mhz
         z3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722791672; x=1723396472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/4bczz6CJr9dhiOX7HKYOe1viOeV19Z0JANISgbZEs=;
        b=Tk6tlQUdKFh18vlMyOYKtYvksEB81ZYa9I7BHh/o/lxcCvhCetgnCoEzhDOW2tu6p0
         LmX7l8kjUpTL1RLNR9W4Jn8hNE1jdzVpNFK5C+eES/Upe1fEM/ZNBI2G4bF+9l6quKVp
         9l1jGnaFj8R6+r0MiH4AIu6rRJIZq9n6Mp/w+F+KZ+137CU0GOU83FhsjT4+jChD/K96
         IpZq8NLrOI+PfBec8nQUhjZZjICyzs3QHtUjSS8yO2VDBF/hm4pT277ccuCyj2ZNdX41
         A8EDq1kSLNy3biusdUwhdI0aaj45dKBDiW9x7lTbcc66mwhZ8LCwEDncaUHQkgZU7E/d
         w+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXVM1jbZMCkXN5M6Qz4R0GlBGIgHuNRK0PN/+2KqhCByp7L/Nr66UOV4fqu+xmfTVWlm9tbRJDBWQ+Ty6XJ8G/g1tf7BCqLTY46ncN5
X-Gm-Message-State: AOJu0YwZ0qytEtUqyGQ6g9yysLMbBPlUZ4OhvGO+k8DOO+ok9kZZPTpD
	RsWiXGGuA0a5337KsrzmchoGIyKiuHHjWg7pIeW20TeMPHCiVrOY
X-Google-Smtp-Source: AGHT+IEKO5RBYTDzHkiZWGRWKYYN7qHNgy8QdQzVisJNOAgr683jPNUBW7oHzC2AkIen8oLpIjxcIg==
X-Received: by 2002:a05:600c:198f:b0:426:5c34:b19b with SMTP id 5b1f17b1804b1-428e6b00c7dmr67548935e9.20.1722791671988;
        Sun, 04 Aug 2024 10:14:31 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd05b92esm7541252f8f.85.2024.08.04.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:14:31 -0700 (PDT)
Date: Sun, 4 Aug 2024 19:14:29 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com, mairacanal@riseup.net, hamohammed.sa@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com
Subject: Re: [PATCH v3] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Message-ID: <Zq-29RHgywzw96xz@fedora>
References: <20240716161725.41408-2-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716161725.41408-2-jose.exposito89@gmail.com>

On Tue, Jul 16, 2024 at 06:17:26PM +0200, José Expósito wrote:
> Building with Sparse enabled prints this warning for cpu_to_le16()
> calls:
> 
>     warning: incorrect type in assignment (different base types)
>         expected unsigned short [usertype]
>         got restricted __le16 [usertype]
> 
> And this warning for le16_to_cpu() calls:
> 
>     warning: cast to restricted __le16
> 
> Declare the target buffer as __le16 to fix both warnings.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> ---
> 
> v1 -> v2: https://lore.kernel.org/dri-devel/20240712161656.7480-1-jose.exposito89@gmail.com/T/
> 
>  - Thomas Zimmermann: Declare "pixels" cariable as __le16 instead of
>    multiple casting.
> 
> v2 -> v3: https://lore.kernel.org/dri-devel/20240715151625.6968-2-jose.exposito89@gmail.com/
> 
>  - Thomas Zimmermann: Use cpu_to_le16() instead of casting 0xffff
>  - Reviewed-by Thomas and Louis
> ---

Would it be possible to get an ACK from the maintainers? It is a very simple patch
and it already has 2 reviewed-by, hopefully we can get it merged.

Thanks a lot in advance!

>  drivers/gpu/drm/vkms/vkms_formats.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 36046b12f296..040b7f113a3b 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -75,7 +75,7 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
>  
>  static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>  {
> -	u16 *pixels = (u16 *)src_pixels;
> +	__le16 *pixels = (__force __le16 *)src_pixels;
>  
>  	out_pixel->a = le16_to_cpu(pixels[3]);
>  	out_pixel->r = le16_to_cpu(pixels[2]);
> @@ -85,7 +85,7 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>  
>  static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>  {
> -	u16 *pixels = (u16 *)src_pixels;
> +	__le16 *pixels = (__force __le16 *)src_pixels;
>  
>  	out_pixel->a = (u16)0xffff;
>  	out_pixel->r = le16_to_cpu(pixels[2]);
> @@ -95,7 +95,7 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>  
>  static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>  {
> -	u16 *pixels = (u16 *)src_pixels;
> +	__le16 *pixels = (__force __le16 *)src_pixels;
>  
>  	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>  	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> @@ -178,7 +178,7 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
>  
>  static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>  {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>  
>  	pixels[3] = cpu_to_le16(in_pixel->a);
>  	pixels[2] = cpu_to_le16(in_pixel->r);
> @@ -188,9 +188,9 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>  
>  static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>  {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>  
> -	pixels[3] = 0xffff;
> +	pixels[3] = cpu_to_le16(0xffff);
>  	pixels[2] = cpu_to_le16(in_pixel->r);
>  	pixels[1] = cpu_to_le16(in_pixel->g);
>  	pixels[0] = cpu_to_le16(in_pixel->b);
> @@ -198,7 +198,7 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>  
>  static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>  {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>  
>  	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>  	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> -- 
> 2.45.2
> 

