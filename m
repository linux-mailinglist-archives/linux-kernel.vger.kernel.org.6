Return-Path: <linux-kernel+bounces-423324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0EE9DA5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A83716209B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58319C556;
	Wed, 27 Nov 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="aASOeJoy"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034D19924E;
	Wed, 27 Nov 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703477; cv=none; b=rsNmFMB5viLHIGQv2YIL0S90ulXJkr/eDNefQinz/xNNAA23nRWXMQLwHsI4iJSBSGuk47E4UrRiXy07VT4lEchwRNNFik2uxyc4yKTW/HJhPoc6aYqryFk7hDUP+qmyh8y2TDyxwenZPm88tYI6tIJe7H8wQUD+5rKSNwUbKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703477; c=relaxed/simple;
	bh=kS5gD+gCPg6RitLvR7solXUmzeZfhRVQioQxVljM6y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8sduhhDP8IibLOUDT/8oWnlnxHE9qWt6Jgk2T90H+39GBWTg2IMd1KRC7UIfxBNWmgVBXl/atdJ5cUTnNItN1/WmV2+6rTcz6db119aslwucEb7u4IyFOztz3rXH3T3aC5MgUA/qMsNLD+ir6xYL0DPvI4CP232vcK33J0dUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=aASOeJoy; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HDovDaEOFR4qUZaygP6Mpx2tbmWwjmnzTWmEO3UiYwo=; b=aASOeJoywklCeOh/F6TjHzBMJD
	mTL5Ymn8eus4irgeCOC5ll4doPl5wfve0rmQDmsf+9muLv/b1Avq/si6cQ1Ehj8t/6fKN05k10sc5
	yAnF7gaZpRoUElF+y3i9I0tk6y5V6kV4Dh/KBWzM/wxkB/HQwSwMBH+NN59+A2IEMuhCGCuMbt5IG
	/NvPtHinS3ioDY8ZXWLHW0tkP6S7Q8SUftXXxSN6PI4RcDhyeXZdo1yBzHUnb9OvvNYsZbi5/1orP
	PFDEmzwMcNnukb6MYWPA3p7jN68U2Cis/X9SoW/SBpnHN9e7DePeZcu5SnLoggNsltqhkIWd5gKkw
	UreS43aw==;
Received: from [89.212.21.243] (port=49750 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tGFK8-007Rx6-32;
	Wed, 27 Nov 2024 11:31:08 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] drm/bridge: ti-sn65dsi83: Add ti,lvds-vcom as optional property
Date: Wed, 27 Nov 2024 11:30:30 +0100
Message-Id: <20241127103031.1007893-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127103031.1007893-1-andrej.picej@norik.com>
References: <20241127103031.1007893-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Janine Hagemann <j.hagemann@phytec.de>

Add a optional property to change LVDS output voltage. This should not
be static as this depends mainly on the connected display voltage
requirement.

If the property is not present, the default value of 0x05 is used.

Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f996..d6824f6501b6 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -147,6 +147,7 @@ struct sn65dsi83 {
 	struct regulator		*vcc;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	u32				lvds_vcom;
 };
 
 static const struct regmap_range sn65dsi83_readable_ranges[] = {
@@ -435,7 +436,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
 
 	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
-	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
+	regmap_write(ctx->regmap, REG_LVDS_VCOM, ctx->lvds_vcom);
 	regmap_write(ctx->regmap, REG_LVDS_LANE,
 		     (ctx->lvds_dual_link_even_odd_swap ?
 		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
@@ -580,6 +581,13 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
+	struct device_node *endpoint;
+
+	ctx->lvds_vcom = 0x05;
+
+	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
+	of_property_read_u32(endpoint, "ti,lvds-vcom", &ctx->lvds_vcom);
+	of_node_put(endpoint);
 
 	ctx->lvds_dual_link = false;
 	ctx->lvds_dual_link_even_odd_swap = false;
-- 
2.34.1


