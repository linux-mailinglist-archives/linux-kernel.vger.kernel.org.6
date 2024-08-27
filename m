Return-Path: <linux-kernel+bounces-303378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07DA960B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597CE285105
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4351BD03D;
	Tue, 27 Aug 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHtCtHdy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3B1C0DD6;
	Tue, 27 Aug 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764089; cv=none; b=G2UoRog6/lvKSRjDd9RYSty96ygJtL6lvcTjY89E9m6ytRUm+eVS192UX5A0py3++bzSCTeGuOyy/vZinzudfFv0cLKc5TG4Y7hF2F/bqgVLHg59HXhpm8SttDUn3X4v33bDQmvesnNyLIR4MXrglP+8eFV2rU3tOQANjkisbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764089; c=relaxed/simple;
	bh=lmMmn37+R6qgv1ErHkOCL6BvGv3yhHItHZa0c5ES79c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REclZLKtwZIkogz/QgkWvlM0MQGOdCxPqEovMrNZoLWNGVibCWwn2L6A6k1Cy8+phXCZXljmwewOnLTpXIYYzHqnZF0WFl2u3Vyq+VmLQ8BmVMTsRdywIvdau5r+m0qbjZ5fQV7Bm5p46f2jE6Iw5Oo/DMhvGrdQpswRpngkre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHtCtHdy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764087; x=1756300087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmMmn37+R6qgv1ErHkOCL6BvGv3yhHItHZa0c5ES79c=;
  b=SHtCtHdy4ngOJR4Mi3cCiJv+pFMmsEYB/BVrCGRzyK/4trFOVuXEoF+q
   f8d71d+jnFYFGi/zlAC8A9LCPE/guCpakwf8t8dr29FSmGlAA6ZSu/gr2
   fXFz7cxrLSgfAWlDQoQ8P848JLC0THQALMCOhaYpALVQVYqtpk2+Pju7b
   1G6dwAHIzl9W103OYYEOotlsEl0XvvulGtOuwwvy1s9+8tY5o6n4l0b9+
   nVevnp42KJlmzvlaS/AQ3+nxVqkQxgu4N5uJokuRyrO02dtLzceO0ZiY/
   dzNvvQ99OnCQJov/88qzISap8NYCk24pJBnnDzcEW9h5pSzD6BQlW6CIe
   w==;
X-CSE-ConnectionGUID: GMqeVtXhSr+FcmPMWuvBuA==
X-CSE-MsgGUID: faa6OD3cRHGkj8YTfvvusA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400557"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400557"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:07 -0700
X-CSE-ConnectionGUID: Uh6/wwnzQrCus+HUcJifkQ==
X-CSE-MsgGUID: odsuXB5AQh6tjZGD4e218Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551963"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 05/14] soundwire: optimize sdw_slave_prop
Date: Tue, 27 Aug 2024 21:06:58 +0800
Message-ID: <20240827130707.298477-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
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


