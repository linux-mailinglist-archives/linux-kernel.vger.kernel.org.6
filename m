Return-Path: <linux-kernel+bounces-303375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489D960B50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA84F284314
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A621BF7FA;
	Tue, 27 Aug 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCWStOBy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1B1BDA86;
	Tue, 27 Aug 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764081; cv=none; b=S28EJxM4LJctoe3x4wS4qDA0qJLTqEyCiSfKv2gNev4wciu5EY1NZ50QAbJjBJ+xxzNcMKaKgXauFki7H9hp3+Ic5TuYSFZwlzZuMfm3NwZ3xNj6XwXwEt9qClhu+Cqfe/Nvn7IKWk3JuSd/GDee0wiw+gV27Gk8zsUf68Upghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764081; c=relaxed/simple;
	bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaPVcTNd6ornKo+cJbTU6qZPUL238HdFPQNp34iFYst3uhMc+hhOI+QsmjKnnYV2qXNrwnCA5b4XyELCr5o66SAGrXdv/o34Xria3ocdY4eWVjE/ajOifHzdc6B1U+drD9Bvue7ZEFBHomnUTdd61AECcvQCRBp0QKZgLHxC7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCWStOBy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764080; x=1756300080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNF7KxV5nkbzub+I8LNYCT9nsHBpi/XN8kK/Yk07yxo=;
  b=lCWStOBy7JXLh2bOkS/KrKp64U/poenhEkAV3V58VZJ2Tqt5enmHLWHL
   lo3ic3zBxS5dZhL0PTCoiTuWqhH5AsBFGYY4ix6I9xRGOl4ipaTLZ8Nhg
   IPyTB744gUmrN0lanqF8FWMGCFwIk7UeMcxZjH3Ry7/eU+E7IUzT03UzG
   22XutAG7wL9Y/6ZlQCPISYgQyocI62hnG6B9uThT9fqD3+I8bMD23nuui
   nUnHY6XBsYkmGos8RY7h4e9kNcjT2xiINKABH7PUbdFQRybP7Y3fHwQT9
   708nfVXWvJnoG6rW+Qf174j7ZYSdobGM/wa/yW2QmejF2FCZZv9o+A/DF
   w==;
X-CSE-ConnectionGUID: TEUB4LvQRymElUVk5mNn8Q==
X-CSE-MsgGUID: G10LkpmrRWebMnm0Jfly4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400513"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400513"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:07:59 -0700
X-CSE-ConnectionGUID: g686dQhJTiG7+rhUK7l4CQ==
X-CSE-MsgGUID: 7rnuVrJzTs+ASiCI9FErTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551945"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:07:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 02/14] soundwire: optimize sdw_stream_runtime memory layout
Date: Tue, 27 Aug 2024 21:06:55 +0800
Message-ID: <20240827130707.298477-3-yung-chuan.liao@linux.intel.com>
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


