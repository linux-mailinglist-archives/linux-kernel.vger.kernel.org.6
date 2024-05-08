Return-Path: <linux-kernel+bounces-173710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1438C0471
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B616228B058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D7131BDB;
	Wed,  8 May 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALTqjdQP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2ED17BD8
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193037; cv=none; b=nf2DVdgbDgLk+/GmT/im68iH0NQrb6KR4eFJAl7Tfw2yuV1EY6ZJuSxOEI/BAACvlairY6NFxEEZygJEwKlHUYQsgXsutScI8W3rUh56HDT6gOEMCwubObgrd27FPIQ6GrfI+b/aE5UL6grdd4G7tLjIUSlgov2K6sFf8XBw8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193037; c=relaxed/simple;
	bh=Gl61C4Yrf98SVELY1sTLyUGC7wQLdfaYgrG7toz6VSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX6Hp5UX8QfZc23ubJTRE5PQTjc+s259rZC/NvGK2sRdN6mmFVKrr4/QOzeTlfx9in8P9F836xtG8sFEcs5Qblg0korLP2aVXQVsiHxftF8WKj/w+zwtsweuMyVmZPpvsm3h8d+ThGmkqUixjYMI1du+Q6Oxs9T0Tvpyum2YqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALTqjdQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1Z+J8quytt2snZdjyP4ZLJgakuTHRL3E7kE9W77lyE=;
	b=ALTqjdQPHOXQ89lSHbwzMBo3fuuFpK43/tDVR8Bblq5xmGMwTOVw3LpEYunajvEjoUMtZ9
	HrpzW9oCvEoBrZCJls2NSn8UH7LBtPcGays+YZCaKE6rujxTHmS4dpb3QAa6Qii76HDQDc
	iDpVrlSbJjXVtS9GweoKPHrQcd88GGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-0bovWoBAO1qJVAY-sqUAiw-1; Wed, 08 May 2024 14:30:31 -0400
X-MC-Unique: 0bovWoBAO1qJVAY-sqUAiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 062F28029ED;
	Wed,  8 May 2024 18:30:30 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21D1910009E6;
	Wed,  8 May 2024 18:30:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 09/10] s390/uv: implement HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
Date: Wed,  8 May 2024 20:29:54 +0200
Message-ID: <20240508182955.358628-10-david@redhat.com>
In-Reply-To: <20240508182955.358628-1-david@redhat.com>
References: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Let's also implement HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE, so we can convert
arch_make_page_accessible() to be a simple wrapper around
arch_make_folio_accessible(). Unfortuantely, we cannot do that in the
header.

There are only two arch_make_page_accessible() calls remaining in gup.c.
We can now drop HAVE_ARCH_MAKE_PAGE_ACCESSIBLE completely form core-MM.
We'll handle that separately, once the s390x part landed.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/page.h |  3 +++
 arch/s390/kernel/uv.c        | 18 +++++++++++-------
 arch/s390/mm/fault.c         | 14 ++++++++------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index ecbf4b626f46..5ec41ec3d761 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -162,6 +162,7 @@ static inline int page_reset_referenced(unsigned long addr)
 #define _PAGE_ACC_BITS		0xf0	/* HW access control bits	*/
 
 struct page;
+struct folio;
 void arch_free_page(struct page *page, int order);
 void arch_alloc_page(struct page *page, int order);
 
@@ -174,6 +175,8 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define HAVE_ARCH_ALLOC_PAGE
 
 #if IS_ENABLED(CONFIG_PGSTE)
+int arch_make_folio_accessible(struct folio *folio);
+#define HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 int arch_make_page_accessible(struct page *page);
 #define HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 #endif
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index b456066d72da..fa62fa0e369f 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -498,14 +498,13 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 EXPORT_SYMBOL_GPL(gmap_destroy_page);
 
 /*
- * To be called with the page locked or with an extra reference! This will
- * prevent gmap_make_secure from touching the page concurrently. Having 2
- * parallel make_page_accessible is fine, as the UV calls will become a
- * no-op if the page is already exported.
+ * To be called with the folio locked or with an extra reference! This will
+ * prevent gmap_make_secure from touching the folio concurrently. Having 2
+ * parallel arch_make_folio_accessible is fine, as the UV calls will become a
+ * no-op if the folio is already exported.
  */
-int arch_make_page_accessible(struct page *page)
+int arch_make_folio_accessible(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int rc = 0;
 
 	/* See gmap_make_secure(): large folios cannot be secure */
@@ -537,8 +536,13 @@ int arch_make_page_accessible(struct page *page)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(arch_make_page_accessible);
+EXPORT_SYMBOL_GPL(arch_make_folio_accessible);
 
+int arch_make_page_accessible(struct page *page)
+{
+	return arch_make_folio_accessible(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(arch_make_page_accessible);
 #endif
 
 #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) || IS_ENABLED(CONFIG_KVM)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c421dd44ffbe..a1ba58460593 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -491,6 +491,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 	unsigned long addr = get_fault_address(regs);
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
+	struct folio *folio;
 	struct page *page;
 	struct gmap *gmap;
 	int rc;
@@ -538,17 +539,18 @@ void do_secure_storage_access(struct pt_regs *regs)
 			mmap_read_unlock(mm);
 			break;
 		}
-		if (arch_make_page_accessible(page))
+		folio = page_folio(page);
+		if (arch_make_folio_accessible(folio))
 			send_sig(SIGSEGV, current, 0);
-		put_page(page);
+		folio_put(folio);
 		mmap_read_unlock(mm);
 		break;
 	case KERNEL_FAULT:
-		page = phys_to_page(addr);
-		if (unlikely(!try_get_page(page)))
+		folio = phys_to_folio(addr);
+		if (unlikely(!folio_try_get(folio)))
 			break;
-		rc = arch_make_page_accessible(page);
-		put_page(page);
+		rc = arch_make_folio_accessible(folio);
+		folio_put(folio);
 		if (rc)
 			BUG();
 		break;
-- 
2.45.0


