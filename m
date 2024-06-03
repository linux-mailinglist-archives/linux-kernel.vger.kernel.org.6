Return-Path: <linux-kernel+bounces-198683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D78D7C12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CB28134F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802773BBEC;
	Mon,  3 Jun 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFGC55yv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CC374EA;
	Mon,  3 Jun 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397968; cv=none; b=h+CGaWqptYIGgb5PQ5z+0w9vbLbmZCikXnjsxsIAVbhzsf5P7+lbP5Zgr+MiiK/li9CjxELx+6SD6EA+KTUyRbkEuRUMSAYqEc2b5PhDOJiKLD6gwm8hd42fgsiJW3kQ2FPfp2XS4IX+QtmRkGMlCGX7Q99uzEWTGfuV6Bfb+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397968; c=relaxed/simple;
	bh=90NECgAVgggLPKgXekyHV4CBwzeKxp8lybxOLkirRl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kC947e0W62pNAwbgulzJMKVFTe1G2vUdASzQE67yx5vj0MDD6XEUYCTn0pJMp7x1PWNDkVX4IyNY5/qW08r40TeDitMU855lWQZnslFMUOvbmMQdVCKg5qqcdcewTI41LAbrng8AW4QbkSlhTxzTbWJaL5jP2HWBCkjQdwHi+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFGC55yv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717397967; x=1748933967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90NECgAVgggLPKgXekyHV4CBwzeKxp8lybxOLkirRl8=;
  b=PFGC55yvXhEHrU2GQgsq0GSliFaYGLF+gnkHjx766kEqjlZ/22KadB0d
   MQY0lrCJ6+PCf+IkBPo0zS9lxp+/nzjAv8wpYo0cpPI24ufLB824j0MRG
   gv0pCKe9Xe/hsSO4lCIjb5Eo74au6Z1BLQXPKETVYUPUmredGtmfD63eg
   dsTTh0SjRzkRCO530nddnr4KDbdZ75qtFBrLmxSwy+2tkdLKR4otGGI1p
   NoSJImFLejzn8KmH0axEmkiPU+jgGZ88kRGysBjKYAglZj21j0QS+R+1C
   469xXzbFUV6SSsUfRtCbPGqQoQ0CxC2Tfel3DLUzpELMefdOsptLTXXcu
   A==;
X-CSE-ConnectionGUID: 11uh7IoxRzyfd3lGljTp1Q==
X-CSE-MsgGUID: YIG50wfWRwWSWN/UCXOxoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13717671"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13717671"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:59:27 -0700
X-CSE-ConnectionGUID: BnBdmcG8R+CuUpU2DEjFUQ==
X-CSE-MsgGUID: 5v4plu/4TgSzpjSeEE9BTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36792773"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:59:23 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND 2/2] soundwire: bus: add stream refcount
Date: Mon,  3 Jun 2024 14:58:41 +0800
Message-Id: <20240603065841.4860-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240603065841.4860-1-yung-chuan.liao@linux.intel.com>
References: <20240603065841.4860-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The notion of stream is by construction based on a multi-bus
capability, to allow for aggregation of Peripheral devices or
functions located on different segments. We currently count how many
master_rt contexts are used by a stream, but we don't have the dual
refcount of how many streams are allocated on a given bus. This
refcount will be useful to check if BTP/BRA streams can be allocated.

Note that the stream_refcount is modified in sdw_master_rt_alloc() and
sdw_master_rt_free() which are both called with the bus_lock mutex
held, so there's no need for refcount_ primitives for additional
protection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c    | 5 +++++
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 4e9e7d2a942d..7aa4900dcf31 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1181,6 +1181,8 @@ static struct sdw_master_runtime
 	m_rt->bus = bus;
 	m_rt->stream = stream;
 
+	bus->stream_refcount++;
+
 	return m_rt;
 }
 
@@ -1217,6 +1219,7 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
 			       struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
+	struct sdw_bus *bus = m_rt->bus;
 
 	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
 		sdw_slave_port_free(s_rt->slave, stream);
@@ -1226,6 +1229,8 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
 	list_del(&m_rt->stream_node);
 	list_del(&m_rt->bus_node);
 	kfree(m_rt);
+
+	bus->stream_refcount--;
 }
 
 /**
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 13e96d8b7423..94fc1b57c57b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -903,6 +903,7 @@ struct sdw_master_ops {
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
+ * @stream_refcount: number of streams currently using this bus
  */
 struct sdw_bus {
 	struct device *dev;
@@ -933,6 +934,7 @@ struct sdw_bus {
 	u32 bank_switch_timeout;
 	bool multi_link;
 	int hw_sync_min_links;
+	int stream_refcount;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.40.1


