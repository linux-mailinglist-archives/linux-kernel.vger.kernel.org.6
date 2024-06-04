Return-Path: <linux-kernel+bounces-200317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D508FAE64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621542847A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B8144D10;
	Tue,  4 Jun 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g2P48wKc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA782144317
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492159; cv=none; b=RN7rj/Umu3rHP/l9zkuauqESfUmbcDM6Y/LtdYTx/zGJxZUnFUXUZZxWH4I1VUPzlFPVj6bgJ596V0xrGj5nBtX3YFlnMbZpFhAjSzaupRrbcjEzE4L6TJEEiF4vb+qUbNhPfW12zizb5b6XW8c+wTu4Oe2A7C2nNn9TAuCUtvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492159; c=relaxed/simple;
	bh=7KHwc80u0MdxH3ly7D3UFHG1v4F0rKQH8Y4sOrdUBRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVxLDAcZuKmSNWKdE8Q4L74mRN2ZcSKu9DEeQjJ+A8shmj5Ndpts0mUj0CssidwPOTKwe1N+NGkZzGmIM9uWHF5d+LuzF87AwRMMEuEx8d5XKXGuBDDIto0zAApvIOcZ30szGiQgiYZITOErxJJkQQj+oEaJ3RZrHaxAD2aS+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g2P48wKc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so406899966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492155; x=1718096955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGA97Ct+cPd+7V/cTW+dx47R1ZSFkzyCh6qF0w1u/vk=;
        b=g2P48wKcC2NlTaNih8WWD+KAegFvx7fibw4lBId7ZzBvHTvTg835iLH3OfSrI+v1A7
         F7JIeKXXd9GBdnalGEh1dcHKtGpAMrnbnRgOTv2ceLkmAIwfJE5tBvblI6OZSejc1uCX
         J5V+2M7GIPij3VoYnKZeMyE6Fw5FMV1kXpf+jtW8rzhMVg9maKc05wbAFramKxdnkNK1
         4D5YAIlOa2p7IRIHG13S/3hhwpHB5vQmxgi7tMYM5P2HgLZjdLp9pFqfzmOMSS8tTOob
         kK+jF+vrSTAF4GUWz7VM5hfhBFQJMRzv4eP7F8szzuwFfC/RHE7NMIkB7Hw3kePs6yIk
         c60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492155; x=1718096955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGA97Ct+cPd+7V/cTW+dx47R1ZSFkzyCh6qF0w1u/vk=;
        b=P9Dm+HvhcP0PTqsMGuA6E9U5XSncF/NPR5eZSfdBIGNA7ooz789MTJbdollorceRDk
         6j2tmhx34km1+vbP1Osl2NDmeZDWsuLFE1JIM+EeetJzuno+I4gx9TWBPcqKwfvmGJoo
         rOC0nRGHMJeTE6cO1oUAlevpLDIdo7n1B/0KAFENU7uH0VvJxlpZ5r9q74FsWtc0qxzT
         Ynuyz2nl9MWX65c0ydzsDqKnJKlyOT8Hed4J4ejteLKFuPFs6udz/dhL95y6g7Kl2NdQ
         +z+TGRGXRcXbgJJT4FMbY8G+Euq4qtiNOYmuVj3GByE2kJzoDvx0Ua5AQLMXAL0PK9Si
         O11A==
X-Forwarded-Encrypted: i=1; AJvYcCXKxZZtaJ1SuQBTELmjzQGfyogss71KZCvev9aYjriBR8dffvfq0qRx/IWJaPGg+KYnBjEotrnPYALrcXyNj+8Zjzt8LbQ8P7fP6/Es
X-Gm-Message-State: AOJu0YykzhEbSbKgIOiUrYXydOYANfQpkCQA/Ba3P1MF/wkKC6BV2WlW
	lbl7u3+G6Ry4Zgrt7nzfbQq/EO7NNYCl2KPJ51J5QXAmJxa4Fn9XFemIoWvmAAc=
X-Google-Smtp-Source: AGHT+IEsb+sDgUGZexqUFY3hraRHpEBznY4zG62l35w3uux2zbvBuWOtU9Ps2+jctDU3Yl2qZVDwFQ==
X-Received: by 2002:a17:907:516:b0:a59:b88c:2b2a with SMTP id a640c23a62f3a-a6821b71cdemr586561966b.50.1717492155201;
        Tue, 04 Jun 2024 02:09:15 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:14 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 07/15] linux/mm.h: move folio_size(), ... to mm/folio_size.h
Date: Tue,  4 Jun 2024 11:08:37 +0200
Message-Id: <20240604090845.2182265-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies on linux/mm.h.

folio_size()/page_size() are used by the following popular headers:

- linux/highmem.h
- linux/iov_iter.h
- linux/pagemap.h

Moving them to a separate lean header will allow us to avoid the
dependency on linux/mm.h.  Additionally, it allows us to move
folio_next() to a separate header, because it needs folio_nr_pages()
which is also moved to folio_size.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 140 +------------------------------
 include/linux/mm/folio_size.h | 150 ++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 139 deletions(-)
 create mode 100644 include/linux/mm/folio_size.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 014db2b39c16..b11bbbdd2754 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1069,38 +1070,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-/*
- * compound_order() can be called without holding a reference, which means
- * that niceties like page_folio() don't work.  These callers should be
- * prepared to handle wild return values.  For example, PG_head may be
- * set before the order is initialised, or this may be a tail page.
- * See compaction.c for some good examples.
- */
-static inline unsigned int compound_order(struct page *page)
-{
-	struct folio *folio = (struct folio *)page;
-
-	if (!test_bit(PG_head, &folio->flags))
-		return 0;
-	return folio->_flags_1 & 0xff;
-}
-
-/**
- * folio_order - The allocation order of a folio.
- * @folio: The folio.
- *
- * A folio is composed of 2^order pages.  See get_order() for the definition
- * of order.
- *
- * Return: The order of the folio.
- */
-static inline unsigned int folio_order(struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return 0;
-	return folio->_flags_1 & 0xff;
-}
-
 #include <linux/huge_mm.h>
 
 /*
@@ -1303,39 +1272,6 @@ void folio_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
-/* Returns the number of bytes in this potentially compound page. */
-static inline unsigned long page_size(struct page *page)
-{
-	return PAGE_SIZE << compound_order(page);
-}
-
-/* Returns the number of bits needed for the number of bytes in a page */
-static inline unsigned int page_shift(struct page *page)
-{
-	return PAGE_SHIFT + compound_order(page);
-}
-
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_order(page);
-}
-
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
@@ -1973,23 +1909,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
-/**
- * folio_nr_pages - The number of pages in the folio.
- * @folio: The folio.
- *
- * Return: A positive power of two.
- */
-static inline long folio_nr_pages(const struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << (folio->_flags_1 & 0xff);
-#endif
-}
-
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 #define MAX_FOLIO_NR_PAGES	(1UL << PUD_ORDER)
@@ -1997,33 +1916,6 @@ static inline long folio_nr_pages(const struct folio *folio)
 #define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
 #endif
 
-/*
- * compound_nr() returns the number of pages in this potentially compound
- * page.  compound_nr() can be called on a tail page, and is defined to
- * return 1 in that case.
- */
-static inline unsigned long compound_nr(struct page *page)
-{
-	struct folio *folio = (struct folio *)page;
-
-	if (!test_bit(PG_head, &folio->flags))
-		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << (folio->_flags_1 & 0xff);
-#endif
-}
-
-/**
- * thp_nr_pages - The number of regular pages in this huge page.
- * @page: The head page of a huge page.
- */
-static inline int thp_nr_pages(struct page *page)
-{
-	return folio_nr_pages((struct folio *)page);
-}
-
 /**
  * folio_next - Move to the next physical folio.
  * @folio: The folio we're currently operating on.
@@ -2043,36 +1935,6 @@ static inline struct folio *folio_next(struct folio *folio)
 	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
 }
 
-/**
- * folio_shift - The size of the memory described by this folio.
- * @folio: The folio.
- *
- * A folio represents a number of bytes which is a power-of-two in size.
- * This function tells you which power-of-two the folio is.  See also
- * folio_size() and folio_order().
- *
- * Context: The caller should have a reference on the folio to prevent
- * it from being split.  It is not necessary for the folio to be locked.
- * Return: The base-2 logarithm of the size of this folio.
- */
-static inline unsigned int folio_shift(struct folio *folio)
-{
-	return PAGE_SHIFT + folio_order(folio);
-}
-
-/**
- * folio_size - The number of bytes in a folio.
- * @folio: The folio.
- *
- * Context: The caller should have a reference on the folio to prevent
- * it from being split.  It is not necessary for the folio to be locked.
- * Return: The number of bytes in this folio.
- */
-static inline size_t folio_size(struct folio *folio)
-{
-	return PAGE_SIZE << folio_order(folio);
-}
-
 /**
  * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
  *				tables of more than one MM
diff --git a/include/linux/mm/folio_size.h b/include/linux/mm/folio_size.h
new file mode 100644
index 000000000000..e7cd567cf069
--- /dev/null
+++ b/include/linux/mm/folio_size.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_SIZE_H
+#define _LINUX_MM_FOLIO_SIZE_H
+
+#include <linux/bitops.h> // for test_bit()
+#include <linux/mmdebug.h> // for VM_BUG_ON_PGFLAGS()
+#include <linux/mm_types.h> // for struct page
+#include <linux/page-flags.h> // for folio_test_large()
+#include <asm/page.h> // for PAGE_SIZE, PAGE_SHIFT
+
+/*
+ * compound_order() can be called without holding a reference, which means
+ * that niceties like page_folio() don't work.  These callers should be
+ * prepared to handle wild return values.  For example, PG_head may be
+ * set before the order is initialised, or this may be a tail page.
+ * See compaction.c for some good examples.
+ */
+static inline unsigned int compound_order(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (!test_bit(PG_head, &folio->flags))
+		return 0;
+	return folio->_flags_1 & 0xff;
+}
+
+/**
+ * folio_order - The allocation order of a folio.
+ * @folio: The folio.
+ *
+ * A folio is composed of 2^order pages.  See get_order() for the definition
+ * of order.
+ *
+ * Return: The order of the folio.
+ */
+static inline unsigned int folio_order(struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 0;
+	return folio->_flags_1 & 0xff;
+}
+
+/* Returns the number of bytes in this potentially compound page. */
+static inline unsigned long page_size(struct page *page)
+{
+	return PAGE_SIZE << compound_order(page);
+}
+
+/* Returns the number of bits needed for the number of bytes in a page */
+static inline unsigned int page_shift(struct page *page)
+{
+	return PAGE_SHIFT + compound_order(page);
+}
+
+/**
+ * thp_order - Order of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ */
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return compound_order(page);
+}
+
+/**
+ * thp_size - Size of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ *
+ * Return: Number of bytes in this page.
+ */
+static inline unsigned long thp_size(struct page *page)
+{
+	return PAGE_SIZE << thp_order(page);
+}
+
+/**
+ * folio_nr_pages - The number of pages in the folio.
+ * @folio: The folio.
+ *
+ * Return: A positive power of two.
+ */
+static inline long folio_nr_pages(const struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 1;
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << (folio->_flags_1 & 0xff);
+#endif
+}
+
+/*
+ * compound_nr() returns the number of pages in this potentially compound
+ * page.  compound_nr() can be called on a tail page, and is defined to
+ * return 1 in that case.
+ */
+static inline unsigned long compound_nr(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (!test_bit(PG_head, &folio->flags))
+		return 1;
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << (folio->_flags_1 & 0xff);
+#endif
+}
+
+/**
+ * thp_nr_pages - The number of regular pages in this huge page.
+ * @page: The head page of a huge page.
+ */
+static inline int thp_nr_pages(struct page *page)
+{
+	return folio_nr_pages((struct folio *)page);
+}
+
+/**
+ * folio_shift - The size of the memory described by this folio.
+ * @folio: The folio.
+ *
+ * A folio represents a number of bytes which is a power-of-two in size.
+ * This function tells you which power-of-two the folio is.  See also
+ * folio_size() and folio_order().
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The base-2 logarithm of the size of this folio.
+ */
+static inline unsigned int folio_shift(struct folio *folio)
+{
+	return PAGE_SHIFT + folio_order(folio);
+}
+
+/**
+ * folio_size - The number of bytes in a folio.
+ * @folio: The folio.
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The number of bytes in this folio.
+ */
+static inline size_t folio_size(struct folio *folio)
+{
+	return PAGE_SIZE << folio_order(folio);
+}
+
+#endif /* _LINUX_MM_FOLIO_SIZE_H_H */
-- 
2.39.2


