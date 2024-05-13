Return-Path: <linux-kernel+bounces-177746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B6D8C4432
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC5281CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0858210;
	Mon, 13 May 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRmDzwba"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC481465A6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614283; cv=none; b=a0agJcfoXUkJA9TXwlQ/qh82700HP98MwQOOtCt7o3HiJC9rdrpWJx/NSVduJS0MF6iGzCoBhqgs0IPdUOYf39Kx4KsLSDfQavWjCpoYu15JUMcmNiXotKCoPLDMgrO90EUKwR32E9cGxTgvnAULJaRIpz+YwqdEDedRw72NL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614283; c=relaxed/simple;
	bh=w20mTqxPk9ZtO8madRvj0Hv77EK2jVodrEj7P3mT978=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SR32OkI5svBpfgM265Lv4pLlFVklNhmhB6+2B+ApWQOhqEE0VqIO1UnOLcdAnwa3GeunoJMhESkzN034bHgis+fsqsot6lr126NUXhpXzsone8Yd/Z+zawxzyuBE0cK3SyCZmuz4QnQKH71+O3BvcuyklIvodA1GqdDaTCv7kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRmDzwba; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k3tjxn3hGY8chOLjVh9vgYTCDBGT+jNofxaqe3MH5eQ=;
	b=ZRmDzwba0JQB7k8VCryqFvCdY5BoaUNiiKnjxAg6mzUz+0tZAiAsPe7OB5HgR+ZSUk4CpZ
	F3qLiy5rGzO5TxUbfWV/9t8OmU2OOlAHMx8b37w8sa/UntnSUAVtJ5Z7Jbh3I7DWmilj2u
	xddyis1gkWeTjmE1+IeRnS+i4eWxyyA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2 00/12] Remove redundant checks on existence of 'bridge->encoder'
Date: Mon, 13 May 2024 23:30:57 +0800
Message-ID: <20240513153109.46786-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The checks on the existence of bridge->encoder in the implementation of
drm_bridge_funcs::attach() is not necessary, as it has already been checked
in the drm_bridge_attach() function call by previous bridge or KMS driver.
The drm_bridge_attach() will quit with a negative error code returned if
it fails for some reasons, hence, it is guaranteed that the .encoder member
of the drm_bridge instance is not NULL when various bridge attach functions
are called.

V1 -> V2:
	* Gather all similar patches to form a series (Laurent)
	* Fix various spell error (Laurent)
	* Correct commit message for bridges of i.MX (Ying)

Sui Jingfeng (12):
  drm/bridge: simple-bridge: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: tfp410: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: nxp-ptn3460: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: panel: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: it6505: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: adv7511: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: cdns-mhdp8546: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Remove a redundant check
    on existence of bridge->encoder
  drm/bridge: synopsys: dw-mipi-dsi: Remove a redundant check on
    existence of bridge->encoder
  drm/bridge: lt9611uxc: Remove a redundant check on existence of
    bridge->encoder
  drm/bridge: imx: Remove redundant checks on existence of
    bridge->encoder
  drm/bridge: analogix: Remove redundant checks on existence of
    bridge->encoder

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c           |  5 -----
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c     |  5 -----
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c     |  5 -----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c     |  5 -----
 drivers/gpu/drm/bridge/analogix/anx7625.c              | 10 ----------
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  5 -----
 drivers/gpu/drm/bridge/imx/imx-ldb-helper.c            |  5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |  5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c        |  5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c           |  5 -----
 drivers/gpu/drm/bridge/ite-it6505.c                    |  5 -----
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c             |  5 -----
 .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  5 -----
 drivers/gpu/drm/bridge/nxp-ptn3460.c                   |  5 -----
 drivers/gpu/drm/bridge/panel.c                         |  5 -----
 drivers/gpu/drm/bridge/simple-bridge.c                 |  5 -----
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c          |  5 -----
 drivers/gpu/drm/bridge/ti-tfp410.c                     |  5 -----
 18 files changed, 95 deletions(-)

-- 
2.43.0


