Return-Path: <linux-kernel+bounces-263424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094293D5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4181F2110B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8817C21F;
	Fri, 26 Jul 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekoM1XeE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1D17334E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006492; cv=none; b=Q1VDDdAUDux9MT6P+FdoFfMPap9B7vU8ARI2rt6q0BzDe5Qog5PeDdWWhrmm4PwVZkMav7wgx9S+CrlZbReVv59PUeH4zTlZRHPpe4IVZjntzCGYeb6wHKkj4hd9YfjPc2D4o7EEchQPyf9HKjs+2N4OPa0c3psAYdHHvoOL39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006492; c=relaxed/simple;
	bh=94YMEgyvK50wXc8j/dEoj47Wl2fHT9Xd2AvGMVVK88k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wdx1hMz54rWZGx7y1QubrD1ZVdi3qd7steagZqJo29e5VoKacLFOQpqDE+vy7CT+Abt6BoJWDy9TW0ci5Ktu+tP6/Sz2f709nXsfQlltUHNec0qA2KIZSWIMqlTE19/4Tsa0vLDMEFk5ud27x3CZkOkMLvngeZufUnkQlv2eXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekoM1XeE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722006490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gclXSPT2RuzrPlofvNqS2CiD4N2Pif5SxTyxuMydzCs=;
	b=ekoM1XeEGewFpWmvKd8XUGfCK0Fm3t2kXd2sCJxEgiWf9EwoZbDjb0vAdkqMzbTaPy8eGP
	a3YwMljDWYrajc8Yum1Uotsj6odyaJXmMFbXpzC0yA2c6A1/XS5BVflhrCNzIiEXC4eXYf
	yxw5jwGCNZRlYzBs4rv8GQMTv/C5tZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-CIqENtZwNcGlPB5wTz9pqg-1; Fri,
 26 Jul 2024 11:08:04 -0400
X-MC-Unique: CIqENtZwNcGlPB5wTz9pqg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 336DD1955D50;
	Fri, 26 Jul 2024 15:08:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D50641955D45;
	Fri, 26 Jul 2024 15:07:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 2/3] mm/hugetlb: enforce that PMD PT sharing has split PMD PT locks
Date: Fri, 26 Jul 2024 17:07:27 +0200
Message-ID: <20240726150728.3159964-3-david@redhat.com>
In-Reply-To: <20240726150728.3159964-1-david@redhat.com>
References: <20240726150728.3159964-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Sharing page tables between processes but falling back to per-MM page
table locks cannot possibly work.

So, let's make sure that we do have split PMD locks by adding a new
Kconfig option and letting that depend on CONFIG_SPLIT_PMD_PTLOCKS.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/Kconfig              | 4 ++++
 include/linux/hugetlb.h | 5 ++---
 mm/hugetlb.c            | 8 ++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f6..0e4efec1d92e6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -288,6 +288,10 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
 
+config HUGETLB_PMD_PAGE_TABLE_SHARING
+	def_bool HUGETLB_PAGE
+	depends on ARCH_WANT_HUGE_PMD_SHARE && SPLIT_PMD_PTLOCKS
+
 config ARCH_HAS_GIGANTIC_PAGE
 	bool
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index da800e56fe590..4d2f3224ff027 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1243,7 +1243,7 @@ static inline __init void hugetlb_cma_reserve(int order)
 }
 #endif
 
-#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static inline bool hugetlb_pmd_shared(pte_t *pte)
 {
 	return page_count(virt_to_page(pte)) > 1;
@@ -1279,8 +1279,7 @@ bool __vma_private_lock(struct vm_area_struct *vma);
 static inline pte_t *
 hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 {
-#if defined(CONFIG_HUGETLB_PAGE) && \
-	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
+#if defined(CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING) && defined(CONFIG_LOCKDEP)
 	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0858a18272073..c4d94e122c41f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7211,7 +7211,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static unsigned long page_table_shareable(struct vm_area_struct *svma,
 				struct vm_area_struct *vma,
 				unsigned long addr, pgoff_t idx)
@@ -7373,7 +7373,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	return 1;
 }
 
-#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+#else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
@@ -7396,7 +7396,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
 	return false;
 }
-#endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+#endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -7494,7 +7494,7 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 /* See description above.  Architectures can provide their own version. */
 __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 {
-#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 	if (huge_page_size(h) == PMD_SIZE)
 		return PUD_SIZE - PMD_SIZE;
 #endif
-- 
2.45.2


