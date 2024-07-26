Return-Path: <linux-kernel+bounces-263026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFCA93CFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EAAB23993
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426A13CA99;
	Fri, 26 Jul 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YJEP1rBF"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7036D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984052; cv=none; b=d3pSvFEN9n6FZ8Gw/sDOpJW819WjK/oAgamjaQFibpUXtYJ3KokJ6Qu6U3sbfNmn4xfZI3tjQ7oLxZk+3hG/5erXuwNsTr+BBZIPP1UAcpacilfGC6yUQrVvzZTYC4FJ/umFES6yHC7Sny29uxY9AyF0QYsX9+ubDyZU/6NORhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984052; c=relaxed/simple;
	bh=t6QuhYE/SSRR8xQo7N5Fh/penc48x+ovfqOLB5mzMIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYzTyEwKnJlwUCAC6mMEKNjVroHBZj/DdgYld0aRv2/oKTmnMB5QWXfnk+f0yy18DFG6KYAPADc0ZrChqZM54cTGXKAeMKxLOkl0CIhBPV8Mt9cs6qXpk3SCEreF6ZmgpAgszYLKVs1v2iKuaRJq8BGFi4E1QOmHnm6fTrhXmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YJEP1rBF; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721984049; x=1753520049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6QuhYE/SSRR8xQo7N5Fh/penc48x+ovfqOLB5mzMIE=;
  b=YJEP1rBFdkraTbPP2FGnVUFFdv4mvlnEOoUjZwQVf6bXhFBG0F4SWRJw
   d/B3PyoYkwtrTba+aL6/Gt3+lCYcQe0aXKfTB+ZrUAZphD1JBvcza0Wcn
   b5rPxBUw5rqDSg4d46TC1a/3tippMEixdeAG/M9JQzJMnEqUX2VPAxPiM
   1r2v14YVc3iw6HycV0mpoCNSya0Jy1+AYOXMRMg3J457BT3Kyi6wz/Sfr
   8ykkL+8xDLE83WAkPWsYJFGswXWLwje6wZkwQyfYKUgXO+vQLURHNbjDd
   JTWcIyQkRzbwm6JedXEsGc0xf7EzVnSMJeSGhOWT8/wmDTcaxEr3+CCY7
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="147526340"
X-IronPort-AV: E=Sophos;i="6.09,238,1716217200"; 
   d="scan'208";a="147526340"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 17:54:00 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id ECAB8C9196
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:45:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 35CA7D0AE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:45:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F1762008B3A6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:45:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D27D31A000B;
	Fri, 26 Jul 2024 16:45:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-kernel@vger.kernel.org,
	Yasunori Gotou <y-goto@fujitsu.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC] mm: Avoid triggering oom-killer during memory hot-remove operations
Date: Fri, 26 Jul 2024 16:44:56 +0800
Message-Id: <20240726084456.1309928-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28552.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28552.006
X-TMASE-Result: 10--3.086200-10.000000
X-TMASE-MatchedRID: 2R1RapUTXmo8g1fEYZ382xIRh9wkXSlFvhf/zJ92tsN9GT4ye9aN7g9l
	TAN4WxnxKuCh/pfd43i12HagvbwDji/7QU2czuUNA9lly13c/gGOVGny5q72hhFBDiQWqOMkoyu
	fjYs62v6OpJMltluhQ/PW5Zy7hnhRWcA4Y6culFZ/OBWacv+iVRLBqTl41fL7K6iPfafXtVijxY
	yRBa/qJShNCXvA0fw+A/nNPR3f3dzGVuWouVipcpfPZdpiFyjvE7jm0IggUvjijL8OSScfR6Ttp
	fvQitq6IgceRPDLi1UGFqMUnVlsWFS668seOAnWhAr0BLHZJbgLt6WET4w7+RFltGxCTkwFQHVA
	+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When a process is bound to a node that is being hot-removed, any memory
allocation attempts from that node should fail gracefully without
triggering the OOM-killer. However, the current behavior can cause the
oom-killer to be invoked, leading to the termination of processes on other
nodes, even when there is sufficient memory available in the system.

Prevent the oom-killer from being triggered by processes bound to a
node undergoing hot-remove operations. Instead, the allocation attempts
from the offlining node will simply fail, allowing the process to handle
the failure appropriately without causing disruption to the system.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/memory_hotplug.h |  6 ++++++
 mm/memory_hotplug.c            | 21 +++++++++++++++++++++
 mm/page_alloc.c                |  6 ++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7a9ff464608d..0ca804215e11 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -332,6 +332,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
+bool is_offlining_node(nodemask_t nodes);
 
 #else
 static inline void try_offline_node(int nid) {}
@@ -348,6 +349,11 @@ static inline int remove_memory(u64 start, u64 size)
 }
 
 static inline void __remove_memory(u64 start, u64 size) {}
+
+static inline bool is_offlining_node(nodemask_t nodes)
+{
+	return false;
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..da3982751ba9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1938,6 +1938,22 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
+static nodemask_t offlining_node = NODE_MASK_NONE;
+
+bool is_offlining_node(nodemask_t nodes)
+{
+	return nodes_equal(offlining_node, nodes);
+}
+
+static void offline_pages_start(int node)
+{
+	node_set(node, offlining_node);
+}
+
+static void offline_pages_end(void)
+{
+	offlining_node = NODE_MASK_NONE;
+}
 /*
  * Must be called with mem_hotplug_lock in write mode.
  */
@@ -1991,6 +2007,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		goto failed_removal;
 	}
 
+	offline_pages_start(node);
 	/*
 	 * Disable pcplists so that page isolation cannot race with freeing
 	 * in a way that pages from isolated pageblock are left on pcplists.
@@ -2107,6 +2124,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	memory_notify(MEM_OFFLINE, &arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
+	offline_pages_end();
+
 	return 0;
 
 failed_removal_isolated:
@@ -2121,6 +2140,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
 		 reason);
+
+	offline_pages_end();
 	return ret;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1780df31d5f5..acdab6b114a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3563,6 +3563,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto out;
 
+	/* hot-remove is on-going, it generally fails to allocate memory from
+	 * the being removed memory node. Leave it alone.
+	 */
+	if (is_offlining_node(*ac->nodemask))
+		goto out;
+
 	/* Coredumps can quickly deplete all memory reserves */
 	if (current->flags & PF_DUMPCORE)
 		goto out;
-- 
2.29.2


