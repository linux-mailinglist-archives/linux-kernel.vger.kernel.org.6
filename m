Return-Path: <linux-kernel+bounces-429527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD179E1D67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55E3283FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3E1F6684;
	Tue,  3 Dec 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2lCq84x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898051F473B;
	Tue,  3 Dec 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231921; cv=none; b=sTmAH5B+7MOS5xBEeZc0qbzzMp4eQ0gd5uhbe4O5+LXwtks3z+oeMGcF8hHvgtVrkncJz6F9sLz/hKetz/Q1/ksSDq2t8oy+5sAG1/Aechd5r1zKSg9GPozUYzxkmSutgdyxCm6kBs0RZECVjKfyq2v54+OHyDlk1FT9XJeYXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231921; c=relaxed/simple;
	bh=xyLayPC8ouR6SZFaJI2R04VDoa3Jzyg2QvEs0O5LSm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS8CmFSPQ99VztbX2mQwPhlus/dnZgXheVDgvyE5gyM9K5ZX7zU/ImMGatIEbp4ojklwTMXNiMaFKW2cokHaVwErb9kiDTb9BL45HBJfoARRDr75qblq5aZg92RKCNTupjSE2IiDhJ9lY3qlOMF8TcOpF3yI3XWiNwxH+EpWSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2lCq84x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231919; x=1764767919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyLayPC8ouR6SZFaJI2R04VDoa3Jzyg2QvEs0O5LSm4=;
  b=i2lCq84xkrddqpCrLEZwrWtG79uiilVwPo5JwYT5jnlDOqgtKuW8MiFN
   JJB0NjNUTPF857sy/clIRAaWQ+YbvbLH2PRtjrfUF1cOTBGV/j63ix0a1
   fmFBaO5W3Rw917ON5/TWb+ogGLSKZ6+8DA3sgIqo5ZWIquHX/o74/o5Vr
   N4KUVRAwEl+o6Z31f1QfJl/hyrmeye2zNpGmHpRaJsXMxvQR0VyQs9rvr
   w0fKt3XJB4l4FW+FsdLdztcfTVKLw8bK47wENWxjK82m9T/aYKkGi0hhH
   Ma3Hg0WVGKYf5DmW+OmZXu+0GjJPgKluYsL9irfUgBE8sQrPwW5xHS2A2
   g==;
X-CSE-ConnectionGUID: y1YIvYGaSra59uH8FWvJ8Q==
X-CSE-MsgGUID: WFRiKcfDTNmsyUtowvycog==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500747"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500747"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:39 -0800
X-CSE-ConnectionGUID: 5OE0PTAqQhiHdGO7fOPmIA==
X-CSE-MsgGUID: MMKjeOBoSlqLL8hUNr+BYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896103"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:37 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 07/14] Soundwire: stream: program BUSCLOCK_SCALE
Date: Tue,  3 Dec 2024 21:18:06 +0800
Message-ID: <20241203131813.58454-8-yung-chuan.liao@linux.intel.com>
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

We need to program bus clock scale to adjust the bus clock if current
bus clock doesn't fit the bandwidth.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/bus.c       | 10 ++++++++++
 drivers/soundwire/stream.c    | 32 ++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 215630d602ad..9b295fc9acd5 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -813,6 +813,16 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 }
 EXPORT_SYMBOL(sdw_extract_slave_id);
 
+bool is_clock_scaling_supported_by_slave(struct sdw_slave *slave)
+{
+	/*
+	 * Dynamic scaling is a defined by SDCA. However, some devices expose the class ID but
+	 * can't support dynamic scaling. We might need a quirk to handle such devices.
+	 */
+	return slave->id.class_id;
+}
+EXPORT_SYMBOL(is_clock_scaling_supported_by_slave);
+
 static int sdw_program_device_num(struct sdw_bus *bus, bool *programmed)
 {
 	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 795017c8081a..a4a668135d16 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -629,8 +629,40 @@ static int sdw_notify_config(struct sdw_master_runtime *m_rt)
 static int sdw_program_params(struct sdw_bus *bus, bool prepare)
 {
 	struct sdw_master_runtime *m_rt;
+	struct sdw_slave *slave;
 	int ret = 0;
+	u32 addr1;
 
+	/* Check if all Peripherals comply with SDCA */
+	list_for_each_entry(slave, &bus->slaves, node) {
+		if (!is_clock_scaling_supported_by_slave(slave)) {
+			dev_dbg(&slave->dev, "The Peripheral doesn't comply with SDCA\n");
+			goto manager_runtime;
+		}
+	}
+
+	if (bus->params.next_bank)
+		addr1 = SDW_SCP_BUSCLOCK_SCALE_B1;
+	else
+		addr1 = SDW_SCP_BUSCLOCK_SCALE_B0;
+
+	/* Program SDW_SCP_BUSCLOCK_SCALE if all Peripherals comply with SDCA */
+	list_for_each_entry(slave, &bus->slaves, node) {
+		int scale_index;
+		u8 base;
+
+		scale_index = sdw_slave_get_scale_index(slave, &base);
+		if (scale_index < 0)
+			return scale_index;
+
+		ret = sdw_write_no_pm(slave, addr1, scale_index);
+		if (ret < 0) {
+			dev_err(&slave->dev, "SDW_SCP_BUSCLOCK_SCALE register write failed\n");
+			return ret;
+		}
+	}
+
+manager_runtime:
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
 
 		/*
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 05a85e2bd96d..fc0a203c3ae0 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1041,6 +1041,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
 
 int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
 void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
+bool is_clock_scaling_supported_by_slave(struct sdw_slave *slave);
 
 #if IS_ENABLED(CONFIG_SOUNDWIRE)
 
-- 
2.43.0


