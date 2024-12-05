Return-Path: <linux-kernel+bounces-433137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654C9E544E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F771662D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69C2116F1;
	Thu,  5 Dec 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BhaR43+3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DA211497;
	Thu,  5 Dec 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399140; cv=none; b=Z4JG4zZU0bArOSXSbQJpap/v/2hhFXw5Ur8VDRpWD1wxQ2XI/+7Epmf1TT6U6VmlcZ+U2kzx6uzheupuOQ/2pFPmCfJvQMYvho8GT6SlcDDSDVN13qhEB+EOMulWwB9lCv8PKSf1cqJ5n5StCgc3hwmmODQmiY+zTI900MVQ4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399140; c=relaxed/simple;
	bh=cgkf1cp1dpYvnbVn9ujd9W1mVPbjreYJZQFTVn9Q5MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miL+0QRYWRZhRJPb0Hy1ILxOVwW6tkEfOf8U1cTCU6BCXmweK3yqRDz8ZcLi1nXDdgTowiAf/PyEhWA7pAg6nQyy6Rrfj/xNHro0wh8Z7cgL93NUm16r/Gjcvu4S+rtgifJs+6erP6Yspx2cUlknQoV4kjv6r0J3OI5S8dNYuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BhaR43+3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733399136;
	bh=cgkf1cp1dpYvnbVn9ujd9W1mVPbjreYJZQFTVn9Q5MU=;
	h=From:To:Cc:Subject:Date:From;
	b=BhaR43+3aGBEJKMdqTzBPpeOvjuxQlBISd5a+1mkqDu409qkb9XL1I47f9HVCythX
	 R4BALPsKX+AMMlbHIhmuLgxgjUaD1piileaBb60Hfu17Hx8661K752LvDGwIL1GkTQ
	 xJDNAin/3KZLhwmdL3GcaEtCcJTDRG7TpdakvC9ZGXyU8BsMeTpQmBW9ovSBAz3dXw
	 4klk5OyMSEUhGF6Jn2l82SM77KtaCPcvB+3rPGa4MLWywtYA2ivMTCRSa0o915wH5s
	 snceX1IeDxv/qzEXLuXWPw8rpkNtKhfCOMeCupex/nJ9KIIjYuu5G0G7XCAgm63g4c
	 VWtz3xGPx8ubw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1932C17E3633;
	Thu,  5 Dec 2024 12:45:35 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 00/15] Add support for MT8195/88 DPI, HDMIv2 and DDCv2
Date: Thu,  5 Dec 2024 12:45:02 +0100
Message-ID: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Merged series "Add support for MT8195/8188 and Pattern Generator"
   and "drm/mediatek: Add support for HDMIv2 and DDCv2 IPs" in one
   as they are directly related, as requested by CK Hu
 - More commonization: moved some audio functions to mtk_hdmi_common
 - Fixed a bug in DDCv2 driver to allow sending a message with len=1
 - Renamed some functions in HDMIv2 to consistently use the prefix
   mtk_hdmi_v2_ across the driver
 - Added .mode_valid() callback to HDMIv2
 - Added .atomic_check() callback to HDMIv2
 - Reordered drm_bridge_funcs in HDMIv2 driver
 - Rewritten .edid_read() callback in HDMIv2 to move checking audio
   availability to bridge_pre_enable() stage, and to stop using the
   drm_edid_read_ddc() in favor of drm_edid_read()
 - Added support for API provided HDMI Helpers
 - Added .tmds_char_rate_valid() callback to HDMIv2 for HDMI helpers
 - Added .hdmi_{read,write}_infoframe() callback to HDMIv2 for helpers
 - Added support for Vendor infoframes in HDMIv2
 - Added missing audio-dai-cells to HDMIv2 binding to fix check error
 - Added more information to the HDMIv2 binding for clocks and PHY
 - Added some comments to the HDMIv2 code to clarify why the controller
   is preconfigured in bridge_pre_enable() instead of bridge_enable()
 - Added a mention of the differences in HPD between v1 and v2 to the
   commit introducing the v2 driver (v2 is not using CEC for HPD)
 - ...and tested again on HW! :-)


This series adds support for the HDMI-TX v2 Encoder and DDCv2, and for
the direct connection DPI as found in MT8195, MT8188 and their variants.

Tested on Genio 700 EVK:
 - ABIST ON: ok, pattern generated internally from HDMI is shown on
   HDMI screen at the correct resolution;
 - ABIST OFF + DPI Pattern Generator ON: ok, pattern coming from DPI is
   shown on HDMI screen at the correct resolution;
 - Can negotiate up to 4k60

and on MT8395 Radxa NIO 12L:
 - ABIST ON: ok, pattern generated internally from HDMI is shown on
   HDMI screen at the correct resolution;
 - ABIST OFF + DPI Pattern Generator ON: ok, pattern coming from DPI is
   shown on HDMI screen at the correct resolution;
 - Dual screen usecase validated (DSI + HDMI 3840x2160p 60Hz)
 - Can negotiate up to 4k60

Please note that this submission does *not* include support for HDCP
nor for CECv2, as I want this to be upstream before implementing
additional features which are not strictly required for simple
HDMI output.

Bonus in this series is the addition of support for the Pattern Generator
found in the DPI HW: since I needed this for debugging during development,
I had to code in the actual support bits and it looked like a waste of
time to just remove it.
I instead decided to clean it up and upstream it, as this will anyway come
handy for multiple things, of which the most important (imo) are:
 - Adding support for new SoCs in the future will be less time consuming
   as this driver already has the pattern generator in;
 - CI Testing might be able to make use of this to validate that the
   data that comes out is not garbled (so, to help testing display
   support in an automated manner).

AngeloGioacchino Del Regno (14):
  dt-bindings: display: mediatek: dpi: Add MT8195 and MT8188 compat
  drm/mediatek: mtk_dpi: Add support for Pattern Generator in debugfs
  drm/mediatek: mtk_dpi: Use an array for pixclk factor calculation
  drm/mediatek: mtk_dpi: Move pixel clock setting flow to function
  drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence
  drm/mediatek: Add support for MT8195 Digital Parallel Interface
  dt-bindings: display: mediatek: Add binding for MT8195 HDMI-TX v2
  drm/mediatek: mtk_cec: Switch to register as module_platform_driver
  drm/mediatek: mtk_hdmi_ddc: Switch to register as
    module_platform_driver
  drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member
  drm/mediatek: mtk_hdmi: Split driver and add common probe function
  drm/mediatek: mtk_hdmi_common: Assign DDC adapter pointer to bridge
  drm/mediatek: mtk_hdmi_common: Add OP_HDMI, vendor and product strings
  drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188

Guillaume Ranquet (1):
  drm/mediatek: hdmi: Use regmap instead of iomem for main registers

 .../display/mediatek/mediatek,dpi.yaml        |    5 +
 .../mediatek/mediatek,mt8195-hdmi.yaml        |  154 ++
 drivers/gpu/drm/mediatek/Kconfig              |   19 +-
 drivers/gpu/drm/mediatek/Makefile             |    5 +
 drivers/gpu/drm/mediatek/mtk_cec.c            |    5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  311 +++-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h       |   10 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |    2 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  896 ++--------
 drivers/gpu/drm/mediatek/mtk_hdmi.h           |   14 -
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c    |  438 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_common.h    |  204 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       |    4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c    |  403 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h   |  263 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c        | 1488 +++++++++++++++++
 16 files changed, 3384 insertions(+), 837 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c

-- 
2.47.0


