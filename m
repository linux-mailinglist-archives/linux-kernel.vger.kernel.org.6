Return-Path: <linux-kernel+bounces-173708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F98C046D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA6B26DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14012F592;
	Wed,  8 May 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlVGU/9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8326131192
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193030; cv=none; b=BX/AdKONsFfrzlGMn/UuOLdJfxrg+VCfzisFDhlQu909PlbioET2kbD8fW2FU8cKDol905uNmfT2VDE3yDdPigYIYad4GD8w8RX8hu1SpblRWkblJbpbSo3Fj0UFUqEK3pdmCTB4DeaE1AtYx+VY2fse0lLxSZvwMZ9p9omSbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193030; c=relaxed/simple;
	bh=RCFyXe/BmA1iPRJlNpc5XH55iNq6jN4Rs2YhPKESAJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOArMoYymV9gtVfn8SjQcEzu2tCXg3syaYJdbCgA+in8RSqqogvmol+ItpN9OIRon6D0HUkcHaftSK0ZiOIwNZ9ZzS1pRcHEuvHJ2gmOeOrtHuDVn0tHvHqMPtvbTuXtcFl+hAT/vuSs2yBq3IvrKWNXX6Pa6gSbv7WgesBatsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlVGU/9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3de0fVoMVHbuon76Xrh/32/a2y385Ila18Wd+gfyMM=;
	b=SlVGU/9INJ2tmMbVuo7tqZB78oGg2VtV0/zxRMGBT1PHpFy1ARsHV2k+Kw36TWB2hN8GRR
	NR+cOu7CyFbTKuy/pK/T3n53iIiUZXA0sW+NK+XMKFbEypEeHdR4oXywbW/vZPlCVnAeT/
	cnRlye55IgiRwrTjyky77jCwYIXQbpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-X7Y5rMQRP0KRA-GwPdjdcA-1; Wed, 08 May 2024 14:30:24 -0400
X-MC-Unique: X7Y5rMQRP0KRA-GwPdjdcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D906D801782;
	Wed,  8 May 2024 18:30:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43B6A1000DB4;
	Wed,  8 May 2024 18:30:20 +0000 (UTC)
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
Subject: [PATCH v3 07/10] s390/uv: convert uv_destroy_owned_page() to uv_destroy_(folio|pte)()
Date: Wed,  8 May 2024 20:29:52 +0200
Message-ID: <20240508182955.358628-8-david@redhat.com>
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

Let's have the following variants for destroying pages:

(1) uv_destroy(): Like uv_pin_shared() and uv_convert_from_secure(),
"low level" helper that operates on paddr and doesn't mess with folios.

(2) uv_destroy_folio(): Consumes a folio to which we hold a reference.

(3) uv_destroy_pte(): Consumes a PTE that holds a reference through the
mapping.

Unfortunately we need uv_destroy_pte(), because pfn_folio() and
friends are not available in pgtable.h.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/include/asm/uv.h      | 10 ++++++++--
 arch/s390/kernel/uv.c           | 24 +++++++++++++++++-------
 arch/s390/mm/gmap.c             |  6 ++++--
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6f11d063d545..f65db37917f2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1215,7 +1215,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	 * The notifier should have destroyed all protected vCPUs at this
 	 * point, so the destroy should be successful.
 	 */
-	if (full && !uv_destroy_owned_page(pte_val(res) & PAGE_MASK))
+	if (full && !uv_destroy_pte(res))
 		return res;
 	/*
 	 * If something went wrong and the page could not be destroyed, or
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index d2205ff97007..a1bef30066ef 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -483,7 +483,8 @@ static inline int is_prot_virt_host(void)
 int uv_pin_shared(unsigned long paddr);
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
-int uv_destroy_owned_page(unsigned long paddr);
+int uv_destroy_folio(struct folio *folio);
+int uv_destroy_pte(pte_t pte);
 int uv_convert_owned_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
@@ -497,7 +498,12 @@ static inline int uv_pin_shared(unsigned long paddr)
 	return 0;
 }
 
-static inline int uv_destroy_owned_page(unsigned long paddr)
+static inline int uv_destroy_folio(struct folio *folio)
+{
+	return 0;
+}
+
+static inline int uv_destroy_pte(pte_t pte)
 {
 	return 0;
 }
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 3d3250b406a6..61c1ce51c883 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -110,7 +110,7 @@ EXPORT_SYMBOL_GPL(uv_pin_shared);
  *
  * @paddr: Absolute host address of page to be destroyed
  */
-static int uv_destroy_page(unsigned long paddr)
+static int uv_destroy(unsigned long paddr)
 {
 	struct uv_cb_cfs uvcb = {
 		.header.cmd = UVC_CMD_DESTR_SEC_STOR,
@@ -131,11 +131,10 @@ static int uv_destroy_page(unsigned long paddr)
 }
 
 /*
- * The caller must already hold a reference to the page
+ * The caller must already hold a reference to the folio
  */
-int uv_destroy_owned_page(unsigned long paddr)
+int uv_destroy_folio(struct folio *folio)
 {
-	struct folio *folio = phys_to_folio(paddr);
 	int rc;
 
 	/* See gmap_make_secure(): large folios cannot be secure */
@@ -143,13 +142,22 @@ int uv_destroy_owned_page(unsigned long paddr)
 		return 0;
 
 	folio_get(folio);
-	rc = uv_destroy_page(paddr);
+	rc = uv_destroy(folio_to_phys(folio));
 	if (!rc)
 		clear_bit(PG_arch_1, &folio->flags);
 	folio_put(folio);
 	return rc;
 }
 
+/*
+ * The present PTE still indirectly holds a folio reference through the mapping.
+ */
+int uv_destroy_pte(pte_t pte)
+{
+	VM_WARN_ON(!pte_present(pte));
+	return uv_destroy_folio(pfn_folio(pte_pfn(pte)));
+}
+
 /*
  * Requests the Ultravisor to encrypt a guest page and make it
  * accessible to the host for paging (export).
@@ -437,6 +445,7 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 {
 	struct vm_area_struct *vma;
 	unsigned long uaddr;
+	struct folio *folio;
 	struct page *page;
 	int rc;
 
@@ -460,7 +469,8 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 	page = follow_page(vma, uaddr, FOLL_WRITE | FOLL_GET);
 	if (IS_ERR_OR_NULL(page))
 		goto out;
-	rc = uv_destroy_owned_page(page_to_phys(page));
+	folio = page_folio(page);
+	rc = uv_destroy_folio(folio);
 	/*
 	 * Fault handlers can race; it is possible that two CPUs will fault
 	 * on the same secure page. One CPU can destroy the page, reboot,
@@ -472,7 +482,7 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 	 */
 	if (rc)
 		rc = uv_convert_owned_from_secure(page_to_phys(page));
-	put_page(page);
+	folio_put(folio);
 out:
 	mmap_read_unlock(gmap->mm);
 	return rc;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f2988bbcebbe..797068dccb73 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2841,13 +2841,15 @@ static const struct mm_walk_ops gather_pages_ops = {
  */
 void s390_uv_destroy_pfns(unsigned long count, unsigned long *pfns)
 {
+	struct folio *folio;
 	unsigned long i;
 
 	for (i = 0; i < count; i++) {
+		folio = pfn_folio(pfns[i]);
 		/* we always have an extra reference */
-		uv_destroy_owned_page(pfn_to_phys(pfns[i]));
+		uv_destroy_folio(folio);
 		/* get rid of the extra reference */
-		put_page(pfn_to_page(pfns[i]));
+		folio_put(folio);
 		cond_resched();
 	}
 }
-- 
2.45.0


