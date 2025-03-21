Return-Path: <linux-kernel+bounces-571865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2724A6C357
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D241890A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3522E3E1;
	Fri, 21 Mar 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnQZNnFm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B818FC75
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585451; cv=none; b=QYz9nlep5YZx3NGPz4uFuoChb3/iThBZG9qZNX3grLLRLwBP/ozUiuS8QnhB6faOZuNMo+8tC9jCgnYWHDSlLsZU9PeRDpFy3BFMmTjxunt/GeuofsK27qyhE+8x/49kx8zDit0q7L1SIZP4ft9Dfh1EcMlKMvKHe/GpNb3ewE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585451; c=relaxed/simple;
	bh=E+DhP9Ym5+nIfAnV1TufHdck737gGEL1ECgnaI4jSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWD0D4/duh6aYBrzIP374QPPo72R/vphiD+D1hby6123bdlYk62fgwTGQ5VAo8CRDxGo3nNGuEhrt3xm0tRpNadxyKhaXTsYtJqXy6ZeL0vFELvtSAqmahS5qcy5gLuRiCYBCdZuaC6CQVY6htMFXE3Xwkr/pMrqzxGiUMGCnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnQZNnFm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742585450; x=1774121450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+DhP9Ym5+nIfAnV1TufHdck737gGEL1ECgnaI4jSTE=;
  b=MnQZNnFmCGQzP1EoDrGskDMpLrNgkOdlZUrZMf46is8YR1lAQjlb+q9W
   yXmvCqctgs7+MYk8/SmZrT85bacXcaYel1ZbMaSxQao47AA+rW1aPXNVQ
   4aEETP1IofH6vRT9Kgkqcfi6+/sVIMZozecmZGbO0HI0fHT1AgdzS/bPS
   kap8qkOb/SfbqEBOUiKBFtOaCX4gjdrWYLNo2aQDG4msZbCoEw45WYY9V
   RkcVBpWDxNxtZ0K/i3VioZ+31wPL20js1D/eYrkoaTHsvVKF3h0lUrmMn
   TzQwk+ebhWBGXbAlo9Goj3zVj/6pW7z0TCau4xVx7eQnKXhTlxa+VtF+9
   w==;
X-CSE-ConnectionGUID: 7ghAh+32SR2lccMBXLa6JA==
X-CSE-MsgGUID: 6RllDrcRQSqGKzS3zelQkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43746516"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43746516"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:30:49 -0700
X-CSE-ConnectionGUID: BaSjNI3JSnyLE94B/nMkSA==
X-CSE-MsgGUID: YZQLM8Q2SqOCiitmsyYiTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="127631808"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Mar 2025 12:30:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3C2BC14B; Fri, 21 Mar 2025 21:30:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] i3c: master: Drop duplicate check before calling OF APIs
Date: Fri, 21 Mar 2025 21:30:06 +0200
Message-ID: <20250321193044.457649-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OF APIs are usually NULL-aware and returns an error in case when
device node is not present or supported. We already have a check
for the returned value, no need to check for the parameter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: added missed updates (hit 'send' too early in v1)

 drivers/i3c/master.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d5dc4180afbc..fd26c4bb8b34 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2276,7 +2276,7 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
 	u32 reg[3];
 	int ret;
 
-	if (!master || !node)
+	if (!master)
 		return -EINVAL;
 
 	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
@@ -2369,14 +2369,10 @@ static u8 i3c_master_i2c_get_lvr(struct i2c_client *client)
 {
 	/* Fall back to no spike filters and FM bus mode. */
 	u8 lvr = I3C_LVR_I2C_INDEX(2) | I3C_LVR_I2C_FM_MODE;
+	u32 reg[3];
 
-	if (client->dev.of_node) {
-		u32 reg[3];
-
-		if (!of_property_read_u32_array(client->dev.of_node, "reg",
-						reg, ARRAY_SIZE(reg)))
-			lvr = reg[2];
-	}
+	if (!of_property_read_u32_array(client->dev.of_node, "reg", reg, ARRAY_SIZE(reg)))
+		lvr = reg[2];
 
 	return lvr;
 }
@@ -2486,7 +2482,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
 	struct i2c_dev_desc *i2cdev;
 	struct i2c_dev_boardinfo *i2cboardinfo;
-	int ret, id = -ENODEV;
+	int ret, id;
 
 	adap->dev.parent = master->dev.parent;
 	adap->owner = master->dev.parent->driver->owner;
@@ -2497,9 +2493,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->timeout = 1000;
 	adap->retries = 3;
 
-	if (master->dev.of_node)
-		id = of_alias_get_id(master->dev.of_node, "i2c");
-
+	id = of_alias_get_id(master->dev.of_node, "i2c");
 	if (id >= 0) {
 		adap->nr = id;
 		ret = i2c_add_numbered_adapter(adap);
-- 
2.47.2


