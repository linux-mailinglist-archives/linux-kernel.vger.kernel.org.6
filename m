Return-Path: <linux-kernel+bounces-324831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4997515F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E313B25379
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CED1A01BF;
	Wed, 11 Sep 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE3JT7hr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AC1A2626;
	Wed, 11 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055976; cv=none; b=DvZAQL+FT8LAtfKXfYBv/03kg+/xq690wRc/uxy5Ml0xm5vPnlya21o4l/Q+txQzgqHtFThSR22lHEvJe6SMuMeeqXgoQmSVl+qZYYdfhTABVmaoo5TT0cbW0s6jDfpq6Mg3sJjkIRcbwQlWlSbfVQwRMnVZo3gyVbsKtygxP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055976; c=relaxed/simple;
	bh=8QxpkFSxoNjBvdT/4TaTLNU6cNZOZw6ufXE7ms0iV0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdXMSaKSwjmh6TTRwIUcymjIV17G0AySBGrUtFCO9vIsKqkJGQsXCBy5YIKqvvQR0GGR3SjtDgRE5E/0HQsY46OjOgWMl15/mExHTyPHfT8jQR9RMwl0qyUBWjeqgKeAvcTobxfqv06Id3A86tbqwhMbfM5jES9Y74Ybw5uqlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE3JT7hr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055975; x=1757591975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QxpkFSxoNjBvdT/4TaTLNU6cNZOZw6ufXE7ms0iV0A=;
  b=FE3JT7hrVbPnszUMmgtn5R78Q/egdkevEkOo3k0iEjbK4j19CORXG6sR
   Naz4uyaYL4sLgZmgTa2TQysUDKzmwbTW5LBQkPq1UskzstkCF8wW2Fh89
   +MjjCyIIPZGZfVBPsI6fbg2CoBQ70EoBEOneJHqxyLk8GkIZEOsvdNN0I
   096kmZ9aAPM2DHu+RZfWNGbXvrjVRkn89QJKvDwpowWKTeJVGqjkbrkbE
   p+mok30NAOfJl4Mh7CcH/tQC7HyfCvH1w+2M4fFHX/qHIF/u4/mKXfDMt
   +VuGZltGoBVLTDheqO3n40w96eOVvVyMKlKMMyVqXpYcS18ooELzCIYfy
   A==;
X-CSE-ConnectionGUID: CP1oTVqvSimc+r6fKcEB+A==
X-CSE-MsgGUID: OsMhJYFlS+qgNgjIxvTVMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417284"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417284"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:34 -0700
X-CSE-ConnectionGUID: /tG9QsCDRHWFPrLEee29lQ==
X-CSE-MsgGUID: Y4VFg8riQBiX6foISsq8XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292820"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:32 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 13/14] soundwire: mipi-disco: add new properties from 2.0 spec
Date: Wed, 11 Sep 2024 19:58:26 +0800
Message-ID: <20240911115827.233171-14-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
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
value. This patch uses the new introduced mipi_device_property_read_bool()
to handle it.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 6 ++++++
 include/linux/soundwire/sdw.h  | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index d6eb63bf1252..36e734751225 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -398,6 +398,12 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
 				 &prop->sink_ports);
 
+	device_property_read_u32(dev, "mipi-sdw-sdca-interrupt-register-list",
+				 &prop->sdca_interrupt_register_list);
+
+	prop->commit_register_supported = mipi_device_property_read_bool(dev,
+			"mipi-sdw-commit-register-supported");
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


