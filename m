Return-Path: <linux-kernel+bounces-518303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A8A38CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6B174BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081DC23770D;
	Mon, 17 Feb 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxwta0y8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DC235C11
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822428; cv=none; b=tMAQjUqcFAJ6v+CCfXJFlLXT64lcYE5MMDsHSa4sZjpFUDR/03V879+1XjdyhFh1bm0jpVz70tpTBOZPwI34VgLupB2zyU3by1H1YgygpNM2SdYg5LtkYCuEMvURRc7I3XCh/8FVGcBIeWV651vFEvfqNImZFJj/D/uDhAlA/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822428; c=relaxed/simple;
	bh=YHEvzk9S5CFELMOEHTtph2rlFu4VkRtoPj93+QGVF1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojrKPblEwnEHGp12jhgRr69HbvLz/XkdLvtWeejw7hm4Xzn0+HQxraizTgi1oYZ4eDLc5HZYJ54K8Y4VZ5s/jpXo3OQinJjK8YXa1oUy6K2lw/DVi6KVc2ePFVCBYNIO0b0L9hxi6KDdAgFy5A+ab2eLFfxJ3Ww3DP/ZspfvVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pxwta0y8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54527a7270eso3398955e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739822424; x=1740427224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpqEL8DpAJMrJ/rNxfQI3uKIUT/9KC6tNWKUzxHa+5g=;
        b=pxwta0y8ScDL8+J7TnP1QGMKJ0T4Fmf8F1E4AqqGNnm+XaNCBUtUYYCwFYxvK1gDou
         nTQ/nzEABq22wS5W7epinkjWlJHBK8MteuLWdyN3f8oNDoJLbw9m2NclW7MpjaTEGUEX
         BuI2TvnSwxIMNvMAbzzserfC4EWqHNG11tWmir4ye7aPw1TTs30yO1jU9SQVSMB2JBiV
         KdBcHmmcsdlJeyA0bQmGfRQYzE73yfHQTC0ZDvZ0qZL+ho50cTwQtjvE8KIU8Q3cZhbp
         l4MNxOf009TFTFHP5vvBeFEqRZC71p2RvCT9lLK9Co4M3d6GoLcPmz1C1sRkBxa/sNf+
         pDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822424; x=1740427224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpqEL8DpAJMrJ/rNxfQI3uKIUT/9KC6tNWKUzxHa+5g=;
        b=eh78z29DDKxUj24uP7ttb1QdvqiY9V7byFWerBQw2cspZ2mJLKpZcZef8jbBnTTqpM
         SID5hoZ+QttGR3n8WI96XqfepQzPdIcoHYiRmmiexdHcXPyp5HBF/sssVU+wY0gnyRnY
         LMIOrcKXYqghGXMymcWXHPsfIiPDbjdf02IKeF6UE8uQplF56v0JS8tl28MTfJRM/dga
         Wla1lqMBeztmkszCqWQiz4YkHCVhUVxvRyWtB1L+KLJ5hPDncWKKqqjF+STSKRaqll9u
         5XBW89ExbkWzWwpPObXytJtAT/VJdI9weP6SUOyocisfcRyRywruesfFt01YC4ngdHft
         0LQg==
X-Forwarded-Encrypted: i=1; AJvYcCWoB1Q5vhqLHMu1nF3kX/49F9a+hTgJLWeZ5Xb4KaQF8fu8d7Z1nMJ0r20qD471NT3kbZAA6z4SLbSoe/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5BQiPXaa+9NNo9VWD8uHRFoNQIPBJ3ZwumLIBb243zEQaEE4
	zJ4kCENwBQcBRFmlr4kcn0+P4//r2PnEqgNujcPjHQVJtzkis3TdYt+qqFnGlSg=
X-Gm-Gg: ASbGncvq/93NXwvecV19c0xMxG7+RyjC43dxVeOOlYEB1KuF38TlJxGEppYCz/1XJbg
	w81Mfg/amMNITBGgeWuzEmSjfFNF56YdAx0JCzDhtSGL8JY+m0bvWfGweGaidwAua8DIB9nHrgj
	SWAofTQHdPB9ucfmYBO57imUmlJIJ1bpEjXC2KFDj6VnvqnyZNff1hAAHwpVO17yT5O6OIfbMN/
	2HlDL9q3rS2T3GqMNnrhLjE4aEooJa40eqcL+Z4Zv/TryvCovUllDc2TOQ3TPWjnyTx0wzJDXTj
	zAuHhfvT1bFOlGvpNNiM/UaD/ksHp8KqMD2g6OxfrfwIx7yCr9IC0cXWxGy38gDMgDJJoUs=
X-Google-Smtp-Source: AGHT+IHfYFHYucbMv9ssVZrygfyI/KAzMXlRnYVSK6/tZCdLiSCDTSlyjiu2Y9vqwm/0Wc+nrvZGmQ==
X-Received: by 2002:a05:6512:2398:b0:545:2c86:17e6 with SMTP id 2adb3069b0e04-5452fe2f270mr3457419e87.5.1739822424412;
        Mon, 17 Feb 2025 12:00:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54525784de2sm1436453e87.109.2025.02.17.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 12:00:23 -0800 (PST)
Date: Mon, 17 Feb 2025 22:00:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, 
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 02/11] drm/fourcc: Add DRM_FORMAT_XV15/XV20
Message-ID: <e5ujn5lhj5vuvkbavoc3oppt3cpxnr7mm2vwh6liojmpxkfy2d@grpmckvbl5h4>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-2-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-2-90d0fe106995@ideasonboard.com>

On Wed, Feb 12, 2025 at 04:56:06PM +0200, Tomi Valkeinen wrote:
> Add two new pixel formats:
> 
> DRM_FORMAT_XV15 ("XV15")
> DRM_FORMAT_XV20 ("XV20")
> 
> The formats are 2 plane 10 bit per component YCbCr, with the XV15 2x2
> subsampled whereas XV20 is 2x1 subsampled.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 8 ++++++++
>  include/uapi/drm/drm_fourcc.h | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 1e9afbf6ef99..bb0a2294573b 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -346,6 +346,14 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_P030,            .depth = 0,  .num_planes = 2,
>  		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
>  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> +		{ .format = DRM_FORMAT_XV15,		.depth = 0,
> +		  .num_planes = 2, .char_per_block = { 4, 8, 0 },
> +		  .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
> +		  .vsub = 2, .is_yuv = true },
> +		{ .format = DRM_FORMAT_XV20,		.depth = 0,
> +		  .num_planes = 2, .char_per_block = { 4, 8, 0 },
> +		  .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
> +		  .vsub = 1, .is_yuv = true },

It might be beneficial to use the same formatting as previous entries,
it simplifies reviewing. If the patchset is resent, it would be nice to
get that fixed..

However the patch looks correct, so


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



>  	};
>  
>  	unsigned int i;
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index e41a3cec6a9e..ead756a71825 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -304,6 +304,14 @@ extern "C" {
>  #define DRM_FORMAT_RGB565_A8	fourcc_code('R', '5', 'A', '8')
>  #define DRM_FORMAT_BGR565_A8	fourcc_code('B', '5', 'A', '8')
>  
> +/*
> + * 2 plane 10 bit per component YCrCb
> + * index 0 = Y plane, [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian
> + * index 1 = Cb:Cr plane, [63:0] x:Cr2:Cb2:Cr1:x:Cb1:Cr0:Cb0 2:10:10:10:2:10:10:10 little endian
> + */
> +#define DRM_FORMAT_XV15		fourcc_code('X', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane 2:10:10:10 */
> +#define DRM_FORMAT_XV20		fourcc_code('X', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane 2:10:10:10 */
> +
>  /*
>   * 2 plane YCbCr
>   * index 0 = Y plane, [7:0] Y
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

