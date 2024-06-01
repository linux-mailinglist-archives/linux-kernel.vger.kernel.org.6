Return-Path: <linux-kernel+bounces-197848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767108D6FFE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47C21F215B4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E41514CB;
	Sat,  1 Jun 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i+8QZ1ck"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B7AD59;
	Sat,  1 Jun 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247588; cv=none; b=LYxC4k0SdfK6a/hBwRvn8hWtlJ6AGZckSQSw8ZRi/S0T7DjZFBuwSbIfLgsvZXOmAcF4NWugbb1KMkPILXRTEwC1q9nOglv4QRqHwMjjACZPdH/jKOFMbP9S0+riMlN9nFsUP69sswPQFqI3+mUGUEMG/DGhfr1lFZzaVhsiKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247588; c=relaxed/simple;
	bh=h58JsD+SebyiyL2HCvGvq4VST8PeU6RDgSW12Kr6f70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e1TZQyQVUy77kl1cG8vo78RReLBNi8L/jmfUQhT5KAvy7ZaTLr8XsNzENn/eG16JcK1hv475Ysx5TccbmzJpsi6d34jlNz93H+7fcCsdaiL4JS61UIaqpe6YjpFW8+2xHfiUjgZK1zbBW250UIml1TdY5s2lLwYuqAFkiqe8f8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i+8QZ1ck; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247578;
	bh=h58JsD+SebyiyL2HCvGvq4VST8PeU6RDgSW12Kr6f70=;
	h=From:Subject:Date:To:Cc:From;
	b=i+8QZ1ckn9fn0MNYXlvoDa1BwwVl3iWJXXphGhoixfP0siuIUWV+i0drhAffhWN5q
	 Qq+dnv5IhTJALQk0gHMaUIeD1foqJWZN3iIjcR6l2xvHFk38KfSSTT9Y3tG9nSQVJN
	 hgqpVjmUb0tIm7cymZRCxcP4NCahLJiSRngakt++NzI9ffbRfUygfciuXoq9Jt8Rt/
	 NU2BaG+OgFRlHP2JuSVuwjMqEmxcvX0q+SEQ0lrWqcU2WtFFDDpijLqiDL06mT9JIV
	 sqDbwWxfsqJ9PtVr0qi+CM1t165hSgP+flA9P7jt9nOXgmsg2ng0N8H5zOvlnC37Cz
	 IDwY+6jDFWiyw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A752378203E;
	Sat,  1 Jun 2024 13:12:58 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
Date: Sat, 01 Jun 2024 16:12:22 +0300
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYeW2YC/x2MQQrDIBAAvyJ7zoLaNJF+JfSgcU2WUitrWgqSv
 1d6HIaZBpWEqcJNNRD6cOVX7mAGBevu80bIsTNYbUc9aYNhRHlcrs5hEI7dv0s9hPwTvZ2DT8k
 El1bofRFK/P2/l/t5/gDw2BPpawAAAA==
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
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>, 
 Algea Cao <algea.cao@rock-chips.com>
X-Mailer: b4 0.14-dev-f7c49

The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
Synopsys DesignWare HDMI TX controller used in the previous SoCs.

It is HDMI 2.1 compliant and supports the following features, among
others:

* Fixed Rate Link (FRL)
* 4K@120Hz and 8K@60Hz video modes
* Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
* Fast Vactive (FVA)
* SCDC I2C DDC access
* TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
* YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
* Multi-stream audio
* Enhanced Audio Return Channel (EARC)

This is the last required component that needs to be supported in order
to enable the HDMI output functionality on the RK3588 based SBCs, such
as the RADXA Rock 5B. The other components are the Video Output
Processor (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for
which basic support has been already made available via [1] and [2],
respectively.

The patches are grouped as follows:
* PATCH 1..7: DW HDMI TX driver refactor to minimize code duplication in
  the new QP driver (no functional changes intended)

* PATCH 8..11: Rockchip DW HDMI glue driver cleanup/improvements (no
  functional changes intended)

* PATCH 12..13: The new DW HDMI QP TX driver reusing the previously
  exported functions and structs from existing DW HDMI TX driver

* PATCH 14: Rockchip DW HDMI glue driver update to support RK3588 and
  make use of DW HDMI QP TX

They provide just the basic HDMI support for now, i.e. RGB output up to
4K@60Hz, without audio, CEC or any of the HDMI 2.1 specific features.
Also note the vop2 driver is currently not able to properly handle all
display modes supported by the connected screens, e.g. it doesn't cope
with non-integer refresh rates.

A possible workaround consists of enabling the display controller to
make use of the clock provided by the HDMI PHY PLL. This is still work
in progress and will be submitted later, as well as the required DTS
updates.

To facilitate testing and experimentation, all HDMI output related
patches, including those part of this series, are available at [3].
So far I could only verify this on the RADXA Rock 3A and 5B boards.

Thanks,
Cristian

[1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
[2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
[3]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-v6.10-rc1

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (14):
      drm/bridge: dw-hdmi: Simplify clock handling
      drm/bridge: dw-hdmi: Add dw-hdmi-common.h header
      drm/bridge: dw-hdmi: Commonize dw_hdmi_i2c_adapter()
      drm/bridge: dw-hdmi: Factor out AVI infoframe setup
      drm/bridge: dw-hdmi: Factor out vmode setup
      drm/bridge: dw-hdmi: Factor out hdmi_data_info setup
      drm/bridge: dw-hdmi: Commonize dw_hdmi_connector_create()
      drm/rockchip: dw_hdmi: Use modern drm_device based logging
      drm/rockchip: dw_hdmi: Simplify clock handling
      drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
      drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, cur_ctr and phy_config
      dt-bindings: display: rockchip,dw-hdmi: Add compatible for RK3588
      drm/bridge: synopsys: Add DW HDMI QP TX controller driver
      drm/rockchip: dw_hdmi: Add basic RK3588 support

 .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 +++-
 drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h   | 179 +++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 787 +++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 831 +++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 353 +++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 351 +++++++--
 include/drm/bridge/dw_hdmi.h                       |   8 +
 8 files changed, 2290 insertions(+), 348 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc


