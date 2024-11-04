Return-Path: <linux-kernel+bounces-394152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA99BAB36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955E8281A9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588818C003;
	Mon,  4 Nov 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUkVeAnn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EA29CE5;
	Mon,  4 Nov 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690641; cv=none; b=fLzC2InjOpZWh4TUn7az6MLwEGXvvsmTZkeg8AWujeIqLtZ9PYt5RDjObgG/dSvS+UER1BqGokLdPZo0iSrTJn6kOpAc43XKex2y2f2QMr8hgRr9rviQ7IV12J26sv2MphcIB0LDlYp/RziGJlc0BpHVQ2JbTE2n8xjkatfEuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690641; c=relaxed/simple;
	bh=0FrkvqKeU0PHY1PTNDNEo+aFOyQkOKCYiJDlCKblxCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPnwz/6S7zD6G43kW2A6ECWtiEsZnXwFhEQnU0xsrcHGqGloG3YDP2Z1EwNDdkyAg75OWdktLCze3Eu9jFK2v7Qkcbu2FQ27MdbKGzHa5J4xD+bzTQj21f1kvGi8YUYEGCy3iokSciuEqxpI8ii+WLmmaWwGuvcwNy0v9g5EjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUkVeAnn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690639; x=1762226639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0FrkvqKeU0PHY1PTNDNEo+aFOyQkOKCYiJDlCKblxCA=;
  b=nUkVeAnnalL8EqhK/NmnOvp/+t+HDVGq3p3N95MhkDxYu+nTLFEtodj/
   klsZ6Vw7DyivN/ersAY9LMql03WSmJbiLuW4aEArzc6rj3kHQUukjH2d2
   BGBQ4dABW9mI2yDWWD4p8ttjV8ZPTLh3KtxhSLHI4csUgSV8elvAGGnJn
   qCMWnL+l+zKuXlFn1Qq7wQhfVC2d/Tul5gHY6ZxuJjtJlrxLWuE4HVXsY
   7w0V2ikomBQsJ6LEq4Y3ZspAuunOXv+8iasd/5U/n+EvVTY5X+PYmf9h6
   1LK0aBT+OjQ448oL/JBZy9b3bn9w4Xujo55Siejdz+n5HVjt6lP7uqs6M
   g==;
X-CSE-ConnectionGUID: LvSmQ3iXTEWL3+VT1aHcVg==
X-CSE-MsgGUID: na/WsCGHRzehCU40V5T4LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594289"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
X-CSE-ConnectionGUID: H4hH5V2kTrCkwPNVHa5J4A==
X-CSE-MsgGUID: jU5j4HhOTt2JfAeQ5aEOzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331812"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 06/12] Soundwire: add sdw_slave_get_scale_index helper
Date: Mon,  4 Nov 2024 03:23:52 +0000
Message-Id: <20241104032358.669705-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
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
index e059d5330b11..b17535324475 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1048,6 +1048,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 			    struct sdw_stream_runtime *stream);
 
+int sdw_slave_get_scale_index(struct sdw_slave *slave, u8 *base);
+
 /* messaging and data APIs */
 int sdw_read(struct sdw_slave *slave, u32 addr);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
-- 
2.34.1


