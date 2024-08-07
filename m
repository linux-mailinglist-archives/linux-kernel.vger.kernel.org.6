Return-Path: <linux-kernel+bounces-277799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DF94A6A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239E31C217CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA151E2879;
	Wed,  7 Aug 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="GJJRaBdv"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF21B8E82;
	Wed,  7 Aug 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028913; cv=pass; b=VSZE0fLw/fkhkiQBiLCfQW5CZp5Jg7ulS1J4AsNijORcMyqFLmK0pHFGLsJUGj7+cj0lqTVyb/FY8Tv0JIbrlLNqGhiBGldgm5g+C3tqhngbsuUnphg0Rp6s4Z+bL1kmWEleWPqBZkK4O9Fpent/OUJISHYGWXBQD3sQoYhT/cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028913; c=relaxed/simple;
	bh=/biSKoGdghroZkIdSrcwVewXKoRZKmiJpXDCXLlf6/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GH8WgoNaM4kjeZlnvGEI+Fuwev/3qm2MAq4GKywQWTCPIHo0uGqftHMYwBJgzNd3m3LcUtGWHn1pN/IwvFYwoXqjdq8IGCBTgmcm24ZA03ZGNX5525BNkGv/2rNKTqkb3IiknppfHX0XxMqoJ/PS8NaEs1bT8biCG6qlQE+A3t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=GJJRaBdv; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723028868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lsROZuLuYQNiSiT8rbwxvEW3hwLy7c0XhbIdtujDMI8a9Ajj87RTToWyfPCAYoAbS/OrLZSVIskb0PGFLw5fXyMXEIaTPRHlt1e8Dm5H4SZb2chXY2RcfA0c0nXkuH/j+q5ARU0LKozf9ANzws+obYyoPs/alhy31CIACVCfvNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723028868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kLdQEDNBVXsEvksFLGhYH90bCM6T+iD6ZGhobATCzPw=; 
	b=kmdzlbmSvJYDF4Fb8P7jqKcIiIBlwdOKmD/6eNtC2H8mBYJsJVBZ1O1ik6uJluoo5bjS03kiRI3ntWSKBEh//I9k8gzSo2wlV/ELIguDcAEwlz6vyIOC6x40hjaN24QDpIharR68XcFGEMAwhk4UuOR/h8Ia0ua/M9EKujOaP0U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723028868;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=kLdQEDNBVXsEvksFLGhYH90bCM6T+iD6ZGhobATCzPw=;
	b=GJJRaBdvFjKGnmap8LXyeb/fWpSWyHgmRT7BnLCo0lMOvh3U2Ls+ti4A/hatEuya
	QTNyonvdOF3gSnh4olhyFTLTD6UCx+AA5gA8giASEa5Cr8HABnRsr7f9AwKJ5+Awvlp
	kgOmxVj0y/9XwybvwAx/Bk75sKJ7TbV7P0mPfls0=
Received: by mx.zohomail.com with SMTPS id 1723028866565296.89284623296203;
	Wed, 7 Aug 2024 04:07:46 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/5] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
Date: Wed, 07 Aug 2024 14:07:22 +0300
Message-Id: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpVs2YC/43NwQ7CIAyA4VdZOIuBMrbpyfcwHgoDR5xjgUk0y
 95dtosHE+Pxb9OvM4kmOBPJsZhJMMlF54ccYlcQ3eFwNdS1uQkwKFnFOFUlDTchm4aq4Nq8f4x
 xCgbvFKFWaC1XjdUk34/BWPfc7PMld+fi5MNre5X4Ov1HTZwyaitgopYCBKiT9n2Pygfca38nq
 5zgozW/NcjawWIlaywNl1/asixvfghpExQBAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>, 
 Algea Cao <algea.cao@rock-chips.com>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

The Rockchip RK3588 SoC family integrates the Synopsys DesignWare HDMI
2.1 Quad-Pixel (QP) TX controller, which is a new IP block, quite
different from those used in the previous generations of Rockchip SoCs.

The controller supports the following features, among others:

* Fixed Rate Link (FRL)
* Display Stream Compression (DSC)
* 4K@120Hz and 8K@60Hz video modes
* Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
* Fast Vactive (FVA)
* SCDC I2C DDC access
* Multi-stream audio
* Enhanced Audio Return Channel (EARC)

This is the last component that needs to be supported in order to enable
the HDMI output functionality on the RK3588 based SBCs, such as the
RADXA Rock 5B.  The other components are the Video Output Processor
(VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for which basic
support has been already made available via [1] and [2], respectively.

Please note this is a reworked version of the original series, which
relied on a commonized dw-hdmi approach.  Since the general consensus
was to handle it as an entirely new IP, I dropped all patches related to
the old dw-hdmi and Rockchip glue code - a few of them might still make
sense as general improvements and will be submitted separately.

It's worth mentioning the HDMI output support is currently limited to
RGB output up to 4K@60Hz, without audio, CEC or any of the HDMI 2.1
specific features.  Moreover, the VOP2 driver is not able to properly
handle all display modes supported by the connected screens, e.g. it
doesn't cope with non-integer refresh rates.

A possible workaround consists of enabling the display controller to
make use of the clock provided by the HDMI PHY PLL.  This is still work
in progress and will be submitted later, as well as the required DTS
updates.

To facilitate testing and experimentation, all HDMI output related
patches, including those part of this series, are available at [3].

So far I could only verify this on the RADXA Rock 5B board.

Thanks,
Cristian

[1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
[2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
[3]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-v6.11-rc1
[4]: https://lore.kernel.org/lkml/20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Reintegrated bridge patchset [4] to allow automated testing and
  simplify reviewing (Krzysztof); the after-split changes were:
  * Made use of the new bridge HDMI helpers indicated by Dmitry
  * Dropped connector creation to ensure driver does only support
    DRM_BRIDGE_ATTACH_NO_CONNECTOR
  * Updated I2C segment handling to properly handle connected DVI
    displays (reported and fixed by Heiko)
- Updated schema for DW HDMI QP TX IP providing some hardware details
- Updated patch for DW HDMI QP TX Controller module referring to a
  support library instead of a platform driver (Krzysztof)
- Drop empty dw_hdmi_qp_unbind() export from the library and related
  usage from RK platform driver
- Drop Fixes tag from "drm/rockchip: Explicitly include bits header"
  patch (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com

Changes in v2:
- Reworked the glue code for RK3588 into a new Rockchip platform driver
- Moved bridge driver patches to a separate series [4]
- Dropped all the patches touching to the old dw-hdmi and RK platform
  drivers
- Added connector creation to ensure the HDMI QP bridge driver does only
  support DRM_BRIDGE_ATTACH_NO_CONNECTOR
- Link to v1: https://lore.kernel.org/r/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com

---
Cristian Ciocaltea (5):
      dt-bindings: display: bridge: Add schema for Synopsys DW HDMI QP TX IP
      drm/bridge: synopsys: Add DW HDMI QP TX Controller support library
      dt-bindings: display: rockchip: Add schema for RK3588 HDMI TX Controller
      drm/rockchip: Explicitly include bits header
      drm/rockchip: Add basic RK3588 HDMI output support

 .../display/bridge/synopsys,dw-hdmi-qp.yaml        |  72 ++
 .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++
 drivers/gpu/drm/bridge/synopsys/Kconfig            |   8 +
 drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 742 ++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 834 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 429 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   4 +-
 include/drm/bridge/dw_hdmi_qp.h                    |  36 +
 12 files changed, 2325 insertions(+), 1 deletion(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc


