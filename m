Return-Path: <linux-kernel+bounces-314981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7877196BBE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E55B27770
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA41DC06C;
	Wed,  4 Sep 2024 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dUZPCihh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Co8mFidp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD351DC05B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451574; cv=none; b=oMpMHxJeNDOII29Zn8ATOKjkIGZXk/i2gClAzj/S8cKU2X8SV8GuRTx4ZxOhunpxYg2ak4MgbDHCWN62T1WBpiqNhZpnn6aidwXFyMZRcbDkyW7AOXo4LVPioZdGmkOYy8wymOE8VfI6Hs9pV5sK5YS0qQ6eT+r9rv21zG9wCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451574; c=relaxed/simple;
	bh=FM2Sg61QUKZNSOBLmUYNt05fapgkUNsA5G4V0Khchr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGlHhsydT25M0hwhPnKapqhsnPKalW/KC7zF+iJ6reG6Do3DMdzo8TsUIYAFL0LJuEJHmG3Ah1sinP7aWnnApYgeqKB7krwPkT78h+RPHRnUrQkgVuGEHi2ItrT7Yb4n/N2b8u0XdO8A9fDpR2zk5aPMjdmVMc6gwni80nPccCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dUZPCihh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Co8mFidp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725451572; x=1756987572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZO2+A9qhMx/vtq4ZcJAHouq6Gc/o3MZqjq9U8ynBSU=;
  b=dUZPCihhvre2+veWkMfNVAv4PZ68fOxn77i7njgE1kHGN3Taobh8X5he
   zoBTicmAHjvgYgSPSs5BQJwJv5cY0lgUbh6BCrczneKsHs8Pn3FQdj/+U
   YRJgHlHRvJ8/bc3CooGkKb+zsGG3dzlweaZOko/fw7KNXFIDkrmP8ud2A
   rr31/O/PIdJVA+/YToFXkjaijOi00uYgRHDDrzvq3Wka5ZbIwDLKbjrcu
   7Q3N5dvOzKXpLQK6974fn3SK8222VeSER2W8rJo33bz2hx8YkbfyWvbGc
   Ay11NMYbROPqsDRKdc3anZyLUV3mgapvRxMBr91dXid+UIASK7Oi7IVeJ
   A==;
X-CSE-ConnectionGUID: uAeUHnF4Qv6Yru00un7Cyg==
X-CSE-MsgGUID: yf8i1uEoQleF89+42bAuuQ==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38762455"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 14:06:11 +0200
X-CheckPoint: {66D84D33-28-E520F13A-D17B83D9}
X-MAIL-CPID: 9456EAE7F1187E878E346CA9AC04C97F_2
X-Control-Analysis: str=0001.0A782F1C.66D84D34.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08C7A160024;
	Wed,  4 Sep 2024 14:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725451567; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MZO2+A9qhMx/vtq4ZcJAHouq6Gc/o3MZqjq9U8ynBSU=;
	b=Co8mFidpRANqj5uhUBrIkhmuJPZLlSak0cddvK+MiJWLMxHWQyQh6FzpDf4cv5zRtTEjZE
	GG62A8Q7VyBmHe4xtG6VJgZpQR0xnWFprDnuLBydQwFuxKTcotDrKHcbcn6GI5bBWb45Xh
	QGBySNQNu5McMaCf0c87Rd71eMx4RpBhKp4ESYYLpWKBBcM6HyiOHanGnVprIMoK9OYAy3
	YpYfZDRtvFpL3E7mL4fToUp4OaXUlmLzGBK5K0xN5m8EOLnxnli7v9hXuWKmgkKK4sG16E
	s600d98QnJMmhWmzlnubX+Fr6EF+FkUS/yR/gpSN5LRegaMTGAE5d3WkInJo7g==
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
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/bridge: tc358767: Support write-only registers
Date: Wed,  4 Sep 2024 14:05:45 +0200
Message-Id: <20240904120546.1845856-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
References: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
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
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 1c42c8c6e632e..159c95b26d33c 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2169,19 +2169,31 @@ static const struct regmap_access_table tc_precious_table = {
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
@@ -2191,9 +2203,9 @@ static const struct regmap_config tc_regmap_config = {
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


