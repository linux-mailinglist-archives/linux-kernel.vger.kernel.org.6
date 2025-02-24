Return-Path: <linux-kernel+bounces-528275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAEA415A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D80818927B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0524A046;
	Mon, 24 Feb 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tp3saxou"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97F24169E;
	Mon, 24 Feb 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379540; cv=none; b=TFa6IjhYKgFWg+qK8lyP3M/zpiZht4rd7WyyOZVLQ26iwsIt70dh3cGhUr5c5bukjB3E0nAW/ajQLN5lCd0/aHMNXJPbCzy/3HzNrSqygHTxfIoUgU+6STq+wKdQ21CHaEN1gYHojO2r7jSTLh4Qr4/LMiJavYvFiWJDvozM5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379540; c=relaxed/simple;
	bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoxCQC1+3xFKGLOGO8HcJ8G0VKPC5WtQD1URnXb8NqF+zmf3KaGrz58Meiv6lk06H+z/EyERiHToFBSiVl6LJFnjT37XxFA31ntikw48aAQ+LXmORezMeYuTaCLDdCyZR8cRZflP4ieWBwo/qkhuop6l9l/eh71gM3m41fi5XUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tp3saxou; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379538; x=1771915538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
  b=Tp3saxou4VziDZi58Jj052vm44twkCXndE6XF6AXDeshuL004v9pPoL4
   g/7uPGU/KOXX0ZoJW8KiW9MjNuqCgEwUYY3z+y/zIIiWFwEEXPI2Owe66
   ic/B+66QlxRh4UtyGSvW2MetO6gDXELECOU5OgKPOFmUp74Y7UC2rCeZi
   mup0XtlhVB3pdPQXHbbRNz9A5hCemMUd6ZbMGNADD7IJlgUiGMwaZLZ/a
   yvIPhzw6Xj8H8Ev0IVVPCE8Yy5MtMgWOF6cYI9E3nHa9G0JriETweS6o7
   CaKlKHrcl5XhpsCWmESyEIYjauGVQ02aDTsgyeNTMafa0dk4c/cYCKZrQ
   Q==;
X-CSE-ConnectionGUID: aZB24AB+SH+fbaqy6SP2PA==
X-CSE-MsgGUID: Kxmp77MfRxWBTytX7unkDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538972"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538972"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:34 -0800
X-CSE-ConnectionGUID: Zzk795wlQ3in577KJQzEjw==
X-CSE-MsgGUID: qFps79K0R/WpKlACOOnI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597729"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:32 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 10/16] soundwire: intel_auxdevice: add indirection for BPT send_async/wait
Date: Mon, 24 Feb 2025 14:44:44 +0800
Message-ID: <20250224064451.33772-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

Mirror abstraction added for master ops.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 24 ++++++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index dee126f6d9d5..5ea6399e6c9b 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -79,6 +79,27 @@ static bool is_wake_capable(struct sdw_slave *slave)
 	return false;
 }
 
+static int generic_bpt_send_async(struct sdw_bus *bus, struct sdw_slave *slave,
+				  struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+
+	if (sdw->link_res->hw_ops->bpt_send_async)
+		return sdw->link_res->hw_ops->bpt_send_async(sdw, slave, msg);
+	return -EOPNOTSUPP;
+}
+
+static int generic_bpt_wait(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+
+	if (sdw->link_res->hw_ops->bpt_wait)
+		return sdw->link_res->hw_ops->bpt_wait(sdw, slave, msg);
+	return -EOPNOTSUPP;
+}
+
 static int generic_pre_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
@@ -267,6 +288,9 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.get_device_num =  intel_get_device_num_ida,
 	.put_device_num = intel_put_device_num_ida,
 	.new_peripheral_assigned = generic_new_peripheral_assigned,
+
+	.bpt_send_async = generic_bpt_send_async,
+	.bpt_wait = generic_bpt_wait,
 };
 
 /*
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 580086417e4b..493d9de4e472 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -436,6 +436,10 @@ struct sdw_intel_hw_ops {
 	bool (*sync_check_cmdsync_unlocked)(struct sdw_intel *sdw);
 
 	void (*program_sdi)(struct sdw_intel *sdw, int dev_num);
+
+	int (*bpt_send_async)(struct sdw_intel *sdw, struct sdw_slave *slave,
+			      struct sdw_bpt_msg *msg);
+	int (*bpt_wait)(struct sdw_intel *sdw, struct sdw_slave *slave, struct sdw_bpt_msg *msg);
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
-- 
2.43.0


