Return-Path: <linux-kernel+bounces-428326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B979E0CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F39283BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4AE1DED68;
	Mon,  2 Dec 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2XaXB04"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397001DE3BE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170871; cv=none; b=BSdzQ9Ub93o76LygPk8L2m6naiWNHPi3cmIifv1bNrgm3qccxXKhM1rxfRDgrlZ/ClJ8UwStrPZGBRBllormg4VdQY/EMx53ZLw0w2KX6pl+dlT15Y3wYE+OjxOEMRud+5Q+JI2FtpOrliW9DBbruD2AhlZ7EyfbFppxdbgQZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170871; c=relaxed/simple;
	bh=dAEln+wM2Y0tUS8n6EhKMG2D60a669n4yTpzPk8PVfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=II/3T4WEHhMgD6aSl3WvwMAQe+KTZtdoJLDZTyOcVy0+KJp/fUJGuGphGGvF2nk8VE4AvjbiBq1OzF4WX1Q3j9OvUmNOhXYXhhDdKbVaMqW4AgQHvWlVa/ulPHnFtjQb2z0n7hQV5+RqmYnl6daNNaIzwvPW8B9Df6I8glKoEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2XaXB04; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7250efecda0so4070559b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733170868; x=1733775668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/n0P7whLMi0XzEQM186r4DNbWC5OCPNUVjgL0U00tb0=;
        b=i2XaXB04gqn3vhL3Tvbzg2Liszy4NZn63pJ4tTlM3PXA+j6nOzD52ZB/cUOTTHVPWe
         itwdx/fEBaMKNtT11+5mhVV0rxN/AMJg4JkqmFgBRt5RpiRjgKQK+Vy0Miz0KF5PWXQL
         zNX9Z5+OySvIiNAteoVe2lja5G2YGXIRSEfjcQpBlr346LSzRlXNyVyyO6hdlnz/sUMJ
         mjS7AcbEO5Mr1VSUyoa4Q0tyD12ILB9u+tyMeAvVZehJEjmCCPn3tkk+qKbMtLymS2xk
         UxcP0qrrbMhquBczASrGkMQKzYhqv8mMExSQw2+Qqif8RpTzHcDftv9/kZa+TfXRcT4X
         10Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170868; x=1733775668;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/n0P7whLMi0XzEQM186r4DNbWC5OCPNUVjgL0U00tb0=;
        b=g32gxpVLHyoVvgeJjgqnBYV1PcpZsfxLy2PEskHAYwrNXX7nezSRa1btZu+ehm/+2m
         Y6vxSVIRmi/+f7QJlcEXWSHGBSNyhBFCMchwL8Mxb08f/ERr33pt8zfeMXOSzJxf58LY
         lKsUvFceieDotthJ3MrDdzWdhsqb37oZ2L0BIZLw914ZWdIc6A9dxPYBN2cOTkXsoh4a
         UCBF5G1GLcCVrKACYxtngt5/n8AGEo9toDFGoM8CegWIQBjVYdLi0A2hPxeXst4bysX7
         aYbzNoq+xA5l9Ignrzzsko5t4jRd0REowZNjUBofTw9IS1HAgy3jIkqu5Q06brpqyg5h
         fvHA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFLEZ9MIXwIyHqbcpONhtvwOZicVpNvFJAnwMyA7taUC/1ZaU2yaRfycg5A26JxD+iSn9AdPsqS27c5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZohZFLduV9RnX4F0QBjSabkwPPokt92uHgkqUqUNTeNM1Urh
	JIjTSiR9wFsyS7pg/npUrwAlh6aaJGXaXXw+OPSv8daEjDUJLhifQspNv9JyrIJ7eoiDmA==
X-Google-Smtp-Source: AGHT+IEUvT80GSquGtteZFhRp8ruF/z2nOJ6T66ZJnCBVJsHjTbZhKDi0Dyyhzwei7iwB2FZcV/I3enx
X-Received: from pfba2.prod.google.com ([2002:a05:6a00:ac02:b0:724:e773:436d])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1793:b0:724:edc5:4726
 with SMTP id d2e1a72fcca58-7253004dee1mr32562729b3a.13.1733170868409; Mon, 02
 Dec 2024 12:21:08 -0800 (PST)
Date: Mon,  2 Dec 2024 20:20:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202202058.3249628-1-fvdl@google.com>
Subject: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
From: Frank van der Linden <fvdl@google.com>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Fresh hugetlb pages are zeroed out when they are faulted in,
just like with all other page types. This can take up a good
amount of time for larger page sizes (e.g. around 40
milliseconds for a 1G page on a recent AMD-based system).

This normally isn't a problem, since hugetlb pages are typically
mapped by the application for a long time, and the initial
delay when touching them isn't much of an issue.

However, there are some use cases where a large number of hugetlb
pages are touched when an application (such as a VM backed by these
pages) starts. For 256 1G pages and 40ms per page, this would take
10 seconds, a noticeable delay.

To make the above scenario faster, optionally pre-zero hugetlb
pages. This is done by a kthread for each hstate/node combination
that is eligible for pre-zeroing.

If there are pages to be pre-zeroed, the kthread starts at the tail
of the per-node free list, and zeroes out pages, walking the list
backwards until done. To make this logic work, new allocations
are always taken from the head, and freed pages are added to the tail.
After a page has been pre-zeroed, it is moved to the head of the list.

The kthread runs on init, and is also woken up when a page is put
back on the free list.

A thread that allocates a hugetlb page can examine the prezero
flag to see whether it's been zeroed out already. If this is
not set, it must do so itself, as before.

For the rare corner where the kthread is busy zeroing out the only
page available on the freelist, the caller must wait, which is done
via a per-hstate wait queue.

Prezeroing can be switched on or off per hugetlb page size (hstate)
by a sysfs value, /sys/kernel/mm/hugepages/hugepage-XXX/prezero_enabled
If this is set to 0 (default), no pre-zeroing is done. If
it's set to 1, all hugetlb pages of that size are pre-zeroed.

A new sysfs value, free_huge_pages_zero, tracks the number of
free prezeroed pages per hstate.

Some test results: a simple test with a loop that maps new
hugetlb pages and touches them, run on an AMD Milan system,
touching 512 1G pages. It records the time in microseconds
that a new touch (fault) takes, and the number of hits,
misses and waits.

Without prezeroing		With prezeroing

total time 20253322us		total time 760us
average    39557us		average    1us
min        38199us		min        0us
max        41347us		max        10us
prezero hits   0		prezero hits   512
prezero misses 512		prezero misses 0
prezero waits  0		prezero waits  0

Repeating the loop 16 times, meaning the background zeroing is not yet
complete when the loop restarts (so the worst case scenario for
prezeroing with these parameters):

Without prezeroing 		With prezeroing

total time 321927564us		total time 111980668us
average    39297us		average    13669us
min        38174us		min        0us
max        41935us		max        41876us
prezero hits   0		prezero hits   5299
prezero misses 8192		prezero misses 2877
prezero waits  0		prezero waits  16

So, even in this scenario, the average fault time is still quite
a bit faster, and the maximum fault time is never bigger than
without prezeroing.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 fs/hugetlbfs/inode.c    |   3 +-
 include/linux/hugetlb.h |  44 +++++
 mm/hugetlb.c            | 374 +++++++++++++++++++++++++++++++++++++++-
 mm/memory_hotplug.c     |   2 +
 4 files changed, 413 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5cf327337e22..7a6749959372 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -893,8 +893,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			error = PTR_ERR(folio);
 			goto out;
 		}
-		folio_zero_user(folio, ALIGN_DOWN(addr, hpage_size));
-		__folio_mark_uptodate(folio);
+		clear_hugetlb_folio(folio, addr);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4697539b665..31d56190a4fb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -586,6 +586,17 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
  * HPG_raw_hwp_unreliable - Set when the hugetlb page has a hwpoison sub-page
  *     that is not tracked by raw_hwp_page list.
+ * HPG_pre_zeroed - page was pre-zeroed, clear_huge_page not needed.
+ *	Synchronization: hugetlb_lock held when set by pre-zero kthread.
+ *	Only valid to read outside hugetlb_lock once the page is off
+ *	the freelist, and HPG_zero_busy is clear. Always cleared when a
+ *	page is put (back) on the freelist.
+ * HPG_zero_busy - page is being zeroed by the pre-zero kthread.
+ *	Synchronization: set and cleared by the pre-zero kthread with
+ *	hugetlb_lock held. Access by others is read-only. Once the page
+ *	is off the freelist, this can only change from set -> clear,
+ *	which the new page owner must wait for. Always cleared
+ *	when a page is put (back) on the freelist.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
@@ -594,6 +605,8 @@ enum hugetlb_page_flags {
 	HPG_freed,
 	HPG_vmemmap_optimized,
 	HPG_raw_hwp_unreliable,
+	HPG_pre_zeroed,
+	HPG_zero_busy,
 	__NR_HPAGEFLAGS,
 };
 
@@ -653,6 +666,8 @@ HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
+HPAGEFLAG(PreZeroed, pre_zeroed)
+HPAGEFLAG(ZeroBusy, zero_busy)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -678,6 +693,19 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+
+	unsigned long free_huge_pages_zero;
+	unsigned int free_huge_pages_zero_node[MAX_NUMNODES];
+
+	/* Wait queue for the prezero thread */
+	wait_queue_head_t hzerod_wait[MAX_NUMNODES];
+	/* Queue to wait for a hugetlb folio that is being prezeroed */
+	wait_queue_head_t dqzero_wait[MAX_NUMNODES];
+	/* Prezero threads (one per node) */
+	struct task_struct *hzerod[MAX_NUMNODES];
+
+	bool prezero_enabled;
+
 	char name[HSTATE_NAME_LEN];
 };
 
@@ -699,6 +727,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
+void clear_hugetlb_folio(struct folio *folio, unsigned long address);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
@@ -1035,6 +1064,9 @@ void hugetlb_unregister_node(struct node *node);
  */
 bool is_raw_hwpoison_page_in_hugepage(struct page *page);
 
+void khzerod_run(int nid);
+void khzerod_stop(int nid);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1239,6 +1271,18 @@ static inline bool hugetlbfs_pagecache_present(
 {
 	return false;
 }
+
+static inline void khzerod_run(int nid)
+{
+}
+
+static inline void khzerod_stop(int nid)
+{
+}
+
+static inline void clear_hugetlb_folio(struct folio *folio, unsigned long address)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..0c9a80851bf5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -44,6 +44,8 @@
 #include <linux/io.h>
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
+#include <linux/memcontrol.h>
+#include <linux/memory_hotplug.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
 #include "internal.h"
@@ -68,6 +70,20 @@ static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
 static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
+static void khzerod_wakeup_node(struct hstate *h, int nid);
+static void hpage_wait_zerobusy(struct hstate *h, struct folio *folio);
+static void khzerod_run_all(void);
+static void khzerod_run_hstate(struct hstate *h);
+
+/*
+ * Mutex to protect prezero kthread stopping / starting.
+ * This is really per <hstate,nid> tuple, but since this
+ * only happens when prezeroing is enabled/disabled via
+ * sysfs (rarely), a mutex per <hstate,nid> would be
+ * overkill.
+ */
+static DEFINE_MUTEX(prezero_chg_lock);
+
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
@@ -1309,6 +1325,16 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+/*
+ * Clear flags for either a fresh page or one that is being
+ * added to the free list.
+ */
+static inline void prep_clear_prezero(struct folio *folio)
+{
+	folio_clear_hugetlb_pre_zeroed(folio);
+	folio_clear_hugetlb_zero_busy(folio);
+}
+
 static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	int nid = folio_nid(folio);
@@ -1316,14 +1342,16 @@ static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 
-	list_move(&folio->lru, &h->hugepage_freelists[nid]);
+	list_move_tail(&folio->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	prep_clear_prezero(folio);
 	folio_set_hugetlb_freed(folio);
+	khzerod_wakeup_node(h, nid);
 }
 
-static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
-								int nid)
+static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h, int nid,
+		gfp_t gfp_mask)
 {
 	struct folio *folio;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
@@ -1333,6 +1361,16 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 		if (pin && !folio_is_longterm_pinnable(folio))
 			continue;
 
+		/*
+		 * This shouldn't happen, as hugetlb pages are never allocated
+		 * with GFP_ATOMIC. But be paranoid and check for it, as
+		 * a zero_busy page might cause a sleep later in
+		 * hpage_wait_zerobusy().
+		 */
+		if (WARN_ON_ONCE(folio_test_hugetlb_zero_busy(folio) &&
+					!gfpflags_allow_blocking(gfp_mask)))
+			continue;
+
 		if (folio_test_hwpoison(folio))
 			continue;
 
@@ -1341,6 +1379,12 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
+		if (folio_test_hugetlb_pre_zeroed(folio) ||
+		    folio_test_hugetlb_zero_busy(folio)) {
+			h->free_huge_pages_zero_node[nid]--;
+			h->free_huge_pages_zero--;
+		}
+
 		return folio;
 	}
 
@@ -1377,7 +1421,7 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 			continue;
 		node = zone_to_nid(zone);
 
-		folio = dequeue_hugetlb_folio_node_exact(h, node);
+		folio = dequeue_hugetlb_folio_node_exact(h, node, gfp_mask);
 		if (folio)
 			return folio;
 	}
@@ -1605,6 +1649,17 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
+		folio_clear_hugetlb_freed(folio);
+	}
+	/*
+	 * Adjust the zero page counters now. Note that
+	 * if a page is currently being zeroed, that
+	 * will be waited for in update_and_free_page()
+	 */
+	if (folio_test_hugetlb_pre_zeroed(folio) ||
+	    folio_test_hugetlb_zero_busy(folio)) {
+		h->free_huge_pages_zero--;
+		h->free_huge_pages_zero_node[nid]--;
 	}
 	if (adjust_surplus) {
 		h->surplus_huge_pages--;
@@ -1658,6 +1713,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
 
+	VM_BUG_ON_FOLIO(folio_test_hugetlb_zero_busy(folio), folio);
+
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
@@ -1743,6 +1800,7 @@ static void free_hpage_workfn(struct work_struct *work)
 		 */
 		h = size_to_hstate(folio_size(folio));
 
+		hpage_wait_zerobusy(h, folio);
 		__update_and_free_hugetlb_folio(h, folio);
 
 		cond_resched();
@@ -1759,7 +1817,8 @@ static inline void flush_free_hpage_work(struct hstate *h)
 static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
-	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
+	if ((!folio_test_hugetlb_zero_busy(folio) &&
+	     !folio_test_hugetlb_vmemmap_optimized(folio)) || !atomic) {
 		__update_and_free_hugetlb_folio(h, folio);
 		return;
 	}
@@ -1974,6 +2033,8 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
 {
 	__prep_new_hugetlb_folio(h, folio);
 	spin_lock_irq(&hugetlb_lock);
+	folio_clear_hugetlb_freed(folio);
+	prep_clear_prezero(folio);
 	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
 }
@@ -2419,6 +2480,13 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 						preferred_nid, nmask);
 		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
+			/*
+			 * The contents of this page will be completely
+			 * overwritten immediately, as its a migration
+			 * target, so no clearing is needed. Do wait in
+			 * case khzerod was working on it, though.
+			 */
+			hpage_wait_zerobusy(h, folio);
 			return folio;
 		}
 	}
@@ -3066,6 +3134,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_unlock_irq(&hugetlb_lock);
 
+	hpage_wait_zerobusy(h, folio);
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
@@ -3503,6 +3573,8 @@ static void __init hugetlb_init_hstates(void)
 				h->demote_order = h2->order;
 		}
 	}
+
+	khzerod_run_all();
 }
 
 static void __init report_hugepages(void)
@@ -4184,15 +4256,72 @@ static ssize_t demote_size_store(struct kobject *kobj,
 }
 HSTATE_ATTR(demote_size);
 
+static ssize_t free_hugepages_zero_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct hstate *h;
+	unsigned long free_huge_pages_zero;
+	int nid;
+
+	h = kobj_to_hstate(kobj, &nid);
+	if (nid == NUMA_NO_NODE)
+		free_huge_pages_zero = h->free_huge_pages_zero;
+	else
+		free_huge_pages_zero = h->free_huge_pages_zero_node[nid];
+
+	return sprintf(buf, "%lu\n", free_huge_pages_zero);
+}
+HSTATE_ATTR_RO(free_hugepages_zero);
+
+static ssize_t prezero_enabled_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	struct hstate *h = kobj_to_hstate(kobj, NULL);
+
+	return sprintf(buf, "%d\n", h->prezero_enabled ? 1 : 0);
+}
+
+static ssize_t prezero_enabled_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct hstate *h;
+	int err;
+	long val;
+	bool prezero_enabled;
+
+	err = kstrtol(buf, 10, &val);
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	prezero_enabled = !!val;
+
+	h = kobj_to_hstate(kobj, NULL);
+	if (prezero_enabled == h->prezero_enabled)
+		return count;
+
+	h->prezero_enabled = prezero_enabled;
+
+	mem_hotplug_begin();
+	khzerod_run_hstate(h);
+	mem_hotplug_done();
+
+	return count;
+}
+HSTATE_ATTR(prezero_enabled);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&resv_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&free_hugepages_zero_attr.attr,
 #ifdef CONFIG_NUMA
 	&nr_hugepages_mempolicy_attr.attr,
 #endif
+	&prezero_enabled_attr.attr,
 	NULL,
 };
 
@@ -4265,6 +4394,7 @@ static struct node_hstate node_hstates[MAX_NUMNODES];
 static struct attribute *per_node_hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
+	&free_hugepages_zero_attr.attr,
 	&surplus_hugepages_attr.attr,
 	NULL,
 };
@@ -4501,6 +4631,232 @@ bool __init __attribute((weak)) arch_hugetlb_valid_size(unsigned long size)
 	return size == HPAGE_SIZE;
 }
 
+struct khzerod_info {
+	struct hstate *h;
+	int nid;
+};
+
+/*
+ * Clear a hugetlb page.
+ *
+ * The caller has already made sure that the page is not
+ * being actively zeroed out in the background.
+ *
+ * If it wasn't zeroed out, do it ourselves.
+ */
+void clear_hugetlb_folio(struct folio *folio, unsigned long address)
+{
+	if (!folio_test_hugetlb_pre_zeroed(folio))
+		folio_zero_user(folio, address);
+
+	__folio_mark_uptodate(folio);
+}
+
+/*
+ * Once a page has been taken off the freelist, the new page owner
+ * must wait for the pre-zero kthread to finish if it happens
+ * to be working on this page (which should be rare).
+ */
+static void hpage_wait_zerobusy(struct hstate *h, struct folio *folio)
+{
+	if (!folio_test_hugetlb_zero_busy(folio))
+		return;
+
+	spin_lock_irq(&hugetlb_lock);
+
+	wait_event_cmd(h->dqzero_wait[folio_nid(folio)],
+		       !folio_test_hugetlb_zero_busy(folio),
+		       spin_unlock_irq(&hugetlb_lock),
+		       spin_lock_irq(&hugetlb_lock));
+
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+/*
+ * This per-node-per-hstate kthread pre-zeroes pages that are on
+ * the freelist. They remain on the freelist while this is being
+ * done. When pre-zeroing is done, they are moved to the head
+ * of the list.
+ *
+ * Pages are left on the freelist because an allocation should not
+ * fail just because the page is being prezeroed. In the rare
+ * corner case that a page that is being worked on by this
+ * thread is taken as part of an allocation, the caller will
+ * wait for the prezero to finish (see hpage_wait_zerobusy).
+ */
+static int khzerod(void *p)
+{
+	struct khzerod_info *ki = p;
+	struct hstate *h = ki->h;
+	int nid = ki->nid;
+	unsigned int *freep, *zerop;
+	struct folio *folio;
+	const struct cpumask *cpumask = cpumask_of_node(nid);
+	struct list_head *freelist;
+
+	if (!cpumask_empty(cpumask))
+		set_cpus_allowed_ptr(current, cpumask);
+
+	freep = &h->free_huge_pages_node[nid];
+	zerop = &h->free_huge_pages_zero_node[nid];
+	freelist = &h->hugepage_freelists[nid];
+
+	do {
+		wait_event_interruptible(h->hzerod_wait[nid],
+				*zerop < *freep || kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		spin_lock_irq(&hugetlb_lock);
+		if (*zerop == *freep || list_empty(freelist)) {
+			spin_unlock_irq(&hugetlb_lock);
+			continue;
+		}
+
+		folio = list_last_entry(freelist, struct folio, lru);
+		if (folio_test_hugetlb_pre_zeroed(folio)) {
+			spin_unlock_irq(&hugetlb_lock);
+			continue;
+		}
+
+		folio_set_hugetlb_zero_busy(folio);
+		/*
+		 * Incrementing this here is a bit of a fib, since
+		 * the page hasn't been cleared yet (it will be done
+		 * immediately after dropping the lock below). But
+		 * it keeps the count consistent with the overall
+		 * free count in case the page gets taken off the
+		 * freelist while we're working on it.
+		 */
+		(*zerop)++;
+		h->free_huge_pages_zero++;
+		spin_unlock_irq(&hugetlb_lock);
+
+		/*
+		 * HWPoison pages may show up on the freelist.
+		 * Don't try to zero it out, but do set the flag
+		 * and counts, so that we don't consider it again.
+		 */
+		if (!folio_test_hwpoison(folio))
+			folio_zero_user(folio, 0);
+
+		spin_lock_irq(&hugetlb_lock);
+		folio_set_hugetlb_pre_zeroed(folio);
+		folio_clear_hugetlb_zero_busy(folio);
+
+		/*
+		 * If the page is still on the free list, move
+		 * it to the head.
+		 */
+		if (folio_test_hugetlb_freed(folio))
+			list_move(&folio->lru, freelist);
+
+		/*
+		 * If someone was waiting for the zero to
+		 * finish, wake them up.
+		 */
+		if (waitqueue_active(&h->dqzero_wait[nid]))
+			wake_up(&h->dqzero_wait[nid]);
+		spin_unlock_irq(&hugetlb_lock);
+
+	} while (1);
+
+	kfree(ki);
+	return 0;
+}
+
+static void khzerod_run_hstate_nid(struct hstate *h, int nid)
+{
+	struct khzerod_info *ki;
+	struct task_struct *t;
+
+	mutex_lock(&prezero_chg_lock);
+
+	if (!h->prezero_enabled) {
+		if (h->hzerod[nid] != NULL) {
+			kthread_stop(h->hzerod[nid]);
+			h->hzerod[nid] = NULL;
+		}
+		goto out;
+	}
+
+	if (h->hzerod[nid] != NULL)
+		goto out;
+
+	ki = kmalloc(sizeof(*ki), GFP_KERNEL);
+	if (ki == NULL)
+		goto out;
+	ki->h = h;
+	ki->nid = nid;
+	t = kthread_run(khzerod, ki, "khzerod%d-%lukB",
+			nid, huge_page_size(h) / 1024);
+	if (IS_ERR(t)) {
+		kfree(ki);
+		pr_err("could not run khzerod on node %d for size %lukB\n",
+		       nid, huge_page_size(h) / 1024);
+	} else
+		h->hzerod[nid] = t;
+
+out:
+	mutex_unlock(&prezero_chg_lock);
+}
+
+static void khzerod_stop_hstate_nid(struct hstate *h, int nid)
+{
+	mutex_lock(&prezero_chg_lock);
+
+	if (h->hzerod[nid] != NULL) {
+		kthread_stop(h->hzerod[nid]);
+		h->hzerod[nid] = NULL;
+	}
+
+	mutex_unlock(&prezero_chg_lock);
+}
+
+/*
+ * (re-)run all pre-zero kthreads for a node. kthreads
+ * that are currently running, but should no longer run
+ * (because the prezero enable flag was changed) are stopped.
+ */
+void khzerod_run(int nid)
+{
+	struct hstate *h;
+
+	for_each_hstate(h)
+		khzerod_run_hstate_nid(h, nid);
+}
+
+static void khzerod_run_all(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		khzerod_run(nid);
+}
+
+static void khzerod_run_hstate(struct hstate *h)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		khzerod_run_hstate_nid(h, nid);
+}
+
+void khzerod_stop(int nid)
+{
+	struct hstate *h;
+
+	for_each_hstate(h)
+		khzerod_stop_hstate_nid(h, nid);
+}
+
+static void khzerod_wakeup_node(struct hstate *h, int nid)
+{
+	if (h->hzerod[nid])
+		wake_up(&h->hzerod_wait[nid]);
+}
+
 void __init hugetlb_add_hstate(unsigned int order)
 {
 	struct hstate *h;
@@ -4515,8 +4871,11 @@ void __init hugetlb_add_hstate(unsigned int order)
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for (i = 0; i < MAX_NUMNODES; ++i) {
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
+		init_waitqueue_head(&h->hzerod_wait[i]);
+		init_waitqueue_head(&h->dqzero_wait[i]);
+	}
 	INIT_LIST_HEAD(&h->hugepage_activelist);
 	h->next_nid_to_alloc = first_memory_node;
 	h->next_nid_to_free = first_memory_node;
@@ -6139,8 +6498,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				ret = 0;
 			goto out;
 		}
-		folio_zero_user(folio, vmf->real_address);
-		__folio_mark_uptodate(folio);
+		clear_hugetlb_folio(folio, vmf->address);
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 621ae1015106..8398e4d0130d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1217,6 +1217,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	kswapd_run(nid);
 	kcompactd_run(nid);
+	khzerod_run(nid);
 
 	writeback_set_ratelimit();
 
@@ -2092,6 +2093,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	if (arg.status_change_nid >= 0) {
 		kcompactd_stop(node);
 		kswapd_stop(node);
+		khzerod_stop(node);
 	}
 
 	writeback_set_ratelimit();
-- 
2.47.0.338.g60cca15819-goog


