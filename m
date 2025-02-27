Return-Path: <linux-kernel+bounces-536526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D2A48119
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7423E16BF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE52405E7;
	Thu, 27 Feb 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJj/HMey"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB623A99E;
	Thu, 27 Feb 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665226; cv=none; b=mAuYKuMLcsw84+TU1jV4tEkyCtFKDmuqfG/W82qwxsDBSAcv4QEYZFwWAwlDsuapPdbVI+Yy5oNBUaioSrpD2eW/sTq4RxM9N0pE1eH8LSub3C2t+XMBNi4O0YpO7MHaLZTdOji9mnONBJaYBg89MHpAovLdOaDzcNW1rZc7UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665226; c=relaxed/simple;
	bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epBWkgDjBQ44Tq+xvIW1394eouDUBM04CEKV69HEP+K6LILS2fN/EMzl089oggpXd/02ds86e1upmaWDWnElwgzv2/BWgXJtVy0JKNTu1u8lai4NJNmDFdho5PHDsoxHFFsnnEkP6jvb7KQxKZr3vJNmYffvEzGIwNc9FytUEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJj/HMey; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665225; x=1772201225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFQV1njpo/0Y7MZd6/sSFiNtToxZ4fmeFKOm9o1GgoQ=;
  b=QJj/HMey+JIW+B8wLF2A08UY2Z02atpdYA1sCYF+JwqxxaTlKeMWlObX
   XasgMksijdrvbTqX7n+M3l1hOCxmwxvg9iibyVoXFS6anjYSA41iy8JGe
   /UnYD8qfgzTvTj9u+/ZVugi+E2ssyWgiBXrrsPRrerc4761XVcs6zcNaS
   BTYUgs/npUjz+OBus6JDajzGRa6twjO+DjVH5oujxamsDi2vyafD8o0y5
   6EQcHRRLJGwb1zbuDj6iAa+XGSpH+8Y9diXljux7W7kRXAf/9CXNoGJ70
   vuzlpSm+L3uKL/JP0GsODAKqj6QfQHfgpH90o/GHWuG2pJDVGmrxKLtqC
   w==;
X-CSE-ConnectionGUID: uluLCe/RSm2TLLrzg+uc8g==
X-CSE-MsgGUID: zwT/8dcWTuiEJHOuesYoKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438078"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:49 -0800
X-CSE-ConnectionGUID: scBcuk+6RIqOFey7r0pbdQ==
X-CSE-MsgGUID: vjBpi3aaRq2T89tlzyIAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831667"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:46 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 10/16] soundwire: intel_auxdevice: add indirection for BPT send_async/wait
Date: Thu, 27 Feb 2025 22:06:09 +0800
Message-ID: <20250227140615.8147-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
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


