Return-Path: <linux-kernel+bounces-275882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC2948B76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9B1F25781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762951BD03B;
	Tue,  6 Aug 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6eGgRNv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E515F409;
	Tue,  6 Aug 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933533; cv=none; b=bQe2XK1Bk5+VZVi0Ku9hYt5pEZ2m57YeHX/a9Id9rkOqt0yFHP220kBzeC++EncPwe9u/n73VWWdBBiQs9RIgR8Md4Ypcf0kCZoaG+61yCDvJ4KRj4iSvlZrlgF6u4xri/dSDDcqo8oI3JPsUq5hgABHmOL8Divh1r4xtRo9SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933533; c=relaxed/simple;
	bh=gthG5YnlzP7ynvKVDkGb/hWnJ4Cepoa8dzgsrMf/p+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeexE+XaXWLuHhKnXWYYHCs93lgl/r/3TQBvrHqn/pFilI1lgvLfd9jBLnuNuPGdxwZigvQO9mPid6nZRL0N1SJ4kYbPQfkfMKACwx4UcNJhEjOvvPIob3c+7HcZeM8aERRIZ6Kc+25Szjw5swhv7gsT46CjQNSeG3Q/Hpm8T0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6eGgRNv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722933532; x=1754469532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gthG5YnlzP7ynvKVDkGb/hWnJ4Cepoa8dzgsrMf/p+o=;
  b=e6eGgRNvdwlM9HJa5mCXNT7BrRaKzX+zHDNbQyMsu6tNRcTSR6exPL1u
   gf+JCtBV59/c719c4/9/CCThyr2w4nXjDON6S0iJDnAChfa8vK4Hcl+Kb
   eSmV2no+8YjlrbxA3Wx13Bke1eh7QNP/YkzVybe5OmSNNMIOrD4wPyY+J
   qg1bpCDIh1PcCFFqPAGbjiLmTv5vLx2S67mvAwkLdwpK6nxOkOsbe6cFI
   RWyFrOH8238qhBH6N2zG4x6K0nkGliIfmS8hnz/GHZi4KU4R+pyMgJaF3
   J8JoUP2JTb9641/lJCrbLw/+xodQRfi4nrF344ImE0iGtMBbFtKzeK6uO
   g==;
X-CSE-ConnectionGUID: sMUGikC3SFaIjFLkZ9j3NA==
X-CSE-MsgGUID: 6+2kuSryR+6ry53IfOBqGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21077155"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21077155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:38:51 -0700
X-CSE-ConnectionGUID: u9NQOVcmTTSGVTd8Rhq+Rw==
X-CSE-MsgGUID: dV0mxQSST/WEqzyvlRWQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="87056502"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.119.23])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:38:49 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_auxdevice: add kernel parameter for mclk divider
Date: Tue,  6 Aug 2024 16:38:40 +0800
Message-ID: <20240806083840.24094-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add a kernel parameter to work-around discrepancies between hardware
and platform firmware, it's not unusual to see e.g. 38.4MHz listed in
_DSD properties as the SoundWire clock source, but the hardware may be
based on a 19.2 MHz mclk source.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index dff49c5ce5b3..e372195b07b3 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -41,6 +41,10 @@ static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
 MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
 
+static int mclk_divider;
+module_param_named(sdw_mclk_divider, mclk_divider, int, 0444);
+MODULE_PARM_DESC(sdw_mclk_divider, "SoundWire Intel mclk divider");
+
 struct wake_capable_part {
 	const u16 mfg_id;
 	const u16 part_id;
@@ -142,8 +146,12 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 				 "intel-sdw-ip-clock",
 				 &prop->mclk_freq);
 
-	/* the values reported by BIOS are the 2x clock, not the bus clock */
-	prop->mclk_freq /= 2;
+	if (mclk_divider)
+		/* use kernel parameter for BIOS or board work-arounds */
+		prop->mclk_freq /= mclk_divider;
+	else
+		/* the values reported by BIOS are the 2x clock, not the bus clock */
+		prop->mclk_freq /= 2;
 
 	fwnode_property_read_u32(link,
 				 "intel-quirk-mask",
-- 
2.43.0


