Return-Path: <linux-kernel+bounces-513942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BCDA3507A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3109516DFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D2266B62;
	Thu, 13 Feb 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnf8c7RW"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203C2661BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482079; cv=none; b=P+z7gemz+9IgdrpGkZ1PmaCaFFHETwzhHRwbZ3pjWa2yrRYICLsWOukaix4p7maKmxwvUMY5UR62kGc1oo94fEYvwyYtwKLIIQ/iwitd6WYkmSF0IzwiiyUamKOasFwZXxydt6hsprBQo2gW+RK+Uzi2bc45u1QdnYH5Dgrsi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482079; c=relaxed/simple;
	bh=hFonpHE81Qosy8TXcABkyJzVv0VM0a0BJMuiqKr6J0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj7jZBRn28M1ZA8qTUh7lcwONjZ4MsqL8eO4YC4/CQwmVkb0wS/OyDFtBP39ji4AOL40tfyLXij9BWqbE+SRvNrp80ER7CvyilefjO07mRq7x1Zy1jShzUh/e+WoUhKCoXfJXvRLad+H/QPN4Kmugz6+31wrqFFdoIDCWowZAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wnf8c7RW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543e47e93a3so1460418e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739482074; x=1740086874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32pmN7Rojbq3WiE3YdIwTHw//I+OMOn4ggHoRZW/QSw=;
        b=wnf8c7RWFWN+C9j10ZftduIWiv3D5Z/E42Noz8RaXJYpqXWSzoz+WSMG9Y/ATMckIR
         cvxIrNDEsKsp+lLETKYe2mIuzBdrgvjB4Nk0+gz4k+Qmj8OrwAVSmBkzU4l2Accc+bcz
         GDHpERzG67kKfcCT8kcF4CXa8PStjHLRY7db1eaSNtRCXjrp2kDo8eSRdYAAwTT1zPrT
         BYHArxbgFuS8VVFu91m37/VqxGOzJpn8tkVNYoxe82wkdHmrfjvRc99NtIJHMmOkwDfu
         YdjUIhRS7ho52MBqROUWDb/SHJb/dTZkFR71iHifBK+XpsDt99SJfg65gLPJD31Wvvzo
         vzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739482074; x=1740086874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32pmN7Rojbq3WiE3YdIwTHw//I+OMOn4ggHoRZW/QSw=;
        b=PlWFRzGXZE95X3E0jO0AAOVOFJKyXfmUna+qm+Y6j/FSR0aDeFh59+ZB3DSgLhddpS
         dxrmY6tq3xNhcvDSUl6SYOUDsplxyXgr29m201eQA15ZbYWP22tSGewBbjCQc8+kzM4Z
         uqm+SIBVJU3cXvTNaF0acyQtawvsQHlEcZ/LJYtae/XequHhMQiiuacLDdJEVHQMQ2b4
         FBzaxGYAIX7tCcQbY8GW/5w5q/9p6MdlnJzNSJSMQ+knxQBny5rNPtGjUZYHsemRnZ6C
         kSLNfmHUBHRkvudT4f5u/fUMCsn63zQOpvkn9pPD1ob8iiHxwAAzx1i9he8H+z5r5/qr
         nq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9ialSrAIcF9zbKKgWVTc7wi3F7DkKaqe/xnHKgfDqKcsRtHqvp46kXcXQrAJ6+GiaVxGKvyy3v3mE9sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVt38/1u5n8bfg7IFCEBAKOdUu+M7TxWtuTr5jNoT4+slnRoJ
	OZynwQop8pZWAxMgfVChgghO1qrU84WLOciAldGZSTg9i/PAvW6aCs4b2ZmHDtw=
X-Gm-Gg: ASbGncsHgTG/0EyPjc1y7Jr9M3lvLsywXC8FE285PDEVxqxmbr/zhi7dfGbyU7VBTTf
	OoaXTsJVxgxBGguffvwYVBc90SW6MKFaTJlsmP6g708TxWqBbzUVpsk9NL99YjfPCkaa1ee9J1r
	OQb6oWQRLPkkPVaOGo4Z99c9MLbYD1C53B13JB+T65kjYFZ66zSla0czjRAPdUbLLVlbUMOjUIv
	2t9U2qIVKxmaSKe7AQmBKPJky4XUWW2vB9fuKlg8tsbVF/lXBa6TQKr0tWUu0ML+vIgRiOxWCRJ
	hkakJBDQH9ZlK7BwkbbXMO1dxYEYT2cZD3Cwe7CWKBgBz8oTf/h4QjEMumyd6lZJcFD/bkU=
X-Google-Smtp-Source: AGHT+IFIGbtJJnFgvvWhZkYTvCJuMlZMYCd1Dn3/s6EA3d4JTiO9s/mkS5r3NViYziOC5l1QjLSJHQ==
X-Received: by 2002:a05:6512:3f0d:b0:545:646:7522 with SMTP id 2adb3069b0e04-54517f78ef4mr3263770e87.0.1739482073789;
        Thu, 13 Feb 2025 13:27:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f107f05sm295616e87.120.2025.02.13.13.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:27:52 -0800 (PST)
Date: Thu, 13 Feb 2025 23:27:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, 
	Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
	Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/20] drm/panel/boe-bf060y8m-aj0: Move to using
 mipi_dsi_*_multi() variants
Message-ID: <qmp3ofpoynff2r66ye6ryv65lztfgbz2gsuoserfsuh3zgeglw@rlibvmp2serx>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <20250213-mipi_cocci_multi-v1-4-67d94ff319cc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-mipi_cocci_multi-v1-4-67d94ff319cc@redhat.com>

On Thu, Feb 13, 2025 at 03:44:21PM -0500, Anusha Srivatsa wrote:
> Stop using deprecated API.
> Used Coccinelle to make the change.
> 
> @rule_3@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var = dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> <+...
> (
> -mipi_dsi_dcs_write_seq(dsi_var,es);
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_set_display_off(dsi_var)@p;
> +mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> |
> .....//rest of the mipi APIs with _multi variant
> )
> <+...
> -if(r < 0) {
> -...
> -}
> ...+>
> }

Granted the amount of issues, I'd kindly ask you to manually review your
patches after coccinelle before sending them to the mailing list.

I'd really repeat Doug's suggestion: please perform those conversions
one by one, etc.

I'm not going to review the rest of the series, Coccinelle most likely
can not catch all of this.

Another note, this is version 2 of your series, so it should have been
marked with v2.

> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 75 +++++++++++---------------
>  1 file changed, 30 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> index 7e66db4a88bbed27920107458d01efd9cf4986df..8903a6c889794330fa1f54a30e779c7d5fbc4b14 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -55,42 +55,34 @@ static void boe_bf060y8m_aj0_reset(struct boe_bf060y8m_aj0 *boe)
>  static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
>  {
>  	struct mipi_dsi_device *dsi = boe->dsi;
> -	struct device *dev = &dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  
> -	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x4c);
> -	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_3D_CONTROL, 0x10);
> -	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, DCS_ALLOW_HBM_RANGE);
> -	mipi_dsi_dcs_write_seq(dsi, 0xf8,
> -			       0x00, 0x08, 0x10, 0x00, 0x22, 0x00, 0x00, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0xa5, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x00, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_3D_CONTROL, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE,
> +				     DCS_ALLOW_HBM_RANGE);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf8, 0x00, 0x08, 0x10, 0x00,
> +				     0x22, 0x00, 0x00, 0x2d);
>  
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>  	msleep(30);

mipi_dsi_msleep();

>  
> -	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, 0xc0,
> -			       0x08, 0x48, 0x65, 0x33, 0x33, 0x33,
> -			       0x2a, 0x31, 0x39, 0x20, 0x09);
> -	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x00, 0x00, 0x1f, 0x1f,
> -			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f,
> -			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
> -	mipi_dsi_dcs_write_seq(dsi, 0xe2, 0x20, 0x04, 0x10, 0x12, 0x92,
> -			       0x4f, 0x8f, 0x44, 0x84, 0x83, 0x83, 0x83,
> -			       0x5c, 0x5c, 0x5c);
> -	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x01, 0x2c, 0x00, 0x77, 0x3e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0xa5, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0x08, 0x48, 0x65, 0x33,
> +				     0x33, 0x33, 0x2a, 0x31, 0x39, 0x20, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x00, 0x00, 0x00, 0x1f,
> +				     0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f,
> +				     0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x20, 0x04, 0x10, 0x12,
> +				     0x92, 0x4f, 0x8f, 0x44, 0x84, 0x83, 0x83,
> +				     0x83, 0x5c, 0x5c, 0x5c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x01, 0x2c, 0x00, 0x77,
> +				     0x3e);
>  
>  	msleep(30);

mipi_dsi_msleep()

>  
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display on: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>  	msleep(50);

mipi_dsi_msleep()

>  
>  	return 0;

return dsi_ctx.accum_err


> @@ -99,24 +91,18 @@ static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
>  static int boe_bf060y8m_aj0_off(struct boe_bf060y8m_aj0 *boe)
>  {
>  	struct mipi_dsi_device *dsi = boe->dsi;
> -	struct device *dev = &dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  
>  	/* OFF commands sent in HS mode */
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display off: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +
>  	msleep(20);

mipi_dsi_msleep()

>  
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +
>  	usleep_range(1000, 2000);

mipi_dsi_usleep_range()

> +
>  	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>  
>  	return 0;

return dsi_ctx.accum_err;

> @@ -233,12 +219,10 @@ static const struct drm_panel_funcs boe_bf060y8m_aj0_panel_funcs = {
>  static int boe_bf060y8m_aj0_bl_update_status(struct backlight_device *bl)
>  {
>  	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  	u16 brightness = backlight_get_brightness(bl);
> -	int ret;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> -	if (ret < 0)
> -		return ret;
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, brightness);
>  
>  	return 0;

return dsi_ctx.accum_err;

But why? There is little point in coverting this function.

>  }
> @@ -246,6 +230,7 @@ static int boe_bf060y8m_aj0_bl_update_status(struct backlight_device *bl)
>  static int boe_bf060y8m_aj0_bl_get_brightness(struct backlight_device *bl)
>  {
>  	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +
>  	u16 brightness;
>  	int ret;

-- 
With best wishes
Dmitry

