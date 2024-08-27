Return-Path: <linux-kernel+bounces-303380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8694960B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B0BB23B05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FE1C3F29;
	Tue, 27 Aug 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfOLTOrG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4C1BD4F9;
	Tue, 27 Aug 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764093; cv=none; b=qoFT+PRsvKZZZzjduIHU8fuXqArtb3fSC6gBfm6pwGyAxHFz5XfhRqEkshWiGF2QcEx4HO5awNCSGTQTH49V7SMnuvUeyyRwqIKQ7ozdniLuFuVqrmfvKzwhH29aaKlEolLVZ0Dj3vQrk3UynlSyUNi/XrUtP14Xz9rI86uLVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764093; c=relaxed/simple;
	bh=EyzHfJ0GwyNdqWr9Tz+WnVWaVwBx3I8DtCHEK5IXV6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh0QxHBMEqPNacWKsUBwo/p1559fu7//mjFlMV36zPVpGgDjlQxpt9oA3PoVptJnI35lYOfmx/FSBURU5OhkGGNy137pu9EHMsumi+coY1rD2wJF2VY0YiriC2Wp5t8yk53hJ7Nw3mr4fUx7u7EFN/UriDXLmZLKKLHluVvL3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfOLTOrG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764092; x=1756300092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyzHfJ0GwyNdqWr9Tz+WnVWaVwBx3I8DtCHEK5IXV6E=;
  b=LfOLTOrGKN+0ABCs+w3uUb8s6DIHFVwWVAzum+XmVvZ79FFosJKGVaae
   0Cix2wwt/UgQQ0uq0qRCjwBVVkfYSEVxrHmyZwpWj/2Te95ohLVCQIsNp
   ltNguEM99gmVNMwxx8eO3x+gyNaCy7sAITqHUxkbHMASb1f/QdLQ/g6IF
   yQ5LHEpGtpyebJTKHZj6ZxMMpDB90GrIhZrH/4DDfHXAiDHEsObndjZjT
   EpnDi9sCqCE5PcRMvVTnnNEmFqY2bt4hW1TLlSttHmqcgnJyl7HgZHExk
   SsGKU9gBeu3eCInfN1f5nREF0HK7K5Q5Y3sTv+vrfXWn+226HQxe9l5rT
   w==;
X-CSE-ConnectionGUID: C93Sv6FiQ8mAFZdsaJ5CjA==
X-CSE-MsgGUID: vmdRw+7FSGSswi+8idocVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400585"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:12 -0700
X-CSE-ConnectionGUID: ZiMHk9YjTzaTlNFh1bJ96w==
X-CSE-MsgGUID: k4r5Cri1SQ253BnR4/XsEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551972"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:10 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 07/14] soundwire: optimize sdw_dpn_prop
Date: Tue, 27 Aug 2024 21:07:00 +0800
Message-ID: <20240827130707.298477-8-yung-chuan.liao@linux.intel.com>
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


