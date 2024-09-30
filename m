Return-Path: <linux-kernel+bounces-344915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A698AFAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9FE1F228CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61B188CDB;
	Mon, 30 Sep 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1G+C+gV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856B188904
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734348; cv=none; b=lg/KNezue3Hj6emoRc5ZAlobeEfHVrgfFxRJZEtzDQ6XT1YkB/GLVcxdw0v8HV60k/TZD06eVUeLmXHOIp2nO7D9mA82n0TjJbmbF/Xv0hlmjvOKSLXIP8lz8f0UDuZC+j8zA8m9t32VlSt6jUgkPFdqF7+Uhh8+yvzO/xg+8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734348; c=relaxed/simple;
	bh=sH8cQ3w+IHRFjDbPI6y+/ZvrGGUAI7tDyoePLrfKV9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKBndc6P2+pwOx2duQgHuEGY4plQ58ns+aNuwzKBKbxc/PnS9W2TEfDb3iFOTeFHJgFagpnaooJ49HHxIB+bRTwimj2xCSKwLGrmyObIIIF/kncTSa7PZaQOrjz5LlmwOaFdQq7tGmB+4oAyNcw04knZSOg9BACzfyzAaVwSbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1G+C+gV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734348; x=1759270348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sH8cQ3w+IHRFjDbPI6y+/ZvrGGUAI7tDyoePLrfKV9c=;
  b=h1G+C+gVod1avA5DC368myABjj2cfpxAs0yqymR4Y8AWdVCN3d1cfTDt
   pydCUkUpFQHuBjU3yQgyJdZftFpvQ2cNbYBwwh8KXOYUt7L7MEx8cfDIY
   kNn+xciSgdm3HOi5IiIAE9JzNoG0oUlz62FQLy0952ZuWUvHYLdSq+Lfz
   +d0o0jOUHkTS27xir9+TluwP98mdv/Gf9N97R9eiM76/k+6sXJuwW3gn6
   2s/CjiZkrf4/VO0N5mlWLAJJgVQIHNiP3A2fMdj4GUJ6DZxWBweeQvAXC
   gCATrK2UmzcTTZ0z3MB+oANHspxK+iyPnRn52Gr47TZoB+XuBH9qA9QDd
   g==;
X-CSE-ConnectionGUID: zTwBA1LwRk6KwZjZr6OYTQ==
X-CSE-MsgGUID: n3OquqyIRzKwOYZ+ZyoVXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368427"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:24 -0700
X-CSE-ConnectionGUID: JiNA1XIES2mHOMYswCZ+/w==
X-CSE-MsgGUID: RS1ODkyVTHartxBgNoU0aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985586"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:23 -0700
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
Subject: [PATCH v9 4/7] mm: Change count_objcg_event() to count_objcg_events() for batch event updates.
Date: Mon, 30 Sep 2024 15:12:18 -0700
Message-Id: <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
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


