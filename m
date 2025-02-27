Return-Path: <linux-kernel+bounces-536111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B7A47B95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65EA1891C26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11822E415;
	Thu, 27 Feb 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3jk2MHb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBA22E3FF;
	Thu, 27 Feb 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654724; cv=none; b=s7eqgmMr7VPJ/j0Bm7R0gcAgZWlV6I7DmDrRAqZwltCcxtDzFHu9/on3f0xjpGpa9gSKQflDysBToTyhHvh94ZKGkAi5qreDIoNcALl0faIVmE56OqKUguyHJJtDUTWiQihAh+C4iC1rDSa2NW/uU/7FBmj4HPuhAn2C2IYxqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654724; c=relaxed/simple;
	bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3Tst97MDja6m8BQWFr/vftho3Bsm1dznux61mDbaHXKNO1bHXozEsv2QSRfyeKD9aB4YGqPvjsEwJUUMfyFC79MOqY1BNJbnFIaf6uwEfi7+ul+CkY3MTel206C2zuBGj4EeRcwGZOpCFXjkALBABpBkWfVMyff92l/WddGPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3jk2MHb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654723; x=1772190723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
  b=S3jk2MHb1je7YsRO2wXMjXsJJVcoGK5iDypSdYPJlco/8N/h+5nyinbV
   nDN6TunWvRdHez8fawn8XFUu5sK52Tz9CmrrtCPbM3t4YJQ/k2U1R8y0z
   gbqzP7hEdRWHL+E5wS7mWFHq4dyeulegJmcN4RcgiT5tYUM4IoTeZe20B
   3PGxw9VqRWqPGyGjvbH9FzAtM9yrIgilTSfCqMhKVKTUDSTLy9BNQDAIB
   iWZTfRM70huPZo8t17Pnb935IA3o9ZoMjtSasXhvJ2cYjU2PRU1x3rwwP
   ZBPTBIzE9zqYQphnpDjrlV/kUUBwvl7EvRSx6zaCyWcwKqoyOhkf2/S3V
   w==;
X-CSE-ConnectionGUID: EMksXj/2TiGM7pky270oeQ==
X-CSE-MsgGUID: 6b0i44/NQ0qy1y2VDhAVgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189860"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:02 -0800
X-CSE-ConnectionGUID: M8FbySz6TFy7TiIsV8VOkQ==
X-CSE-MsgGUID: 0pUr/dHFR5GcZ2Uc+n8NsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154179022"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:00 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 10/16] soundwire: intel_auxdevice: add indirection for BPT send_async/wait
Date: Thu, 27 Feb 2025 19:11:23 +0800
Message-ID: <20250227111130.272698-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
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


