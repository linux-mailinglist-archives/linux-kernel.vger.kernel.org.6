Return-Path: <linux-kernel+bounces-223916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D280911A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5CB23182
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB313E88C;
	Fri, 21 Jun 2024 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRbg5wZp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364F13CFB8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948527; cv=none; b=rJP5ulq/IrLohKdfbK2JMBN7HIp0m3GaJfsE3NIkoFNfVEiLpWeRCv/BVQRefeBO7Fkh1DP5WVTpZjom1irzpp74RB5ruqgsAoAK+Zv3S8h3Ac47eARcZtL/uoH8J+OXyEPwJZ3VNjB45WVelkbeLuwrvfMwgYKP2Dsg8ouHbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948527; c=relaxed/simple;
	bh=nrW0QvxLKLlDHZUd0Xa2UXqPdoTHBMmkz4AnWaU+jyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRZL2NKDkAMWefoDI+gIBYVA6LDB1ijF6bHiwe8db5QYzA3vKbCi5DEC8DB1E+LTtTbkuOYyzQfC5/hdbQyCVL2CDQOlnC4OFSlPQMPxspQwzHFeDMLr8ADywi9rhU73ZL/YXXGxj77eYJZH/N1RLrR4P4H3rJrlo8Vd1lbsj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRbg5wZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DADC4AF0A;
	Fri, 21 Jun 2024 05:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948527;
	bh=nrW0QvxLKLlDHZUd0Xa2UXqPdoTHBMmkz4AnWaU+jyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRbg5wZpEC9mSEW33Mg+dxiP8pUoi07ZZ/5F/960HRxTGr8p88LrW+F7XECclmEQl
	 c9eBg3G/dL2KRKCuhTn6ckQKH5geiK9dUhWc66Uvkf44QjZrkLszJJPW+rbg92AKJI
	 sTIqfeF4GpOYKmdvdQY2sR4qJ1T9QBF3O9ZfqtwKW6DK1B8NpGP2pJZuN8C3EJwbjq
	 fKzlvXmy0auuOFcFNp8iZeqNUXgq2lGT0nSv62pFsCeLR73b0y/mgXvSQAPlpq8wjA
	 H0WmCMVCCZFAt1sLB4fTlXvI51DjEhP819kD3TdnzWezEAuF7mgPHBhTs9d6p7IhXN
	 u46tfDHGJD5lA==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 01/15] mm/z3fold: add zpdesc struct and helper and use them in z3fold_page_isolate
Date: Fri, 21 Jun 2024 13:46:41 +0800
Message-ID: <20240621054658.1220796-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The 1st patch here, we introduce some helper functions along with struct
zpdesc, like zpdesc_page/zpdesc_folio/page_zpdesc and zpdesc_address
similar with folio_address, and convert page to zpdesc in func
z3fold_page_isolate. z3fold_page_isolate() hooked to page_isolate that
the reason we could not fully remove page from its parameter for now.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 14 ++++++++------
 mm/zpdesc.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 6 deletions(-)
 create mode 100644 mm/zpdesc.h

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2ebfed32871b..b1229c0520f1 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
 #include <linux/kmemleak.h>
+#include "zpdesc.h"
 
 /*
  * NCHUNKS_ORDER determines the internal allocation granularity, effectively
@@ -1251,22 +1252,23 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct z3fold_header *zhdr;
 	struct z3fold_pool *pool;
+	struct zpdesc *zpdesc = page_zpdesc(page);
 
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
+	VM_BUG_ON_PAGE(PageIsolated(zpdesc_page(zpdesc)), zpdesc_page(zpdesc));
 
-	if (test_bit(PAGE_HEADLESS, &page->private))
+	if (test_bit(PAGE_HEADLESS, &zpdesc->zppage_flag))
 		return false;
 
-	zhdr = page_address(page);
+	zhdr = zpdesc_address(zpdesc);
 	z3fold_page_lock(zhdr);
-	if (test_bit(NEEDS_COMPACTING, &page->private) ||
-	    test_bit(PAGE_STALE, &page->private))
+	if (test_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag) ||
+	    test_bit(PAGE_STALE, &zpdesc->zppage_flag))
 		goto out;
 
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0)
 		goto out;
 
-	if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+	if (test_and_set_bit(PAGE_CLAIMED, &zpdesc->zppage_flag))
 		goto out;
 	pool = zhdr_to_pool(zhdr);
 	spin_lock(&pool->lock);
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
new file mode 100644
index 000000000000..d51785863596
--- /dev/null
+++ b/mm/zpdesc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* zpdesc.h: zswap.zpool memory descriptor
+ *
+ * Written by Alex Shi (Tencent) <alexs@kernel.org>
+ */
+#ifndef __MM_ZPDESC_H__
+#define __MM_ZPDESC_H__
+
+/*
+ * struct zpdesc -	Memory descriptor for z3fold memory
+ * @flags:		Page flags, PG_locked for headless z3fold memory
+ * @lru:		Indirected used by page migration
+ * @zppage_flag:	z3fold memory flags
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct zpdesc {
+	unsigned long flags;
+	struct list_head lru;
+	unsigned long _zp_pad_1;
+	unsigned long _zp_pad_2;
+	unsigned long zppage_flag;
+};
+#define ZPDESC_MATCH(pg, zp) \
+	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
+
+ZPDESC_MATCH(flags, flags);
+ZPDESC_MATCH(lru, lru);
+ZPDESC_MATCH(private, zppage_flag);
+#undef ZPDESC_MATCH
+static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
+
+#define zpdesc_page(zp)			(_Generic((zp),			\
+	const struct zpdesc *:		(const struct page *)(zp),	\
+	struct zpdesc *:		(struct page *)(zp)))
+
+#define zpdesc_folio(zp)		(_Generic((zp),			\
+	const struct zpdesc *:		(const struct folio *)(zp),	\
+	struct zpdesc *:		(struct folio *)(zp)))
+
+#define page_zpdesc(p)			(_Generic((p),			\
+	const struct page *:		(const struct zpdesc *)(p),	\
+	struct page *:			(struct zpdesc *)(p)))
+
+static inline void *zpdesc_address(const struct zpdesc *zpdesc)
+{
+	return folio_address(zpdesc_folio(zpdesc));
+}
+
+#endif
-- 
2.43.0


