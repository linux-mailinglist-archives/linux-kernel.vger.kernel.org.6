Return-Path: <linux-kernel+bounces-197949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80F8D7121
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE73E1F21EF2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B447153506;
	Sat,  1 Jun 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFKVW+Qn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14701527A0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259559; cv=none; b=FAC1+2LyOgS9hyaGK3AcC6kQKj3QPyv06ogygqP58UbI15ijqEJA6DhtMVy27q5/m9KeRHc5dkU84HjPDPhIlmhnScN1E1Wzugs1m/noFxFOXwd2rPMbTKRBRbruXiAqaJvLkBcFBRi/wiB4TkTYf2VIeHVsn2Ypv4N7U/Wfg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259559; c=relaxed/simple;
	bh=6Q8v16gfsKsN+vZ0Run+ylSZZbatVo+E2fXTSv+Ql9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtDSNBK3Z4TUTxH9rr/UCPW8Izsh8xSym6B+wZ+S835fx2JtAXLOVpMQTIuSV7BIAiaxtNAOnqprrK430rplDGD/AYhR3qx5Mu/AsKOddhDrYnjUxtrRQSnAVUQZlBl5ZL0SaD2uSbhBUYU4YrkRj7ejambbOsriYSzeE/MCiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFKVW+Qn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b8b7b8698so1895121e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717259556; x=1717864356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeNWgTvWB9NOiq+Vqu2GBpsAJX9qGaBSyXZdTFfGgGw=;
        b=iFKVW+QnztLtodYjvGqRaPRDtfllj7Px3676oN9AfPNB0Tm1ySCPH3aAYqzqe85rSN
         AMAlMDATEdm9NaUzT3096xZMObCH8zoS7SXOq6EBERq797YXGNCnFF8rNlGfkzUaE5+W
         bZf+Gaq6KnDAtyMw6jozfqeMhogKDsOBgwvsbSW6hBZE4XB0w7qvb8eaRnxFd0Br5Abl
         cbpvqGlNf4k8Ipqxo5TY5zA1mgWYC+oqCN58YClV7nNqPnC188UQ7eR4c8VU5tlue1/p
         +9Qymi+U12Xj61xHPI2dppot7edhw6ooynDgxv2W4rCRM8x1lFegI6v3gMtzV6MTGFQ+
         b0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717259556; x=1717864356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeNWgTvWB9NOiq+Vqu2GBpsAJX9qGaBSyXZdTFfGgGw=;
        b=UfBOgkOIBLbD6hctYMfEI4uDtPHG1gDTpFp0HYidaKDjUxoCtsIZe9drEAP76omxHd
         gK6ecmHOoGgQfb5Q/Rh+bj2sODVQK5iwf7n42FjSVZ77wKWaVFR3r2o5ZRVnwmdpEOrU
         TpYT1cHHTNqGBSD87Ixhx5mhWED1+46tbEziFqBLdy3WyC3uv96nz7amdhqF1f+BfDeT
         cKdZe1pYoB9LXNTl89OvqJu+hDS8tH4QbAIrQybHCw4pqSgUdgF7xoLAcuW8zbQYbVsE
         KXQEe+NqWLuGgMouJLfd2ewpb3gZd4WDyQ5XB7BLZo1SNEyVbAIV6v0Aox8t/uKWyIvH
         jAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2hJ0X3nrVUySMWiwIOeXQihwFittJxN/zO6QgR69oODhuP4d/DR8lc2qQecrjFCU3RPmM8CMQCOS2tU2UMShbrpOLffQMcElHlFBQ
X-Gm-Message-State: AOJu0Yx85szl/h+aYuoYifAEGzhj77lMrWHmnAIK55xfGKNJEQhyGVb4
	7aF75AnD0ztQFNOAq8F+UTR3aFftMn4hTNvDnQvB/ZpFmrStJ9+IcFvI3JDpAWY=
X-Google-Smtp-Source: AGHT+IEGq9nFbnbn3YZLDr5pbWxznGwX+oNfINNXl+JWzilp9OJBdS+502iu7P5yQzsdmL9dipjc6g==
X-Received: by 2002:ac2:518f:0:b0:529:a646:932b with SMTP id 2adb3069b0e04-52b8956c4dbmr3060104e87.20.1717259555422;
        Sat, 01 Jun 2024 09:32:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3eb89sm713308e87.70.2024.06.01.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 09:32:35 -0700 (PDT)
Date: Sat, 1 Jun 2024 19:32:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
Message-ID: <a5jlj5hncv2p7lxk6pbgynkqfovlg3lzz2muzrbrkd73afiopu@n5tmd4zfyeik>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>

On Sat, Jun 01, 2024 at 04:12:22PM +0300, Cristian Ciocaltea wrote:
> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
> 
> It is HDMI 2.1 compliant and supports the following features, among
> others:
> 
> * Fixed Rate Link (FRL)
> * 4K@120Hz and 8K@60Hz video modes
> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
> * Fast Vactive (FVA)
> * SCDC I2C DDC access
> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> * Multi-stream audio
> * Enhanced Audio Return Channel (EARC)

It would be really nice if you can take a look at using the HDMI
connector framework (landed few days ago) with adaptations for the
drm_bridge / drm_bridge_connector ([1]). Your comments for the
drm_bridge patches would be defeinitely appreciated.

[1] https://lore.kernel.org/dri-devel/20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org/

> 
> This is the last required component that needs to be supported in order
> to enable the HDMI output functionality on the RK3588 based SBCs, such
> as the RADXA Rock 5B. The other components are the Video Output
> Processor (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for
> which basic support has been already made available via [1] and [2],
> respectively.
> 
> The patches are grouped as follows:
> * PATCH 1..7: DW HDMI TX driver refactor to minimize code duplication in
>   the new QP driver (no functional changes intended)
> 
> * PATCH 8..11: Rockchip DW HDMI glue driver cleanup/improvements (no
>   functional changes intended)
> 
> * PATCH 12..13: The new DW HDMI QP TX driver reusing the previously
>   exported functions and structs from existing DW HDMI TX driver
> 
> * PATCH 14: Rockchip DW HDMI glue driver update to support RK3588 and
>   make use of DW HDMI QP TX
> 
> They provide just the basic HDMI support for now, i.e. RGB output up to
> 4K@60Hz, without audio, CEC or any of the HDMI 2.1 specific features.
> Also note the vop2 driver is currently not able to properly handle all
> display modes supported by the connected screens, e.g. it doesn't cope
> with non-integer refresh rates.
> 
> A possible workaround consists of enabling the display controller to
> make use of the clock provided by the HDMI PHY PLL. This is still work
> in progress and will be submitted later, as well as the required DTS
> updates.
> 
> To facilitate testing and experimentation, all HDMI output related
> patches, including those part of this series, are available at [3].
> So far I could only verify this on the RADXA Rock 3A and 5B boards.
> 
> Thanks,
> Cristian
> 
> [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> [3]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-v6.10-rc1
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Cristian Ciocaltea (14):
>       drm/bridge: dw-hdmi: Simplify clock handling
>       drm/bridge: dw-hdmi: Add dw-hdmi-common.h header
>       drm/bridge: dw-hdmi: Commonize dw_hdmi_i2c_adapter()
>       drm/bridge: dw-hdmi: Factor out AVI infoframe setup
>       drm/bridge: dw-hdmi: Factor out vmode setup
>       drm/bridge: dw-hdmi: Factor out hdmi_data_info setup
>       drm/bridge: dw-hdmi: Commonize dw_hdmi_connector_create()
>       drm/rockchip: dw_hdmi: Use modern drm_device based logging
>       drm/rockchip: dw_hdmi: Simplify clock handling
>       drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
>       drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, cur_ctr and phy_config
>       dt-bindings: display: rockchip,dw-hdmi: Add compatible for RK3588
>       drm/bridge: synopsys: Add DW HDMI QP TX controller driver
>       drm/rockchip: dw_hdmi: Add basic RK3588 support
> 
>  .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 +++-
>  drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h   | 179 +++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 787 +++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 831 +++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 353 +++------
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 351 +++++++--
>  include/drm/bridge/dw_hdmi.h                       |   8 +
>  8 files changed, 2290 insertions(+), 348 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
> 

-- 
With best wishes
Dmitry

