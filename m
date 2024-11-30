Return-Path: <linux-kernel+bounces-426136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082929DEF63
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB205281BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA914A62A;
	Sat, 30 Nov 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKz6RwwM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C533F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955993; cv=none; b=cZ7WivjdjJDuEabd4WOKMBT0mBVrLaGfesZBtM2bXez8l5WxVTTGc6WpwDdLlijV/RzsFs4davVJr1x9o2juDY/iEeEYCaBpMTMJ/VBXSr3h5Gsn+uhtXGtdyAt6ObhfVDKzBzpPNxg9b464FNUFksdRNCFNgj9049JxrKMYk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955993; c=relaxed/simple;
	bh=+ABYhfmKYNgCozpTkF2oOSxzY3EsT5Dul4CT8WREsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwPW+AZ50S6KNnPv0VEyArmFJ3Jrw60ZIqorbAM8X7c0jtwu23qzDM5uG19Tv7jUgt4J1z31kjjF8P1Pq6PcIJxEbGCmzzZ82T50dfxzEhA0m1gM+bwrphlzbQ+2Xf4d266inQgi/2LVLNV0PS9Kkh7pZ8kGDgFRWD0ZYMNu/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKz6RwwM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so25868291fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955990; x=1733560790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60sx0mWw0yfKGfuq1JkGjNW0KfJvKS/QRfp4rQuI3pc=;
        b=LKz6RwwMcn2L/QRKASwlrIeZ6dNw5MItB8v2UnCcZrUOPmSQRSi3zR1kap85rBzzc8
         36IwbitQEOGn1q+bk+Jzm1SinLooEi39DxoO3KCfyZ8qROeZ9TB4IMLCqUFGaHbmq+9Q
         JZxzxKJl+7UNbn72JUDPkeS6z55uQIg2mYUP039fZcDNwLo2pM1EgSzQUiouaFRpZvqa
         SeI9OruBdtkyx/shLDFBFhzJb9Sl4oxQmXS25ZonV5s/Brh3G3D6EKmZxfOo1xp5GvKs
         e6V92kXSInLaM6LYCQZtipFs5vfsnhZ9ce2Am7v8fZEi29rdSokTv/lnYVsNiya6ZY7d
         y9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955990; x=1733560790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60sx0mWw0yfKGfuq1JkGjNW0KfJvKS/QRfp4rQuI3pc=;
        b=k65Wry4zmU0XBxGLhwBBTMuC2YgejkhbDzKMAbNoFotVzQpNt3CtB5wimmC4wCZtsX
         SZJrzz0dhWG2pbdnXC8Nf469fhl5asOgNE0Vi93rCdqORA941ONtlQshkeEivVwDvfrG
         90GC2aGtxvwPK+S28vl5ScV61BuVJZ2XB64NohPnyr0mdZVB4wxscDnY6S0QKddqP0ks
         FZ2IbC4s4V/1gaLHG1J0thhC7uTZ27YPIh1igNItL7v+sqE6/IsNuc5zF4duTmwE4yXd
         ZReotZZYUSRkJu2HB5faGC/urb8zisFwLDt34HmOdmlxmhmOxqj+FSaCyacaPlZexA8M
         YOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhww9qlFjNz5UZT2wJ7iwfvTW3vK3jbqhWXtzY7CqceKTET1Pjb0j1tzDTPS6NDwcAiVRMGRL4NXzX2uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJbvxhne4AUq0V46kxtbJ8KAQoeTRap3osKLjgeHE5OXn+lFZ
	Lpd0A/He5UMVAEgwCq8HeakkOPYpM9K5hDMA60oFkQiKgXYEGPq+KezQ0tf6xyo=
X-Gm-Gg: ASbGncvzwFJgmZML5rT95y6VdbfO+k+ZWHCDUHoikDmy1Tuw4VlZuKJCvlzIllQpxuI
	zZ5VpdArLe/vAbj5pJl7Ql7uBRi4K7RE8+D+UJSzXfdCITS6BKrIp7gE2NK0YoXHEMR2BTsp7Sh
	6w7iMVy6PZJBaxI7zKkXxg79abptz6Jqqnu/+a3isq05tCknMJFltUAvBXAdRpK2wS6Kcel8mYd
	9hsd+qaOOk8xmCqUKdUTa3knJ5OVoGqKjzll/Paau7sZFLDWekUolBEx47p1xYwPt531U7P11St
	C2zYfDmhTPMijbUNze2GU1zi3uKk1Q==
X-Google-Smtp-Source: AGHT+IEZ0VPvlTILkrhYt48fs8ZlxgdXNHcVOZdYnoICSZyUeiM50kM2bpLGagJTYYGxnqPFfP1oYw==
X-Received: by 2002:a05:6512:3e1d:b0:53d:de4f:a15 with SMTP id 2adb3069b0e04-53df00c74aemr8303777e87.6.1732955990159;
        Sat, 30 Nov 2024 00:39:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0666sm706052e87.276.2024.11.30.00.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:39:48 -0800 (PST)
Date: Sat, 30 Nov 2024 10:39:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/connector: hdmi: Use YUV420 output format as an
 RGB fallback
Message-ID: <w66zx533ugdapxvs6mtks7wj3tyqdu334t33mbb6i665m2fiqk@r4qtm7linuvv>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-3-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-3-254279a08671@collabora.com>

On Sat, Nov 30, 2024 at 01:56:34AM +0200, Cristian Ciocaltea wrote:
> Introduce the switch to YUV420 when computing the best output format and
> RGB cannot be supported for a given color depth.
> 
> While at it, add a minor improvement to the debug message indicating the
> supported format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 3a55881a544a519bb1254968db891c814f831a0f..b4e865e0680f35fd2d849536789f6c1f98a48258 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -304,7 +304,7 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
>  		return false;
>  	}
>  
> -	drm_dbg_kms(dev, "%s output format supported with %u (TMDS char rate: %llu Hz)\n",
> +	drm_dbg_kms(dev, "%s output format supported with %u bpc (TMDS char rate: %llu Hz)\n",

Correct, but irrelevant. Please split to a separate commit.

>  		    drm_hdmi_connector_get_output_format_name(fmt),
>  		    bpc, conn_state->hdmi.tmds_char_rate);
>  
> @@ -319,15 +319,16 @@ hdmi_compute_format(const struct drm_connector *connector,
>  {
>  	struct drm_device *dev = connector->dev;
>  
> -	/*
> -	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
> -	 * devices, for modes that only support YCbCr420.
> -	 */
>  	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPACE_RGB)) {
>  		conn_state->hdmi.output_format = HDMI_COLORSPACE_RGB;
>  		return 0;
>  	}
>  
> +	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPACE_YUV420)) {
> +		conn_state->hdmi.output_format = HDMI_COLORSPACE_YUV420;
> +		return 0;
> +	}

Should we prefer YCbCr 4:2:0 over RGB?

> +
>  	drm_dbg_kms(dev, "Failed. No Format Supported for that bpc count.\n");
>  
>  	return -EINVAL;
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

