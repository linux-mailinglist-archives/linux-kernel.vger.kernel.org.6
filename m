Return-Path: <linux-kernel+bounces-334527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB897D859
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B85282AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26D17E015;
	Fri, 20 Sep 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIivEpfN"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832E17E003
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849778; cv=none; b=YjREDxBzSTG4utv0zNhJNdbOSNLju7zCIbjBr0R5RWoZLvB5+zuXx3104cgBSL+rJcAn0TtR/7EhrfWDkibrW+c/6NvotRBjCZkw2itazj/ZizZuUOs9q61VIaT3CQXslaFllVVPsSZA2QWTcHtYSpjG5ht4yYzO/Pe67kIkpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849778; c=relaxed/simple;
	bh=TN0NJfVZUKW3GmXh3PRo+7KhLjpRvz74v7ilmzZY0No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHjcFh1waX/yz/EwBQ74bztWPWPNOkedfB4YsT1Lzzdrl1vJ4/y409KGZtg4u8nYkawMI+rFH3LK+KEqqKL8hF3XcOwNF2NtN8gFzsOyZp6Rob4q7xh42iEGCqos3ZboRX5dr1DBPKNVkgn3vDW/os6bHJbAmtpPl18e5snxJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIivEpfN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5356ab89665so2982097e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726849774; x=1727454574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfditimrKF4JK7u3yX1xKfHCsL9hDUk5eltnda23Uak=;
        b=WIivEpfNgvALdSrwWsdug/t2XJKcSYffmyI8j5G6Klfpr0buxMLAMw/TWUUbEVzFsg
         sbqAoBiDC92qRm+n6wdKujEFXMD9beGfAx9yXWG24AcaAs+KW80barXXnPsUHo4K5WkP
         BwhQR7i2msXQjI3WeYNANp1FUnYfyHQvRVT7p+K71OXQCJKw6dmLi9jt3YFSrg781Cmo
         iZTf2Dd8G9MZVb/4dfMcEKrZv1yFEmKZNHYR8/p846lE/bhRfm2ggW5NqDtIWYlsUGjF
         Juvbp2B8PRHHfUMjH3nOHXdqY5sCOgLFr733HGATiJ5SOVz5iYeiecBW/4xMyXDv2U6O
         T3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849774; x=1727454574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfditimrKF4JK7u3yX1xKfHCsL9hDUk5eltnda23Uak=;
        b=IDr/0aIWrTq+kEaI5aIh8588LFnyUcZM1mq3qJPC/g6KYardXZQbe3gmRNlHmC6GUw
         7DMUZeaaQNXXzP6pJpdC3tYJFdBI7AnhretWdbMobP+QsVoWMkxMpwGVpxoGWHjJOKmz
         JuEFzxspIQijigVzxuu1dyXk5qSgem7dEhHPau5D0BAOoI4Ty8+KkjtXdVU22OZlQmHj
         +WW4ERR/QeDDUrGRDlVZnJC1ZEfKN313OCXxZKAj6502T191dL5qlg7DmmIPXpgFhM5m
         dslHu2x8OCnthbGNlCOEV+YOjGTiSm7iLUdNjfk1A4C7/s6FxCUpMdipT3FNRVEOtmGd
         IL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXtWXOwoEd6PojcPfV4LS5ND7lED4FrSmPkLGnG+7SnUj0blX6kdCDWRpKg8SzLxuPkUBQp/JfGZdN8KCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9/1YaScsDC5WEBJFjWvsswT5j/39snVk3aLJ1qiktp3pYJgz
	AM3edMhuVvGNmDbzTWB1AAzhD6PZNfV/7wMtaLWHp0yQobAvZ5sx5ROwpe9myDQ=
X-Google-Smtp-Source: AGHT+IE1LZCxErRgPXK8fC0M6EtENAw/5XRWiIO/oy6Uyv8AOGscn4kh6HaF6ktB+yZZ3J0CygZZ2Q==
X-Received: by 2002:a05:6512:3087:b0:52e:91ff:4709 with SMTP id 2adb3069b0e04-536ad161af5mr2458077e87.21.1726849774195;
        Fri, 20 Sep 2024 09:29:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a8700sm2240915e87.221.2024.09.20.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:29:31 -0700 (PDT)
Date: Fri, 20 Sep 2024 19:29:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dianders@chromium.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
Message-ID: <c3wv3r44cmua2hphyjqzb7pp2a32pvs6svcj6s2zohp77qn3cr@4iica7j5bx5l>
References: <20240917071710.1254520-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917071710.1254520-1-tejasvipin76@gmail.com>

On Tue, Sep 17, 2024 at 12:47:10PM GMT, Tejas Vipin wrote:
> Changes the elida-kd35t133 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 107 ++++++++-----------
>  1 file changed, 45 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> index 00791ea81e90..62abda9559e7 100644
> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> @@ -50,55 +50,45 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
>  	return container_of(panel, struct kd35t133, panel);
>  }
>  
> -static int kd35t133_init_sequence(struct kd35t133 *ctx)
> +static void kd35t133_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>  {
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	struct device *dev = ctx->dev;
> -
>  	/*
>  	 * Init sequence was supplied by the panel vendor with minimal
>  	 * documentation.
>  	 */
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
> -			       0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
> -			       0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
> -			       0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
> -			       0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
> -	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
> -	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
> -			       0x20, 0x02);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
> -			       0xa9, 0x51, 0x2c, 0x82);
> -	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
> -
> -	dev_dbg(dev, "Panel init sequence done\n");
> -	return 0;
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POSITIVEGAMMA,
> +				     0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
> +				     0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_NEGATIVEGAMMA,
> +				     0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
> +				     0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL2, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_FRAMERATECTRL, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
> +				     0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_ADJUSTCONTROL3,
> +				     0x51, 0x2c, 0x82);
> +	if (!dsi_ctx->accum_err)
> +		mipi_dsi_dcs_write(dsi_ctx->dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);

Please use mipi_dsi_dcs_write_buffer_multi() instead.

>  }
>  
>  static int kd35t133_unprepare(struct drm_panel *panel)
>  {
>  	struct kd35t133 *ctx = panel_to_kd35t133(panel);
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret < 0)
> -		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
> -
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
>  
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>  
> @@ -112,18 +102,20 @@ static int kd35t133_prepare(struct drm_panel *panel)
>  {
>  	struct kd35t133 *ctx = panel_to_kd35t133(panel);
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  
>  	dev_dbg(ctx->dev, "Resetting the panel\n");
> -	ret = regulator_enable(ctx->vdd);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n", ret);
> -		return ret;
> +	dsi_ctx.accum_err = regulator_enable(ctx->vdd);
> +	if (dsi_ctx.accum_err) {
> +		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n",
> +			dsi_ctx.accum_err);
> +		return dsi_ctx.accum_err;
>  	}
>  
> -	ret = regulator_enable(ctx->iovcc);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
> +	dsi_ctx.accum_err = regulator_enable(ctx->iovcc);
> +	if (dsi_ctx.accum_err) {
> +		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n",
> +			dsi_ctx.accum_err);
>  		goto disable_vdd;
>  	}
>  
> @@ -135,25 +127,16 @@ static int kd35t133_prepare(struct drm_panel *panel)
>  
>  	msleep(20);
>  
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
> -		goto disable_iovcc;
> -	}
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 250);
>  
> -	msleep(250);
> +	kd35t133_init_sequence(&dsi_ctx);
> +	if (!dsi_ctx.accum_err)
> +		dev_dbg(ctx->dev, "Panel init sequence done\n");
>  
> -	ret = kd35t133_init_sequence(ctx);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
>  		goto disable_iovcc;
> -	}

Move this after the last mipi_dsi_msleep(), merge with the error
handling.

> -
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
> -		goto disable_iovcc;
> -	}
>  
>  	msleep(50);

mipi_dsi_msleep()

>  
> @@ -163,7 +146,7 @@ static int kd35t133_prepare(struct drm_panel *panel)
>  	regulator_disable(ctx->iovcc);
>  disable_vdd:
>  	regulator_disable(ctx->vdd);
> -	return ret;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static const struct drm_display_mode default_mode = {
> -- 
> 2.46.0
> 

-- 
With best wishes
Dmitry

