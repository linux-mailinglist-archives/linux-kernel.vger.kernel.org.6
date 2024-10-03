Return-Path: <linux-kernel+bounces-348653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225098EA17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D71B1F27AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE313A25F;
	Thu,  3 Oct 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/bqgZvS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282A84A3E;
	Thu,  3 Oct 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939261; cv=none; b=L58+5Sra4x8FM2/nRruBxNOtwWHcU3gJ7THJRB12i1XCx6o+d9Z90WNku0AbdVDd/ez6Jeitw5aPmRb9uOOnKRdprrmpYdP0BbeBFaIifDorzYGMzWjvmlQzl/rLgnJCY3BdY2/xUvC2ViD6jG8DqCmBscvmaGHnFCwVVWi/h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939261; c=relaxed/simple;
	bh=lmMmn37+R6qgv1ErHkOCL6BvGv3yhHItHZa0c5ES79c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPySSL9kVvz6Nwc1OttFORzE2AOZ1bR5lLi4O198IrbcFLC80ZVtgZMv5ULPYhyNHaRlMqYl41fb/YfFHYUbyFOXcCOFcIqS8/40oSAVvUolh4mIltQXqbkWlX1HlZ1VuRGUDtIsEuIUnsiN/P1NUmFMwFJRLNQJ33Pyi7QUgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/bqgZvS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939261; x=1759475261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmMmn37+R6qgv1ErHkOCL6BvGv3yhHItHZa0c5ES79c=;
  b=V/bqgZvSZCwPvMwU8J7mOZrjG76iCSIuLSzHnDyXblgW0MvisWqQh8n/
   nU8CORxeOQHUuWUZLCnYC+ZYgrOrOX8N3Qfvv1TGBiHFb0dgOZTVSVH1p
   cU5qYQA7a693EY4P8BDMUDaR5KU5IxAZH2E2sNJKLiWt0rBfdi/dVCqMG
   lgrodG/EknNmcy3JDgU54Ck3OZvoo/e9Ly66+gryRf/1awjZ6Y30Fhg5w
   pk3v6QfsSeaxLDYLuR7aZWS2arRBZG0rNCVcEsNg2g3BFj8PMY6oEcdUM
   BeipAqPiH4GCtBxki+FeJDHi7lWoBisVl2UmlParnhn1R1W0h7mp7meBs
   w==;
X-CSE-ConnectionGUID: hRNNbhRaRUevc11yaHhQ7Q==
X-CSE-MsgGUID: 2XotJWo1SxqKy8r/LoiIzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070754"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070754"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:35 -0700
X-CSE-ConnectionGUID: gycyiyg0TsmJgK2DfdV4HQ==
X-CSE-MsgGUID: M9tJw58EQbSPJtaJXEGicg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508398"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:32 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 05/14] soundwire: optimize sdw_slave_prop
Date: Thu,  3 Oct 2024 15:06:41 +0800
Message-ID: <20241003070650.62787-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

move pointers first, and move booleans together.

before:

struct sdw_slave_prop {
	u32                        mipi_revision;        /*     0     4 */
	bool                       wake_capable;         /*     4     1 */
	bool                       test_mode_capable;    /*     5     1 */
	bool                       clk_stop_mode1;       /*     6     1 */
	bool                       simple_clk_stop_capable; /*     7     1 */
	u32                        clk_stop_timeout;     /*     8     4 */
	u32                        ch_prep_timeout;      /*    12     4 */
	enum sdw_clk_stop_reset_behave reset_behave;     /*    16     4 */
	bool                       high_PHY_capable;     /*    20     1 */
	bool                       paging_support;       /*    21     1 */
	bool                       bank_delay_support;   /*    22     1 */

	/* XXX 1 byte hole, try to pack */

	enum sdw_p15_behave        p15_behave;           /*    24     4 */
	bool                       lane_control_support; /*    28     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        master_count;         /*    32     4 */
	u32                        source_ports;         /*    36     4 */
	u32                        sink_ports;           /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	struct sdw_dp0_prop *      dp0_prop;             /*    48     8 */
	struct sdw_dpn_prop *      src_dpn_prop;         /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct sdw_dpn_prop *      sink_dpn_prop;        /*    64     8 */
	u8                         scp_int1_mask;        /*    72     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        quirks;               /*    76     4 */
	bool                       clock_reg_supported;  /*    80     1 */
	bool                       use_domain_irq;       /*    81     1 */

	/* size: 88, cachelines: 2, members: 23 */
	/* sum members: 71, holes: 4, sum holes: 11 */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

after:

truct sdw_slave_prop {
	struct sdw_dp0_prop *      dp0_prop;             /*     0     8 */
	struct sdw_dpn_prop *      src_dpn_prop;         /*     8     8 */
	struct sdw_dpn_prop *      sink_dpn_prop;        /*    16     8 */
	u32                        mipi_revision;        /*    24     4 */
	bool                       wake_capable;         /*    28     1 */
	bool                       test_mode_capable;    /*    29     1 */
	bool                       clk_stop_mode1;       /*    30     1 */
	bool                       simple_clk_stop_capable; /*    31     1 */
	u32                        clk_stop_timeout;     /*    32     4 */
	u32                        ch_prep_timeout;      /*    36     4 */
	enum sdw_clk_stop_reset_behave reset_behave;     /*    40     4 */
	bool                       high_PHY_capable;     /*    44     1 */
	bool                       paging_support;       /*    45     1 */
	bool                       bank_delay_support;   /*    46     1 */
	bool                       lane_control_support; /*    47     1 */
	enum sdw_p15_behave        p15_behave;           /*    48     4 */
	u32                        master_count;         /*    52     4 */
	u32                        source_ports;         /*    56     4 */
	u32                        sink_ports;           /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32                        quirks;               /*    64     4 */
	u8                         scp_int1_mask;        /*    68     1 */
	bool                       clock_reg_supported;  /*    69     1 */
	bool                       use_domain_irq;       /*    70     1 */

	/* size: 72, cachelines: 2, members: 23 */
	/* padding: 1 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 6fcf122c1831..38db81f5bdb9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -344,6 +344,9 @@ struct sdw_dpn_prop {
 
 /**
  * struct sdw_slave_prop - SoundWire Slave properties
+ * @dp0_prop: Data Port 0 properties
+ * @src_dpn_prop: Source Data Port N properties
+ * @sink_dpn_prop: Sink Data Port N properties
  * @mipi_revision: Spec version of the implementation
  * @wake_capable: Wake-up events are supported
  * @test_mode_capable: If test mode is supported
@@ -360,15 +363,12 @@ struct sdw_dpn_prop {
  * SCP_AddrPage2
  * @bank_delay_support: Slave implements bank delay/bridge support registers
  * SCP_BankDelay and SCP_NextFrame
+ * @lane_control_support: Slave supports lane control
  * @p15_behave: Slave behavior when the Master attempts a read to the Port15
  * alias
- * @lane_control_support: Slave supports lane control
  * @master_count: Number of Masters present on this Slave
  * @source_ports: Bitmap identifying source ports
  * @sink_ports: Bitmap identifying sink ports
- * @dp0_prop: Data Port 0 properties
- * @src_dpn_prop: Source Data Port N properties
- * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
  * @clock_reg_supported: the Peripheral implements the clock base and scale
@@ -377,6 +377,9 @@ struct sdw_dpn_prop {
  * @use_domain_irq: call actual IRQ handler on slave, as well as callback
  */
 struct sdw_slave_prop {
+	struct sdw_dp0_prop *dp0_prop;
+	struct sdw_dpn_prop *src_dpn_prop;
+	struct sdw_dpn_prop *sink_dpn_prop;
 	u32 mipi_revision;
 	bool wake_capable;
 	bool test_mode_capable;
@@ -388,16 +391,13 @@ struct sdw_slave_prop {
 	bool high_PHY_capable;
 	bool paging_support;
 	bool bank_delay_support;
-	enum sdw_p15_behave p15_behave;
 	bool lane_control_support;
+	enum sdw_p15_behave p15_behave;
 	u32 master_count;
 	u32 source_ports;
 	u32 sink_ports;
-	struct sdw_dp0_prop *dp0_prop;
-	struct sdw_dpn_prop *src_dpn_prop;
-	struct sdw_dpn_prop *sink_dpn_prop;
-	u8 scp_int1_mask;
 	u32 quirks;
+	u8 scp_int1_mask;
 	bool clock_reg_supported;
 	bool use_domain_irq;
 };
-- 
2.43.0


