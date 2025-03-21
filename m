Return-Path: <linux-kernel+bounces-571744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A541DA6C1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED767A8FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACA22F386;
	Fri, 21 Mar 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3F+bm3D"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AC22DFAB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578656; cv=none; b=m2mpDtXFRjJROSPuYUzHBvDtrdVpKXzr/laRtX7e0uyuEoECMnRf99lrZ/V9PVvcLHpQZkYzRHxngGxdbwLfuoJWFlKGRI2RGmfTgv27qElEwXCTNjKdOYzUE6ARecMOMITqFJSyPj2FFV+IlQ8TEoP3DpyddVCJ9Im1oJHmFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578656; c=relaxed/simple;
	bh=Mwcr17jhQhHp1tM5uzIGNfIK5QpDNbH1adnC5f9s0YI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fPECT4fTQMnYZFymm7YpSO1On+dj0ppBmAUw6DfoPMnx+nwUWU2gWiis7vgvBi/s7a39rNjiyYMvIQbnex9Cskxi8mW9ZcccYHD5t/Gfcn2hu/ZIrni/o5ug9+UnOzQedT+ak/bTYvzubEt8xsW/9Dq3nLMnpKhasnkqpnq6SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3F+bm3D; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so3571094a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578654; x=1743183454; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD+/AzOE/8DE108iYCdGt2BwCB9Yw4lZbr5znCcmPD8=;
        b=T3F+bm3DV6F+Nm18o/lfh9K5Lvk5V9QIvk8xqX77UQQtH+fXDr7LRp2ypKE7IKkUw8
         q7ycZbLQT95UqavJ/mAyRj1dWh0owMTw9iJV7pmvftatumz37clAJWZKL3xfiNkufUaI
         b8jNiwGzuiWGpRUVf2STfcUiTsonA/7hfZEAcrtJyPYASQeSCCDlXCmKi+u0XhT+JBdN
         jV8/V7YWg0u2UCvsd4JO1ijcixGituUyPJ3H8pDVzLLr2x/Ok3KwRY8h1hrxK+Cuyyvp
         STaW+v8qeZtPKzJ7Sz8RdVSGI+RPuNxwObNgGRAJhwN9kpzhS3u9Ele8QOJt2HrjwAgV
         xwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578654; x=1743183454;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KD+/AzOE/8DE108iYCdGt2BwCB9Yw4lZbr5znCcmPD8=;
        b=eF3k/Rpq37zw+HTmy6P0E8x1qWI4a7M7xa4kMzPLczFhzvI1jlR003FKoGmg6OIze9
         E8UYtokJvwBKeTD/g0BFufA28l6K6QdWI5S4KJDo9JSIMp9/xdL1Sv7zhvKbM8XMp1Yg
         Qla0M1QEUq3BcHwnWYPS+Sj43x/1m2szliu5/7IFNecxr4YP1RPIvI5I+wWa88zxLgGs
         tbhN+9PdkRIm7kTZ5hJnkbIxY8dOYmsj73ubqP7E1i4KgXjmlo4r81YMd88p0scb5OFM
         1EVlAwPxWnQam00pT2W/EHdC28Y0FOvQFoYqOMoqTtKeBimy4HMqSITtSF9qT8XqRX8f
         riGA==
X-Forwarded-Encrypted: i=1; AJvYcCWqwNUP+XjVFcZ9n+FRyB3hwQOVhRDdRavaCCPtVuZJtS9lyyfsICMrIPY/awiomgEID5RJKgfQraQ3tuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VhwDInWtd+E8tbZduJyZpopQR9jfhMsxHNFPXqk2Zs/7rzvZ
	b+NJZytby/lFPnMGNJq4uFgaa5v95MVUqZUJB7QSrGWhN8fjHaZMEOOJaPDQAO4ZUaFL1/k4APZ
	tKlusXmqyF8hrGFvsFFfcbw==
X-Google-Smtp-Source: AGHT+IE3zfkzVNg9SOyEjNSGlTIDNM2s5rLvniscEkew+nzR6ifKeKx8uNXSoO7cH2YP2/p20l9xr1Homzd8hizqww==
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2ea:46ed:5d3b])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b10:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-3030fea7630mr6796934a91.11.1742578653992;
 Fri, 21 Mar 2025 10:37:33 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:25 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-3-souravpanda@google.com>
Subject: [RFC PATCH 2/6] mm: make Selective KSM synchronous
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Make KSM synchronous by introducing the following sysfs file, which
shall carryout merging on the specified memory region synchronously
and eliminates the need of ksmd running in the background.

echo "pid start_addr end_addr" > /sys/kernel/mm/ksm/trigger_merge

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 mm/ksm.c | 317 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 271 insertions(+), 46 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8be2b144fefd..b2f184557ed9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -290,16 +290,18 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
-/* Skip pages that couldn't be de-duplicated previously */
-/* Default to true at least temporarily, for testing */
-static bool ksm_smart_scan = true;
-
 /* The number of zero pages which is placed by KSM */
 atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
 
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
 
+#ifndef CONFIG_SELECTIVE_KSM /* advisor immaterial if there is no scanning */
+
+/* Skip pages that couldn't be de-duplicated previously */
+/* Default to true at least temporarily, for testing */
+static bool ksm_smart_scan = true;
+
 /* Don't scan more than max pages per batch. */
 static unsigned long ksm_advisor_max_pages_to_scan = 30000;
 
@@ -465,6 +467,7 @@ static void advisor_stop_scan(void)
 	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
 		scan_time_advisor();
 }
+#endif /* CONFIG_SELECTIVE_KSM */
 
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
@@ -957,6 +960,25 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 	return NULL;
 }
 
+static unsigned char get_rmap_item_age(struct ksm_rmap_item *rmap_item)
+{
+#ifdef CONFIG_SELECTIVE_KSM /* age is immaterial in selective ksm */
+	return 0;
+#else
+	unsigned char age;
+	/*
+	 * Usually ksmd can and must skip the rb_erase, because
+	 * root_unstable_tree was already reset to RB_ROOT.
+	 * But be careful when an mm is exiting: do the rb_erase
+	 * if this rmap_item was inserted by this scan, rather
+	 * than left over from before.
+	 */
+	age = (unsigned char)(ksm_scan.seqnr - rmap_item->address);
+	WARN_ON_ONCE(age > 1);
+	return age;
+#endif /* CONFIG_SELECTIVE_KSM */
+}
+
 /*
  * Removing rmap_item from stable or unstable tree.
  * This function will clean the information from the stable/unstable tree.
@@ -991,16 +1013,7 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 		rmap_item->address &= PAGE_MASK;
 
 	} else if (rmap_item->address & UNSTABLE_FLAG) {
-		unsigned char age;
-		/*
-		 * Usually ksmd can and must skip the rb_erase, because
-		 * root_unstable_tree was already reset to RB_ROOT.
-		 * But be careful when an mm is exiting: do the rb_erase
-		 * if this rmap_item was inserted by this scan, rather
-		 * than left over from before.
-		 */
-		age = (unsigned char)(ksm_scan.seqnr - rmap_item->address);
-		BUG_ON(age > 1);
+		unsigned char age = get_rmap_item_age(rmap_item);
 		if (!age)
 			rb_erase(&rmap_item->node,
 				 root_unstable_tree + NUMA(rmap_item->nid));
@@ -2203,6 +2216,37 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
 	rmap_item->mm->ksm_merging_pages++;
 }
 
+#ifdef CONFIG_SELECTIVE_KSM
+static int update_checksum(struct page *page, struct ksm_rmap_item *rmap_item)
+{
+	/*
+	 * Typically KSM would wait for a second round to even consider
+	 * the page for unstable tree insertion to ascertain its stability.
+	 * Avoid this when using selective ksm.
+	 */
+	rmap_item->oldchecksum = calc_checksum(page);
+	return 0;
+}
+#else
+static int update_checksum(struct page *page, struct ksm_rmap_item *rmap_item)
+{
+	remove_rmap_item_from_tree(rmap_item);
+
+	/*
+	 * If the hash value of the page has changed from the last time
+	 * we calculated it, this page is changing frequently: therefore we
+	 * don't want to insert it in the unstable tree, and we don't want
+	 * to waste our time searching for something identical to it there.
+	 */
+	checksum = calc_checksum(page);
+	if (rmap_item->oldchecksum != checksum) {
+		rmap_item->oldchecksum = checksum;
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif
+
 /*
  * cmp_and_merge_page - first see if page can be merged into the stable tree;
  * if not, compare checksum to previous and if it's the same, see if page can
@@ -2218,7 +2262,6 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	struct page *tree_page = NULL;
 	struct ksm_stable_node *stable_node;
 	struct folio *kfolio;
-	unsigned int checksum;
 	int err;
 	bool max_page_sharing_bypass = false;
 
@@ -2241,20 +2284,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		if (!is_page_sharing_candidate(stable_node))
 			max_page_sharing_bypass = true;
 	} else {
-		remove_rmap_item_from_tree(rmap_item);
-
-		/*
-		 * If the hash value of the page has changed from the last time
-		 * we calculated it, this page is changing frequently: therefore we
-		 * don't want to insert it in the unstable tree, and we don't want
-		 * to waste our time searching for something identical to it there.
-		 */
-		checksum = calc_checksum(page);
-		if (rmap_item->oldchecksum != checksum) {
-			rmap_item->oldchecksum = checksum;
+		if (update_checksum(page, rmap_item))
 			return;
-		}
-
 		if (!try_to_merge_with_zero_page(rmap_item, page))
 			return;
 	}
@@ -2379,6 +2410,111 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
 
+#ifdef CONFIG_SELECTIVE_KSM
+static struct ksm_rmap_item *retrieve_rmap_item(struct page **page,
+						struct mm_struct *mm,
+						unsigned long start,
+						unsigned long end)
+{
+	struct ksm_mm_slot *mm_slot;
+	struct mm_slot *slot;
+	struct vm_area_struct *vma;
+	struct ksm_rmap_item *rmap_item;
+	struct vma_iterator vmi;
+
+	lru_add_drain_all();
+
+	if (!ksm_merge_across_nodes) {
+		struct ksm_stable_node *stable_node, *next;
+		struct folio *folio;
+
+		list_for_each_entry_safe(stable_node, next,
+					 &migrate_nodes, list) {
+			folio = ksm_get_folio(stable_node, KSM_GET_FOLIO_NOLOCK);
+			if (folio)
+				folio_put(folio);
+		}
+	}
+
+	spin_lock(&ksm_mmlist_lock);
+	slot = mm_slot_lookup(mm_slots_hash, mm);
+	spin_unlock(&ksm_mmlist_lock);
+
+	if (!slot)
+		return NULL;
+	mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+
+	ksm_scan.address = 0;
+	ksm_scan.mm_slot = mm_slot;
+	ksm_scan.rmap_list = &mm_slot->rmap_list;
+
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (!(vma->vm_flags & VM_MERGEABLE))
+			continue;
+		if (ksm_scan.address < vma->vm_start)
+			ksm_scan.address = vma->vm_start;
+		if (!vma->anon_vma)
+			ksm_scan.address = vma->vm_end;
+
+		while (ksm_scan.address < vma->vm_end) {
+			struct page *tmp_page = NULL;
+			struct folio_walk fw;
+			struct folio *folio;
+
+			if (ksm_scan.address < start || ksm_scan.address > end)
+				break;
+
+			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
+			if (folio) {
+				if (!folio_is_zone_device(folio) &&
+				    folio_test_anon(folio)) {
+					folio_get(folio);
+					tmp_page = fw.page;
+				}
+				folio_walk_end(&fw, vma);
+			}
+
+			if (tmp_page) {
+				flush_anon_page(vma, tmp_page, ksm_scan.address);
+				flush_dcache_page(tmp_page);
+				rmap_item = get_next_rmap_item(mm_slot,
+							       ksm_scan.rmap_list,
+							       ksm_scan.address);
+				if (rmap_item) {
+					ksm_scan.rmap_list =
+							&rmap_item->rmap_list;
+					ksm_scan.address += PAGE_SIZE;
+					*page = tmp_page;
+				} else {
+					folio_put(folio);
+				}
+				mmap_read_unlock(mm);
+				return rmap_item;
+			}
+			ksm_scan.address += PAGE_SIZE;
+		}
+	}
+	mmap_read_unlock(mm);
+	return NULL;
+}
+
+static void ksm_sync_merge(struct mm_struct *mm,
+			   unsigned long start, unsigned long end)
+{
+	struct ksm_rmap_item *rmap_item;
+	struct page *page;
+
+	rmap_item = retrieve_rmap_item(&page, mm, start, end);
+	if (!rmap_item)
+		return;
+	cmp_and_merge_page(page, rmap_item);
+	put_page(page);
+}
+
+#else /* CONFIG_SELECTIVE_KSM */
 /*
  * Calculate skip age for the ksm page age. The age determines how often
  * de-duplicating has already been tried unsuccessfully. If the age is
@@ -2688,6 +2824,7 @@ static int ksm_scan_thread(void *nothing)
 	}
 	return 0;
 }
+#endif /* CONFIG_SELECTIVE_KSM */
 
 static void __ksm_add_vma(struct vm_area_struct *vma)
 {
@@ -3335,9 +3472,10 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
 	unsigned int nr_pages;
 	int err;
 
+#ifndef CONFIG_SELECTIVE_KSM
 	if (ksm_advisor != KSM_ADVISOR_NONE)
 		return -EINVAL;
-
+#endif
 	err = kstrtouint(buf, 10, &nr_pages);
 	if (err)
 		return -EINVAL;
@@ -3396,6 +3534,65 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t trigger_merge_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	return -EINVAL;	/* Not yet implemented */
+}
+
+static ssize_t trigger_merge_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long start, end;
+	pid_t pid;
+	char *input, *ptr;
+	int ret;
+	struct task_struct *task;
+	struct mm_struct *mm;
+
+	input = kstrdup(buf, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	ptr = strim(input);
+	ret = sscanf(ptr, "%d %lx %lx", &pid, &start, &end);
+	kfree(input);
+
+	if (ret != 3)
+		return -EINVAL;
+
+	if (start >= end)
+		return -EINVAL;
+
+	/* Find the mm_struct */
+	rcu_read_lock();
+	task = find_task_by_vpid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	get_task_struct(task);
+
+	rcu_read_unlock();
+	mm = get_task_mm(task);
+	put_task_struct(task);
+
+	if (!mm)
+		return -EINVAL;
+
+	mutex_lock(&ksm_thread_mutex);
+	wait_while_offlining();
+	ksm_sync_merge(mm, start, end);
+	mutex_unlock(&ksm_thread_mutex);
+
+	mmput(mm);
+	return count;
+}
+KSM_ATTR(trigger_merge);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -3635,6 +3832,7 @@ static ssize_t full_scans_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(full_scans);
 
+#ifndef CONFIG_SELECTIVE_KSM
 static ssize_t smart_scan_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
@@ -3780,11 +3978,13 @@ static ssize_t advisor_target_scan_time_store(struct kobject *kobj,
 	return count;
 }
 KSM_ATTR(advisor_target_scan_time);
+#endif /* CONFIG_SELECTIVE_KSM */
 
 static struct attribute *ksm_attrs[] = {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
+	&trigger_merge_attr.attr,
 	&pages_scanned_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
@@ -3802,12 +4002,14 @@ static struct attribute *ksm_attrs[] = {
 	&stable_node_chains_prune_millisecs_attr.attr,
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
+#ifndef CONFIG_SELECTIVE_KSM
 	&smart_scan_attr.attr,
 	&advisor_mode_attr.attr,
 	&advisor_max_cpu_attr.attr,
 	&advisor_min_pages_to_scan_attr.attr,
 	&advisor_max_pages_to_scan_attr.attr,
 	&advisor_target_scan_time_attr.attr,
+#endif
 	NULL,
 };
 
@@ -3815,40 +4017,63 @@ static const struct attribute_group ksm_attr_group = {
 	.attrs = ksm_attrs,
 	.name = "ksm",
 };
+
+static int __init ksm_sysfs_init(void)
+{
+	return sysfs_create_group(mm_kobj, &ksm_attr_group);
+}
+#else /* CONFIG_SYSFS */
+static int __init ksm_sysfs_init(void)
+{
+	ksm_run = KSM_RUN_MERGE;	/* no way for user to start it */
+	return 0;
+}
 #endif /* CONFIG_SYSFS */
 
-static int __init ksm_init(void)
+#ifdef CONFIG_SELECTIVE_KSM
+static int __init ksm_thread_sysfs_init(void)
+{
+	return ksm_sysfs_init();
+}
+#else /* CONFIG_SELECTIVE_KSM */
+static int __init ksm_thread_sysfs_init(void)
 {
 	struct task_struct *ksm_thread;
 	int err;
 
-	/* The correct value depends on page size and endianness */
-	zero_checksum = calc_checksum(ZERO_PAGE(0));
-	/* Default to false for backwards compatibility */
-	ksm_use_zero_pages = false;
-
-	err = ksm_slab_init();
-	if (err)
-		goto out;
-
 	ksm_thread = kthread_run(ksm_scan_thread, NULL, "ksmd");
 	if (IS_ERR(ksm_thread)) {
 		pr_err("ksm: creating kthread failed\n");
 		err = PTR_ERR(ksm_thread);
-		goto out_free;
+		return err;
 	}
 
-#ifdef CONFIG_SYSFS
-	err = sysfs_create_group(mm_kobj, &ksm_attr_group);
+	err = ksm_sysfs_init();
 	if (err) {
 		pr_err("ksm: register sysfs failed\n");
 		kthread_stop(ksm_thread);
-		goto out_free;
 	}
-#else
-	ksm_run = KSM_RUN_MERGE;	/* no way for user to start it */
 
-#endif /* CONFIG_SYSFS */
+	return err;
+}
+#endif /* CONFIG_SELECTIVE_KSM */
+
+static int __init ksm_init(void)
+{
+	int err;
+
+	/* The correct value depends on page size and endianness */
+	zero_checksum = calc_checksum(ZERO_PAGE(0));
+	/* Default to false for backwards compatibility */
+	ksm_use_zero_pages = false;
+
+	err = ksm_slab_init();
+	if (err)
+		goto out;
+
+	err = ksm_thread_sysfs_init();
+	if (err)
+		goto out_free;
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 	/* There is no significance to this priority 100 */
-- 
2.49.0.395.g12beb8f557-goog


