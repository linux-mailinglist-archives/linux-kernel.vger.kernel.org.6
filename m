Return-Path: <linux-kernel+bounces-227508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066591524C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6038B25909
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0626819B5B7;
	Mon, 24 Jun 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdJ5soiP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D119E7F2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242868; cv=none; b=W1QcbtBPoiSX0zinBQA1H9d1V3Zs/j6hKcnGLjRCZRsS/yWk/QIyjz57kqMe1OeVW+7h2lRwm5GN5eTmtj3y3iVJi3ZYBxEHbAWR4QDnyFGf80naFw2E90ofsetaguY0CQL/A5xXRsaWZjMaRC9FgVCBvdN0Yc6ZWMtoEfMpmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242868; c=relaxed/simple;
	bh=9DwZ8C3KCly4h/zRNT3BmacUbsxmOjyY16JcnZMRjm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzPwVx1XRTrWr24bCSKRjRpqB4ZbVuA7EvQPsm3vyQNaGFM9LblQQmcp+YCZPhGGSwlfnYQfR4POQU+tJwGklLVIwEwofIL/GYRuBkb28B/t8X/THEIu8TcXlMdof5Mj9W88kyR4i3u9YMxrIlDMJDyN7maeYcYUr5oD4jvkjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdJ5soiP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso2789934e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719242864; x=1719847664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zknmga5PBkgGw8TgH0HGAYjZwH1IzFooajhy3i9qJ1I=;
        b=RdJ5soiPnkMutzNhPO+YI8iuYgNF+HWkcVXyef40fQ52NNTfSmv3q+VNbdhM6GPfhS
         +zWzB3JFpRITm8ZpA23C/D0372+Fv8pPoiDg54WTpPDWRiLt8Pd1BNeAWmnSTPRfnYCP
         zIbazzLHo55v64Oxqu3G+4lsIvthvtkNLVznbOU+J0PlCw5m4hjp9p1DwrEqUWlJsUrw
         u4TQOI8A5SHeawv8h3O+4iIFZ9ArfsjJYUaHw4Qcq1ycrVqf5gnFHsMn8ypiW24VUTxy
         bwlL6xFjL88HXS9v2ALIYS5EWT9PJUESUWvenopAwZWur0j/4E0KmFmXiDTY8afZNYnM
         9caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242864; x=1719847664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zknmga5PBkgGw8TgH0HGAYjZwH1IzFooajhy3i9qJ1I=;
        b=vykGXIFY3GNg1tgOcKstiV/+eIbepRl6pnp47pQJ8kY1x9ZVLfDwzLwf6wufUk4hYp
         yf40ZIOUl3Yk5LwdQgDT9RxiNY5d6O8vxBrKXl/iwDBGnmwZKuQ50cq6/5g/yOCVhcJi
         rWV/7qW7OZewzMgKPelFIRI1laX15NEkME+4aE28ocer3X3fpju7z2BBWSfXbHDxEaA9
         BHHcL/nRhvEl3nws31aW1sF6pF/KRhSyNYRVNxL6hKWOnQ+xfd7kK3gMoedznLE4131p
         Ba8cpH5HZ48TJJMCB1yCXmYp94mhtsRVphFsPizw76BTkMCUvBwoqEhgh21GNLDLtlDj
         /5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJK0Gh/AeSZBJXZ8IlZ+jf7o6M/inFAz6jpHbdnDVyDlUkoyj/O8wy0KLffxP60bUNOP9ZMHMbYntho/sBSBxSXcL68XwHyPl5tZDe
X-Gm-Message-State: AOJu0YyRUuJCpYK1xmfEkpdkzeGuwMCcmGDyJRoLdClqrIzhQKdGew/L
	OV97ICNA650Fy5V7dsByC2JJ97qyKgXIDj/TSyIjnEedvfF5q3Hiq1elxz/VCxGKLE74Jgv6C7G
	4Nqg=
X-Google-Smtp-Source: AGHT+IHDKHZF641+eAwV/7qMCMAd3xlHkRDY+QbpVU6UAqq4KN7gdHrHBVq0n1HMXETpl9kIvQ0KeA==
X-Received: by 2002:ac2:4882:0:b0:52c:e05f:f70c with SMTP id 2adb3069b0e04-52ce1835310mr2739405e87.26.1719242864274;
        Mon, 24 Jun 2024 08:27:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdd9800a7sm710361e87.126.2024.06.24.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:27:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:27:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, jagan@edgeble.ai, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped
 MIPI DCS functions
Message-ID: <zvkl2wyqp3iem4ln4qkbhgvxafsfn5wkkmqwhufabm2gqs3eqw@vmqs3lx72ekk>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com>

On Mon, Jun 24, 2024 at 10:19:24PM GMT, Zhaoxiong Lv wrote:
> Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
> simplify driver's init/enable/exit code.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 793 +++++++++---------
>  1 file changed, 390 insertions(+), 403 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index a9c483a7b3fa..e836260338bf 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -19,17 +19,13 @@
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  
> -#define JD9365DA_INIT_CMD_LEN		2
> -
> -struct jadard_init_cmd {
> -	u8 data[JD9365DA_INIT_CMD_LEN];
> -};
> +struct jadard;
>  
>  struct jadard_panel_desc {
>  	const struct drm_display_mode mode;
>  	unsigned int lanes;
>  	enum mipi_dsi_pixel_format format;
> -	const struct jadard_init_cmd *init_cmds;
> +	int (*init)(struct jadard *jadard);
>  	u32 num_init_cmds;
>  };
>  
> @@ -50,46 +46,33 @@ static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
>  
>  static int jadard_enable(struct drm_panel *panel)
>  {
> -	struct device *dev = panel->dev;
>  	struct jadard *jadard = panel_to_jadard(panel);
> -	struct mipi_dsi_device *dsi = jadard->dsi;
> -	int err;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
>  
>  	msleep(120);
>  
> -	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (err < 0)
> -		DRM_DEV_ERROR(dev, "failed to exit sleep mode ret = %d\n", err);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>  
> -	err =  mipi_dsi_dcs_set_display_on(dsi);
> -	if (err < 0)
> -		DRM_DEV_ERROR(dev, "failed to set display on ret = %d\n", err);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>  
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static int jadard_disable(struct drm_panel *panel)
>  {
> -	struct device *dev = panel->dev;
>  	struct jadard *jadard = panel_to_jadard(panel);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
>  
> -	ret = mipi_dsi_dcs_set_display_off(jadard->dsi);
> -	if (ret < 0)
> -		DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>  
> -	ret = mipi_dsi_dcs_enter_sleep_mode(jadard->dsi);
> -	if (ret < 0)
> -		DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", ret);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>  
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static int jadard_prepare(struct drm_panel *panel)
>  {
>  	struct jadard *jadard = panel_to_jadard(panel);
> -	const struct jadard_panel_desc *desc = jadard->desc;
> -	unsigned int i;
>  	int ret;
>  
>  	ret = regulator_enable(jadard->vccio);
> @@ -109,13 +92,9 @@ static int jadard_prepare(struct drm_panel *panel)
>  	gpiod_set_value(jadard->reset, 1);
>  	msleep(130);
>  
> -	for (i = 0; i < desc->num_init_cmds; i++) {
> -		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
> -
> -		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);

This function usesd mipi_dsi_dcs_write_buffer()...

> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = jadard->desc->init(jadard);
> +	if (ret)
> +		return ret;
>  
>  	return 0;

[...]

> +static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);

... while your code uses mipi_dsi_dcs_write_seq_multi(), which
internally calls mipi_dsi_generic_write_multi(). These two function use
different packet types to send the payload. To be conservatite, please
use mipi_dsi_dcs_write_buffer_multi().

> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);

-- 
With best wishes
Dmitry

