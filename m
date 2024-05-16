Return-Path: <linux-kernel+bounces-180673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15A8C719F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAB1C20AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEAF2D781;
	Thu, 16 May 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OvVRu5Be";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GzR3r79t"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBD250EC
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840719; cv=none; b=VZ/silFUjlTpJpXrgQeuiDqadLAQK6ZSNnBS28ZmLz8WSNTzeSBp/O7zUy7OZxll3zszie/47JJRtY7sfvOPXlgQr+LXvnnKhwtoMKeB8HNgZ0mTF/ukCzhridYck4GWYEHgb1IdoAGQ8noWbdFWwQgp8tZbAg7qJC3YHuvFGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840719; c=relaxed/simple;
	bh=cr2u80cvM29z+pFP8mTV5WAvPIk+8alCYrHT5NDOLII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9PtvaDIRJo4NZHMCFgfVMs/NunOjy/jm0gKIGgLDzacPehSycGsYp42gin5PBF45/FYhG412bhLpcHN1Zt+9NAjVhvfT42GR6ZmHUrroHXDlq7JQilUbQ2plWgZmOdMZYZ5cUDl5Ciqy1ili4hpJJr45BDKzedMckey6d3C1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OvVRu5Be; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GzR3r79t reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715840716; x=1747376716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pjwDRb2G8zbxPaNc+6tKezQ18Sz0q1wOIQZhKqVMLVI=;
  b=OvVRu5BebKHRHR+BtHfXcFHqHYcMldAqGx3xh3ZB+6RX5QtpSzD1ExzL
   6OrVUN4Z04654b6H/dUolXaiBRnFdr5Yhkk5J9m2knKXVFVzA7eik0078
   xku89WTm3nwGTlxdWYoM6JWXX7Pcs4sw0y1jO4J+yOXwM+PrBP8Fqsek1
   O72G0Pl6Qyx/qVccNho8gB4Bo7GVM1JuDO176HYE1r30qlRDyU2BqO5me
   yZS6ZFYdZ0M+UmsAjk4CUVu260K+w/dx1Rq03fBKouYsJbRLDeY2qZxLy
   oR3ENDM9uOBU3cfVT/VRYWvwUOjC1MuMf1vX0CD8+eXtt8HqFaTvtuksb
   g==;
X-CSE-ConnectionGUID: 8Zh0bOBDSNqc60l5W+vPSw==
X-CSE-MsgGUID: HmPVmQodSIaBzFT1MtwTfQ==
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; 
   d="scan'208";a="36926967"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 08:25:15 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54669172BB1;
	Thu, 16 May 2024 08:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715840711; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pjwDRb2G8zbxPaNc+6tKezQ18Sz0q1wOIQZhKqVMLVI=;
	b=GzR3r79t9O7j1ByvAwCMbL1xieMpA+SDimX0ooFuOfNOlHs937Tc8x+Q7yT2Pr3gp6LEKi
	+RUePh2UyGihMp6CnJ5swrw8lTGV7bBZthQoCqXgMVGltCqUwtZAtONSkzsG6c+ByRpl9J
	XGrAPhVVMDbuqLpBf5hxrEgyCNgZfq9D1YDFvGw+JrEyfbGwNOn2UrYMSPb2k5ZvVV2LGT
	/pfwh5UKBCNwm9AOWoiniV6B20tc4QPQPCEjk0I7I51/eTgMq21/nztZa90PQExrHW2O4H
	NaIXL3cB3MB0WkdrMUqyVlcSYtOjOmTW2+ToDngyY7jn7jFvtvYzBptzlge+hA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/bridge: tc358767: Support write-only registers
Date: Thu, 16 May 2024 08:24:55 +0200
Message-Id: <20240516062455.106266-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
References: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Most registers are read-writable, but some are only RO or even WO.
regmap does not support using readable_reg and wr_table when outputting
in debugfs, so switch to writeable_reg.
First check for RO or WO registers and fallback tc_readable_reg() for the
leftover RW registers.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 8874713bdd4a4..04c98ab1991bd 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2086,19 +2086,31 @@ static const struct regmap_access_table tc_precious_table = {
 	.n_yes_ranges = ARRAY_SIZE(tc_precious_ranges),
 };
 
-static const struct regmap_range tc_non_writeable_ranges[] = {
-	regmap_reg_range(PPI_BUSYPPI, PPI_BUSYPPI),
-	regmap_reg_range(DSI_BUSYDSI, DSI_BUSYDSI),
-	regmap_reg_range(DSI_LANESTATUS0, DSI_INTSTATUS),
-	regmap_reg_range(TC_IDREG, SYSSTAT),
-	regmap_reg_range(GPIOI, GPIOI),
-	regmap_reg_range(DP0_LTSTAT, DP0_SNKLTCHGREQ),
-};
-
-static const struct regmap_access_table tc_writeable_table = {
-	.no_ranges = tc_non_writeable_ranges,
-	.n_no_ranges = ARRAY_SIZE(tc_non_writeable_ranges),
-};
+static bool tc_writeable_reg(struct device *dev, unsigned int reg)
+{
+	/* RO reg */
+	switch (reg) {
+	case PPI_BUSYPPI:
+	case DSI_BUSYDSI:
+	case DSI_LANESTATUS0:
+	case DSI_LANESTATUS1:
+	case DSI_INTSTATUS:
+	case TC_IDREG:
+	case SYSBOOT:
+	case SYSSTAT:
+	case GPIOI:
+	case DP0_LTSTAT:
+	case DP0_SNKLTCHGREQ:
+		return false;
+	}
+	/* WO reg */
+	switch (reg) {
+	case DSI_STARTDSI:
+	case DSI_INTCLR:
+		return true;
+	}
+	return tc_readable_reg(dev, reg);
+}
 
 static const struct regmap_config tc_regmap_config = {
 	.name = "tc358767",
@@ -2108,9 +2120,9 @@ static const struct regmap_config tc_regmap_config = {
 	.max_register = PLL_DBG,
 	.cache_type = REGCACHE_MAPLE,
 	.readable_reg = tc_readable_reg,
+	.writeable_reg = tc_writeable_reg,
 	.volatile_table = &tc_volatile_table,
 	.precious_table = &tc_precious_table,
-	.wr_table = &tc_writeable_table,
 	.reg_format_endian = REGMAP_ENDIAN_BIG,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
-- 
2.34.1


