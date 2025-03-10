Return-Path: <linux-kernel+bounces-554859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11DA5A206
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0D31884B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1BE236A98;
	Mon, 10 Mar 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGc46SA6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9F23535D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630535; cv=none; b=ZVMGtMt7GgOzi1/uo8ujFre1Vp0a3h4pTpU3jiEL8lSgElAtcRFkl2XlUuyBnFmHdOipemiy0bugHV9Ie5pvGzO4gJdVE1LS590HOzFDJBTUmMGgYCaY558jp9vRJ+rDotfdnXZJE/hkSQEMIXYrApnigVdGxHOVRACKM4U8ZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630535; c=relaxed/simple;
	bh=zd3HVt4gmQGJ6ya5t30XZ+4HKvIEROPsmUqgYh5jM1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6qFjoXOSgS9432Bqwjii5NVYEwTHfdpvL3iSOEESpkuG1m+LA2XBMgAhTvuovlHZHyOsUsu/Tv8AB6jbMs1+SFPj39BFGgCEBNRbm/Tx5KF9u91n2XQhrXLUpLlqU85M7RwG9jjBMzzaYjF4xoBqFTzZu8sOCgPBZkmuwP40VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGc46SA6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741630534; x=1773166534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zd3HVt4gmQGJ6ya5t30XZ+4HKvIEROPsmUqgYh5jM1U=;
  b=XGc46SA60MraDxgVWB0pmc9hxvoiGgCtE4FfahOMZn3vetN+o72ujqLL
   7Nbu9xmvaUnQ2FHvznJxx5RWBZ56kJbG8fbaotDHrHiyQSmWZzyqhcFfl
   hpF4vx5246WqmttesrxrW4UVwFs0fa1UQRkRUEbBSJ4ihxsPRIh/RNqfa
   YTQ58Xb1Ln+eMHBDWbS04JuFIs15F5MGGxzLS0P8T2FVakpbVuh/VYEjU
   +ZO25Bnk84u9ed/mLgXx/2uRq4s4aCq7hQqYNyGMJgnhiH3Z5ZgiXj4eX
   0GD5rb40MIzDkwdAoxmk5Waf2RdtVU4OfodhqmtKYzMTQ5E1ZNGpH5HWZ
   A==;
X-CSE-ConnectionGUID: 1YjdQFYZQ9+4H8jEQP/boQ==
X-CSE-MsgGUID: 1v32ghbXSDWZuk/lTArpoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42773682"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42773682"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:15:26 -0700
X-CSE-ConnectionGUID: OTQ5e9m8SQ2dXsyjQ9Ew+w==
X-CSE-MsgGUID: LxHudLJAQpKhtYGxe9G/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150865639"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 10 Mar 2025 11:15:25 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf: Extend per event callchain limit to branch stack
Date: Mon, 10 Mar 2025 11:15:36 -0700
Message-Id: <20250310181536.3645382-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The commit 97c79a38cd45 ("perf core: Per event callchain limit")
introduced a per-event term to allow finer tuning of the depth of
callchains to save space.

It should be applied to the branch stack as well. For example, autoFDO
collections require maximum LBR entries. In the meantime, other
system-wide LBR users may only be interested in the latest a few number
of LBRs. A per-event LBR depth would save the perf output buffer.

The patch simply drops the uninterested branches, but HW still collects
the maximum branches. There may be a model-specific optimization that
can reduce the HW depth for some cases to reduce the overhead further.
But it isn't included in the patch set. Because it's not useful for all
cases. For example, ARCH LBR can utilize the PEBS and XSAVE to collect
LBRs. The depth should have less impact on the collecting overhead.
The model-specific optimization may be implemented later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      | 3 +++
 include/uapi/linux/perf_event.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 24f2eba200ac..bca1dfd30276 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1347,6 +1347,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
+
+	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
+
 	size += brs->nr * sizeof(struct perf_branch_entry);
 
 	/*
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0524d541d4e3..5fc753c23734 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -385,6 +385,8 @@ enum perf_event_read_format {
  *
  * @sample_max_stack: Max number of frame pointers in a callchain,
  *		      should be < /proc/sys/kernel/perf_event_max_stack
+ *		      Max number of entries of branch stack
+ *		      should be < hardware limit
  */
 struct perf_event_attr {
 
-- 
2.38.1


