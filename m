Return-Path: <linux-kernel+bounces-303379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142C960B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5678B1C22937
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AA1C2DCB;
	Tue, 27 Aug 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KE3XnO/U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F21C0DF7;
	Tue, 27 Aug 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764091; cv=none; b=Z6IE1ApkIyYJXJrrmlMhTAFW+Bcb7FFQ7pU2xRo91nkAxVjUOxf5Oonwc7p7hVyTX35QLBs3GNic+pOlMDVc/hXV4z8Wzj+tQUZWQDglq0wqRwGH2PZxO0bD9wL5uU4akL+VdLRAvkkjmT5IMXg2Hh/ivSSlXLoFD/KHa2E4/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764091; c=relaxed/simple;
	bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJT36tWgfacSzAs11Rg6FBwfSDsM5XvyFxK+2J1oiRo6HL39VPJCdn5/09OzZ8TuVbtGjnjDgbM3qXN8HcYKQjjtgS459Oe7jqZ3YNH6LbiCDMZhir/eeK9q6FVEG4QnXhypv6ZjsdjVSMJ01zZkOJsrmnrZodnRjcs0k436EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KE3XnO/U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764090; x=1756300090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jbLbmtzHZhVY/UmQFDWYc+qSpox4qDdhDzbm1XAid8=;
  b=KE3XnO/Uzu5ntaauZ8395Ib+QA3K5LOtLtRB8bTsTT3/rS7d8zQMRJOz
   ZFKURn610i+UMafXaRwCqCSZRKFPVET5tJfEfexlgVfaa+UYjB6BVzzlV
   9ZBybo77ftDPDjT5G8Z2IeBi4FdzNYrkIZ2VpAeI01SJvhdFBiNm75Kuc
   RKDPHWpHCrfAneRZoyUkX/wBFTFxkaElPhI8ur6YWhHJZU/ZsO9Ol4G5K
   jPuCXec6jaKQZasNtT6omC6tyxMLx4dnK3lVGj/as07Z25bby5m+JdO8l
   val+RmAjB+0IQQvJxZ2D/Y1oAa5T70QWz7EHhkc+gxhTrDh7OfhKyfqpd
   w==;
X-CSE-ConnectionGUID: sSr8KnDoTuO1cmmCFIUR4w==
X-CSE-MsgGUID: kLYNLs2nRb+bXRv+k6mwlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400570"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400570"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:09 -0700
X-CSE-ConnectionGUID: Ccchy1ClSs6VZIKhtOkvug==
X-CSE-MsgGUID: xIdVomEWTC61KM0CJlVbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551968"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 06/14] soundwire: optimize sdw_dp0_prop
Date: Tue, 27 Aug 2024 21:06:59 +0800
Message-ID: <20240827130707.298477-7-yung-chuan.liao@linux.intel.com>
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


