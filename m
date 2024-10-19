Return-Path: <linux-kernel+bounces-373006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BE9A508E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3918DB25AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E811922D6;
	Sat, 19 Oct 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FUzQFxHB"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A816191F62
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367689; cv=none; b=JMySEy0zQqI5CWHfvEer4Zy332OPl7DV6IrGwtzYzdK609nAdBAqOsxhXZ9qmbjYH2Zq+toycDZE51pgvWn6DX1DJEgtKBe6jQHBXQzlJzDo6kJwrlGzCh5SI8bxqeoLNi3gpoo+goyAdncvNuGFKtm0ujDBrp8nxEoojPWbd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367689; c=relaxed/simple;
	bh=YG8WiJQeyyD4dF+PgGaf/rrZpU7jT4w9sE/GFgFQGp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swI4ZLvIS5RrGfti8cMLSwAx/IyFaEdwVcQByHt5nhgfls58NR2oQKQqDRFAhseDkozUjmI2pw194mZrNwxNo/wR8u5KxLdWZXs54R5dlV8c4ZZp5VNWjtTZgMAK4aa8bw98QxFqlR4V6pcItT25YhJqirbE9OYc71sqMFSkSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FUzQFxHB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729367685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HJygdyJ066Xs3apcFHC5i1N9FuSeNHbO8RlThkAytM=;
	b=FUzQFxHBL9otUEIDyVWpeNdRZFDmEjJL8ODtFmDiEfVFL2kKA5Yxnlb0xcorYHi3VZtuWj
	aD18WdPkL+Rpxb9VYkfC1z6/MZObNM2QpVdzVU9BFQaPDzMqMNlnYgFvQ7B+eOnstBIZ2q
	raoLeW3Qp2rUlBtOtaQH8KseJwmfR9o=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Dominik Haller <d.haller@phytec.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: [PATCH v5 03/13] drm/bridge: cdns-dsi: Fix Phy _init() and _exit()
Date: Sun, 20 Oct 2024 01:24:01 +0530
Message-Id: <20241019195411.266860-4-aradhya.bhatia@linux.dev>
In-Reply-To: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

Initialize the Phy during the cdns-dsi _resume(), and de-initialize it
during the _suspend().

Also power-off the Phy from bridge_disable.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 5159c3f0853e..d89c32bae2b9 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -672,6 +672,10 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 	if (dsi->platform_ops && dsi->platform_ops->disable)
 		dsi->platform_ops->disable(dsi);
 
+	phy_power_off(dsi->dphy);
+	dsi->link_initialized = false;
+	dsi->phy_initialized = false;
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -698,7 +702,6 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 	       DPHY_CMN_PDN | DPHY_PLL_PDN,
 	       dsi->regs + MCTL_DPHY_CFG0);
 
-	phy_init(dsi->dphy);
 	phy_set_mode(dsi->dphy, PHY_MODE_MIPI_DPHY);
 	phy_configure(dsi->dphy, &output->phy_opts);
 	phy_power_on(dsi->dphy);
@@ -1120,6 +1123,8 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	clk_prepare_enable(dsi->dsi_p_clk);
 	clk_prepare_enable(dsi->dsi_sys_clk);
 
+	phy_init(dsi->dphy);
+
 	return 0;
 }
 
@@ -1127,10 +1132,11 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
+	phy_exit(dsi->dphy);
+
 	clk_disable_unprepare(dsi->dsi_sys_clk);
 	clk_disable_unprepare(dsi->dsi_p_clk);
 	reset_control_assert(dsi->dsi_p_rst);
-	dsi->link_initialized = false;
 	return 0;
 }
 
-- 
2.34.1


