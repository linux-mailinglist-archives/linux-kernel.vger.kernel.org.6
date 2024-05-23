Return-Path: <linux-kernel+bounces-187283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5758CCF71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE0F1F22661
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3E13D2B6;
	Thu, 23 May 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSFNtl4h"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901A42040
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457069; cv=none; b=IqIF+y3cPkRTgYWiU+ozw18Bu4pdBPhxVqEhSKGGEe6hfHIuuH5XJ5RkMAxyvN2IRUYTcBG+Cqb39uyVC3o+vwpmWsIlChkVFPu2keb8p4WDj7Y4p1bIMIBZrqtT4tHqBkaYy4w0I5fb9CvfkJlhaEkJDaBX3oyElSK19vTlfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457069; c=relaxed/simple;
	bh=jPJ6DzLDX2BHRE6KsBDDylqHgEYcMKmyxOvYuUL0H/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWgwOAPReK82oMwk+QO5OhKXLSfQ8QjTCxl1zeXBmlVHDVjitaAdIM8wdKaz0kd9dq9Dl6uZ43zR83pYx2OIca3RXn76RExqMvQoxB9/LDM9zarYM1q3lA6+CP1Z57+UpIe0xDkVL+ZPqXsh2/n+Ws4Ko6AP0ps1DKKHNIlamSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSFNtl4h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e1fa824504so72408431fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716457066; x=1717061866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbtplpmpPo1tIVSyyQuZaq4Je2fwXqMCocDbrqYpVcE=;
        b=VSFNtl4hG1k8YZRDcZdV7eFS0IL95wYuOnr0Xf4Z2nQEk/Cl1tBP42S9tK7nmTA/6p
         ysnZveBbnv6MXEvCAD4r4905+MnHQ6z0qeXNVU2QvwdEY8u2mdRJZ7C/LATsj7JZXcKd
         /3XjKHA4F23EzWplMEfsWjt2e23zdW0OT++hcQhrNbYjGgYwo4mE66sRqfet5dDHjdhH
         MPQcoYimJCjaxCrL4/G8Hvd4sZIxjTjTqxiis58AA71PsnRbD1e41DDuCvacWerg2k5f
         zjy3IdrztMRZcQRItj6XwIAoe30Mz1ua6n7JeEz/vZlXWq6Tlv2SgIBu4wQQP6ydXj22
         PrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716457066; x=1717061866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbtplpmpPo1tIVSyyQuZaq4Je2fwXqMCocDbrqYpVcE=;
        b=wycx6xhhrOb/c2qNNuWABAbxTxuVpGYdnDnZvU+5RsvDojc9/BMBdpCWCZfffgsTeB
         QwfDKod+ReIa8Wv7p5HsDQwP3TF3HMnah2eA6Ig9HxjADt1tTFMQhjkOk69ehJJwVlaU
         LJQzB0tnt+Wskd2omNQ6dBITJbhwaUPMG/rIIOzCYdWZNs3WifBcD1hKMn0DQQ0XP+Wz
         9hrEyCcyQqwwTyEpLEZItNvICV3zoG2S05BxZ5u8PpGpkNv9/vGcphOBL0fLn1RVYZLB
         5xo0g0UJDlsiyIPnttngkTCH96p35tW17WcyJqn7a+cwOe0XzlC8X9or0FSlUyxJLoLs
         kl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxf0Z/ysgPfkHec3eRrV7lXVCEI7w7q8tNN/kunLNLqslYtSMZaesxINh6Fl+15A79qwo4bBeJsnQHm2+4Y2gHO5ontwqXreUFQho/
X-Gm-Message-State: AOJu0YxKybLHdt1gAmAtCbUmLXw+ZOJvs4BNmQD4ZVtwc+JEBg5MRuWb
	fsx9qtjhyd2JnaNelvngVeD3AyN2bJc4WLKEzZpuOlyDm+1kaA2iqbw3dMCNmGQ=
X-Google-Smtp-Source: AGHT+IHqJtv15hUgyIuf/PqlwYbirx+pXbxomvRBOWOOi94YU/Q64qb1oAcP8REV+yec+knrG9zq/Q==
X-Received: by 2002:a2e:9dc8:0:b0:2e1:18d:5b4f with SMTP id 38308e7fff4ca-2e949540b40mr26515691fa.42.1716457065632;
        Thu, 23 May 2024 02:37:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0bbcba8sm42053591fa.2.2024.05.23.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:37:45 -0700 (PDT)
Date: Thu, 23 May 2024 12:37:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v14 09/28] drm/display: hdmi: Add HDMI compute clock
 helper
Message-ID: <vjsv2fn4wdlzkcu6bkssbzv26hjihzrjvzzoynyabuju7sigo6@gnmyc4nqfk22>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-9-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-9-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:42PM +0200, Maxime Ripard wrote:
> A lot of HDMI drivers have some variation of the formula to calculate
> the TMDS character rate from a mode, but few of them actually take all
> parameters into account.
> 
> Let's create a helper to provide that rate taking all parameters into
> account.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_helper.c | 57 +++++++++++++++++++++++++++++++
>  include/drm/display/drm_hdmi_helper.h     |  4 +++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> index faf5e9efa7d3..679eb3e81393 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -193,5 +193,62 @@ void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
>  	}
>  
>  	frame->itc = conn_state->content_type != DRM_MODE_CONTENT_TYPE_NO_DATA;
>  }
>  EXPORT_SYMBOL(drm_hdmi_avi_infoframe_content_type);
> +
> +/**
> + * drm_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
> + * @mode: Display mode to compute the clock for
> + * @bpc: Bits per character
> + * @fmt: Output Pixel Format used
> + *
> + * Returns the TMDS Character Rate for a given mode, bpc count and output format.
> + *
> + * RETURNS:
> + * The TMDS Character Rate, in Hertz, or 0 on error.
> + */
> +unsigned long long
> +drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +			    unsigned int bpc, enum hdmi_colorspace fmt)
> +{
> +	unsigned long long clock = mode->clock * 1000ULL;
> +	unsigned int vic = drm_match_cea_mode(mode);
> +
> +	/*
> +	 * CTA-861-G Spec, section 5.4 - Color Coding and Quantization
> +	 * mandates that VIC 1 always uses 8 bpc.
> +	 */
> +	if (vic == 1 && bpc != 8)
> +		return 0;
> +
> +	if (fmt == HDMI_COLORSPACE_YUV422) {
> +		/*
> +		 * HDMI 1.4b Spec, section 6.2.3 - Pixel Encoding Requirements

This is probably 6.2.4, but it doesn't specify that it is 36-bit _only_.

> +		 * specifies that YUV422 is 36-bit only.
> +		 */
> +		if (bpc != 12)
> +			return 0;

6.5.1 allows using less than 12 bits (If fewer than 12 bits are
used...). So I think it would be more correct to allow less than 12 bpc,
but we'd still have to use 8 for the matter of the calculating the
clock.

> +
> +		/*
> +		 * HDMI 1.0 Spec, section 6.5 - Pixel Encoding
> +		 * specifies that YUV422 requires two 12-bits components per
> +		 * pixel clock, which is equivalent in our calculation to three
> +		 * 8-bits components
> +		 */
> +		bpc = 8;
> +	}
> +
> +	/*
> +	 * HDMI 2.0 Spec, Section 7.1 - YCbCr 4:2:0 Pixel Encoding
> +	 * specifies that YUV420 encoding is carried at a TMDS Character Rate
> +	 * equal to half the pixel clock rate.
> +	 */
> +	if (fmt == HDMI_COLORSPACE_YUV420)
> +		clock = clock / 2;
> +
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> +		clock = clock * 2;
> +
> +	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
> +}
> +EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
> index 76d234826e22..57e3b18c15ec 100644
> --- a/include/drm/display/drm_hdmi_helper.h
> +++ b/include/drm/display/drm_hdmi_helper.h
> @@ -22,6 +22,10 @@ drm_hdmi_infoframe_set_hdr_metadata(struct hdmi_drm_infoframe *frame,
>  				    const struct drm_connector_state *conn_state);
>  
>  void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
>  					 const struct drm_connector_state *conn_state);
>  
> +unsigned long long
> +drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +			    unsigned int bpc, enum hdmi_colorspace fmt);
> +
>  #endif
> 
> -- 
> 2.45.0
> 

-- 
With best wishes
Dmitry

