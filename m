Return-Path: <linux-kernel+bounces-198158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516938D7437
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A911F21696
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C9208A4;
	Sun,  2 Jun 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKQqLGI1"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030742135A;
	Sun,  2 Jun 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717315153; cv=none; b=o0AXzCNXE/0cYV8cmjcrsC898VrWRfrw44WKTsBr/hZ49KVZF1vtIg5fETmACV22HAywsLyxgqetHe+d6MT31HYa1SH8XDl1b4scmdVt6qTkDFEvBxqO9a7dnqxpnCE93BrDbQKMgftX/ySRTwfEsVFBwlzt8hWrLvla6W4Y5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717315153; c=relaxed/simple;
	bh=sSq5iPDhjRIQEyOd3MlHOSmfykEAsomRGR+IFEzP7Ho=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tLxBhBWaECjUWF3RPq8mf2quaIg7c6pEBLFWFSKu805GFJm4QK5vSNumJgkJvOv+FPVNeguQF9KGbS3BZh8ZeC/5/pusY2CE3x7eow5JxPpxkZfO+q5JQQEdI/IJKJO4YFV3UCJgZCh1aPjyyMskDUJ/W4pNEZiV9idgqUGIcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKQqLGI1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso3086995a12.1;
        Sun, 02 Jun 2024 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717315150; x=1717919950; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNH+q9S8FeOpIJMVISEmaZGU+MHC6ijhQj3KIdeVPco=;
        b=MKQqLGI1RNkDHW8svjNoD7NL7z5xloU7Eth1iBssB6IratS62qgMiDIrlPjrBYieV+
         7N+/HGRRgHQKVaImyckHeTUuV3LxpQ5hMUYPgsbQTufOUA/wJRu3pORAdmZDMgfgCq1z
         fyrkdW2QmPeNwgggyED6Ew3XL1uizfhTQmwv38IzmrRLknBkIUlMPvH4a4tqYfMMbduH
         S2iyyyNsT/4T0YINe/u2qbW3mS39+BcLUIUty6mGt3TY/MT48Zygs37uULiIrQoZ26Za
         aO3m1ittbxBBtvtpx822gO8Fxu1vNRTVVGWAsAcyWERJ5uV5rhyzeLEXcwYJSFra7Beu
         czTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717315150; x=1717919950;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNH+q9S8FeOpIJMVISEmaZGU+MHC6ijhQj3KIdeVPco=;
        b=rO4L4aKBMw2PaCYYaCEslmzdudeN/MtzY1636FV07qYqZk818xHH/hdBu1pFhdgCNM
         9HKBbdCQZ6f3m5nsXn92jyoSvOvHiZba8L9mTrELUBAiZFtxxnJ1ZLfGRlQ+xFpxhq+x
         pEpEQfWjxqzDFE9Ua9w9nnNDOBaLmqjpYuX3XKCk37nZjR12ubJKtDkbsMIPlFNq12JI
         h8wBJj5AIK1Ie/YpQDMbCBqclq988vLiqrlQUfQPcfDABFKQElNZmiuV5Ex2Ehpbk3IA
         YmSSeRmWsX0XozwzTAYous9pk0WzXq95uMQ0OUswrAETKlHXodMlrvoRtPiArhIjRlcj
         0Ghg==
X-Forwarded-Encrypted: i=1; AJvYcCVG7RIYZIrEyPEnxvVF+YJvjQbKtL89bVs8RV32x8yxmFJ2zVpeWAf4JVKnjumWcJ5vPxFfAIpcP1R7HgJWIh72dH13ZCJgQ0cDnjQVrqrhJ17C6/w9flz2dnl/IDCVE7dswA7bv3MFWA==
X-Gm-Message-State: AOJu0Yx21qBXs3yKwe2vFV1Oe+nztkzeE4F0B65hfhXUzGp2iMKX3Off
	+nOpuwZtOchRV3bvr7V7cLYq0gnLAqNd9tErffAahKspeasFdtDW
X-Google-Smtp-Source: AGHT+IEzoVR/QekSFlxwlG1y8gK8vH3Bdx5XnDmjrRTB2zenBkCf2dUGrpltlAYKRVdfu3RIHU7Dww==
X-Received: by 2002:a17:906:f59c:b0:a68:e335:3e67 with SMTP id a640c23a62f3a-a68e3354039mr160861566b.17.1717315149813;
        Sun, 02 Jun 2024 00:59:09 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f6a557f9sm42073966b.83.2024.06.02.00.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2024 00:59:09 -0700 (PDT)
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
Date: Sun, 2 Jun 2024 09:59:03 +0200
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
 linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org,
 kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1316DC2-0822-4B82-BCD0-99904D4741EF@gmail.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

(resent as plain text instead of html)
=20
Cristian,

I was awaiting over year for this work!

I=E2=80=99m devel. 2 distros where single mainline kernel serves =
2835/2711/2712/h6/h313/h616/h618/rk3328/rk3399/rk3566/rk3568/rk3588/s905/s=
912/sm1/g12.

Before this work rk3588 was excluded because rk3588 hdmi was regressing =
hdmi on other socs.
With this code all other socs seems work ok now. Perfect.

As one of my project is multimedia appliance - good news is that now i =
can nicely play hdtv on rk3588 using mainline common 6.9.3 kernel =
and=E2=80=A6.started to hear from my users a lot of Qs like: =E2=80=9Eah =
so nice! rk3588 now works nicely=E2=80=A6.but where is hdmi audio and =
cec?=E2=80=9D

It will be fantastic to add (e.g. by backport Detlev =
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/tre=
e/rk3588-hdmi-audio?ref_type=3Dheads ) audio code to get basic support =
hdmi audio?
  =20
thx again for fantastic work!

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


