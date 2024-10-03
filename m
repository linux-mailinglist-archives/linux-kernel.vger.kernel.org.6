Return-Path: <linux-kernel+bounces-348654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155F98EA19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB8BB23D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4B13AA41;
	Thu,  3 Oct 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho47Jzic"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1084E04;
	Thu,  3 Oct 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939262; cv=none; b=PUfc2fUN809JJK/n4eFUzunky7YdktiirmZRkY2T01o9xzO2lWbRw/b9i8GhQ8yYD9XX6gATzoKfFEy65vB6nNrVy+xPSlubHyYtMg06rThi8WEsFZ5AmF2LRudrqtp9m+IB6aENY8B4/GthN42fV9Y0r1ZnI4k5pKHfwyWWP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939262; c=relaxed/simple;
	bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an0/WHqovHV9W5NVGhu3mRHvdngPX2sVGjwtSozFqH+1YCLA6YzA/2ImEOeN/VZ6GIIkXPLecUWDH3sz0F9VfigDAiKkH/Met5Uh1/s9jqoqhHhvp/WrlwgKF2LafvZmW7dGAqSSckpW9p3oirIkaNxWmCv2C2i5Rcfjqa207Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho47Jzic; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939261; x=1759475261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
  b=Ho47JzicWMfD0ToIKwfc/aeqdz/EsGVDsRu5XWTWZMrfLHsDDhLWH0RH
   aPnMCW4byicEKOjOpEW2vOM/b+d2qsEN8qRjmd3Sn3WNlcn+iWh7hmJzs
   oW5gmw+xrIlEpaAhEpzaQB8IvmNCMY4qQgpcRwI0mGpmmzO6XDPrjQkmY
   3OcmrTzvCvo9+rQP7uPif5UCkwl0BrsjRAmrrCH7SxAPxIlUnPQtvNOkY
   HHEZznmKfXH4qNQHjDgV/nMhhpa1zsrT4SlQqw/MOsir7KJWjhd+yGbXq
   dZ8VE+GCTHr4gGeUiInbaJfnluZ0u3B75dnldX3hyWlf6E35jHblNR5B8
   A==;
X-CSE-ConnectionGUID: uz2c4YxUQbKj8MhSQg0EcQ==
X-CSE-MsgGUID: lswplhdnSBCHPLyOr/9aWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070760"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:37 -0700
X-CSE-ConnectionGUID: 3SKXCQ3vQwGm9DzKvVpLCA==
X-CSE-MsgGUID: Cpfsn0TFTdGP4cjOJXimbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508401"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:35 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 06/14] soundwire: optimize sdw_dp0_prop
Date: Thu,  3 Oct 2024 15:06:42 +0800
Message-ID: <20241003070650.62787-7-yung-chuan.liao@linux.intel.com>
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

Move pointers and booleans.

Before:

struct sdw_dp0_prop {
	u32                        max_word;             /*     0     4 */
	u32                        min_word;             /*     4     4 */
	u32                        num_words;            /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	u32 *                      words;                /*    16     8 */
	bool                       BRA_flow_controlled;  /*    24     1 */
	bool                       simple_ch_prep_sm;    /*    25     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        ch_prep_timeout;      /*    28     4 */
	bool                       imp_def_interrupts;   /*    32     1 */

	/* size: 40, cachelines: 1, members: 8 */
	/* sum members: 27, holes: 2, sum holes: 6 */
	/* padding: 7 */
	/* last cacheline: 40 bytes */
};

after:

struct sdw_dp0_prop {
	u32 *                      words;                /*     0     8 */
	u32                        max_word;             /*     8     4 */
	u32                        min_word;             /*    12     4 */
	u32                        num_words;            /*    16     4 */
	u32                        ch_prep_timeout;      /*    20     4 */
	bool                       BRA_flow_controlled;  /*    24     1 */
	bool                       simple_ch_prep_sm;    /*    25     1 */
	bool                       imp_def_interrupts;   /*    26     1 */

	/* size: 32, cachelines: 1, members: 8 */
	/* padding: 5 */
	/* last cacheline: 32 bytes */
};

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 38db81f5bdb9..c72095137a35 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -226,16 +226,16 @@ enum sdw_clk_stop_mode {
 
 /**
  * struct sdw_dp0_prop - DP0 properties
- * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
- * (inclusive)
- * @min_word: Minimum number of bits in a Payload Channel Sample, 1 to 64
- * (inclusive)
- * @num_words: number of wordlengths supported
  * @words: wordlengths supported
+ * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @min_word: Minimum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @num_words: number of wordlengths supported
+ * @ch_prep_timeout: Port-specific timeout value, in milliseconds
  * @BRA_flow_controlled: Slave implementation results in an OK_NotReady
  * response
  * @simple_ch_prep_sm: If channel prepare sequence is required
- * @ch_prep_timeout: Port-specific timeout value, in milliseconds
  * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
  *
@@ -244,13 +244,13 @@ enum sdw_clk_stop_mode {
  * support
  */
 struct sdw_dp0_prop {
+	u32 *words;
 	u32 max_word;
 	u32 min_word;
 	u32 num_words;
-	u32 *words;
+	u32 ch_prep_timeout;
 	bool BRA_flow_controlled;
 	bool simple_ch_prep_sm;
-	u32 ch_prep_timeout;
 	bool imp_def_interrupts;
 };
 
-- 
2.43.0


