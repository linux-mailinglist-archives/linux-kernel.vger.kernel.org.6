Return-Path: <linux-kernel+bounces-360908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E498399A13E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2043F1C21D32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A7212EE0;
	Fri, 11 Oct 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwC02mub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47548212636
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642310; cv=none; b=THicebn4t/MJF4/vnwRB+ANnpuBFSFxljaCmd4DmST58ITN5FQ7/0F7bOZ01kE33bW5p6qWzYJZw+wHTfGlO2ELAV0ltYQsmGadf0p/crLXAJ6ktpc5LuH55L1YFOeqvHhH0TuC5n8PDVBrv7l+HZ88ScgDzpqSBepiD8vhCMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642310; c=relaxed/simple;
	bh=r91IR9RnNN1IZS82gFZ8gu0zseWnOomd+jSCq/BfdW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/gzzsDErBqS7rikC9qOTqVokWSfBIGnBtIIC0YKXHIXalH2+gABuZj7yQYw0jsKvKOCA2PpMIj4uq2XDwysLgoZ79MwyPS7m5JMTOXESQGnqvzn6k4znnMr5QL7TSv8n3X2m+mp3FpCK35iFkbq2/6evtuexwkO4W1XW1C+XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwC02mub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728642308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMssNf1Ju+sw1bhZpq8lk0Jjp7pzX4VBi27YvpYNCzI=;
	b=GwC02mubEUTY23xg2FFWDQhWk9t72BxKwpAnygBwgGs2taH/e22kw7BR3AFwWamoCUvD30
	ExgrYxdhb8p4r/eRj1lwEaNwBmI3rgDLMOm/gSl7CMqdRaYsKJeEy283ugzGdcJHF3Wp5p
	K62j2KyXFZBiL66NAwAziQ0esG7TjME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-pXT2G1CgOGWkQX4PSZq0Wg-1; Fri,
 11 Oct 2024 06:25:00 -0400
X-MC-Unique: pXT2G1CgOGWkQX4PSZq0Wg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D2C11955F07;
	Fri, 11 Oct 2024 10:24:58 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.80.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B6E91955F42;
	Fri, 11 Oct 2024 10:24:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 1/2] mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()
Date: Fri, 11 Oct 2024 12:24:44 +0200
Message-ID: <20241011102445.934409-2-david@redhat.com>
In-Reply-To: <20241011102445.934409-1-david@redhat.com>
References: <20241011102445.934409-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add vma_thp_disabled() and thp_disabled_by_hw() helpers to be shared by
shmem_allowable_huge_orders() and __thp_vma_allowable_orders().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
[ rename to vma_thp_disabled(), split out thp_disabled_by_hw() ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/huge_memory.c        | 13 +------------
 mm/shmem.c              |  7 +------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 67d0ab3c3bba..ef5b80e48599 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -322,6 +322,24 @@ struct thpsize {
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
+static inline bool vma_thp_disabled(struct vm_area_struct *vma,
+		unsigned long vm_flags)
+{
+	/*
+	 * Explicitly disabled through madvise or prctl, or some
+	 * architectures may disable THP for some mappings, for
+	 * example, s390 kvm.
+	 */
+	return (vm_flags & VM_NOHUGEPAGE) ||
+	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
+}
+
+static inline bool thp_disabled_by_hw(void)
+{
+	/* If the hardware/firmware marked hugepage support disabled. */
+	return transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED);
+}
+
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87b49ecc7b1e..2fb328880b50 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -109,18 +109,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	/*
-	 * Explicitly disabled through madvise or prctl, or some
-	 * architectures may disable THP for some mappings, for
-	 * example, s390 kvm.
-	 * */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return 0;
-	/*
-	 * If the hardware/firmware marked hugepage support disabled.
-	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/shmem.c b/mm/shmem.c
index 4f11b5506363..c5adb987b23c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1664,12 +1664,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	loff_t i_size;
 	int order;
 
-	if (vma && ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
-		return 0;
-
-	/* If the hardware/firmware marked hugepage support disabled. */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
 		return 0;
 
 	global_huge = shmem_huge_global_enabled(inode, index, write_end,
-- 
2.46.1


