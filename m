Return-Path: <linux-kernel+bounces-323754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33849742F9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A826728B2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15F1A705E;
	Tue, 10 Sep 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TVPqYnYt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3191A08A6;
	Tue, 10 Sep 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995195; cv=none; b=hT+wTe7PDWAGlKUhyDYduAHvpeywYJTIUwscr6OVfJ2yV1N1U/8VMwYwnHRh1GOECpqWy0tE43wkcR6OlZdSI3HhGRo7v9RJZ9ARWvYsQMbxPMhLT0e9SfCwJCIbTyZ+Zwko+UL4HZwKncN2SPTXZVRLalZ5CtuJKHGEBnXZjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995195; c=relaxed/simple;
	bh=N1mGjLqDGutWemkHf9Z3LwVK5s7YVZi9Tn9xqvgiQXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hg7aNwQqVTNbSnjYMOjvOROBtbgS6YS/7EDO/tWnKR/KQhQ1BSGoSTazh1o5GgjhPGH2+I7kfbGwAqxWQiE3gP9afhEanw1vXOiDEPvXzg10hbxK2lRlHraEToUropV0VRdHXXDClxqIwNMUvkSWjBNVk1395LvNw1HUbLBseSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TVPqYnYt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ChL/YEahALI4OeYSLmEr7fBrkTltEQI0iMrMHT81QuU=; b=TVPqYnYthS2I29wCxwNXXM0YdA
	U1NvRPJPMQcaART58a7jWuA+lDhRIwnQe3C7R1Lwj9Vjo2FVA667DBIx902lcf40SnfF3OvWf629j
	+VFFytIrLhw2VxbkDoPoq0EF5ySWnV/x4V3thix2tixCliiQfhVFGyNT7thCwypi6AjkQ2mfG7AJC
	uOIA3yyQ1S9dRyXxbyjmApbcJHVwdF73Iy45QsSHaeUtP/31HJye/lWhxrmcQVL6DFIEot0SaJFSW
	As9ZP4Rhy6mNAs9eTQUuqBs2boAb+vMqbsoKRD+D0yndIAUVPBNhWYJxYUz25dz3pGTMZ772MW4pZ
	l8JWwkHw==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1so6Ba-0007jv-So; Tue, 10 Sep 2024 21:05:58 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Date: Tue, 10 Sep 2024 21:08:26 +0200
Message-ID: <2376712.1SvkZsmPdQ@diego>
In-Reply-To:
 <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>
References:
 <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 6. September 2024, 03:17:42 CEST schrieb Cristian Ciocaltea:
> The RK3588 SoC family integrates the newer Synopsys DesignWare HDMI 2.1
> Quad-Pixel (QP) TX controller IP and a HDMI/eDP TX Combo PHY based on a
> Samsung IP block.
> 
> Add just the basic support for now, i.e. RGB output up to 4K@60Hz,
> without audio, CEC or any of the HDMI 2.1 specific features.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[...]

> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index 3ff7b21c0414..3eab662a5a1d 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -11,6 +11,7 @@ rockchipdrm-$(CONFIG_ROCKCHIP_VOP) += rockchip_drm_vop.o rockchip_vop_reg.o

> +static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
> +				    void *data)
> +{
> +	static const char * const clk_names[] = {
> +		"pclk", "earc", "aud", "hdp", "hclk_vo1",
> +		"ref" /* keep "ref" last */
> +	};

[...]

> +	for (i = 0; i < ARRAY_SIZE(clk_names); i++) {
> +		clk = devm_clk_get_enabled(hdmi->dev, clk_names[i]);
> +
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			if (ret != -EPROBE_DEFER)
> +				drm_err(hdmi, "Failed to get %s clock: %d\n",
> +					clk_names[i], ret);
> +			return ret;
> +		}
> +	}
> +	hdmi->ref_clk = clk;

How about using devm_clk_bulk_get_all_enable() for everything except the
refclk and a separate call to devm_clk_get_enabled() for that refclk .

That hdmi->ref_clk just accidentially falls out of that loop at the end
looks somewhat strange, so getting and keeping that refclk
separately would make this look cleaner.



