Return-Path: <linux-kernel+bounces-288862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FA953FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A811B24AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1DA6F077;
	Fri, 16 Aug 2024 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqU120tC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1576056;
	Fri, 16 Aug 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775636; cv=none; b=VPtr8JIt+OInbDnHwsVXdTgb36xlZXOF/nllw8reHfg3uex25fW8oJRKO34gXjyv5i2CBa4vi1E0TGdX+AMwLcKA8J9Ci+JNcyGQf47GOQnD4B0G0TPe7qYReVHBvIvR0XokH/Ul/fRBxsMwHqy3Ytv1N7q0klKXfEWHQxhm93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775636; c=relaxed/simple;
	bh=Jr4/OGLQnK9gpgUHkut0m6qsxTOqjervLSR11XEpo40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtX5yavsBEBYPiK5LXip8QCwiWfPkm4u/QmY7tLRQZtsRhkDXhzZjXOGmHnwVaZlHUq+Pc/myr8D5UJMz+TwCYEtZX22qWp/3z/Jne4fnagPOme24yLAHpB4EtgNWSq5cE5sa/pD12/ervFuDowe/SXOp3jE2o5PY2NBNqtH3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqU120tC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723775635; x=1755311635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jr4/OGLQnK9gpgUHkut0m6qsxTOqjervLSR11XEpo40=;
  b=UqU120tCApfhHCeR/CNrSU4mBxAG/FyAez9E4MANXwsTWnrbGAyI35iz
   IEQOBskU0nNAfo2CHXJnGo9Ctbhmrj9BF7mNhE4oAz1Wq7gX8xWhKCzj1
   kum3kD4oNCrUEP22pCySHszCZCW8tDcHWpRAsM6QRS2Z8lql+hi+pTeYs
   7q2REIkgh5n6cuW4Gw1g7FZ/2qKO403dyWZuJcHFtHTIzOUO8QFeB3zQx
   y/tD+O0OAqJw/gXDeYtObd+wvVSlk3G/pgq8Vr2EgR6ND4lEc+t224fOT
   RF42uOI67aWacNHox7OK6mZSIGSaxU2sTA/I6CTAaTJz6ZFDLiS3FmNmM
   A==;
X-CSE-ConnectionGUID: AOtKSm/vRHeB13cg8I1/yA==
X-CSE-MsgGUID: tEMhfP/6TGKXKYwk9gh4Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22203581"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22203581"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:54 -0700
X-CSE-ConnectionGUID: skpkR3DzRfiAirew3dejpg==
X-CSE-MsgGUID: mKh35jl6R0G9O2rZFFPW2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63949220"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:51 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: intel: add probe-time check on link id
Date: Fri, 16 Aug 2024 10:33:31 +0800
Message-ID: <20240816023331.6565-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
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
index edbe1d4af8f8..37ae69365fe2 100644
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


