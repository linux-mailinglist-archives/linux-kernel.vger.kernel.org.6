Return-Path: <linux-kernel+bounces-291302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A258895609E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C362819EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045E241E7;
	Mon, 19 Aug 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7Fblr/C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E317991;
	Mon, 19 Aug 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724028970; cv=none; b=MZVpSEa1wRKvK2UWF1K9/9aQC8TRamQ1AZ0/sf6QETg3Gpx/8dGQlAIxuxtRnpiE7Uek9r9tuFKqOOSLTJjk8c3mwcqwj70C9JQ4q2V3fNN3wNebBO9tXWEPwpTQ1Ch+4LHmNh3PLXxcimfNEtyn1gQ2hcRxBJCTuzr1cJLLVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724028970; c=relaxed/simple;
	bh=bhrb8WRNVZ1RIQ/10zE8YtSGqhg1SiogDhyp6w3JVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgaOInyZ+cF0fhlqyigI7ar2QHZ9/QoqrqfjPCL5O5PeBcIHkKcS5+6kIWMsdMU4s7qCJpAXcNYVJZ4ksMQ5WzzS0RHBIfB1xOnrokAdUV1snF8FG8k2IC5MXz5N1uoNe/7xJihkHzYN5AmcDL1UHmrFJ5Llfgs2PG4QWKh6wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7Fblr/C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724028968; x=1755564968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bhrb8WRNVZ1RIQ/10zE8YtSGqhg1SiogDhyp6w3JVvQ=;
  b=h7Fblr/C0/GQcfQpLfkjARmaIruT7CBkXhNjrJjrWsfqTs3HXRip6im4
   y5kG3tuX3Jt0RM3V3hFdlRZZa9lza0EewDK+du/vEcn0krz7z3E96AnOg
   P4UTBzEo3qBtAZ6abluGkvo0qq3jhUpSSLk19FgHt7TKteh0BXjNZN98Q
   Mo4nXQt2R20jPMM4mLt1KBrs8dZA7qG6P179lpP8gIZv0oOmiadDJa1Rs
   h1/XnCKiE0HUD9SBk8rnzJMKC8+g0Orwo8hGLi5XFLwCYC7gj6Pq97CYB
   /5edVo+SBcTkX+Eji3JLfPsMOacM931eDVx9iNqEXBCpLTD4V1Q7TILC1
   A==;
X-CSE-ConnectionGUID: H8dVPXeMSa+sY3TSOw4BfA==
X-CSE-MsgGUID: z6Q9BCYTSOWDEbZQXbMqDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22400170"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22400170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:56:08 -0700
X-CSE-ConnectionGUID: 44/vSjXkRCOJX1Wgg/AoFg==
X-CSE-MsgGUID: faJ8Gv76TumIgqm7XX8HGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60771415"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.197])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:56:04 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 2/3] soundwire: intel: add probe-time check on link id
Date: Mon, 19 Aug 2024 08:55:47 +0800
Message-ID: <20240819005548.5867-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
References: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In older platforms, the number of links was constant and hard-coded to
4. Newer platforms can have varying number of links, so we need to add
a probe-time check to make sure the ACPI-reported information with
_DSD properties is aligned with hardware capabilities reported in the
SoundWire LCAP register.

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           |  7 +++++++
 drivers/soundwire/intel_ace2x.c     | 20 ++++++++++++++++++++
 drivers/soundwire/intel_auxdevice.c | 14 ++++++++++++++
 include/linux/soundwire/sdw_intel.h |  3 +++
 4 files changed, 44 insertions(+)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 68838e843b54..1db4d9d3a3ba 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -222,6 +222,13 @@ static inline bool sdw_intel_sync_check_cmdsync_unlocked(struct sdw_intel *sdw)
 	return false;
 }
 
+static inline int sdw_intel_get_link_count(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, get_link_count))
+		return SDW_INTEL_OPS(sdw, get_link_count)(sdw);
+	return 4; /* default on older generations */
+}
+
 /* common bus management */
 int intel_start_bus(struct sdw_intel *sdw);
 int intel_start_bus_after_reset(struct sdw_intel *sdw);
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 781fe0aefa68..fff312c6968d 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -706,10 +706,30 @@ static void intel_program_sdi(struct sdw_intel *sdw, int dev_num)
 			__func__, sdw->instance, dev_num);
 }
 
+static int intel_get_link_count(struct sdw_intel *sdw)
+{
+	int ret;
+
+	ret = hdac_bus_eml_get_count(sdw->link_res->hbus, true, AZX_REG_ML_LEPTR_ID_SDW);
+	if (!ret) {
+		dev_err(sdw->cdns.dev, "%s: could not retrieve link count\n", __func__);
+		return -ENODEV;
+	}
+
+	if (ret > SDW_INTEL_MAX_LINKS) {
+		dev_err(sdw->cdns.dev, "%s: link count %d exceed max %d\n", __func__, ret, SDW_INTEL_MAX_LINKS);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.debugfs_init = intel_ace2x_debugfs_init,
 	.debugfs_exit = intel_ace2x_debugfs_exit,
 
+	.get_link_count = intel_get_link_count,
+
 	.register_dai = intel_register_dai,
 
 	.check_clock_stop = intel_check_clock_stop,
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 8807e01cbf7c..d110f2b587d5 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -317,6 +317,20 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	bus->link_id = auxdev->id;
 	bus->clk_stop_timeout = 1;
 
+	/*
+	 * paranoia check: make sure ACPI-reported number of links is aligned with
+	 * hardware capabilities.
+	 */
+	ret = sdw_intel_get_link_count(sdw);
+	if (ret < 0) {
+		dev_err(dev, "%s: sdw_intel_get_link_count failed: %d\n", __func__, ret);
+		return ret;
+	}
+	if (ret <= sdw->instance) {
+		dev_err(dev, "%s: invalid link id %d, link count %d\n", __func__, auxdev->id, ret);
+		return -EINVAL;
+	}
+
 	sdw_cdns_probe(cdns);
 
 	/* Set ops */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 87d82ea9a13a..cb8e7396b4db 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -388,6 +388,7 @@ struct sdw_intel;
 /* struct intel_sdw_hw_ops - SoundWire ops for Intel platforms.
  * @debugfs_init: initialize all debugfs capabilities
  * @debugfs_exit: close and cleanup debugfs capabilities
+ * @get_link_count: fetch link count from hardware registers
  * @register_dai: read all PDI information and register DAIs
  * @check_clock_stop: throw error message if clock is not stopped.
  * @start_bus: normal start
@@ -412,6 +413,8 @@ struct sdw_intel_hw_ops {
 	void (*debugfs_init)(struct sdw_intel *sdw);
 	void (*debugfs_exit)(struct sdw_intel *sdw);
 
+	int (*get_link_count)(struct sdw_intel *sdw);
+
 	int (*register_dai)(struct sdw_intel *sdw);
 
 	void (*check_clock_stop)(struct sdw_intel *sdw);
-- 
2.43.0


