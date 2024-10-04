Return-Path: <linux-kernel+bounces-349854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA098FC44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8CB2128F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4E1CAAF;
	Fri,  4 Oct 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7eQRrt5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAB1CF83;
	Fri,  4 Oct 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008343; cv=none; b=T+ZygWNaMnGge+BsLVnoNrDs/AbB4fNlMDIEAzV75hdqAFlWIWBUwRd6eVoy73ZuhW7BNtEYa73/CrtwgHwJK1/9N+zj5KPYg1/fYesWrje/TtHwgpD2SKrK8YvxzB9YmTwjU1O9NNi7p8vvu6q3v+7ixToDli1euTrYDt1iUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008343; c=relaxed/simple;
	bh=qZ7ML2pykEZMI1rPmX5Axhp2/3r4PO0h8FUz8ihRTBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FffUvir6Eds5VIog/WLDqCReSKBx0w/TMs2LUIRrdKrNdtTjg/c+wMP9WOQ1ogcEB8e2cZMSXNwQ1alHATZaVqikMu8QyDw1NOKVNCcYk6p7RiprIEoumsAVeSCBlQ0rO/uHwIGeZW+CyV3pXuo5VPxjmtO8VF8jEHTshzw4hP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7eQRrt5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728008342; x=1759544342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qZ7ML2pykEZMI1rPmX5Axhp2/3r4PO0h8FUz8ihRTBQ=;
  b=O7eQRrt5Vv3TbcZgpqdncAA8gUZn4T+o83ajWMfvqRXrq4rqtS7LelRY
   huFFYzP/vLUe099tqi8AgmYpe14dEY+Mnh94xV2fPdGpuvjKwTEFBZxQp
   xSTky26jWJuPICHyBBjMMrjuzbmfWJeiMIw7QE7nqr5XjIoe2qwye0ane
   Wf1sp2/rmSomZKTN+4jYsy3LjcIluMcHdutoBRiNh8Ne3M9cOLSFBFwsB
   gHUvbREfSr4avdcA6PR5vBXVDN/wmtur3IDpgCe6lHhnyqy7sWBPOakDs
   6Ku69Pb1GUAk+O+rAP0YeNyYchmm0PmQsWKLWz7PSimF++HJ93mhmYBJE
   Q==;
X-CSE-ConnectionGUID: qgPNNqqYRpmm51YB5M5Okg==
X-CSE-MsgGUID: lE3VoKImQz6rNltUTr0zIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27104468"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="27104468"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 19:19:01 -0700
X-CSE-ConnectionGUID: JtGFL84uS6KSu911y86U0A==
X-CSE-MsgGUID: GcooGaWFRbiGUieqavuOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="105305585"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 19:18:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2] soundwire: intel_auxdevice: add kernel parameter for mclk divider
Date: Fri,  4 Oct 2024 10:18:50 +0800
Message-ID: <20241004021850.9758-1-yung-chuan.liao@linux.intel.com>
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
v2: Add description of the kernel parameter in in kernel-parameters.txt.
---
 Documentation/admin-guide/kernel-parameters.rst |  1 +
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/soundwire/intel_auxdevice.c             | 12 ++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index fdea7c26ef80..a64130fd19bf 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -159,6 +159,7 @@ is applicable::
 	SCSI	Appropriate SCSI support is enabled.
 			A lot of drivers have their options described inside
 			the Documentation/scsi/ sub-directory.
+        SDW     SoundWire support is enabled.
 	SECURITY Different security models are enabled.
 	SELINUX SELinux support is enabled.
 	SERIAL	Serial support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..d7aee9ed5a1d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6060,6 +6060,10 @@
 			non-zero "wait" parameter.  See weight_single
 			and weight_many.
 
+	sdw_mclk_divider=[SDW]
+			Specify the MCLK divider for Intel SoundWire buses in
+			case the BIOS does not provide the clock rate properly.
+
 	skew_tick=	[KNL,EARLY] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index ae689d5d1ab9..599954d92752 100644
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


