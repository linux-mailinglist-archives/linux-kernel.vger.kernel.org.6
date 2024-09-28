Return-Path: <linux-kernel+bounces-342316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93633988D86
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE211F2233A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802560B8A;
	Sat, 28 Sep 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTm0byvn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618238389
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489788; cv=none; b=LNltF+ij/lg7CBrEuifdKlX283700JsqzZV3IfUsRKZnOfLuxPbnkTJzHUN7/wsnji0lDYlmuwV9l77P7+mND6sPdjHkxlf/Qk1o7tS0Ep0/LgEB6tX3JZ4UJ+P/AXk1rF9Tmd7wBU+FAEEMWZolHPOgjMyVCNJvywiYZF1r004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489788; c=relaxed/simple;
	bh=QHKnkJGGdaPi/P8pWr1YVsvSRJmDf6+suHy+r3IyAYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckR6tnlGFiiPoZIUgzCMFcCYpEvgdPjEDXipQiTqZ+xlz1GAUDKiEAP/CqBKNt9RXA+T6SA++7IZkuT8CsirFya2D8k/8OTADDbWAEYWGYa9lW3jL7ntvE6zVXXIKCBYCDS/96RHwmSluF/N9b/8nJlwgyIWgbUJQJBnfD19aTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTm0byvn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489787; x=1759025787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHKnkJGGdaPi/P8pWr1YVsvSRJmDf6+suHy+r3IyAYQ=;
  b=HTm0byvnzXkP9HeJ92lpTpdGE2YxqttyZb5Xz4VFHy987RZgNL8Lt4h8
   Pxzqiygb/TQLYw2RknEj1qMzJX1wKyuXW8nALWffbEGx5Tkc+HYF9bG4B
   oG2Cn6Cxnr+RccZvyNBOiFafvhMhn+8yiRi+1fMe7B9rlXz0xaA4E8U5z
   ZU3PXrqSpMko+Y0gu8OayKOm0W0J/SteSfjIFRvxdQoclqXlyB7Jzcyvj
   KtLHeb3xTGRLPQ9Lo5SdNRaVz9Dq4jwQfEw1+P5Mm+Y0OwrThCYvXvSh6
   nbZrXBuYbLNFW8Ai+JUHhP7tg0pX3L3lDoReL4nOktd7kegc0Ww8SU9m9
   A==;
X-CSE-ConnectionGUID: Q/8KffVeRXiZNplaLzrckA==
X-CSE-MsgGUID: mtULPFWtSeCe88QxYczbJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526884"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:21 -0700
X-CSE-ConnectionGUID: NLInsGB0QhKm+ll4bJ7x3w==
X-CSE-MsgGUID: VaCbO+f5T0Sm7iNs63SZkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507123"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 4/8] mm: Provide a new count_objcg_events() API for batch event updates.
Date: Fri, 27 Sep 2024 19:16:16 -0700
Message-Id: <20240928021620.8369-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of zswap_store() swapping out large folios,
we need to efficiently update the objcg's memcg events once per
successfully stored folio. For instance, the 'ZSWPOUT' event needs
to be incremented by folio_nr_pages().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/memcontrol.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 15c2716f9aa3..f47fd00c5eea 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1778,6 +1778,21 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
+{
+	struct mem_cgroup *memcg;
+
+	if (!memcg_kmem_online())
+		return;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	count_memcg_events(memcg, idx, count);
+	rcu_read_unlock();
+}
+
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1834,6 +1849,11 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
-- 
2.27.0


