Return-Path: <linux-kernel+bounces-550019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD10A55A11
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD170189869C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F4207A14;
	Thu,  6 Mar 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4MPKx3w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8792202F7C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301111; cv=none; b=cEWwn2+LrdDp+vCi6KNJV407ISi5wowzs1EyqFBJ9pr9uN31Ggw8ZKZQ0BIsmS+pnpFnaCudj55p3JsfsaN3jTE1M4I+oQ3dzhLwK5oo2rX++K1tp5vYfgCBdUIvdfRvNYOt/4mxK0OKl7owYFY/t085n7mhPya7DOiYfh65xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301111; c=relaxed/simple;
	bh=6KyAmW1ynHK4gKKzbiuH5cEiOxuQlpK4quga9hHaa20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnrXK5W9/YncRgE+yIJejsVze8UT89q6Mn5iGZmkxCb0QiBKaeDFGvnEyQrbYGzyiqqyeP+zuxDQ0Tjcw5oOAvn7TOxoIKBXrSJeXXa78Bkp8Mj5n+8rOw80gT4eEoZhdB60YblxReqsIirgYWeS+uH/Z/8o0DEowlDPo455HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4MPKx3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741301108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teoBvxfOPLZG+ZTVaUDHrQiabUlTMJDRM/IlVl3SrJk=;
	b=e4MPKx3wdW42onuazbBaIObbHmcGQtoFWg0jWj/+7G6l0llQZzmp86nSqdAFXqMZVV9S95
	jNzoVxsP/tYoKMskxCODznXWz6TNe7jHgrFwdUZoKm8EQIPFehFrFzwZqOPP+E4ltmdBqf
	syXxYjtqGD0vf7IITz3GnJ0nXnPz93Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-e9BIJS8YNq2T-zcJVrc-Tw-1; Thu,
 06 Mar 2025 17:45:06 -0500
X-MC-Unique: e9BIJS8YNq2T-zcJVrc-Tw-1
X-Mimecast-MFC-AGG-ID: e9BIJS8YNq2T-zcJVrc-Tw_1741301105
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1A0719560A3;
	Thu,  6 Mar 2025 22:45:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B98818009BC;
	Thu,  6 Mar 2025 22:45:02 +0000 (UTC)
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
Subject: [PATCH v3 1/3] mm: page_ext: add an iteration API for page extensions
Date: Thu,  6 Mar 2025 17:44:50 -0500
Message-ID: <a45893880b7e1601082d39d2c5c8b50bcc096305.1741301089.git.luizcap@redhat.com>
In-Reply-To: <cover.1741301089.git.luizcap@redhat.com>
References: <cover.1741301089.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
through page extensions. The main iteration macro is for_each_page_ext()
and it must be called with the RCU read lock taken. Here's an usage
example:

"""
struct page_ext_iter iter;
struct page_ext *page_ext;

...

rcu_read_lock();
for_each_page_ext(page, 1 << order, page_ext, iter) {
	struct my_page_ext *obj = get_my_page_ext_obj(page_ext);
	...
}
rcu_read_unlock();
"""

The loop construct uses page_ext_iter_next() which checks to see if we
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
 include/linux/page_ext.h | 93 ++++++++++++++++++++++++++++++++++++++++
 mm/page_ext.c            | 13 ++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index e4b48a0dda244..76c817162d2fb 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -3,6 +3,7 @@
 #define __LINUX_PAGE_EXT_H
 
 #include <linux/types.h>
+#include <linux/mmzone.h>
 #include <linux/stacktrace.h>
 
 struct pglist_data;
@@ -69,16 +70,31 @@ extern void page_ext_init(void);
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
 extern void page_ext_put(struct page_ext *page_ext);
+extern struct page_ext *page_ext_lookup(unsigned long pfn);
 
 static inline void *page_ext_data(struct page_ext *page_ext,
 				  struct page_ext_operations *ops)
@@ -93,6 +109,83 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
 	return next;
 }
 
+struct page_ext_iter {
+	unsigned long index;
+	unsigned long start_pfn;
+	struct page_ext *page_ext;
+};
+
+/**
+ * page_ext_iter_begin() - Prepare for iterating through page extensions.
+ * @iter: page extension iterator.
+ * @pfn: PFN of the page we're interested in.
+ *
+ * Must be called with RCU read lock taken.
+ *
+ * Return: NULL if no page_ext exists for this page.
+ */
+static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
+						unsigned long pfn)
+{
+	iter->index = 0;
+	iter->start_pfn = pfn;
+	iter->page_ext = page_ext_lookup(pfn);
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
+static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
+{
+	unsigned long pfn;
+
+	if (WARN_ON_ONCE(!iter->page_ext))
+		return NULL;
+
+	iter->index++;
+	pfn = iter->start_pfn + iter->index;
+
+	if (page_ext_iter_next_fast_possible(pfn))
+		iter->page_ext = page_ext_next(iter->page_ext);
+	else
+		iter->page_ext = page_ext_lookup(pfn);
+
+	return iter->page_ext;
+}
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
+	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page));\
+		__page_ext && __iter.index < __pgcount;          \
+		__page_ext = page_ext_iter_next(&__iter))
+
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 641d93f6af4c1..c351fdfe9e9a5 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -507,6 +507,19 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 
 #endif
 
+/**
+ * page_ext_lookup() - Lookup a page extension for a PFN.
+ * @pfn: PFN of the page we're interested in.
+ *
+ * Must be called with RCU read lock taken and @pfn must be valid.
+ *
+ * Return: NULL if no page_ext exists for this page.
+ */
+struct page_ext *page_ext_lookup(unsigned long pfn)
+{
+	return lookup_page_ext(pfn_to_page(pfn));
+}
+
 /**
  * page_ext_get() - Get the extended information for a page.
  * @page: The page we're interested in.
-- 
2.48.1


