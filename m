Return-Path: <linux-kernel+bounces-234353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404891C58B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57475B20D16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD21CCCB1;
	Fri, 28 Jun 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXPGoK0d"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA33FBA5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598594; cv=none; b=Vy1TRLRgAlydlYQF7bv0Z00ARRSHlc8w9bprCSx8gp0aYt9Yb18oC0rnhSHzjhM7iWv/+r+EkoPkrCi4r0LitHm/rdWReiXK2FWMyBl6HL/hsl5G2AYrGirL2IVk/UsFqcL1aoXWzG/9XqWwpKlbTPkJ/cWwH2sbkVB0nWAyQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598594; c=relaxed/simple;
	bh=AbXpYfWa3WekkbKdkR50dkfMIXEVbHy46HiSuzZd87E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DD61KXmICEj/PZpGbS+BKJ6Kl8GI+Cez/F3SSXbA9/Pcr8PkVgQTe8eIR3575Oe7UVXyQH/CnUbdNjma1pjx/nUzAORSrXCVegfdsVciI6muzhzQf1keoZUTQLpuB55kLx8KZgMc8Oi36Ams0yVib66SAiSSHZUOv2HKo6y0E+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXPGoK0d; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37636c38d6aso4270335ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598590; x=1720203390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCsaVaw4BhqD+Xyg8ynJ6DJaSe0bJqCFl9DQMDKbxYg=;
        b=iXPGoK0dsZuemMpln0UgAvSF2yvzRHHsSTvXuMzPHV9m8fJOTTzwofAwFELT63xe9C
         GJGPM28l5818PFvWm7wNu8aaAQtDEtnyUSBPsdX4DKIZ1JClpY2YSt7t/bLtFoXA2kbS
         IblEKDErMXdUCs6jdfMnMDY5l6wDM22baGXuQnRw+W8N+vhfzd49j6LPVjceJdxKUiVg
         RyRoe0zdHY5Z68wRf2C0tgfebH4E+qFrnogTiGwYvNvn+zGeVCKuyyDl+h1EgH2VG2q1
         9MVKjIRX5ZRoKffVqjWaO2vm6VtPeQ2NvZopP1FAnqceyteMUk2infaTrL6yHuQ3CBN9
         DKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598590; x=1720203390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCsaVaw4BhqD+Xyg8ynJ6DJaSe0bJqCFl9DQMDKbxYg=;
        b=RhyO1K42zpgRj5tHZUuC9vxvmWrBc0L9rGMl4DdZP2KTgN3Zla4QfZdz/NAeBq9J1S
         1e2dMf6dYA0PAkrWqhXHUnHvF4XDl3UiJ2qq7K68DBRzyFxE9qKssXXxrBH9vvIlcZVv
         NVzxbH4KOIGebb4jElQPYrDzDd+B196+gx/q7/LgPTyM7fpptBWGv25bdEKDQm7g8r/a
         HqADpa9rMxvyzN/m2q2HG5O/s6EU3v2VfFyG9tUVQf+w2npTAMy+u0PQ7aR6z/WeYIId
         DoBH4E61FAbehgHCtSB4iKLZRv7dwsol0a0Mfo6EHI2DqJXPImd8+olcoRhgVqlZGvPz
         c0fA==
X-Forwarded-Encrypted: i=1; AJvYcCVvlzfXAw4jDt3lLx9hfodWSngnK3kd13NntXyCIdzhH4+5tIe4bRsPaNuWomycY/r2tu7aK7kzzuwsku1QYnJg6cBZQZwdtwKmRyAV
X-Gm-Message-State: AOJu0Yyb7fmyfdbr/bJtegebnPFEXkXOYnHkCFG7ua+gPSq+xr0b8hm2
	Ttg6pAnJLulbRtCbRzZCV8c4XJ2x9O01UN8Dn0rl+bvrbw+d5gCG
X-Google-Smtp-Source: AGHT+IGuKG9hnWHCmMAXNatkQYs5+I9y300IdNC6/HNAZ5tSrEEUeSsWTdrlSPRh9aBkW3sh3wAz9A==
X-Received: by 2002:a05:6602:2dd2:b0:7eb:5250:a54a with SMTP id ca18e2360f4ac-7f3a75a6321mr2326073139f.7.1719598590363;
        Fri, 28 Jun 2024 11:16:30 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b1124sm1920736b3a.181.2024.06.28.11.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 11:16:30 -0700 (PDT)
Message-ID: <db64751c-1305-4dc2-a889-3d5da2ebd455@gmail.com>
Date: Fri, 28 Jun 2024 23:46:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: asus-z00t-tm5p5-n35596: transition to mipi_dsi
 wrapped functions
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com
Cc: dianders@chromium.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240628181238.169681-1-tejasvipin76@gmail.com>
 <20240628181238.169681-4-tejasvipin76@gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <20240628181238.169681-4-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, didn't intend to send this. please ignore it :p

On 6/28/24 11:42 PM, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> asus-z00t-tm5p5-n35596 panel.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 140 ++++++++----------
>  1 file changed, 59 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> index bcaa63d1955f..b05a663c134c 100644
> --- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> +++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> @@ -33,119 +33,97 @@ static void tm5p5_nt35596_reset(struct tm5p5_nt35596 *ctx)
>  	usleep_range(15000, 16000);
>  }
>  
> -static int tm5p5_nt35596_on(struct tm5p5_nt35596 *ctx)
> +static void tm5p5_nt35596_on(struct mipi_dsi_multi_context *dsi_ctx)
>  {
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -
> -	mipi_dsi_generic_write_seq(dsi, 0xff, 0x05);
> -	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
> -	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x31);
> -	mipi_dsi_generic_write_seq(dsi, 0xff, 0x04);
> -	mipi_dsi_generic_write_seq(dsi, 0x01, 0x84);
> -	mipi_dsi_generic_write_seq(dsi, 0x05, 0x25);
> -	mipi_dsi_generic_write_seq(dsi, 0x06, 0x01);
> -	mipi_dsi_generic_write_seq(dsi, 0x07, 0x20);
> -	mipi_dsi_generic_write_seq(dsi, 0x08, 0x06);
> -	mipi_dsi_generic_write_seq(dsi, 0x09, 0x08);
> -	mipi_dsi_generic_write_seq(dsi, 0x0a, 0x10);
> -	mipi_dsi_generic_write_seq(dsi, 0x0b, 0x10);
> -	mipi_dsi_generic_write_seq(dsi, 0x0c, 0x10);
> -	mipi_dsi_generic_write_seq(dsi, 0x0d, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x0e, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x0f, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x10, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x11, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x12, 0x14);
> -	mipi_dsi_generic_write_seq(dsi, 0x17, 0xf3);
> -	mipi_dsi_generic_write_seq(dsi, 0x18, 0xc0);
> -	mipi_dsi_generic_write_seq(dsi, 0x19, 0xc0);
> -	mipi_dsi_generic_write_seq(dsi, 0x1a, 0xc0);
> -	mipi_dsi_generic_write_seq(dsi, 0x1b, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0x1c, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0x1d, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0x1e, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0x1f, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0x20, 0xb3);
> -	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
> -	mipi_dsi_generic_write_seq(dsi, 0xff, 0x00);
> -	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
> -	mipi_dsi_generic_write_seq(dsi, 0x35, 0x01);
> -	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x06);
> -	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x04);
> -	mipi_dsi_generic_write_seq(dsi, 0x5e, 0x0d);
> -	mipi_dsi_generic_write_seq(dsi, 0x11, 0x00);
> -	msleep(100);
> -	mipi_dsi_generic_write_seq(dsi, 0x29, 0x00);
> -	mipi_dsi_generic_write_seq(dsi, 0x53, 0x24);
> -
> -	return 0;
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x05);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc5, 0x31);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x04);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x01, 0x84);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x05, 0x25);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x06, 0x01);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x07, 0x20);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x08, 0x06);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x09, 0x08);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0a, 0x10);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0b, 0x10);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0c, 0x10);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0e, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0f, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x10, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x12, 0x14);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x17, 0xf3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0xc0);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x19, 0xc0);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1a, 0xc0);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1b, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1c, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1d, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1e, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1f, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x20, 0xb3);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x00);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x35, 0x01);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd3, 0x06);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd4, 0x04);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x5e, 0x0d);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x00);
> +
> +	mipi_dsi_msleep(dsi_ctx, 100);
> +
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x29, 0x00);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x53, 0x24);
>  }
>  
> -static int tm5p5_nt35596_off(struct tm5p5_nt35596 *ctx)
> +static void tm5p5_nt35596_off(struct mipi_dsi_multi_context *dsi_ctx)
>  {
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -	struct device *dev = &dsi->dev;
> -	int ret;
> -
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display off: %d\n", ret);
> -		return ret;
> -	}
> -	msleep(60);
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
>  
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_msleep(dsi_ctx, 60);
>  
> -	mipi_dsi_dcs_write_seq(dsi, 0x4f, 0x01);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
>  
> -	return 0;
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x4f, 0x01);
>  }
>  
>  static int tm5p5_nt35596_prepare(struct drm_panel *panel)
>  {
>  	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
> -	struct device *dev = &ctx->dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx =	{.dsi = ctx->dsi};
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> -		return ret;
> -	}
> +	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
>  
>  	tm5p5_nt35596_reset(ctx);
>  
> -	ret = tm5p5_nt35596_on(ctx);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +	tm5p5_nt35596_on(&dsi_ctx);
> +
> +	if (dsi_ctx.accum_err) {
>  		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>  		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies),
>  				       ctx->supplies);
> -		return ret;
>  	}
>  
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static int tm5p5_nt35596_unprepare(struct drm_panel *panel)
>  {
>  	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
> -	struct device *dev = &ctx->dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx =	{.dsi = ctx->dsi};
>  
> -	ret = tm5p5_nt35596_off(ctx);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +	tm5p5_nt35596_off(&dsi_ctx);
>  
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>  	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies),
>  			       ctx->supplies);
>  
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static const struct drm_display_mode tm5p5_nt35596_mode = {

-- 
Tejas Vipin

