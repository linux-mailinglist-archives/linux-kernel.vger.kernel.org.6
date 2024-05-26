Return-Path: <linux-kernel+bounces-189855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F108CF5E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6B2280F53
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD7139562;
	Sun, 26 May 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wObpxQXN"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC120138493
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754906; cv=none; b=bvLUu7U2hQy4+p0+O2a/PUb3cKRBH+m2irjPmB9Pr+3PjT410ZATdDscJYXufYlkYmD3cgv69sQ+n3v0Fk4N6n/ShNchS6+QB6CH+uVwQCHda5KAhleip85+aqkNkGrV21Z7MpCM9COjTIkmHVOlj9vi3pSEkThwr6hwoMwNHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754906; c=relaxed/simple;
	bh=eEXyqEF2xDXBMfpcWeHey4NR2VDQOK8iwEQXHLZN+nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qzx0lNpbY2qbqakPrkf5w9WV9d7fNZmE063jZZlctpNeiih4B9Jel+K/CUN98jh5q60vTXMPsXCKRGfVdjI5gHCIYSrXHDALSbviXjm/uzoszu1QdcsgNh0JGEACLPSuGzgtpRFb2MCV5JaN32ZpsGgPUaLutkbIkNfcJ6HXIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wObpxQXN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GyqCBg/CJHjL1uDi9eGBGDlBz622MYKQ4wKZcqbZn/0=;
	b=wObpxQXNzmb2+e4fVfKNiI2Iv2hR1kY42nzdWOZuiQpTCeMb+Gkv4v26HbEByCqoJB0yPy
	VypWT+FySjbae+OirPEjtYhB3ox+32730WKl0531X7XpRyqutqw3FMSxnUzuAqju711BA5
	sOpEqWyscS4Vg72Z8qgL/Mqah3Px7WU=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v6 00/10] drm/bridge: Allow using fwnode API to get the next bridge
Date: Mon, 27 May 2024 04:21:05 +0800
Message-Id: <20240526202115.129049-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the various display bridge drivers rely on OF infrastructures
to works very well, yet there are platforms and/or devices absence of 'OF'
support. Such as virtual display drivers, USB display apapters and ACPI
based systems etc.

Add fwnode based helpers to fill the niche, this allows part of the display
bridge drivers to work across systems. As the fwnode API has wider coverage
than DT counterpart and the fwnode graphs are compatible with the OF graph,
so the provided helpers can be used on all systems in theory. Assumed that
fwnode graphs are well established on the system.

Tested on TI BeaglePlay board.

v1 -> v2:
	 * Modify it66121 to switch togather
	 * Drop the 'side-by-side' implement
	 * Add drm_bridge_find_next_bridge_by_fwnode() helper
	 * Add drm_bridge_set_node() helper

v2 -> v3:
	 * Read kernel-doc and improve function comments (Dmitry)
	 * Drop the 'port' argument of it66121_read_bus_width() (Dmitry)
	 * drm-bridge: sii902x get nuked

v3 -> v4:
	 * drm-bridge: tfp410 get nuked
	 * Add platform module alias
	 * Rebase and improve commit message and function comments

v4 -> v5:
	 * Modify sii9234, ch7033 and ANX7688
	 * Trivial fixes

v5 -> v6:
	 * Implement the same thing with no boilerplate introduced
	 * Add 'struct device *' field to the drm_bridge structure
	 * Re-implement of_drm_find_bridge() with drm_bridge_find_by_fwnode()

Sui Jingfeng (10):
  drm/bridge: Allow using fwnode APIs to get the next bridge
  drm/bridge: Set firmware node of drm_bridge instances automatically
  drm/bridge: Implement of_drm_find_bridge() on the top of
    drm_bridge_find_by_fwnode()
  drm/bridge: simple-bridge: Use fwnode APIs to acquire device
    properties
  drm/bridge: display-connector: Use fwnode APIs to acquire device
    properties
  drm/bridge: sii902x: Switch to use fwnode APIs to acquire device
    properties
  drm-bridge: it66121: Use fwnode APIs to acquire device properties
  drm/bridge: tfp410: Use fwnode APIs to acquire device properties
  drm/bridge: sii9234: Use fwnode APIs to abstract DT dependent API away
  drm/bridge: ch7033: Switch to use fwnode based APIs

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |  3 +-
 .../drm/bridge/analogix/analogix-anx6345.c    |  4 +-
 .../drm/bridge/analogix/analogix-anx78xx.c    |  4 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     |  3 +-
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    |  3 +-
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  3 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c      |  5 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c      | 15 ++--
 drivers/gpu/drm/bridge/cros-ec-anx7688.c      |  4 +-
 drivers/gpu/drm/bridge/display-connector.c    | 26 +++---
 drivers/gpu/drm/bridge/fsl-ldb.c              |  3 +-
 drivers/gpu/drm/bridge/imx/imx-ldb-helper.c   |  3 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  3 +-
 .../drm/bridge/imx/imx8qxp-pixel-combiner.c   |  3 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-link.c   |  3 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c  |  3 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |  3 +-
 drivers/gpu/drm/bridge/ite-it66121.c          | 58 ++++++++-----
 drivers/gpu/drm/bridge/lontium-lt8912b.c      |  3 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c       |  3 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c       |  3 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c    |  3 +-
 drivers/gpu/drm/bridge/lvds-codec.c           |  3 +-
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  3 +-
 drivers/gpu/drm/bridge/microchip-lvds.c       |  3 +-
 drivers/gpu/drm/bridge/nwl-dsi.c              |  3 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c          |  3 +-
 drivers/gpu/drm/bridge/panel.c                |  3 +-
 drivers/gpu/drm/bridge/parade-ps8622.c        |  3 +-
 drivers/gpu/drm/bridge/parade-ps8640.c        |  1 -
 drivers/gpu/drm/bridge/samsung-dsim.c         |  3 +-
 drivers/gpu/drm/bridge/sii902x.c              | 46 ++++------
 drivers/gpu/drm/bridge/sii9234.c              |  8 +-
 drivers/gpu/drm/bridge/sil-sii8620.c          |  3 +-
 drivers/gpu/drm/bridge/simple-bridge.c        | 24 +++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  3 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  3 +-
 drivers/gpu/drm/bridge/tc358762.c             |  3 +-
 drivers/gpu/drm/bridge/tc358764.c             |  3 +-
 drivers/gpu/drm/bridge/tc358767.c             |  3 +-
 drivers/gpu/drm/bridge/tc358768.c             |  3 +-
 drivers/gpu/drm/bridge/tc358775.c             |  3 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c         |  3 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c          |  3 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         |  3 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  3 +-
 drivers/gpu/drm/bridge/ti-tfp410.c            | 42 ++++-----
 drivers/gpu/drm/bridge/ti-tpd12s015.c         |  3 +-
 drivers/gpu/drm/drm_bridge.c                  | 87 +++++++++++++++----
 drivers/gpu/drm/exynos/exynos_drm_mic.c       |  3 +-
 drivers/gpu/drm/i2c/tda998x_drv.c             |  5 +-
 drivers/gpu/drm/mcde/mcde_dsi.c               |  3 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  3 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c    |  3 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c     |  3 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c    |  3 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c             |  3 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c             |  3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c           |  3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c           |  3 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c             |  3 +-
 drivers/gpu/drm/omapdrm/dss/venc.c            |  3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c   |  3 +-
 .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   |  3 +-
 .../gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c  |  3 +-
 drivers/gpu/drm/sti/sti_dvo.c                 |  3 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                 |  5 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  2 +-
 include/drm/drm_bridge.h                      | 21 +++--
 70 files changed, 256 insertions(+), 260 deletions(-)

-- 
2.34.1


