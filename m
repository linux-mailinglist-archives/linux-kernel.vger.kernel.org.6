Return-Path: <linux-kernel+bounces-518311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F1A38D11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CB53AFD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6B19E82A;
	Mon, 17 Feb 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3TLBvo+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41415149C41
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823331; cv=none; b=VuVOVT8h48Ljb3FzGgUFM9UtdfyQw4+NCbxByM86wQmvN2JF+l/vzWNlYWsoqTyXW4tF37Usjvt1xn2VjRa2BwHChaLZKsoafdRcOMdYKitJJRaYM0ur64Tj28ZmoIEt3ZQwiK2MysGuIqL33pypx2fK6V0CE+ydpF1+LV8y2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823331; c=relaxed/simple;
	bh=8hgtSq+DKZ5LHKar18MniLjf8PSgDafS9oaF0lbKPmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfET469Kipv2xYovCvzge+7Dtcqllpn+wdTiYnUcwwJ40PceKGuvwiw6nFuW+YaMHwlWKnFqiu8am4sI5uAUJSHilXH8AFtoRSv+OBQITDpxGh9bY7Udg/khiCWGqj0txYH+Af3rGYEb0X1gUjLqR3XzZVRb9zaFGzwF5M7hur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3TLBvo+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54622940ef7so1358132e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739823327; x=1740428127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRkHg5Ucp6RGHWusT3IEAggViQD31EKhbXy2GP0vglI=;
        b=U3TLBvo+Yr5tVxjsHUdnQFTP+C02TPJLU5VRJZNiEWxLiKUUwHLrOBhigjOFQljk9x
         jLXhiL0dIhDHWOdJDnidHL4Q9BoM4De1YwT7FtiN/8pDbfh6fOxA/RT8MupG8jxpMgXo
         kiVxMpEpSbxWD42TAbbdnAzE+kTRaWQXVbNvip5JxYRyZrBd8jGJG7+3G1c9y11cednk
         Xilbmswl+xsHEs8Z83ZWRbxnjD7+4A9c1QfM9gnwUw2KvkgbKHjzawMVoCVgktwycuNC
         Z8Q7F5dupYg+lrZzfQy+sn3SA9QsCsZwY6fAx6sk6mmXl0ONoZZ3tFibj61i3GRFCEkG
         ryMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739823327; x=1740428127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRkHg5Ucp6RGHWusT3IEAggViQD31EKhbXy2GP0vglI=;
        b=qNmqe+0TlXooSWWTV78X7WGCmtOJQR0LSIfAxxCtwQC6qFXK+xo2p16era8Lf8Nmdk
         nIUvfcz4zMULec6UyOKwg/YCpCW/AG1/YEOr54lJOchTap52eoW2TgvTw5vgjfEPppU8
         39ematbk+xmmM10tnpN2xfV7F5sCxF4Ue7VhHo7XoPFUXi5svMcvvzT20ZaNZDNb79Fy
         t3QVfVMG2h9Vtex8P76XhJI/gEI9+ieChg7wAcWIrFtadbzistT0q4B2esGPcdmKxZLo
         GaLCzvfg0nY/8Bs2IlNxk6qXHu+u0bPMDA1F2Q0eB5n+hG3FibBfyLqIJCL6e9LYiW9Q
         hJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJfUXOPTrt47eIfdIPkO7nPnwCxhvrzi9XHGvPG4fRH5xKVBMw9kd9LF854r8gAhGt7oLJpJj8M0k7y8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9IQ44/YD0FsxkJcy5sbvfUWsQe8PymbyA2mhbhAooVjZigDl
	8BExlCUPtkZFfONiBJ0+VHjANU7VFQ5cjNXSL5KNGUc37vYFy9Y6JlikSS2M8jc=
X-Gm-Gg: ASbGnctgfgntAoyYtst+SL6M/iuUB4btfTxPm++Ljq7CvljyyRxc5VYd09NvUeZTpks
	qwPzYcuOS1FW4I5eOdOcqYdtJEwROtIjYIXbOXWb3bLyF6jT9Hgs/rZtylWDqQ1GB6HH8reSxUX
	Y1r5lP+ohW8+OhsR4GfoYG7E5iRjuoapt2rBc4mVO5rarRwi4I0aXRtNQYxkp5pWd+v7EgA8SBW
	IVBThpFPfxFsDd9EU7Yc/loy/kEsq2tNYk1ds4pC+svOIiszAYJnVF9Wi74oRGmHKFQ40PZL6Kl
	jBuZs6XClC8r864v8M8qUmEPRIcwoQ7bVrLIcv90/0cRgrrrXrUsPfzeViN1sQK0i/RGvAI=
X-Google-Smtp-Source: AGHT+IHN4TQQDcSOwXKpfuPORhrxQ9cJeq7yFtgX9iUm7RPvnEU4xWfa1ad7OdRTHhcIA1rKUqRDiA==
X-Received: by 2002:a05:6512:3ba9:b0:545:1233:d4f9 with SMTP id 2adb3069b0e04-5452fe66b4fmr2845657e87.30.1739823327250;
        Mon, 17 Feb 2025 12:15:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54620544eacsm565555e87.136.2025.02.17.12.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 12:15:25 -0800 (PST)
Date: Mon, 17 Feb 2025 22:15:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, 
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Message-ID: <bdpw2g65uor77tijlhpabodog7haqvdcemnr3wzqkooerzuib5@hfdn5zsrbkgg>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>

On Wed, Feb 12, 2025 at 04:56:10PM +0200, Tomi Valkeinen wrote:
> Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
> container.

Is there a more common name for this format? Otherwise googling for it
reveals only your series.

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index cc7e1ef4ef21..07b03b0fe9ad 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -280,6 +280,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
>  		{ .format = DRM_FORMAT_XYUV8888,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
>  		{ .format = DRM_FORMAT_VUY888,          .depth = 0,  .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +		{ .format = DRM_FORMAT_XVUY2101010,     .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
>  		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
>  		{ .format = DRM_FORMAT_Y210,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
>  		{ .format = DRM_FORMAT_Y212,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index f936cac2aebc..7e8aa3bd52b9 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -246,6 +246,7 @@ extern "C" {
>  #define DRM_FORMAT_XVUY8888	fourcc_code('X', 'V', 'U', 'Y') /* [31:0] X:Cr:Cb:Y 8:8:8:8 little endian */
>  #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
>  #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
> +#define DRM_FORMAT_XVUY2101010	fourcc_code('X', 'Y', '3', '0') /* [31:0] x:Cr:Cb:Y 2:10:10:10 little endian */
>  
>  /*
>   * packed Y2xx indicate for each component, xx valid data occupy msb
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

