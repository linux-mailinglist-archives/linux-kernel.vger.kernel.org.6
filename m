Return-Path: <linux-kernel+bounces-274601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC4947A94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A37A1F2171E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317E155CB2;
	Mon,  5 Aug 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMuCiKOe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6C6A01E;
	Mon,  5 Aug 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858575; cv=none; b=oisOJJYjBAMYRY/Aivl9s6sI4gMBrYMrhnMTnPmZ+2SvL16QOMUqZZE+v+OCvFSOrWzP4cUzz3g11OJ6qFnsZtx2Dljs3c3EcDlc1BaZxrQPMyFLejqXnH1CdZ0uIRCdfmiK5C9QS+dGq3xU3eHkxyPZtVaFGna+K9nWCDdYpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858575; c=relaxed/simple;
	bh=rFC86BQt2fPeW0GVsgV01QHBlJdjM9Z76+MVFGxxXbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7JY7iZtkZRDs5kaVINL6usSN+B4YNsco+vYBUOcEM2oEmSBYyBesuM/rV27dzFQf72GqFoiYlJg2cC65n+4xxXJeOz6MvJSL4+S5IIc/vatLb1GO3EitozQQkzjxOqR8qJGBcawRhlVanBGl0g2kx+qMzuPxWnP1cAXrKjcK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMuCiKOe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722858574; x=1754394574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rFC86BQt2fPeW0GVsgV01QHBlJdjM9Z76+MVFGxxXbA=;
  b=AMuCiKOevdgilB1eRbo4Wciq7YvZu8rB8IK64uFJubwLN0/JBjnsGMte
   Oot6EiZ/hQYvi2MrWpVDDxh4KtvCJ4Lll/IGXCbGaOlAU08pzPsA/nf5D
   ovhcv92TYLmk4y9trkKakgSl7D5dHdob2vOm1NtWfzOsW8gP5Q2xU0MpR
   cpggbgc2hkvs1xqYEpMz6sx3tDqhI54mFuT9YI7cC+lxX5pf5/94JR70u
   8G1qpV+XWTScW5UO0VX25UQQwutu/eqxImlYodmmt0Nqy9fSOeyBdTSg/
   XVkDlL6Q/8hf7vGPQSMUq2H9evX8hkHL6FMgQnF30jYgzAUmhMB2urSF3
   Q==;
X-CSE-ConnectionGUID: NC1Hul8xR1a6m56jX6fqWQ==
X-CSE-MsgGUID: XLodrOPNR22jkNLCwRFeAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20993671"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20993671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 04:49:33 -0700
X-CSE-ConnectionGUID: unTce+y+SB2UHc7K7RwBzg==
X-CSE-MsgGUID: KFbkZIhESnih2nuGx0I1fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="79418027"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.12])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 04:49:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: re-check Peripheral status with delayed_work
Date: Mon,  5 Aug 2024 19:49:21 +0800
Message-ID: <20240805114921.88007-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire peripheral enumeration is entirely based on interrupts,
more specifically sticky bits tracking state changes.

This patch adds a defensive programming check on the actual status
reported in PING frames. If for some reason an interrupt was lost or
delayed, the delayed work would detect a peripheral change of status
after the bus starts.

The 100ms defined for the delay is not completely arbitrary, if a
Peripheral didn't join the bus within that delay then probably the
hardware link is broken, and conversely if the detection didn't happen
because of software issues the 100ms is still acceptable in terms of
user experience.

The overhead of the one-shot workqueue is minimal, and the mutual
exclusion ensures that the interrupt and delayed work cannot update
the status concurrently.

Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c   | 39 ++++++++++++++++++++++++++--
 drivers/soundwire/cadence_master.h   |  5 ++++
 drivers/soundwire/intel.h            |  2 ++
 drivers/soundwire/intel_auxdevice.c  |  1 +
 drivers/soundwire/intel_bus_common.c | 11 ++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e0683a5975d1..05652e983539 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -890,8 +890,14 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		}
 	}
 
-	if (is_slave)
-		return sdw_handle_slave_status(&cdns->bus, status);
+	if (is_slave) {
+		int ret;
+
+		mutex_lock(&cdns->status_update_lock);
+		ret = sdw_handle_slave_status(&cdns->bus, status);
+		mutex_unlock(&cdns->status_update_lock);
+		return ret;
+	}
 
 	return 0;
 }
@@ -988,6 +994,31 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 }
 EXPORT_SYMBOL(sdw_cdns_irq);
 
+static void cdns_check_attached_status_dwork(struct work_struct *work)
+{
+	struct sdw_cdns *cdns =
+		container_of(work, struct sdw_cdns, attach_dwork.work);
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
+	u32 val;
+	int ret;
+	int i;
+
+	val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+
+	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
+		status[i] = val & 0x3;
+		if (status[i])
+			dev_dbg(cdns->dev, "Peripheral %d status: %d\n", i, status[i]);
+		val >>= 2;
+	}
+
+	mutex_lock(&cdns->status_update_lock);
+	ret = sdw_handle_slave_status(&cdns->bus, status);
+	mutex_unlock(&cdns->status_update_lock);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: sdw_handle_slave_status failed: %d\n", __func__, ret);
+}
+
 /**
  * cdns_update_slave_status_work - update slave status in a work since we will need to handle
  * other interrupts eg. CDNS_MCP_INT_RX_WL during the update slave
@@ -1740,7 +1771,11 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 	init_completion(&cdns->tx_complete);
 	cdns->bus.port_ops = &cdns_port_ops;
 
+	mutex_init(&cdns->status_update_lock);
+
 	INIT_WORK(&cdns->work, cdns_update_slave_status_work);
+	INIT_DELAYED_WORK(&cdns->attach_dwork, cdns_check_attached_status_dwork);
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_probe);
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index bc84435e420f..e1d7969ba48a 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -117,6 +117,8 @@ struct sdw_cdns_dai_runtime {
  * @link_up: Link status
  * @msg_count: Messages sent on bus
  * @dai_runtime_array: runtime context for each allocated DAI.
+ * @status_update_lock: protect concurrency between interrupt-based and delayed work
+ * status update
  */
 struct sdw_cdns {
 	struct device *dev;
@@ -148,10 +150,13 @@ struct sdw_cdns {
 	bool interrupt_enabled;
 
 	struct work_struct work;
+	struct delayed_work attach_dwork;
 
 	struct list_head list;
 
 	struct sdw_cdns_dai_runtime **dai_runtime_array;
+
+	struct mutex status_update_lock; /* add mutual exclusion to sdw_handle_slave_status() */
 };
 
 #define bus_to_cdns(_bus) container_of(_bus, struct sdw_cdns, bus)
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 68838e843b54..f4235f5991c3 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -103,6 +103,8 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
 
 #define INTEL_MASTER_RESET_ITERATIONS	10
 
+#define SDW_INTEL_DELAYED_ENUMERATION_MS	100
+
 #define SDW_INTEL_CHECK_OPS(sdw, cb)	((sdw) && (sdw)->link_res && (sdw)->link_res->hw_ops && \
 					 (sdw)->link_res->hw_ops->cb)
 #define SDW_INTEL_OPS(sdw, cb)		((sdw)->link_res->hw_ops->cb)
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 8807e01cbf7c..dff49c5ce5b3 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -475,6 +475,7 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	 */
 	if (!bus->prop.hw_disabled) {
 		sdw_intel_debugfs_exit(sdw);
+		cancel_delayed_work_sync(&cdns->attach_dwork);
 		sdw_cdns_enable_interrupt(cdns, false);
 	}
 	sdw_bus_master_delete(bus);
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index df944e11b9ca..2bc960d05780 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -60,6 +60,9 @@ int intel_start_bus(struct sdw_intel *sdw)
 	sdw_cdns_check_self_clearing_bits(cdns, __func__,
 					  true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -151,6 +154,9 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 	}
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -184,6 +190,9 @@ int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
 
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -194,6 +203,8 @@ int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 	bool wake_enable = false;
 	int ret;
 
+	cancel_delayed_work_sync(&cdns->attach_dwork);
+
 	if (clock_stop) {
 		ret = sdw_cdns_clock_stop(cdns, true);
 		if (ret < 0)
-- 
2.43.0


