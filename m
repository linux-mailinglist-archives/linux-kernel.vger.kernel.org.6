Return-Path: <linux-kernel+bounces-197947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7798D7118
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66CF1F21679
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA21534F8;
	Sat,  1 Jun 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MB/WMJyh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70882482
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259177; cv=none; b=I/sN22bjNtvG/L0yATqXh9oQ7TsNiC5mGCB1U7/K21zk4bf++WvYSYfgK3tFDQIOfkVIzmj9winq+EEhA0oJmJ+m6vfs+Rfucy/x4ACLiwHnPXdjEkzhjb7p0ME601XTw2TH3Hc1FRymicy5Do7dTXI6XaClWvTxhuD5EOrZFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259177; c=relaxed/simple;
	bh=S3GpDUQHNvIic1fflG71nSbaU+cR+1PlTtVTzQ+uieI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GchsZgUtjIcymCNTvcP1q9OD6DYcO79j3Fs1pwacgvLB44xhVWja1CNBH35foHN19hlJ1jJdUCtJqHHaGacSHzP0lQuNMm2L/oT717Ndt1isCMmF/ZNmnq87ssm5GxcWdU0cTY20+n5gHOGMn/Mm2lP5hvYSGoFHtO9nl5Ggn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MB/WMJyh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e719bab882so32488191fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717259174; x=1717863974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dz7eDnR6aldQYl6qT9Nozc6yfZ+G7n/nWlooLnLDrf8=;
        b=MB/WMJyhZUggpFc932JOHWPP+sQVh0/mqw8U6V2X/VGq56ovCyfM5k5pVeZx4cRqJ3
         je52c2x+jgV3Qo+Fi+fC58OTUl/3cDammv9Ay3bioA2J5V0+DADHO4770v7wYuBIed2c
         S9Sq0nXrqXxhvMwAhSztNTyTbB+Lsu7Wubn6fCbNP+tPXsV8bejpbdD740LNkErPxeD9
         bdTXMTaf+qxmGUezZaa4n+0KshwHlLvosH4rbAMeA0AKKmA3ycDGH12vLbD1+W3mMX0+
         XNMhCg8dHNHg5LLi75cYtcvfZ57ifNPFnn/f/Ke5QfMKUeYHUJXWIypJQPTiTij8ymEZ
         oGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717259174; x=1717863974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz7eDnR6aldQYl6qT9Nozc6yfZ+G7n/nWlooLnLDrf8=;
        b=q+hQ5x31sjFxycSSMLa8cjhBdz4aPWlVVrMEvxOThWiHgGrcUsamjUkF7gD9b+uhU+
         Pr8yb4ZpO8ooSjgMsx57XKQOpSf41ybeisxPuRxwmNO9BGDu1AhqmC40TxrpnYJJUJKa
         a8AWJlDSJwTv2z2Rnpu1orV1fCXerG6qmkQIGJ+wTAwy+qCiMPCi6TnXVO+Fbgv3UNrF
         JyU9z++GR10wmLnVpBkdT39UbLncxTFRpYsl3riVHi/oG4Sri7unAbBYKbWbUbHD6ZWO
         r3Ntnh6RTIJR+qOMHVwtjD4yFW0EEbdoVi6aE5nfYcIpX1LFxlVMltvhPgWAkXXOiPrz
         R+9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpFKCtkdr/zqIEgau+TOvHXjxV+BrMmL6K299ls7Apm1uB78tiF1RhirRK36k43tc8fK6TFIf1ITq+it1RWd7uozgZlxsjs0p1deMv
X-Gm-Message-State: AOJu0YxDWb+UG//5BNKoSvLf0FVvTObe6XhtB7k/RKFuZSDgXdaBM1bD
	6X1dlBJKNg+zok3RShL8nerwCCpDfTXNj5z1x4mzUtaRNJctuCahf9RiF/pduYw=
X-Google-Smtp-Source: AGHT+IF5cj9uWJfRvJeWylt+ilarefZeL35V3vMlaznKpn/yi2CrH6ZWiIhwMFRDmQECSh/o+AAVwg==
X-Received: by 2002:a2e:9d12:0:b0:2ea:7cca:31aa with SMTP id 38308e7fff4ca-2ea950e64ebmr33071271fa.16.1717259173685;
        Sat, 01 Jun 2024 09:26:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0bdasm6476021fa.121.2024.06.01.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 09:26:13 -0700 (PDT)
Date: Sat, 1 Jun 2024 19:26:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/panel: starry: add new panel driver
Message-ID: <5yz4uct3dnxqflij34zasu6fhr42gyl6kjfjobftrwpsl6j4y6@3kzp4s3dxktw>
References: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com>

On Sat, Jun 01, 2024 at 04:45:28PM +0800, Zhaoxiong Lv wrote:
> This Starry panel has the same timing as the Kingdisplay panel,
> so add starry configuration in the Kingdisplay driver.

Do these two panels share the same driver IC? Programming sequences do
not seem common, so it might be better to have a separate driver for
this panel.

> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> 
> Chage since V2:
> 
> -  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 drivers.
> 
> ---
>  .../drm/panel/panel-kingdisplay-kd101ne3.c    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> index 8994a1c9afb5..b614d28475a6 100644
> --- a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> @@ -267,6 +267,67 @@ static int kingdisplay_kd101ne3_init(struct kingdisplay_panel *kingdisplay)
>  	return 0;
>  };
>  
> +static int starry_er88577_init(struct kingdisplay_panel *kingdisplay)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->dsi };
> +
> +	/* T5:HWreset to init_code >= 120ms */
> +	msleep(120);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31,
> +				     0x1a, 0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26,
> +				     0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31, 0x1a,
> +				     0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26, 0x0e,
> +				     0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x34, 0x44, 0x44, 0x44,
> +				     0x44, 0x98, 0x04, 0x98, 0x04, 0x0f, 0x00, 0x00, 0xc1);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00, 0x6f,
> +				     0x00, 0x54, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11, 0x22,
> +				     0x20, 0x44, 0xff, 0x18, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x05, 0x1c, 0x1c, 0x1d,
> +				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0f, 0x0f, 0x0d, 0x0d,
> +				     0x13, 0x13, 0x11, 0x11, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x04, 0x1c, 0x1c, 0x1d,
> +				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0e, 0x0e, 0x0c, 0x0c,
> +				     0x12, 0x12, 0x10, 0x10, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b, 0x06,
> +				     0xb3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44, 0x08,
> +				     0x10, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0xff, 0xff, 0xff, 0xff,
> +				     0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_EXIT_SLEEP_MODE);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
> +
> +	msleep(120);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_ON);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
> +
> +	msleep(20);

Most of the comments from the patch 2 apply:
- drop conditions
- use mipi_dsi_dcs_set_display_on_multi(),
  mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().

> +
> +	return 0;
> +};
> +
>  static inline struct kingdisplay_panel *to_kingdisplay_panel(struct drm_panel *panel)
>  {
>  	return container_of(panel, struct kingdisplay_panel, base);
> @@ -391,6 +452,34 @@ static const struct panel_desc kingdisplay_kd101ne3_40ti_desc = {
>  	.lp11_before_reset = true,
>  };
>  
> +static const struct drm_display_mode starry_er88577_default_mode = {
> +	.clock = 77380,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 80,
> +	.hsync_end = 800 + 80 + 20,
> +	.htotal = 800 + 80 + 20 + 80,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 20,
> +	.vsync_end = 1280 + 20 + 4,
> +	.vtotal = 1280 + 20 + 4 + 12,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc starry_er88577_desc = {
> +	.modes = &starry_er88577_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 135,
> +		.height_mm = 216,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init = starry_er88577_init,
> +	.lp11_before_reset = true,
> +};
> +
>  static int kingdisplay_panel_get_modes(struct drm_panel *panel,
>  			       struct drm_connector *connector)
>  {
> @@ -514,6 +603,9 @@ static const struct of_device_id kingdisplay_of_match[] = {
>  	{ .compatible = "kingdisplay,kd101ne3-40ti",
>  	  .data = &kingdisplay_kd101ne3_40ti_desc
>  	},
> +	{ .compatible = "starry,er88577",
> +	  .data = &starry_er88577_desc
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, kingdisplay_of_match);
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

