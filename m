Return-Path: <linux-kernel+bounces-415757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736499D3B05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212331F24C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A41AA1D3;
	Wed, 20 Nov 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZyLSPf8V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F419E82A;
	Wed, 20 Nov 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106729; cv=none; b=KqboPsdNFN0i1d4gbTw/xNkvNN3EwYUUUKHD7ODS8sQs2eJ5pWA/Qw5E8X/l8Pifm/59xLpEISk1eOTX/42TjPKLetSuTdCXqQJ9hftW4vOlOdGQBXBVAqNhEcvsojbW5HNmpEQHq2odSParEF4hiwIUE5eUmWftZRyvPLnQWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106729; c=relaxed/simple;
	bh=DlFjoO8RntcaAZI4sE6wRiR0Wf7VsiwXxZxdjrSEBn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJPRwoQP3PnzKa4/b1jRjyGCPddrDDLYLjx+A8WwcW0kWYqpL62vQz3Z68cnc/wIubHQkUysGMqexzcRgYjMLnXt2gJVyXrdDhTdFwd/mX4/klRJkk2aBbczaemEyNWMQGTKXNr+X1iQNIpdzKGAhLHOK3VlaVuR4j3lYrQH+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZyLSPf8V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106726;
	bh=DlFjoO8RntcaAZI4sE6wRiR0Wf7VsiwXxZxdjrSEBn8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZyLSPf8VjThZ7G0QsGZayt3/X9S50h/pZ/z6do3uRuCIb+bYX2L4ScNSfuNEe7nL8
	 k6HmxBnqclIMymkt8V81I3VEo74DfS/MNZZFne2YMqOm/xq1ZYxbOnVGxijobDK+vW
	 UyR3FG4BQmqse+E8gPny/GqEnSQmnH5Z3dbk5hL92upZor04b8wMYLp+oUoPLas3xo
	 WWDJJSjHM4UZY8OIQmjhiurHhiq0HMDZM5yYqhxQ5x0O0rLG6HQpUAOykLDSYMqy7b
	 U8qKEZWsiquAD2Ck92X6Cfug+Ryd9AgmgAp9gWsWmNXw7qtfPm6wRzfeJDA6JpIbr9
	 bQZN0xekohbng==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34E4C17E3661;
	Wed, 20 Nov 2024 13:45:25 +0100 (CET)
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
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/7] drm/mediatek: Add support for HDMIv2 and DDCv2 IPs
Date: Wed, 20 Nov 2024 13:45:05 +0100
Message-ID: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the HDMI-TX v2 Encoder and DDCv2, as found
in MT8195, MT8188 and their variants.

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

AngeloGioacchino Del Regno (6):
  dt-bindings: display: mediatek: Add binding for HDMIv2 DDC
  dt-bindings: display: mediatek: Add binding for MT8195 HDMI-TX v2
  drm/mediatek: mtk_cec: Switch to register as module_platform_driver
  drm/mediatek: mtk_hdmi_ddc: Switch to register as
    module_platform_driver
  drm/mediatek: mtk_hdmi: Split driver and add common probe function
  drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188

Guillaume Ranquet (1):
  drm/mediatek: hdmi: Use regmap instead of iomem for main registers

 .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    |   41 +
 .../mediatek/mediatek,mt8195-hdmi.yaml        |  150 ++
 drivers/gpu/drm/mediatek/Kconfig              |   19 +-
 drivers/gpu/drm/mediatek/Makefile             |    5 +
 drivers/gpu/drm/mediatek/mtk_cec.c            |    5 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  843 ++--------
 drivers/gpu/drm/mediatek/mtk_hdmi.h           |   14 -
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c    |  375 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_common.h    |  200 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       |    4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c    |  401 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h   |  249 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c        | 1460 +++++++++++++++++
 13 files changed, 3060 insertions(+), 705 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c

-- 
2.47.0


