Return-Path: <linux-kernel+bounces-345255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D61C98B3B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5909B1C210CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCAE1BC065;
	Tue,  1 Oct 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjkEP2gv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C291BB6BF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761031; cv=none; b=HwWDuA9GyDbr5vVCkGlstWyaZsu+8Fwp41yYe7In+RvVfymj+84+Iw3TN/mCjfcHqN/znrGmxQ1X2O+jB09CTzy/LHHtuss9dV5qPlzE0UK93yWE3ODEKUsXOtvDZRgOgrRgj3st22AuC+VKdc15MtDtdvslNTETW+o4gdljVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761031; c=relaxed/simple;
	bh=lB+hvyf3yxepm5Kmd6XwZLQVvnN7/oVBqCxfq4eIzGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsgd2Fr25a5B9/hDbhN47XVJv7nWBq+WyqMfkp0d96VoPX2TSjpCO/pvQKnQFz9r2TmVMFgGkeAbUPpGOdHoXuEO1cLqWVZK6eeCy1LVvYpyGAqwp/Zz1lDMeNkpTBGTAZecX9SrkGcC75gPdXDdQMU7+NOUFFxq6kZUafNY7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjkEP2gv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761030; x=1759297030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lB+hvyf3yxepm5Kmd6XwZLQVvnN7/oVBqCxfq4eIzGU=;
  b=YjkEP2gvbNTPZZMJBJGZgXVgzTu5b4GyYSwBJJmumeUYA88EWEfJ7qNv
   5BSVXNbn78D0hT4HRxOi+w6vKrO9q76nkyBbAbD0ruFMn11kqP8bvZuFb
   b13WAZ57TKPqXnpJwwO77gdFMlm2P95x75+89Ovhb17fsilash+RTRR/1
   /XHtFp42zajeL6EEmnP7cr4TDfNq9ix9HupwR3Pj+A5F7sXJNgwkg2Jp+
   JaA326zxupv7ZQ8QqXoityeNCLxybUL2Ud6dIDiYU3V5LBFnOg8yh8SiE
   REyAOO0W0ZpqVIPG0xcu1ACRFykYk++t2uX1eydRiIgY3TwmIW4ps5Rb1
   w==;
X-CSE-ConnectionGUID: k8QomehVSZCltBO6DX9u6Q==
X-CSE-MsgGUID: ck6UqRWFSGuaGlhOcnZBNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465103"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:25 -0700
X-CSE-ConnectionGUID: PKBxrDh5Qx2Gv53SQPU5uQ==
X-CSE-MsgGUID: wtC/7FAEQlSZaTIPojmcow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205804"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:25 -0700
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
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v10 4/7] mm: Change count_objcg_event() to count_objcg_events() for batch event updates.
Date: Mon, 30 Sep 2024 22:32:19 -0700
Message-Id: <20241001053222.6944-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
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

To facilitate this, the existing count_objcg_event() API is modified
to be count_objcg_events() that additionally accepts a count parameter.
The only existing calls to count_objcg_event() are in zswap.c - these
have been modified to call count_objcg_events() with a count of 1.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 12 +++++++-----
 mm/zswap.c                 |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 15c2716f9aa3..524006313b0d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1764,8 +1764,9 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
 
-static inline void count_objcg_event(struct obj_cgroup *objcg,
-				     enum vm_event_item idx)
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
 {
 	struct mem_cgroup *memcg;
 
@@ -1774,7 +1775,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	count_memcg_events(memcg, idx, 1);
+	count_memcg_events(memcg, idx, count);
 	rcu_read_unlock();
 }
 
@@ -1829,8 +1830,9 @@ static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 	return NULL;
 }
 
-static inline void count_objcg_event(struct obj_cgroup *objcg,
-				     enum vm_event_item idx)
+static inline void count_objcg_events(struct obj_cgroup *objcg,
+				      enum vm_event_item idx,
+				      unsigned long count)
 {
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 0f281e50a034..69b9c025fd47 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1053,7 +1053,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPWB);
+		count_objcg_events(entry->objcg, ZSWPWB, 1);
 
 	zswap_entry_free(entry);
 
@@ -1482,7 +1482,7 @@ bool zswap_store(struct folio *folio)
 
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
-		count_objcg_event(objcg, ZSWPOUT);
+		count_objcg_events(objcg, ZSWPOUT, 1);
 	}
 
 	/*
@@ -1576,7 +1576,7 @@ bool zswap_load(struct folio *folio)
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPIN);
+		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
 	if (swapcache) {
 		zswap_entry_free(entry);
-- 
2.27.0


