Return-Path: <linux-kernel+bounces-348655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9598EA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5494B24619
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6513CA8A;
	Thu,  3 Oct 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkHyyDFY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6D126BE0;
	Thu,  3 Oct 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939263; cv=none; b=lnSf3F+60KwVfYeY0wuqAYKxnJ4YxFFFnU8de0wIRVKh7SRQahOdlqtFLYAMimi/MjZucxQftclqUVk4K9CBsOgNcmm5EKYhWtuJKO9XIRZCcgRQfiK1MEyCsMCpkLfCJrOq0gZ60VYTqpJn5e57DKOIotn6QEO1S1efXYHskM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939263; c=relaxed/simple;
	bh=EyzHfJ0GwyNdqWr9Tz+WnVWaVwBx3I8DtCHEK5IXV6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEu0/5dKFqrjK0EG1yHBt3BIx3v9xObZ94NwdWDMj8x273pp4RiQcRD2e6FvIYTwYxAsxAqHcXSDpfe5bM3OTY95H+e9o/yEG2+Lu8JJ5jGRo2ByVVz8xGstw8+gKMPxn+YO+ZgZM7Rx4YqyBoK/C6e/sew251Yo7/Y13/Bt7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkHyyDFY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939262; x=1759475262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyzHfJ0GwyNdqWr9Tz+WnVWaVwBx3I8DtCHEK5IXV6E=;
  b=bkHyyDFYCFUi7FsgdZ/Dt17o/CygmM0GaJ8EathmbXvtM/7G34w5uTIU
   mL8/kvnhzkFa3hWJw6T1x5DumJHuLQMhszI/30RHxSDPK32DIbt86dhjb
   tm66gcmAWRafIzbK72SqCwTEIGeWJ6DpNYwh77NJJhn8/SLr1uX7I882I
   vYCeeF4UTdKS+4PImMPCRWMjcgMQSBol9e9TTcBD2QDGzIRsoW4olIfdT
   23M9PBRcUPyVTcFQn2aGTsi2ZsV6IHfTy81FM5SJlpTVd8UfH4XgtaBXR
   2whSSgTxhqJg58G+bGIYwQq+jZk+L4CUjAZ7s87MgCy/7B3OOXCG1p+GZ
   Q==;
X-CSE-ConnectionGUID: cYpoR+aYQCicexhmESQEXA==
X-CSE-MsgGUID: KiqPtdcIRzK8o2nAs3Mpeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070767"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070767"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:40 -0700
X-CSE-ConnectionGUID: fhnCjkIQT46lXfWlDyg+UA==
X-CSE-MsgGUID: L+6XzqOHQS+4MaTow+T70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508404"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:37 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 07/14] soundwire: optimize sdw_dpn_prop
Date: Thu,  3 Oct 2024 15:06:43 +0800
Message-ID: <20241003070650.62787-8-yung-chuan.liao@linux.intel.com>
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

before:
struct sdw_dpn_prop {
	u32                        num;                  /*     0     4 */
	u32                        max_word;             /*     4     4 */
	u32                        min_word;             /*     8     4 */
	u32                        num_words;            /*    12     4 */
	u32 *                      words;                /*    16     8 */
	enum sdw_dpn_type          type;                 /*    24     4 */
	u32                        max_grouping;         /*    28     4 */
	bool                       simple_ch_prep_sm;    /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        ch_prep_timeout;      /*    36     4 */
	u32                        imp_def_interrupts;   /*    40     4 */
	u32                        max_ch;               /*    44     4 */
	u32                        min_ch;               /*    48     4 */
	u32                        num_channels;         /*    52     4 */
	u32 *                      channels;             /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32                        num_ch_combinations;  /*    64     4 */

	/* XXX 4 bytes hole, try to pack */

	u32 *                      ch_combinations;      /*    72     8 */
	u32                        modes;                /*    80     4 */
	u32                        max_async_buffer;     /*    84     4 */
	bool                       block_pack_mode;      /*    88     1 */
	bool                       read_only_wordlength; /*    89     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        port_encoding;        /*    92     4 */
	struct sdw_dpn_audio_mode * audio_modes;         /*    96     8 */

	/* size: 104, cachelines: 2, members: 22 */
	/* sum members: 95, holes: 3, sum holes: 9 */
	/* last cacheline: 40 bytes */
};

after:

struct sdw_dpn_prop {
	struct sdw_dpn_audio_mode * audio_modes;         /*     0     8 */
	u32                        num;                  /*     8     4 */
	u32                        max_word;             /*    12     4 */
	u32                        min_word;             /*    16     4 */
	u32                        num_words;            /*    20     4 */
	u32 *                      words;                /*    24     8 */
	enum sdw_dpn_type          type;                 /*    32     4 */
	u32                        max_grouping;         /*    36     4 */
	u32                        ch_prep_timeout;      /*    40     4 */
	u32                        imp_def_interrupts;   /*    44     4 */
	u32                        max_ch;               /*    48     4 */
	u32                        min_ch;               /*    52     4 */
	u32                        num_channels;         /*    56     4 */
	u32                        num_ch_combinations;  /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32 *                      channels;             /*    64     8 */
	u32 *                      ch_combinations;      /*    72     8 */
	u32                        modes;                /*    80     4 */
	u32                        max_async_buffer;     /*    84     4 */
	u32                        port_encoding;        /*    88     4 */
	bool                       block_pack_mode;      /*    92     1 */
	bool                       read_only_wordlength; /*    93     1 */
	bool                       simple_ch_prep_sm;    /*    94     1 */

	/* size: 96, cachelines: 2, members: 22 */
	/* padding: 1 */
	/* last cacheline: 32 bytes */
};

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index c72095137a35..cc0afb8af333 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -288,6 +288,7 @@ struct sdw_dpn_audio_mode {
 
 /**
  * struct sdw_dpn_prop - Data Port DPn properties
+ * @audio_modes: Audio modes supported
  * @num: port number
  * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
  * (inclusive)
@@ -298,26 +299,26 @@ struct sdw_dpn_audio_mode {
  * @type: Data port type. Full, Simplified or Reduced
  * @max_grouping: Maximum number of samples that can be grouped together for
  * a full data port
- * @simple_ch_prep_sm: If the port supports simplified channel prepare state
- * machine
  * @ch_prep_timeout: Port-specific timeout value, in milliseconds
  * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
  * @max_ch: Maximum channels supported
  * @min_ch: Minimum channels supported
  * @num_channels: Number of discrete channels supported
- * @channels: Discrete channels supported
  * @num_ch_combinations: Number of channel combinations supported
+ * @channels: Discrete channels supported
  * @ch_combinations: Channel combinations supported
  * @modes: SDW mode supported
  * @max_async_buffer: Number of samples that this port can buffer in
  * asynchronous modes
+ * @port_encoding: Payload Channel Sample encoding schemes supported
  * @block_pack_mode: Type of block port mode supported
  * @read_only_wordlength: Read Only wordlength field in DPN_BlockCtrl1 register
- * @port_encoding: Payload Channel Sample encoding schemes supported
- * @audio_modes: Audio modes supported
+ * @simple_ch_prep_sm: If the port supports simplified channel prepare state
+ * machine
  */
 struct sdw_dpn_prop {
+	struct sdw_dpn_audio_mode *audio_modes;
 	u32 num;
 	u32 max_word;
 	u32 min_word;
@@ -325,21 +326,20 @@ struct sdw_dpn_prop {
 	u32 *words;
 	enum sdw_dpn_type type;
 	u32 max_grouping;
-	bool simple_ch_prep_sm;
 	u32 ch_prep_timeout;
 	u32 imp_def_interrupts;
 	u32 max_ch;
 	u32 min_ch;
 	u32 num_channels;
-	u32 *channels;
 	u32 num_ch_combinations;
+	u32 *channels;
 	u32 *ch_combinations;
 	u32 modes;
 	u32 max_async_buffer;
+	u32 port_encoding;
 	bool block_pack_mode;
 	bool read_only_wordlength;
-	u32 port_encoding;
-	struct sdw_dpn_audio_mode *audio_modes;
+	bool simple_ch_prep_sm;
 };
 
 /**
-- 
2.43.0


