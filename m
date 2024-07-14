Return-Path: <linux-kernel+bounces-251899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0513930B45
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 21:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A101C21010
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983813C8E3;
	Sun, 14 Jul 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhaeZl32"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8957168BD;
	Sun, 14 Jul 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720983793; cv=none; b=ULGiucuALDUVWUuZQ4qbgDfj6aPcfSdKePql72Nnj3BRToMKlxnQFg7YhA5Oge7lW3C/ajON3UGiTHw4wb8r1obvq1npN2ZZCy+aioXzAh9CYJxq1dtZw03e28agyqpKJRcC+UlZ+1a9CBP3OiO+pFPiHt4/UFlgcTqY6wiVdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720983793; c=relaxed/simple;
	bh=7o91MK8p9OUVL7CUPQzMF16oV2YMWzxt1zwhRpu8rLM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pGQdRrNHG7iyCvXSoaiKxARV7iYljAc7TBMpbhQBQDVZFVkEYuYxCuStOzpFqDcq18ATVXMoL4CBdt7swW0RMcOWt+7uG9GpSzQ3vG5xkAvl8hdYUll734PyoGMQ9Tjmh0eSFkgbxaVbV+6IQjE5JMDIto0FBon2PJilZZL+at8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhaeZl32; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so6000800a12.1;
        Sun, 14 Jul 2024 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720983790; x=1721588590; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpLKCYqOq8OhTR/IQ+Mu2itaQqqnEIJciBUNt74hFys=;
        b=FhaeZl32Jmj0uIAhX6cor0DXVol2pxGpp+Y6828kgvzqGjXpjIZgg44YECa3EUhVIG
         Utc6r3/Twp5yuQ20kjkrQpiU+uXe8NrdGUt+CGrqTyl7cBL/Aq+PiqUbogpUiSdLQgez
         IA2paPGGB3hoQJCk5FVTFC0F1wuoK7Vivn512GQ8iUSFL7WzikgoZxBqrKq+QSqQj1VX
         isdVedTsLkPNjRdwxBx3To4GHRd4py1pSY4DZK2GyRyqpBlACiJe+A7iBXBqNkht9Dco
         4fEpgDUShZrs7dTYOdOmdSwCpdMC//j06M/J+Z4MUdkvDMDmL7l5tMsNIigiIVGK7iQ4
         Hpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720983790; x=1721588590;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpLKCYqOq8OhTR/IQ+Mu2itaQqqnEIJciBUNt74hFys=;
        b=pVxwIEkISb1hGB9iaWQlJ0HCAHpEXqTRU6Ek1QVRNKrEYlWIuER0qkOUfy0cGZE5wk
         lb1e1eZ9RJVyPqE6SvHnqe9gYg2WwyCeOtgwhjEtB1jQFWFsOorpzzCb4uxI1e9X423x
         AFeSe8U9FruTogJ9itNSBO1sL4T/KAkrk7nTmMSmVErpy9rfwKec9e+eepPt0N9h8i17
         DqzfmfXDkhePLc5V+YjjR5u+OAzkFxI9mcxkTog95mTizb7P1+qvQNlLe0bW0IufeG8G
         ow+AhEsTu+lsvd6JGhqFW9Xg9rMVrjeOaQS+/UdWL/WMUrSSu4GoyT870UqbqeM1H9Xg
         MPHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/lmoZUggeyKVfDG/sLT1huVZV+1hknQMVUmTlZ28lnClSKOfVe5+V9UobApzsLV+DScA+m/yD4lWO4abtWp/U3ZnAsBMWNwN3VfXCWYsupxpZYCTaHD4xA1AQOM315+q+UM/EpqZmcA==
X-Gm-Message-State: AOJu0YxqS53Su7yPMD1L+7QKQUBuFMh+bvNFJh737OWEIn8TlsD31G3g
	+el38x2Dc46Gc0Bc82OgJ+RltHPQ9R4pUdnJx5OYfaSWOZWocHJ/
X-Google-Smtp-Source: AGHT+IEiZ3XE5DCQgY9kNRkFpmTTq0d5xY4aw+RUuvL7vqErHI903pTnt1/xVZtLMdVodSxdewKJGw==
X-Received: by 2002:a50:d5d1:0:b0:57d:4409:4f48 with SMTP id 4fb4d7f45d1cf-59960007ed3mr6172383a12.15.1720983789914;
        Sun, 14 Jul 2024 12:03:09 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a77114sm2488563a12.6.2024.07.14.12.03.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2024 12:03:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
Date: Sun, 14 Jul 2024 21:03:06 +0200
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mark Yao <markyao0591@gmail.com>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 devicetree@vger.kernel.org,
 kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4BAF501-E5FE-498B-B5F3-A9818C4EA702@gmail.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

Cristian,

I'm hacking with adding cec support for rk3588 hdmi on 6.10-rc7 =
mainline.=20

Cec kernel module is my backport from bsp.=20
Module loads. Cec line (observed on osciloscope) has pulses when i'm =
issuing i.e. cec-ctl -d /dev/cec0 --phys-addr=3D1.0.0.0 =E2=80=94playback=20=


My issue is that timings are 2,9 times longer that should be (start bit =
is 10,7mS instead of 3.6; zero is 4.4 instead 1.5 while one is 1,7 =
instead of 0.6).

This suggests me issue is cec clock isn't?=20

Looking on bsp code =
https://github.com/radxa/kernel/blob/linux-6.1-stan-rkr1/drivers/gpu/drm/b=
ridge/synopsys/dw-hdmi-qp-cec.c#L186 there is nothing with clock.=20

So probably issue is in 3588 clk code, or=E2=80=A6=E2=80=A6
Maybe you have some hints how to move forward with this issue?


> Wiadomo=C5=9B=C4=87 napisana przez Cristian Ciocaltea =
<cristian.ciocaltea@collabora.com> w dniu 01.06.2024, o godz. 15:12:
>=20
> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
>=20
> It is HDMI 2.1 compliant and supports the following features, among
> others:
>=20
> * Fixed Rate Link (FRL)
> * 4K@120Hz and 8K@60Hz video modes
> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
> * Fast Vactive (FVA)
> * SCDC I2C DDC access
> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> * Multi-stream audio
> * Enhanced Audio Return Channel (EARC)
>=20
> This is the last required component that needs to be supported in =
order
> to enable the HDMI output functionality on the RK3588 based SBCs, such
> as the RADXA Rock 5B. The other components are the Video Output
> Processor (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for
> which basic support has been already made available via [1] and [2],
> respectively.
>=20
> The patches are grouped as follows:
> * PATCH 1..7: DW HDMI TX driver refactor to minimize code duplication =
in
>  the new QP driver (no functional changes intended)
>=20
> * PATCH 8..11: Rockchip DW HDMI glue driver cleanup/improvements (no
>  functional changes intended)
>=20
> * PATCH 12..13: The new DW HDMI QP TX driver reusing the previously
>  exported functions and structs from existing DW HDMI TX driver
>=20
> * PATCH 14: Rockchip DW HDMI glue driver update to support RK3588 and
>  make use of DW HDMI QP TX
>=20
> They provide just the basic HDMI support for now, i.e. RGB output up =
to
> 4K@60Hz, without audio, CEC or any of the HDMI 2.1 specific features.
> Also note the vop2 driver is currently not able to properly handle all
> display modes supported by the connected screens, e.g. it doesn't cope
> with non-integer refresh rates.
>=20
> A possible workaround consists of enabling the display controller to
> make use of the clock provided by the HDMI PHY PLL. This is still work
> in progress and will be submitted later, as well as the required DTS
> updates.
>=20
> To facilitate testing and experimentation, all HDMI output related
> patches, including those part of this series, are available at [3].
> So far I could only verify this on the RADXA Rock 3A and 5B boards.
>=20
> Thanks,
> Cristian
>=20
> [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY =
driver")
> [3]: =
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/com=
mits/rk3588-hdmi-bridge-v6.10-rc1
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Cristian Ciocaltea (14):
>      drm/bridge: dw-hdmi: Simplify clock handling
>      drm/bridge: dw-hdmi: Add dw-hdmi-common.h header
>      drm/bridge: dw-hdmi: Commonize dw_hdmi_i2c_adapter()
>      drm/bridge: dw-hdmi: Factor out AVI infoframe setup
>      drm/bridge: dw-hdmi: Factor out vmode setup
>      drm/bridge: dw-hdmi: Factor out hdmi_data_info setup
>      drm/bridge: dw-hdmi: Commonize dw_hdmi_connector_create()
>      drm/rockchip: dw_hdmi: Use modern drm_device based logging
>      drm/rockchip: dw_hdmi: Simplify clock handling
>      drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
>      drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, =
cur_ctr and phy_config
>      dt-bindings: display: rockchip,dw-hdmi: Add compatible for RK3588
>      drm/bridge: synopsys: Add DW HDMI QP TX controller driver
>      drm/rockchip: dw_hdmi: Add basic RK3588 support
>=20
> .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 +++-
> drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +-
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h   | 179 +++++
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 787 =
+++++++++++++++++++
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 831 =
+++++++++++++++++++++
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 353 +++------
> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 351 +++++++--
> include/drm/bridge/dw_hdmi.h                       |   8 +
> 8 files changed, 2290 insertions(+), 348 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


