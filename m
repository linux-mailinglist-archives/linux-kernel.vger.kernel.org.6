Return-Path: <linux-kernel+bounces-348650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6298EA14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610921C222C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915512C473;
	Thu,  3 Oct 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcOuAmUg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A1126C09;
	Thu,  3 Oct 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939248; cv=none; b=kKtC2Z+tq7jpiyhSJOhWv7NTYzpOF/il5ZeM5D7B1UFzWoXSXoWMVEVOhXOjJea7V1/68Md1RCwK7pDwrLxEYIt/ghU2WtFy0EyBkpNG7pnY3D6EuMH1d1/l1ZDOHggkpNJZGd/Zk70w778HHDVa+ISrEjINmqrYCE1fcY1NDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939248; c=relaxed/simple;
	bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRF88DR48Fhl6walFg4YwYnBQi/YMgemJmf4kQwlmMckUO0BLBLANQxOyKXrGm6ATjjRoWIe/2bDbKPKQVwgf6jxpB5avXPdBzjVUB1SAhfAjyvA1i4XxYDf1aYy1dWjSqDQ4by/YV/YcaZSFPdV92owqmgyxg+264UUb1mzAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcOuAmUg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939247; x=1759475247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
  b=CcOuAmUg52wn1C+gVCh0q8uC8B+qGq2lTD2kW0M/Mtb2eQ+8oTlAVzR0
   daG8kY+ACBBxh7FnQwl/byP8svO16fAd3IBJPXj/Zz9EOkN0hp2/FunXJ
   F2vriiBCvc2hCTegwzzfX0iY44EpTUT0mBCeMq3pi8sq9rapTXbg7m+8y
   DClnDKgS96pLta5axeRZN8v54i/pWJusVVsBscq8LR5+3Dii+QyZyoycR
   EFML6H6DPCx9d3OSW6F0oA6tREhAJ7TPNsLc4sBPePyfIqts6gGedIRjq
   9u3nSMjFWgEZLo5gq63EQcFyuwKQIlCYsEfqfBzQNsuEhMfyXX5NbWr2n
   A==;
X-CSE-ConnectionGUID: 2Q9ojnVHR6ON3MNIkSQQQw==
X-CSE-MsgGUID: /5pPEazsROScAjVJ1u1CJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070728"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070728"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:27 -0700
X-CSE-ConnectionGUID: Fl74/teRRj+g3xQp98nJ7Q==
X-CSE-MsgGUID: DAkDtubHSOO27KVM5fX7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508386"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:24 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 02/14] soundwire: optimize sdw_stream_runtime memory layout
Date: Thu,  3 Oct 2024 15:06:38 +0800
Message-ID: <20241003070650.62787-3-yung-chuan.liao@linux.intel.com>
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

pahole suggestion: swap position of 'm_rt_count'

before: pahole -C sdw_stream_runtime drivers/soundwire/soundwire-bus.ko
struct sdw_stream_runtime {
	const char  *              name;                 /*     0     8 */
	struct sdw_stream_params   params;               /*     8    12 */
	enum sdw_stream_state      state;                /*    20     4 */
	enum sdw_stream_type       type;                 /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           master_list;          /*    32    16 */
	int                        m_rt_count;           /*    48     4 */

	/* size: 56, cachelines: 1, members: 6 */
	/* sum members: 48, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* last cacheline: 56 bytes */
};

after: pahole --reorganize -C sdw_stream_runtime drivers/soundwire/soundwire-bus.ko
struct sdw_stream_runtime {
	const char  *              name;                 /*     0     8 */
	struct sdw_stream_params   params;               /*     8    12 */
	enum sdw_stream_state      state;                /*    20     4 */
	enum sdw_stream_type       type;                 /*    24     4 */
	int                        m_rt_count;           /*    28     4 */
	struct list_head           master_list;          /*    32    16 */

	/* size: 48, cachelines: 1, members: 6 */
	/* last cacheline: 48 bytes */
};   /* saved 8 bytes! */

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 5e0dd47a0412..a4fa45132030 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -820,15 +820,15 @@ struct sdw_master_port_ops {
 struct sdw_msg;
 
 /**
- * struct sdw_defer - SDW deffered message
- * @length: message length
+ * struct sdw_defer - SDW deferred message
  * @complete: message completion
  * @msg: SDW message
+ * @length: message length
  */
 struct sdw_defer {
+	struct sdw_msg *msg;
 	int length;
 	struct completion complete;
-	struct sdw_msg *msg;
 };
 
 /**
@@ -1010,18 +1010,18 @@ struct sdw_stream_params {
  * @params: Stream parameters
  * @state: Current state of the stream
  * @type: Stream type PCM or PDM
+ * @m_rt_count: Count of Master runtime(s) in this stream
  * @master_list: List of Master runtime(s) in this stream.
  * master_list can contain only one m_rt per Master instance
  * for a stream
- * @m_rt_count: Count of Master runtime(s) in this stream
  */
 struct sdw_stream_runtime {
 	const char *name;
 	struct sdw_stream_params params;
 	enum sdw_stream_state state;
 	enum sdw_stream_type type;
-	struct list_head master_list;
 	int m_rt_count;
+	struct list_head master_list;
 };
 
 struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
-- 
2.43.0


