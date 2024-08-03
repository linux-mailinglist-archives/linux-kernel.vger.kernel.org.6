Return-Path: <linux-kernel+bounces-273488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C99469DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B51281C66
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32E14F9C5;
	Sat,  3 Aug 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVjQIszx"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBE847B;
	Sat,  3 Aug 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722691456; cv=none; b=T5ZQYkTtIN09pG9v0Z3N2W21OAWZ49Pd4h2wJ8Kxyx1OXLTZS1onw+zNwaH006DoTb6GBxF1ueanCwyatU9gSqJ/jLNp166olNKxKSF5wNrQdVseQD8cy+mxbqllZXL1SLVUd/SmxJPWmfr4TRsPQ1FcpDQ/HfsE+WgYdexmkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722691456; c=relaxed/simple;
	bh=TiHAzfgoe8EM3ja/jx7BuKXYx53rmM4dW1LvTOCVuXw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R1uv+qIsAwYAsNaPRXm47VFkOY+E594ePNXpHl9JOGXuhR10PmrLLTumRvSOidBiw0k+lHIKVkA+FZfAXsuijB8/MoK9IyPskc6BoiVtFwymFU3/QlQvlht5goLw2Jg3CoxGUXpSVY1KbOAxUibs1i9j6mg+K1P/bAi9a7bEjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVjQIszx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso128151951fa.0;
        Sat, 03 Aug 2024 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722691453; x=1723296253; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzpCCTH0/xwvVQdxzEjUmceihmN3TBWI0uvCFLscZtY=;
        b=NVjQIszxGCat3ns0uFOlK1afyPWcIgDfq/MdIFY/OWZ10T+U5iDlnuxuxAUKg+jEwE
         v5QkoUiuF8hxl5grgDJqyOjk85x/+bEEA1+W9EUB+o/k99ZsnCcfkKQoSVG0hp+2WrKk
         VJSdJ4V8AjghvGYilMljwJL4HWHU04cmVgA9C/IIaP/NWHuVN0D3GP6v/5zY5jOEpYeT
         vSf1TsvmlL3mz2gcfRD+H/u7oGzwL77EyQzuG7RhDhLU6O+XtVq0QmZ5AVrWQ1UHlLGg
         uq4YMCH9QRdsfGFWEcu9C8pSInChKQJeXfBJJBQhizxMt2FPqeqxwInByDhZFtI/vYUJ
         UzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722691453; x=1723296253;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzpCCTH0/xwvVQdxzEjUmceihmN3TBWI0uvCFLscZtY=;
        b=r5wf+JZRmdk6wfIWi/0u7F1vDJefFemAsKrDBhQT/CRLtFVYspXEjGrwArWBLmFZAO
         tKAl1XJBgc2ldZVnSXuMgIynK50YVD2I/onoilAVjVVZ0PDNpPOwOStPGrcMqqghx8u5
         xugmAfsPKa+vCfSBuXiRER0j/sv4LLQPC+o/JFqKFctckXIQJISdGHSy6WHVTQo9BbbN
         FIG/yHoIyjuNAHPCqVm6IVzfU6VQQS3ssjsRXsJoPujdjaN8KJ9WwSh4DmBy9yNBiM9Y
         7AO2MVTHwosE4VrEAsNo/dl6aeFutgEB2yBG43Zc8wZ6JKTMh3+BjlRhOybgha7DWA+b
         yaow==
X-Forwarded-Encrypted: i=1; AJvYcCWdKf6KI/u8e81YK2iB4Jgll8uzxr2aVzKRAiYOzsUhNv+QBnjMfiwIDEys1xugyt5LYgUoIwLAdeR7mXZbDjaycqyWHnBF6MowWWgk7zwKwQM+QoRz6Gm1K+Zam1oSNsbyhEu2rGuLOw==
X-Gm-Message-State: AOJu0Yx5sQivsEUVf/Y3gjbWV7mNopvOEbHthUHdqdjOuIRABS+EQRmM
	IFV5LoZ5Qs7gHCToJR7DiSaVFWiNhMC4J5GOrlNJRVRBWduAG1ub
X-Google-Smtp-Source: AGHT+IHxajhrVXECR8o0njI5ofrgVEj/uAk6WTxsocWIGcDjAW3f8TEqykfMjSBHeSmbargLx9MOqw==
X-Received: by 2002:a2e:b8c7:0:b0:2f1:5d61:937e with SMTP id 38308e7fff4ca-2f15d61943dmr51500231fa.29.1722691452413;
        Sat, 03 Aug 2024 06:24:12 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f16a9ded09sm2451181fa.109.2024.08.03.06.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2024 06:24:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH v2 0/3] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
Date: Sat, 3 Aug 2024 15:24:06 +0200
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
 =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
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
Message-Id: <45B07EAF-4CBA-4DE4-A03B-109767D52B29@gmail.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

Hi Cristian,

Will you find some time and motivation to add CEC support to Quad-Pixel =
(QP) TX controller ?

Probably you recall - I added initial CEC support to yours v1 series and =
i=E2=80=99m stuck with timing issue (cec pulses are 3x too long).
For me it looks like clock issue.
I=E2=80=99m out of ideas how to move forward with this timming issue=E2=80=
=A6.
=20


> Wiadomo=C5=9B=C4=87 napisana przez Cristian Ciocaltea =
<cristian.ciocaltea@collabora.com> w dniu 01.08.2024, o godz. 04:25:
>=20
> The Rockchip RK3588 SoC family integrates the Synopsys DesignWare HDMI
> 2.1 Quad-Pixel (QP) TX controller [4], which is a new IP block, quite
> different from those used in the previous generations of Rockchip =
SoCs.
>=20
> This is the last component that needs to be supported in order to =
enable
> the HDMI output functionality on the RK3588 based SBCs, such as the
> RADXA Rock 5B. The other components are the Video Output Processor
> (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for which basic
> support has been already made available via [1] and [2], respectively.
>=20
> Please note this is a reworked version of the original series, which
> relied on a commonized dw-hdmi approach.  Since the general consensus
> was to handle it as an entirely new IP, I dropped all patches related =
to
> the old dw-hdmi and Rockchip glue code - a few of them might still =
make
> sense as general improvements and will be submitted separately.
>=20
> Additionally, as suggested by Neil, I've sent the reworked bridge =
driver
> as a separate patchset [4], hence this series handles now just the new
> Rockchip QP platform driver.
>=20
> It's worth mentioning the HDMI output support is currently limited to
> RGB output up to 4K@60Hz, without audio, CEC or any of the HDMI 2.1
> specific features.  Moreover, the VOP2 driver is not able to properly
> handle all display modes supported by the connected screens, e.g. it
> doesn't cope with non-integer refresh rates.
>=20
> A possible workaround consists of enabling the display controller to
> make use of the clock provided by the HDMI PHY PLL. This is still work
> in progress and will be submitted later, as well as the required DTS
> updates.
>=20
> To facilitate testing and experimentation, all HDMI output related
> patches, including those part of this series, as well as the bridge
> driver, are available at [3].
>=20
> So far I could only verify this on the RADXA Rock 5B board.
>=20
> Thanks,
> Cristian
>=20
> [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY =
driver")
> [3]: =
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/com=
mits/rk3588-hdmi-bridge-v6.11-rc1
> [4]: =
https://lore.kernel.org/lkml/20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@coll=
abora.com/
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
> - Reworked the glue code for RK3588 into a new Rockchip platform =
driver
> - Moved bridge driver patches to a separate series [4]
> - Dropped all the patches touching to the old dw-hdmi and RK platform
>  drivers
> - Added connector creation to ensure the HDMI QP bridge driver does =
only
>  support DRM_BRIDGE_ATTACH_NO_CONNECTOR
> - Link to v1: =
https://lore.kernel.org/r/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753=
232b@collabora.com
>=20
> ---
> Cristian Ciocaltea (3):
>      dt-bindings: display: rockchip: Add schema for RK3588 HDMI TX =
Controller
>      drm/rockchip: Explicitly include bits header
>      drm/rockchip: Add basic RK3588 HDMI output support
>=20
> .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++++++
> drivers/gpu/drm/rockchip/Kconfig                   |   8 +
> drivers/gpu/drm/rockchip/Makefile                  |   1 +
> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 430 =
+++++++++++++++++++++
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
> drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   4 +-
> 6 files changed, 632 insertions(+), 1 deletion(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


