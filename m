Return-Path: <linux-kernel+bounces-324820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99607975153
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A62866D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E9192D78;
	Wed, 11 Sep 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mlag4Mqz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087D18FC9D;
	Wed, 11 Sep 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055948; cv=none; b=WNhxVvA+aTTtsCns+NFgfV5jJFygTJMkPiQkMVX+zHJv5YWLxxJu77ia36e9Lx/og3WopwotOdYH3LPjMWvbeWdGwUzK/xSOgdcyaFRtTxU5owF9t4zX2MTINIsDl5VxSK/27NrhSK0nk3ZZ0eIkW8VLIm0Pq+qHx/mnVpdGJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055948; c=relaxed/simple;
	bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2EizPLgp4n4DeTzbZemNLJE32Om2gh8Dl/X3VuU7rWu4rWvdihkv1/heNbgYmQRBJhRWPcvhWRly6wl7j9r6/UGxlkPuyk+ROWxBfTQsK9iQFb2j3DmMf2eubCRf16S+TlSV8fldAhYMWHAJlZHs4IOyzotyYAbMJRfohYG10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mlag4Mqz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055947; x=1757591947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
  b=Mlag4Mqz/+YbQ6aMOoYftbDmXvx8nZBYBMpwTXKeT1E2Jx0oetjnMViF
   qkkiocpbppsaw427TS+paNvxDWyULApQCnRZkioH10HcJi11vNE6x6oPb
   xeg1Pu5C0wSQ1P7fV8dIYJv2KcfqbOvvOX3jhLjjckJ8aT4aG5iq88Nng
   V1Imwn214iNgJgUZgx912/k/OOYRhxtGx7KcrQz0uG4eNM2hM0Uxmb7QW
   iNLnOF+X8EaLHtRxKEcF2TARrQ6OAQIxYtW/97BcwQXJOIGpbAljBvMZC
   f+l2/DqRUfKpzerDvGBrVn05dxEafkKKD/Nu5IW5QF1ZuhNl6C0kiEsQC
   g==;
X-CSE-ConnectionGUID: xVHY9x86RemUYn22x99Rtg==
X-CSE-MsgGUID: gwora+6ETGWKvzcL+xejLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417217"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417217"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:06 -0700
X-CSE-ConnectionGUID: OQQFkxAFTFiYwKVw7Amuqw==
X-CSE-MsgGUID: sM87YRf6SSqfnNQQM+ooyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292726"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:04 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 02/14] soundwire: optimize sdw_stream_runtime memory layout
Date: Wed, 11 Sep 2024 19:58:15 +0800
Message-ID: <20240911115827.233171-3-yung-chuan.liao@linux.intel.com>
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


