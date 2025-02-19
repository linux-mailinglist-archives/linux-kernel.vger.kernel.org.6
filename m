Return-Path: <linux-kernel+bounces-520803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6EA3AF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EAA7A47E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F001714B2;
	Wed, 19 Feb 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxmZOGZs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9385260
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931503; cv=none; b=biUT5iFUoRNHUlItqEVvWzwf9waXtCUHdjz3MP37I1tZ2KVsv6yKrwu5FQtM6bV9UGm6D1TCAOvsOcx+iORJXJ+uieqOqdGbU5Mbj5LB0XwoV1V8UP1i/z3kK3dWDmoFcJVOpFNtbxr0wpAd5/BFZQM1rqzgTJaoAoSoI2eBuBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931503; c=relaxed/simple;
	bh=qPogO3+SURGDVctjzFSU9aTDFySdl7GETz8GHCW3wlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX5aDd8ZXzQGxrrYoBfELhrHjFqSpg1Zou4ECZ1MxMDyAfyt8QGuqQo6LPwYhSkXBNAw67zjvVVOzS8FvOqkM8d7zw4B+nO8h26p8Zo3+DgLtJ2dlAT24GAhAIObWu2j21F545xyHs+r0S+bfWo2k+m2S+G3eaH18cNumYXv9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxmZOGZs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739931500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvFM6GZiRQiXqBZ3vCZFiH0Ays3za6p0+8us7Xm2FsA=;
	b=AxmZOGZs2dhHxNycOG02YO2p/7RouMIIc2z4m20K2KX0aDn7B1fjcX67jB5MuolJo4n0HG
	Vwfp1cFjA9ZEfJ6yD2oNehoM/5UxmrBazDADXkOQEVh/IT8W1nxg0Gie1V82JDmGIPByZe
	mx/YjGRqtrvvPXsmcGDGn12OQBxGWU4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-uF3_mlKrM2imXHAX3cLYTQ-1; Tue,
 18 Feb 2025 21:18:16 -0500
X-MC-Unique: uF3_mlKrM2imXHAX3cLYTQ-1
X-Mimecast-MFC-AGG-ID: uF3_mlKrM2imXHAX3cLYTQ_1739931495
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13B48180087A;
	Wed, 19 Feb 2025 02:18:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC6A719560B9;
	Wed, 19 Feb 2025 02:18:12 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@redhat.com,
	yuzhao@google.com,
	pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	luizcap@redhat.com
Subject: [PATCH 1/4] mm: page_ext: add an iteration API for page extensions
Date: Tue, 18 Feb 2025 21:17:47 -0500
Message-ID: <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
In-Reply-To: <cover.1739931468.git.luizcap@redhat.com>
References: <cover.1739931468.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The page extension implementation assumes that all page extensions of
a given page order are stored in the same memory section. The function
page_ext_next() relies on this assumption by adding an offset to the
current object to return the next adjacent page extension.

This behavior works as expected for flatmem but fails for sparsemem when
using 1G pages. The commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for
gigantic folios") exposes this issue, making it possible for a crash when
using page_owner or page_table_check page extensions.

The problem is that for 1G pages, the page extensions may span memory
section boundaries and be stored in different memory sections. This issue
was not visible before commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP
for gigantic folios") because alloc_contig_pages() never passed more than
MAX_PAGE_ORDER to post_alloc_hook(). However, the series introducing
mentioned commit changed this behavior allowing the full 1G page order
to be passed.

Reproducer:

 1. Build the kernel with CONFIG_SPARSEMEM=y and table extensions
    support
 2. Pass 'default_hugepagesz=1 page_owner=on' in the kernel command-line
 3. Reserve one 1G page at run-time, this should crash (backtrace below)

To address this issue, this commit introduces a new API for iterating
through page extensions. The main iteration loops are for_each_page_ext()
and for_each_page_ext_order(). Both must be called with the RCU read
lock taken. Here's an usage example:

"""
struct page_ext_iter iter;
struct page_ext *page_ext;

...

rcu_read_lock();
for_each_page_ext_order(page, order, page_ext, iter) {
	struct my_page_ext *obj = get_my_page_ext_obj(page_ext);
	...
}
rcu_read_unlock();
"""

Both loop constructs use page_ext_iter_next(), which checks to see if we
have crossed sections in the iteration. In this case, page_ext_iter_next()
retrieves the next page_ext object from another section.

Thanks to David Hildenbrand for helping identify the root cause and
providing suggestions on how to fix and optmize the solution (final
implementation and bugs are all mine through).

Lastly, here's the backtrace, without kasan you can get random crashes:

[   76.052526] BUG: KASAN: slab-out-of-bounds in __update_page_owner_handle+0x238/0x298
[   76.060283] Write of size 4 at addr ffff07ff96240038 by task tee/3598
[   76.066714]
[   76.068203] CPU: 88 UID: 0 PID: 3598 Comm: tee Kdump: loaded Not tainted 6.13.0-rep1 #3
[   76.076202] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.0007/Mt.Jade Motherboard, BIOS 2.10.20220810 (SCP: 2.10.20220810) 2022/08/10
[   76.088972] Call trace:
[   76.091411]  show_stack+0x20/0x38 (C)
[   76.095073]  dump_stack_lvl+0x80/0xf8
[   76.098733]  print_address_description.constprop.0+0x88/0x398
[   76.104476]  print_report+0xa8/0x278
[   76.108041]  kasan_report+0xa8/0xf8
[   76.111520]  __asan_report_store4_noabort+0x20/0x30
[   76.116391]  __update_page_owner_handle+0x238/0x298
[   76.121259]  __set_page_owner+0xdc/0x140
[   76.125173]  post_alloc_hook+0x190/0x1d8
[   76.129090]  alloc_contig_range_noprof+0x54c/0x890
[   76.133874]  alloc_contig_pages_noprof+0x35c/0x4a8
[   76.138656]  alloc_gigantic_folio.isra.0+0x2c0/0x368
[   76.143616]  only_alloc_fresh_hugetlb_folio.isra.0+0x24/0x150
[   76.149353]  alloc_pool_huge_folio+0x11c/0x1f8
[   76.153787]  set_max_huge_pages+0x364/0xca8
[   76.157961]  __nr_hugepages_store_common+0xb0/0x1a0
[   76.162829]  nr_hugepages_store+0x108/0x118
[   76.167003]  kobj_attr_store+0x3c/0x70
[   76.170745]  sysfs_kf_write+0xfc/0x188
[   76.174492]  kernfs_fop_write_iter+0x274/0x3e0
[   76.178927]  vfs_write+0x64c/0x8e0
[   76.182323]  ksys_write+0xf8/0x1f0
[   76.185716]  __arm64_sys_write+0x74/0xb0
[   76.189630]  invoke_syscall.constprop.0+0xd8/0x1e0
[   76.194412]  do_el0_svc+0x164/0x1e0
[   76.197891]  el0_svc+0x40/0xe0
[   76.200939]  el0t_64_sync_handler+0x144/0x168
[   76.205287]  el0t_64_sync+0x1ac/0x1b0

Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/page_ext.h | 66 ++++++++++++++++++++++++++++++++++++++++
 mm/page_ext.c            | 41 +++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index e4b48a0dda244..a99da12e59fa7 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -3,6 +3,7 @@
 #define __LINUX_PAGE_EXT_H
 
 #include <linux/types.h>
+#include <linux/mmzone.h>
 #include <linux/stacktrace.h>
 
 struct pglist_data;
@@ -69,12 +70,26 @@ extern void page_ext_init(void);
 static inline void page_ext_init_flatmem_late(void)
 {
 }
+
+static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
+{
+	/*
+	 * page_ext is allocated per memory section. Once we cross a
+	 * memory section, we have to fetch the new pointer.
+	 */
+	return next_pfn % PAGES_PER_SECTION;
+}
 #else
 extern void page_ext_init_flatmem(void);
 extern void page_ext_init_flatmem_late(void);
 static inline void page_ext_init(void)
 {
 }
+
+static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
+{
+	return true;
+}
 #endif
 
 extern struct page_ext *page_ext_get(const struct page *page);
@@ -93,6 +108,57 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 	return next;
 }
 
+struct page_ext_iter {
+	unsigned long pfn;
+	unsigned long index;
+	struct page_ext *page_ext;
+};
+
+struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page);
+struct page_ext *page_ext_iter_next(struct page_ext_iter *iter);
+
+/**
+ * page_ext_iter_get() - Get current page extension
+ * @iter: page extension iterator.
+ *
+ * Return: NULL if no page_ext exists for this iterator.
+ */
+static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *iter)
+{
+	return iter->page_ext;
+}
+
+/**
+ * for_each_page_ext(): iterate through page_ext objects.
+ * @__page: the page we're interested in
+ * @__pgcount: how many pages to iterate through
+ * @__page_ext: struct page_ext pointer where the current page_ext
+ *              object is returned
+ * @__iter: struct page_ext_iter object (defined in the stack)
+ *
+ * IMPORTANT: must be called with RCU read lock taken.
+ */
+#define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
+	__page_ext = page_ext_iter_begin(&__iter, __page);     \
+	for (__iter.index = 0;                                 \
+		__page_ext && __iter.index < __pgcount;        \
+		__page_ext = page_ext_iter_next(&__iter),      \
+		__iter.index++)
+
+/**
+ * for_each_page_ext_order(): iterate through page_ext objects
+ *                            for a given page order
+ * @__page: the page we're interested in
+ * @__order: page order to iterate through
+ * @__page_ext: struct page_ext pointer where the current page_ext
+ *              object is returned
+ * @__iter: struct page_ext_iter object (defined in the stack)
+ *
+ * IMPORTANT: must be called with RCU read lock taken.
+ */
+#define for_each_page_ext_order(__page, __order, __page_ext, __iter) \
+	for_each_page_ext(__page, (1UL << __order), __page_ext, __iter)
+
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 641d93f6af4c1..508deb04d5ead 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -549,3 +549,44 @@ void page_ext_put(struct page_ext *page_ext)
 
 	rcu_read_unlock();
 }
+
+/**
+ * page_ext_iter_begin() - Prepare for iterating through page extensions.
+ * @iter: page extension iterator.
+ * @page: The page we're interested in.
+ *
+ * Must be called with RCU read lock taken.
+ *
+ * Return: NULL if no page_ext exists for this page.
+ */
+struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page)
+{
+	iter->pfn = page_to_pfn(page);
+	iter->page_ext = lookup_page_ext(page);
+
+	return iter->page_ext;
+}
+
+/**
+ * page_ext_iter_next() - Get next page extension
+ * @iter: page extension iterator.
+ *
+ * Must be called with RCU read lock taken.
+ *
+ * Return: NULL if no next page_ext exists.
+ */
+struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
+{
+	if (WARN_ON_ONCE(!iter->page_ext))
+		return NULL;
+
+	iter->pfn++;
+
+	if (page_ext_iter_next_fast_possible(iter->pfn)) {
+		iter->page_ext = page_ext_next(iter->page_ext);
+	} else {
+		iter->page_ext = lookup_page_ext(pfn_to_page(iter->pfn));
+	}
+
+	return iter->page_ext;
+}
-- 
2.48.1


