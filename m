Return-Path: <linux-kernel+bounces-324824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E210B975158
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2009B1C22ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0BC19CC1B;
	Wed, 11 Sep 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJMYOcUq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0B19C56B;
	Wed, 11 Sep 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055958; cv=none; b=UxsXsbypi65kgg9NbI/+y3UMDjoAbifrpXUm4PVsHNEhBP6qWeyKtMLLHFkhbKJfLnolms6EGgG6qKOLT4+rJNH7jfdcIqt8T1EFJefcDBFKTvUQszGVNv73qzjXlo+vGy3pKTTkrwcFhiVXrfZC7NfUfZ5SeY7uMG8yEmDX8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055958; c=relaxed/simple;
	bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPTGJO9+YGpvkoyr7s4uAEMfY8xMuBjrNN7t7LO4had1pECHI8k30onkIO1hFRK91fow6RgcL+HJMUNWHUpXcOA3uO+8g20ywor4C7JkhIXTA8ySeTXklrhZgQfmmxaPK2+/Cw6T+s0F5lwqcDY1Y0eZAFC0cKJGJHyXgA/8hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJMYOcUq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055957; x=1757591957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
  b=GJMYOcUqr/mefbUcxuIQgG+fwL+5f9vKoL711/LVoIChmCl5jS1B2fvU
   eVJi0/N+MPcZtGQukum8zp4uiQnpUe3ocdLDtD+9dMkXEzqDSQ1teCHTA
   NsaSxgQiMCWKJwx8dJdKQvP/XUMql24yCLYk/Rmm9GdUBuYACFgY2WHEJ
   gxLhGuCJ0wKfKLRmjSqFsPGin3V7tPvSUiwL+D397Ka7VpvPTCQOTCj+j
   b1rT7efstb1AhS3UNvc5Wex0/V+ggu4tEGnNGHzp9jY7cx50kL54+cobB
   ZMI0ehyXP+QkxzLvHngGQnAnehNT3VH0odvVjWgAPurde484Zg4Ujpk47
   A==;
X-CSE-ConnectionGUID: IeQRklTvQWmuqSihfWWPMA==
X-CSE-MsgGUID: T93lINWBSO+iO4IkPIW2uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417245"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:17 -0700
X-CSE-ConnectionGUID: 6LpHCJkTQ1WxutSwoJaQww==
X-CSE-MsgGUID: y2Cw+9liR42ToYToKjMnDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292748"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:14 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 06/14] soundwire: optimize sdw_dp0_prop
Date: Wed, 11 Sep 2024 19:58:19 +0800
Message-ID: <20240911115827.233171-7-yung-chuan.liao@linux.intel.com>
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


