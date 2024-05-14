Return-Path: <linux-kernel+bounces-178875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7678C58F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEC81F22AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87417EBA5;
	Tue, 14 May 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmYNiU8i"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B351E480
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701260; cv=none; b=GvZrrbl0TILr7bAv/dzQFfnFV4mwxuXCn8rc1SGyguJfKPV5WditAquPj6Mu0oQtvU/UU34zNoKMxCm7JRtQzWrcy2hAejZ6hVc8CvhAz7ps8l5cjUvSCGpNPbBii0DXev8Gk9d2RHDggY1/KGHz01L2UgixVIqgm/saHTP/l9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701260; c=relaxed/simple;
	bh=6P5TUbjdoN0pOeO0r2aoBSMClDKbikMxRR5daggJxSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBLICdP7uHADCUkjXabW9JJHG/to6z0140AJRok+fQE/PlMuzw7wwVrHeud5GuXbIXSvfv91649mHAcRouKjr9xFbATJ+AqZUNffF//A4gFftzkXUEvC9Eh75H2oBP36OA28NoE1q90jbTpwW6NX6fl5MIV/jRHN3h+uXS6bJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmYNiU8i; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715701255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GqWA4dxsny1RyIST0+ZaXedMLewwlAUbRrK+aI3zxqY=;
	b=wmYNiU8i7Glte1xtOP0HceYbc1gq6ZpxEuUEq+EkWRMSxetyWLm5RE8SBYA8zwP2aiLjEh
	IIsu7f/4vNWzV4a3mXxeYFGav06juT/I4051bQEoeSWK5Rfj6s3IkKNY0kuk5S1WCPHVMt
	okLhUv9DoeJNCovwTEm38fTXUa/dHpA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the drm_bridge structure
Date: Tue, 14 May 2024 23:40:43 +0800
Message-ID: <20240514154045.309925-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because a lot of implementations has already added it into their drived
class, promote it into drm_bridge core may benifits a lot. drm bridge is
a driver, it should know the underlying hardware entity.

Sui Jingfeng (2):
  drm/bridge: Support finding bridge with struct device
  drm/bridge: Switch to use drm_bridge_add_with_dev()

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |  3 +-
 .../drm/bridge/analogix/analogix-anx6345.c    |  4 +-
 .../drm/bridge/analogix/analogix-anx78xx.c    |  4 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     |  3 +-
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    |  3 +-
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  3 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c      |  5 +--
 drivers/gpu/drm/bridge/chrontel-ch7033.c      |  3 +-
 drivers/gpu/drm/bridge/cros-ec-anx7688.c      |  4 +-
 drivers/gpu/drm/bridge/display-connector.c    |  3 +-
 drivers/gpu/drm/bridge/fsl-ldb.c              |  3 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  3 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-link.c   |  3 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c  |  3 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |  3 +-
 drivers/gpu/drm/bridge/ite-it66121.c          |  3 +-
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
 drivers/gpu/drm/bridge/sii902x.c              |  3 +-
 drivers/gpu/drm/bridge/sii9234.c              |  3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c          |  3 +-
 drivers/gpu/drm/bridge/simple-bridge.c        |  3 +-
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
 drivers/gpu/drm/bridge/ti-tfp410.c            |  3 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c         |  3 +-
 drivers/gpu/drm/drm_bridge.c                  | 39 +++++++++++++++++++
 drivers/gpu/drm/i2c/tda998x_drv.c             |  5 +--
 include/drm/drm_bridge.h                      |  5 +++
 49 files changed, 91 insertions(+), 99 deletions(-)

-- 
2.43.0


