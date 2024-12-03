Return-Path: <linux-kernel+bounces-429525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151D9E1D66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4AA165242
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E21F473C;
	Tue,  3 Dec 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiJinrh4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FD1EF08F;
	Tue,  3 Dec 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231919; cv=none; b=c5oWryv4V89BCZV0C8XAK26Y8pe+OImbfWSqcx615ndvcvYLUXuM3IzY9uLTV84lSri+XDdwRPYw1Kyvmy5OzPeYc7gU5m6UjIVrpOdzTx4S1APUtANrOkbYVfFWQ2MLgB01lWZMDDgp+JUJh2pQSAuBQlhAH7BvV3yrctn+oTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231919; c=relaxed/simple;
	bh=fYfNMeMSga/5R1bo7mTW9errUnZ+UozHTmrrkJSXbtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYkXktFBGaJJvjgj6FE0z//d/ouM+nm0slvOMdWRK0tnBc7uOmZj1244xTmFSYBuZxz7O1FCZ4WjayWkC9VdztuMHkVGP1Wg0sDxElBqGSWgJBnfWONPXslMHUy6Kph88ILvGzxxhXZSmyyJKnSof6oB72S8NhPLlcysV+0gf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiJinrh4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231917; x=1764767917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYfNMeMSga/5R1bo7mTW9errUnZ+UozHTmrrkJSXbtc=;
  b=fiJinrh4p5sK0wBsvvZZDiPnVL/KwHXX+9rDLYwGusTJSxx7FsZTzXr0
   tuW6Y9J2c/CKmS29Ap4FHnjLPjLd/V+2PtiwwBbEpd6VmDtaRB+nvOX6G
   tzcXcWFpHTdBQobz44YjUrtmp9dhkKRV5fwS3ROlqOlDGUoZRjS587eWk
   Sq29AvOmA1pKZHBc2Rnix4o34ukYniDF/aWUKoBCXfcdO/u/+sPlPAOU2
   auCQZ4E6xro/Z8Ih4EowSvONu47qlqCuOYiEbRSWwDuP6h9HA83oBbw2E
   V7X0+9uy1tFjBnj9Xm5+NKWFbcFM0sAQl4n1VisnOKO1XQ0lN73RXQaBa
   Q==;
X-CSE-ConnectionGUID: psfOld9lRYS8LTqsHkREtQ==
X-CSE-MsgGUID: 4zDfSregQp2bnC4PgUOpQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500742"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:37 -0800
X-CSE-ConnectionGUID: Hrx5IfxwRPuLILfhMBL33A==
X-CSE-MsgGUID: aKw756hySWuYXQ9O9hxDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896094"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:36 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 06/14] Soundwire: add sdw_slave_get_scale_index helper
Date: Tue,  3 Dec 2024 21:18:05 +0800
Message-ID: <20241203131813.58454-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only set peripheral frequency when the peripheral is
initialized. However, curr_dr_freq may change to get required bandwidth.
For example, curr_dr_freq may increase from 4.8MHz to 9.6MHz when the
4th stream is opened. Add a helper to get the scale index so that we can
get the scale index and program it.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/bus.c       | 55 ++++++++++++++++++++++-------------
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d1dc62c34f1c..215630d602ad 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1276,23 +1276,12 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 	return ret;
 }
 
-static int sdw_slave_set_frequency(struct sdw_slave *slave)
+int sdw_slave_get_scale_index(struct sdw_slave *slave, u8 *base)
 {
 	u32 mclk_freq = slave->bus->prop.mclk_freq;
 	u32 curr_freq = slave->bus->params.curr_dr_freq >> 1;
 	unsigned int scale;
 	u8 scale_index;
-	u8 base;
-	int ret;
-
-	/*
-	 * frequency base and scale registers are required for SDCA
-	 * devices. They may also be used for 1.2+/non-SDCA devices.
-	 * Driver can set the property, we will need a DisCo property
-	 * to discover this case from platform firmware.
-	 */
-	if (!slave->id.class_id && !slave->prop.clock_reg_supported)
-		return 0;
 
 	if (!mclk_freq) {
 		dev_err(&slave->dev,
@@ -1311,19 +1300,19 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 	 */
 	if (!(19200000 % mclk_freq)) {
 		mclk_freq = 19200000;
-		base = SDW_SCP_BASE_CLOCK_19200000_HZ;
+		*base = SDW_SCP_BASE_CLOCK_19200000_HZ;
 	} else if (!(22579200 % mclk_freq)) {
 		mclk_freq = 22579200;
-		base = SDW_SCP_BASE_CLOCK_22579200_HZ;
+		*base = SDW_SCP_BASE_CLOCK_22579200_HZ;
 	} else if (!(24576000 % mclk_freq)) {
 		mclk_freq = 24576000;
-		base = SDW_SCP_BASE_CLOCK_24576000_HZ;
+		*base = SDW_SCP_BASE_CLOCK_24576000_HZ;
 	} else if (!(32000000 % mclk_freq)) {
 		mclk_freq = 32000000;
-		base = SDW_SCP_BASE_CLOCK_32000000_HZ;
+		*base = SDW_SCP_BASE_CLOCK_32000000_HZ;
 	} else if (!(96000000 % mclk_freq)) {
 		mclk_freq = 24000000;
-		base = SDW_SCP_BASE_CLOCK_24000000_HZ;
+		*base = SDW_SCP_BASE_CLOCK_24000000_HZ;
 	} else {
 		dev_err(&slave->dev,
 			"Unsupported clock base, mclk %d\n",
@@ -1354,6 +1343,34 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 	}
 	scale_index++;
 
+	dev_dbg(&slave->dev,
+		"Configured bus base %d, scale %d, mclk %d, curr_freq %d\n",
+		*base, scale_index, mclk_freq, curr_freq);
+
+	return scale_index;
+}
+EXPORT_SYMBOL(sdw_slave_get_scale_index);
+
+static int sdw_slave_set_frequency(struct sdw_slave *slave)
+{
+	int scale_index;
+	u8 base;
+	int ret;
+
+	/*
+	 * frequency base and scale registers are required for SDCA
+	 * devices. They may also be used for 1.2+/non-SDCA devices.
+	 * Driver can set the property directly, for now there's no
+	 * DisCo property to discover support for the scaling registers
+	 * from platform firmware.
+	 */
+	if (!slave->id.class_id && !slave->prop.clock_reg_supported)
+		return 0;
+
+	scale_index = sdw_slave_get_scale_index(slave, &base);
+	if (scale_index < 0)
+		return scale_index;
+
 	ret = sdw_write_no_pm(slave, SDW_SCP_BUS_CLOCK_BASE, base);
 	if (ret < 0) {
 		dev_err(&slave->dev,
@@ -1373,10 +1390,6 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 		dev_err(&slave->dev,
 			"SDW_SCP_BUSCLOCK_SCALE_B1 write failed:%d\n", ret);
 
-	dev_dbg(&slave->dev,
-		"Configured bus base %d, scale %d, mclk %d, curr_freq %d\n",
-		base, scale_index, mclk_freq, curr_freq);
-
 	return ret;
 }
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ae38ac848d38..05a85e2bd96d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1052,6 +1052,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 			    struct sdw_stream_runtime *stream);
 
+int sdw_slave_get_scale_index(struct sdw_slave *slave, u8 *base);
+
 /* messaging and data APIs */
 int sdw_read(struct sdw_slave *slave, u32 addr);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
-- 
2.43.0


