Return-Path: <linux-kernel+bounces-303386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEC960B66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30779B2462F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2071BF7EE;
	Tue, 27 Aug 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHw4T1nu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE11C578C;
	Tue, 27 Aug 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764108; cv=none; b=FPL2op9S3W6LSeBAah/j8PRJKVsMG5ctwlia3Ptrk3qPkeblVHNe9PXrEBtRaxngw5jA/txjPD3fx5F3CN0dx0hEcpbGd5hSTfdndO1C9fcooBa9uhUmx78XYsHdbsfFHpypr/drC8J7tTw1EHUre/gh84N+iP1BoeeTouZje1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764108; c=relaxed/simple;
	bh=/xD0tp45bfndSFRzJw+Cewf5R47ETFfE+YhTpNmbtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFYxTmlxU3fZlx4QUU0A7KyArZCzwS2/ZTAZNOotvY6HCZWnmPC7r0GLPZ/Vg+JIzczmNN6de4sEG8E6rt9XPVkA/CAvkD7NDyrboIaP9GW5w7RwaExE9tKYkSJQK2QAUqxMgbWmHJjdYzWAkTMkZro+UEiEiRRe8TcCLKK9nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHw4T1nu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764107; x=1756300107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xD0tp45bfndSFRzJw+Cewf5R47ETFfE+YhTpNmbtLg=;
  b=cHw4T1nulMEy5Sk8rPfUCoh0fFQvesSNg04n7QTjcwSFE6jxszJUsOTe
   Xfyl5/qw4rJRWYN0BJvGGqijmQOcuwNQcslm7iXeNfQwHIzP1jxrASY4O
   s7L7Md+4LRWYF3DozNEwngGJTQDOOXPHNssWLAan0KirLXyiA7nyHRXC+
   Fp4qbgmjEdrZSDzAXkft/ueuAIKypTD7fkEI7JWQEBjGDnTsmJrEN5Xpu
   dz8q8an+JhKtDlVoqWy40lqFAHR+ZXxInXqg8QJT/3078NFHBPP51d92i
   UEHBfIdKmW61MJgiu+2qnuZaYaVoDIniBmjK/Ks0gvjWspkohX4tm8qhB
   Q==;
X-CSE-ConnectionGUID: /h7q72l8TxCFxMkFBAQWOg==
X-CSE-MsgGUID: UBxq13IDToyG+ZkCnqpEUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400655"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400655"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:26 -0700
X-CSE-ConnectionGUID: xTQ/a/UESPe/EWBnbiHTxg==
X-CSE-MsgGUID: GEOjlBkKQPab+kxudQDsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552163"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:25 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 13/14] soundwire: mipi-disco: add new properties from 2.0 spec
Date: Tue, 27 Aug 2024 21:07:06 +0800
Message-ID: <20240827130707.298477-14-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The DisCo for SoundWire 2.0 spec adds support for new
'mipi-sdw-sdca-interrupt-register-list' and
'mipi-sdw-commit-register-supported'.

This patch only adds the definitions and property reads, but the use
of these properties will come at some point in the future when needed.

Note a slight conceptual disconnect between the MIPI DisCo definition
of a boolean property and the Linux implementation. The latter only
checks the presence of the property to set its value to 'true',
whereas the MIPI definitions allow for a property with a 'false'
value. This patch relies on a read_u8() even if the DisCo property is
defined as boolean.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 13 +++++++++++++
 include/linux/soundwire/sdw.h  |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index d6eb63bf1252..2215c53f95de 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -398,6 +398,19 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
 				 &prop->sink_ports);
 
+	device_property_read_u32(dev, "mipi-sdw-sdca-interrupt-register-list",
+				 &prop->sdca_interrupt_register_list);
+
+	/*
+	 * The specification defines the property value as boolean, but
+	 * the value can be defined as zero. This is not aligned the
+	 * implementation of device_property_read_bool() which only checks
+	 * the presence of the property.
+	 * Let's use read_u8 to work-around this conceptual disconnect.
+	 */
+	device_property_read_u8(dev, "mipi-sdw-commit-register-supported",
+				&prop->commit_register_supported);
+
 	/*
 	 * Read dp0 properties - we don't rely on the 'mipi-sdw-dp-0-supported'
 	 * property since the 'mipi-sdw-dp0-subproperties' property is logically
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 66feaa79ecfc..952514f044f0 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -335,8 +335,11 @@ struct sdw_dpn_prop {
  * @master_count: Number of Masters present on this Slave
  * @source_ports: Bitmap identifying source ports
  * @sink_ports: Bitmap identifying sink ports
- * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
+ * @sdca_interrupt_register_list: indicates which sets of SDCA interrupt status
+ * and masks are supported
+ * @commit_register_supported: is PCP_Commit register supported
+ * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @clock_reg_supported: the Peripheral implements the clock base and scale
  * registers introduced with the SoundWire 1.2 specification. SDCA devices
  * do not need to set this boolean property as the registers are required.
@@ -363,6 +366,8 @@ struct sdw_slave_prop {
 	u32 source_ports;
 	u32 sink_ports;
 	u32 quirks;
+	u32 sdca_interrupt_register_list;
+	u8 commit_register_supported;
 	u8 scp_int1_mask;
 	bool clock_reg_supported;
 	bool use_domain_irq;
-- 
2.43.0


