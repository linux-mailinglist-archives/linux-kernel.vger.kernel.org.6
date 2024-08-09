Return-Path: <linux-kernel+bounces-281201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778694D446
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23FEB2296A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBC19CCF2;
	Fri,  9 Aug 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCFXZ4vh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4219B3C6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219780; cv=none; b=LFToxInWQAQTM/oTuP8QuHQZk7+HBQpHzwfzlxW45qO5ZvgrZPjRcWrWDH0OjbG5XzpFV2JGG6DEqSkPaoKgchefXq/7Nom3cH7/7KSTcStU/FuulDorxAzncpf5kIIhYatgML19yDTNUIcQQw16JrHAvb23OnzH3eR8ve8sKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219780; c=relaxed/simple;
	bh=yfBU6y6kSdOFyZjcdoL0YKRvT9xfK+pyg+o4OfDl314=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr/3k+l+IdbGz6kyP3/n6sm5Ucm/vCVKrr19gMYlTFBmbnYRANNA77rkELH1rcJk8mBHtONsAAG0jnrob2JfNx7oKEoFrVqce7Szn9xEZyLgSY0MgkKiOx4dXTJMq+P2tT03NnLg0reKiPAuK+A0eoUYYTwkAlW5EBsNHRkuUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCFXZ4vh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXGL3lb2RETUVA/g/GpjABQk9U9hrAJ/lFeyUGjNHTs=;
	b=UCFXZ4vhMbtvOf7JuxO23tzqGl/ML7sXTCRlID+n7fKZ6GG9HgMHYxVk2m5A4N1OwebuHS
	2UfvU5Au06T5dG8873orcFME9Fh0jFbVQSScz2yRpITDkPeQyaXi9U8j00BtI5xWHoJngH
	0TVAzxwFqL9ZOEM4o2Pwz5oGw78drOU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-XvfV9HQbOdG3bOs3SbFAcQ-1; Fri, 09 Aug 2024 12:09:36 -0400
X-MC-Unique: XvfV9HQbOdG3bOs3SbFAcQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44ff25bbfe1so3070061cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219776; x=1723824576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXGL3lb2RETUVA/g/GpjABQk9U9hrAJ/lFeyUGjNHTs=;
        b=RZPG+Ye4wgF4Q9Mi35FF1K6IjX21l1hlNK334HlJ7+so8ulvx1bnxTxqNxvoeUfp84
         tAh5p7RVoP6+I1X8E3IkVBA5m11dHEmYuiUJ2calL7JesOkshvzLeRQAutJtYOgbME9R
         zi2r9Vx3muNvbNgP8HO2rihn5Yq18jF1HV2iK55yzk7PYuAb+nQqYJ8efZzo7wlfHXsK
         ABn21YgxVl0Kg6V0s6NNRo+MKuR+9VZzoOmji4BAHRwjsmsqG56mx5Rdxr1IydTEvjcj
         KUV47kDQgpJ/IDg+6X5E/5ClJzpypWEWAQLIuzava+V59C/kImz06lzzgMnAISav4mkl
         PrRw==
X-Forwarded-Encrypted: i=1; AJvYcCUnHw0rpPgqC2db5nfjd/cmHx8QhzhQ0mZEu4mJPdPQSLGCk6kZrhXPn6tJtXmlhsdlLMZP1i72pHKyF0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHb0FC2G31fLAqURM8nnR0eKS6SReIXeQFvvF5fkJEvpPZgauH
	3WlQaldyuCwRvl5tV1oP/Vws5FyKUmKAomDeTkCy1YwNVvOpBFVa7HVxJVMdYl5pAwVYJ7wJdso
	dyQqHlwWZ0uLV7YEEuiGQEqGV6in21ZX9zJCmT4fMomnyDDP0pRobrnn43wwpaA==
X-Received: by 2002:a05:622a:1b8e:b0:447:e636:9ea9 with SMTP id d75a77b69052e-4531251c724mr14428631cf.3.1723219775681;
        Fri, 09 Aug 2024 09:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUrJX3vSa/2Mr5PpFf2V5KDcJEixKltLA8oaEJqLbElyFRMCegYAzgvcdg3qK/Zl0Af+cLBA==
X-Received: by 2002:a05:622a:1b8e:b0:447:e636:9ea9 with SMTP id d75a77b69052e-4531251c724mr14428311cf.3.1723219775158;
        Fri, 09 Aug 2024 09:09:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 09/19] mm: New follow_pfnmap API
Date: Fri,  9 Aug 2024 12:08:59 -0400
Message-ID: <20240809160909.1023470-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a pair of APIs to follow pfn mappings to get entry information.
It's very similar to what follow_pte() does before, but different in that
it recognizes huge pfn mappings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  31 ++++++++++
 mm/memory.c        | 147 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 90ca84200800..7471302658af 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2374,6 +2374,37 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
+struct follow_pfnmap_args {
+	/**
+	 * Inputs:
+	 * @vma: Pointer to @vm_area_struct struct
+	 * @address: the virtual address to walk
+	 */
+	struct vm_area_struct *vma;
+	unsigned long address;
+	/**
+	 * Internals:
+	 *
+	 * The caller shouldn't touch any of these.
+	 */
+	spinlock_t *lock;
+	pte_t *ptep;
+	/**
+	 * Outputs:
+	 *
+	 * @pfn: the PFN of the address
+	 * @pgprot: the pgprot_t of the mapping
+	 * @writable: whether the mapping is writable
+	 * @special: whether the mapping is a special mapping (real PFN maps)
+	 */
+	unsigned long pfn;
+	pgprot_t pgprot;
+	bool writable;
+	bool special;
+};
+int follow_pfnmap_start(struct follow_pfnmap_args *args);
+void follow_pfnmap_end(struct follow_pfnmap_args *args);
+
 extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
diff --git a/mm/memory.c b/mm/memory.c
index 67496dc5064f..2194e0f9f541 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6338,6 +6338,153 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(follow_pte);
 
+static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
+				     spinlock_t *lock, pte_t *ptep,
+				     pgprot_t pgprot, unsigned long pfn_base,
+				     unsigned long addr_mask, bool writable,
+				     bool special)
+{
+	args->lock = lock;
+	args->ptep = ptep;
+	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
+	args->pgprot = pgprot;
+	args->writable = writable;
+	args->special = special;
+}
+
+static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_LOCKDEP
+	struct address_space *mapping = vma->vm_file->f_mapping;
+
+	if (mapping)
+		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
+			       lockdep_is_held(&vma->vm_mm->mmap_lock));
+	else
+		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
+#endif
+}
+
+/**
+ * follow_pfnmap_start() - Look up a pfn mapping at a user virtual address
+ * @args: Pointer to struct @follow_pfnmap_args
+ *
+ * The caller needs to setup args->vma and args->address to point to the
+ * virtual address as the target of such lookup.  On a successful return,
+ * the results will be put into other output fields.
+ *
+ * After the caller finished using the fields, the caller must invoke
+ * another follow_pfnmap_end() to proper releases the locks and resources
+ * of such look up request.
+ *
+ * During the start() and end() calls, the results in @args will be valid
+ * as proper locks will be held.  After the end() is called, all the fields
+ * in @follow_pfnmap_args will be invalid to be further accessed.
+ *
+ * If the PTE maps a refcounted page, callers are responsible to protect
+ * against invalidation with MMU notifiers; otherwise access to the PFN at
+ * a later point in time can trigger use-after-free.
+ *
+ * Only IO mappings and raw PFN mappings are allowed.  The mmap semaphore
+ * should be taken for read, and the mmap semaphore cannot be released
+ * before the end() is invoked.
+ *
+ * This function must not be used to modify PTE content.
+ *
+ * Return: zero on success, -ve otherwise.
+ */
+int follow_pfnmap_start(struct follow_pfnmap_args *args)
+{
+	struct vm_area_struct *vma = args->vma;
+	unsigned long address = args->address;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *lock;
+	pgd_t *pgdp;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	pfnmap_lockdep_assert(vma);
+
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+		goto out;
+
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		goto out;
+retry:
+	pgdp = pgd_offset(mm, address);
+	if (pgd_none(*pgdp) || unlikely(pgd_bad(*pgdp)))
+		goto out;
+
+	p4dp = p4d_offset(pgdp, address);
+	p4d = READ_ONCE(*p4dp);
+	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
+		goto out;
+
+	pudp = pud_offset(p4dp, address);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		goto out;
+	if (pud_leaf(pud)) {
+		lock = pud_lock(mm, pudp);
+		if (!unlikely(pud_leaf(pud))) {
+			spin_unlock(lock);
+			goto retry;
+		}
+		pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
+				  pud_pfn(pud), PUD_MASK, pud_write(pud),
+				  pud_special(pud));
+		return 0;
+	}
+
+	pmdp = pmd_offset(pudp, address);
+	pmd = pmdp_get_lockless(pmdp);
+	if (pmd_leaf(pmd)) {
+		lock = pmd_lock(mm, pmdp);
+		if (!unlikely(pmd_leaf(pmd))) {
+			spin_unlock(lock);
+			goto retry;
+		}
+		pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
+				  pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
+				  pmd_special(pmd));
+		return 0;
+	}
+
+	ptep = pte_offset_map_lock(mm, pmdp, address, &lock);
+	if (!ptep)
+		goto out;
+	pte = ptep_get(ptep);
+	if (!pte_present(pte))
+		goto unlock;
+	pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
+			  pte_pfn(pte), PAGE_MASK, pte_write(pte),
+			  pte_special(pte));
+	return 0;
+unlock:
+	pte_unmap_unlock(ptep, lock);
+out:
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(follow_pfnmap_start);
+
+/**
+ * follow_pfnmap_end(): End a follow_pfnmap_start() process
+ * @args: Pointer to struct @follow_pfnmap_args
+ *
+ * Must be used in pair of follow_pfnmap_start().  See the start() function
+ * above for more information.
+ */
+void follow_pfnmap_end(struct follow_pfnmap_args *args)
+{
+	if (args->lock)
+		spin_unlock(args->lock);
+	if (args->ptep)
+		pte_unmap(args->ptep);
+}
+EXPORT_SYMBOL_GPL(follow_pfnmap_end);
+
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 /**
  * generic_access_phys - generic implementation for iomem mmap access
-- 
2.45.0


