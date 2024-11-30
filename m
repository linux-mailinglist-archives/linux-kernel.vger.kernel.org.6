Return-Path: <linux-kernel+bounces-426156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB019DEF9B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE00E281604
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14CF14A60F;
	Sat, 30 Nov 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0iZSo34"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAF7083A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959341; cv=none; b=KR7HOsyDagYejlbdTa6tWAcUU4ypptytUUYeYauVXl6dZ3Iqlbaoakbz0v962A+c+OpZVzlbtGdAPCtHicOllW8wgbsOEZALN4rwcWDMfmnwKXAxH7ECxHRXTtzt3wR0OtM2NZJFsQZanIw9lLSbAdIge9S7AZYWL7OeVRbBuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959341; c=relaxed/simple;
	bh=YAPIWZ+2TdFjhG9dutenVS7y+qNnSmr0JSVMDPAVx6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvnRIjS/xk8k4mFpCqQBIZSyHXPQCuLsQr0r6FkROH6aByaBlmZU1F9x7FtP7BPs4tbyYdHmBi0Tsoi2GU39vTrBXfEnU0zJIE8bV9GFWDAKXOPg2Mthd3hfzIHEHEu6FldR5NghrNaRcWub3L6Jq70btze4WiPPUcoaSSfQEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q0iZSo34; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de852a287so2803569e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732959337; x=1733564137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJpAceZsvwXrkIr1FtmUK4kMCTXmq7VlVQ0IrLAf8OE=;
        b=Q0iZSo34urcIbhCfD0ik0I/IrnEU2FIMuvW4G+KMWUieFv26Dz154N7EQpjOYoXXz9
         hBhM6lV1iDkXrEYx193Zx6bP04+rKBZDlXRAoSRcky85zmxHd6gzD78FsMIJ0+kLxuV8
         Hm3VCJKdLqXbY9VYCzWGZFqrmR6q338PWTW13UDMUqaJDy1O+8NjIpnZR0xQ12sDJ4ey
         ccf376yA9bKiNqHeV44EXRUC+5+VvlVrkeXy4ItZUBR6HoTga5tJZ/IjlHtccULa9yTF
         WX3x8bbxTYz2ruVeyk2xz/wH1VilNGKDPttAqE3oLYk4Mujq86xwjmPsrq0hCtsS0HuC
         GpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732959337; x=1733564137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJpAceZsvwXrkIr1FtmUK4kMCTXmq7VlVQ0IrLAf8OE=;
        b=EpfKli6ZMzlXpQRd8pJbvbPCptT72LkIpBBodYXlY0lKzkMLU5eMotD0zUs5pkJr4X
         SojsD8xJ8W44HZnwNSTGMFUz/PrUsEjDHAzCuPqjS7mNpV/O2T6ZAVRykwIot6ZKCT/7
         3ni3cdH1wuOgI3NrWicvrDYw4wniguacNPj4jmnDtnTayeBqzlIhinlzE6xb3/P7wMPX
         23PepStQQeHNL/qP2CPH8thm38ZQi9R8k8uPCXykpqaWN3346KCkCBIjnJrBxImYFrkG
         YrHfOIRsFphpltnL10r2lQ9gpH4kMvz2Le8upKrGb2WkVzlFNQTJMj2/8pZsYgaSQN9J
         Tbnw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2IS5ZVpdFpWo+a/fpnKFBgZDOygBldGTKxbi6PRaV1xh9+erBUW5//rSp1lTRRrOTgxf7etO7NWp9hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVwlpugNXMILy+8BfLykZo84idD3jkDf3lmy0XeMc6RmutxzR
	QCXh1ksF4U2d8G9BRdjLXn/4XbQtoBG+Sg0PSKZX4s3hcziIgQ8Su80Ho3WnpcU=
X-Gm-Gg: ASbGncvAiZ0iWg3k9ZfT7jqcFxxE0/ojP0YK8/DxXHsueZnnuv1WGwuOPN53HwKi9Iu
	lfsJuXK1vIYrOpuWiyqaP8wdeKgnO9b7phwKzZkzo6A1yA+G0/XMHnmWiZ3iWgQgN3X0w5gwwSS
	6LVCfgwwZa/XgnDr+GdK+CZO1RK6h8LeldKtAOfaZkiLwO39GK6qr4MMkSFk+c1oYrPVbAUqDb/
	ThkURQeHgaI8dAchpcFi+2xXk4GXQMlCoRKKcDKAYKyQt6oAWSFaEElX7hF2LJPo/3MJN5CpUf0
	gowgJywabwlC0/K7fPuAEoNi8oM0AA==
X-Google-Smtp-Source: AGHT+IFbMjYux+SSZ96v0jN8KYReJVZhl0TeMioEfshmhbV98iI9mESjw7Z64iU8uw4lxUzUNRlHYg==
X-Received: by 2002:a05:6512:39d0:b0:53d:e5f0:32bb with SMTP id 2adb3069b0e04-53df01120a0mr5805994e87.51.1732959336835;
        Sat, 30 Nov 2024 01:35:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64432d6sm722760e87.85.2024.11.30.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:35:35 -0800 (PST)
Date: Sat, 30 Nov 2024 11:35:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nikolaus.voss@haag-streit.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
Message-ID: <lio6natmz5d5hdmdxwuj5ghfbpl4medb2orhw2m27m6g3rvaga@tanmydgbufg2>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126172610.AD8B51622C@mail.steuer-voss.de>

On Tue, Nov 26, 2024 at 04:45:54PM +0100, Nikolaus Voss wrote:
> LDB clock has to be a fixed multiple of the pixel clock.
> As LDB and pixel clock are derived from different clock sources
> (at least on imx8mp), this constraint cannot be satisfied for
> any pixel clock, which leads to flickering and incomplete
> lines on the attached display.
> 
> To overcome this, check this condition in mode_fixup() and
> adapt the pixel clock accordingly.
> 
> Cc: <stable@vger.kernel.org>
> 
> Signed-off-by: Nikolaus Voss <nv@vosn.de>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 40 ++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 0e4bac7dd04ff..e341341b8c600 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -104,12 +104,14 @@ static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
>  	return container_of(bridge, struct fsl_ldb, bridge);
>  }
>  
> +static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb *fsl_ldb)
> +{
> +	return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
> +}
> +
>  static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int clock)
>  {
> -	if (fsl_ldb_is_dual(fsl_ldb))
> -		return clock * 3500;
> -	else
> -		return clock * 7000;
> +	return clock * fsl_ldb_link_freq_factor(fsl_ldb);
>  }
>  
>  static int fsl_ldb_attach(struct drm_bridge *bridge,
> @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
>  				 bridge, flags);
>  }
>  
> +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
> +				const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)

The driver uses atomic callbacks. Please use .atomic_check() instead.

> +{
> +	const struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
> +	unsigned long requested_link_freq =
> +		mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
> +	unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_link_freq);
> +
> +	if (freq != requested_link_freq) {
> +		/*
> +		 * this will lead to flicker and incomplete lines on
> +		 * the attached display, adjust the CRTC clock
> +		 * accordingly.
> +		 */
> +		int pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb);
> +
> +		if (adjusted_mode->clock != pclk) {
> +			dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -> %d kHz)!\n",
> +				 adjusted_mode->clock, pclk);
> +
> +			adjusted_mode->clock = pclk;
> +			adjusted_mode->crtc_clock = pclk;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>  				  struct drm_bridge_state *old_bridge_state)
>  {
> @@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>  
>  static const struct drm_bridge_funcs funcs = {
>  	.attach = fsl_ldb_attach,
> +	.mode_fixup = fsl_ldb_mode_fixup,
>  	.atomic_enable = fsl_ldb_atomic_enable,
>  	.atomic_disable = fsl_ldb_atomic_disable,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

