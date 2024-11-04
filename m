Return-Path: <linux-kernel+bounces-394155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848689BAB3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CCF1F21E99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B418DF7A;
	Mon,  4 Nov 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liko3ify"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC318BB82;
	Mon,  4 Nov 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690642; cv=none; b=rXLSzZeULXhks1IZjEJ1t58NB1kPJIDGObKBGUmCEmA7v1hiau9+itTbbW7xTAp+EneF1vpsWT1fBPs7+uScNLPF0jvdrZOonGbixljPpcvHFz4eQPP7yCv/+atQR+N2xBdeYORwjqzokcw2iJ0tIrDOKy9VOK0zLVX0WiGgUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690642; c=relaxed/simple;
	bh=KYN8+ISRZKUp7fiOygZATuABVZRdGih7avU/KOGA+l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGVxrxigHWz4UeWqPWWOFS8uY7cyzi0PdJoWV7DyoxUb8QsSJ+Nhwn/Ho1wbAa+y2L+4ZRu2xAlzaireYkcYmerlGNAODmLGxXiBFPiqeHSBluL0kWv3J4WwuwCxyUr6IrONJuWk49qORahcYGXOtNBDKSQjKseaRQoYmqA3eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liko3ify; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690641; x=1762226641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYN8+ISRZKUp7fiOygZATuABVZRdGih7avU/KOGA+l4=;
  b=liko3ifymIMj2qSCAANZ/81VOqa0eGsuCN+e6m8is1rAjL8fwxS9hyTJ
   uzNo7G0btqZYnMCL5uR0EUI+0ZhFberO3OWQ4ZbbgYeLdEql3OnzjmUaJ
   3xq1id6aTSeNa4W738pjMbJw9UxfiwzFWO04+x4n8t20eB4kcR+NZx/CE
   xppa6toOVm7uPQIT5AhwNZUAzzpOMmp5DF02Xzo+bl3axoBnwzthuuNBa
   4r0FoZ2fGDERhtPJqCq6CaGsRSOnzI+4l82wF8lix8tjJ7tj5n7ZY19K5
   zTu/g+A1E33aBdmhKK6hOyH34Ql64m2Y+9wTjCf4HF1dtN1vrtDBJwABi
   A==;
X-CSE-ConnectionGUID: QTfZcXDrT1Kj3iGLZPfqrQ==
X-CSE-MsgGUID: k9izAvX7Q1GOO6bxnTx1Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594293"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
X-CSE-ConnectionGUID: yfOhuYA6SSqZSv0F6XBGGg==
X-CSE-MsgGUID: /30wCCFRRQ+FETz4cHWNQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331815"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 07/12] Soundwire: stream: program BUSCLOCK_SCALE
Date: Mon,  4 Nov 2024 03:23:53 +0000
Message-Id: <20241104032358.669705-8-yung-chuan.liao@linux.intel.com>
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
index b17535324475..ebf4cf9eed9a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1037,6 +1037,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
 
 int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
 void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
+bool is_clock_scaling_supported_by_slave(struct sdw_slave *slave);
 
 #if IS_ENABLED(CONFIG_SOUNDWIRE)
 
-- 
2.34.1


