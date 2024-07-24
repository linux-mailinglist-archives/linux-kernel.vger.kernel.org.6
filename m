Return-Path: <linux-kernel+bounces-260492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D493AA34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A528429E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618F5221;
	Wed, 24 Jul 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dr7G1PxO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C4C66
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781441; cv=none; b=mlgjISM7Zdyy4LASscGMZ6ZbjHRWKjhsbKweoyePxnPCB38n+zgGnyTVXirNVl3n3uhOFLR2uAUchxVtBabi6BHA1mvAPkEp7/N1dsQjkPxz55U3XREnJhj0TQCMieLrsaOXOCqh9tCTd+wjOcLXg+bSh4lsFFB6NiPiljHD3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781441; c=relaxed/simple;
	bh=2sIExTgkE69oYCZK/sCrL6LOICo37hU1irVyTFaFzdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CI/pQR6wS8BzdcPAe4SY6fN8HiqcPcGE/9/9o+0v3FI/XFlr0jnLztogTfRPMzw0o6T+Vo0n8Z43Gd3ar27/SyvHb8ZajC9UXRn59FhXRbFO6Cf/iAN/M6S5dzqltAkEbOE/EYaFkHzEpjANSo+we/lId/AUTTUftnw9zVZphDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dr7G1PxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C01BC4AF09;
	Wed, 24 Jul 2024 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721781440;
	bh=2sIExTgkE69oYCZK/sCrL6LOICo37hU1irVyTFaFzdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dr7G1PxOy3yHGZuUlch65NMzOEJcRbEta/yXzXSSgIV9npQ13T2MQfSjzNcdRqYIK
	 BfGdP28GeZkDRYrUzl+u/gNNMTApt9/XwzUBxQfO6hbS3bvqWjp3QNPfs/MApSHwFS
	 RQqInT6svUsdaLgtbOVAXlPcpLWxqowIIlW/m3xY=
Date: Tue, 23 Jul 2024 17:37:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>, Michal Hocko
 <mhocko@suse.com>, Donet Tom <donettom@linux.ibm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox
 <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 7/9] mm: Drop hugetlb_get_unmapped_area{_*} functions
Message-Id: <20240723173719.e0894a5855e1b46d95cbc3cd@linux-foundation.org>
In-Reply-To: <20240718105903.19617-8-osalvador@suse.de>
References: <20240718105903.19617-1-osalvador@suse.de>
	<20240718105903.19617-8-osalvador@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 12:59:01 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> Hugetlb mappings are now handled through normal channels just like any
> other mapping, so we no longer need hugetlb_get_unmapped_area* specific
> functions.
> 
> ...
>
>  fs/hugetlbfs/inode.c             |  86 ------------------------

The fs/hugetlbfs/inode.c code which this patch removes is quite
different from the code which is currently present.

The concern is that important recent changes to this code were not
carried over into the code which replaced it ("normal channels").  And
that this patchset hasn't been tested against latest trees.

So can we please have a redo?

(Here's my diff of what-is-there versus what-this-patch-removes)

--- /tmp/1	2024-07-23 17:29:43.704770012 -0700
+++ /tmp/2	2024-07-23 17:29:42.232748301 -0700
@@ -1,29 +1,28 @@
-static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
-		unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+static unsigned long
+hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
 	struct vm_unmapped_area_info info = {};
 
 	info.length = len;
 	info.low_limit = current->mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.high_limit = arch_get_mmap_end(addr, len, flags);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	return vm_unmapped_area(&info);
 }
 
-static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
-		unsigned long addr0, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+static unsigned long
+hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
 	struct vm_unmapped_area_info info = {};
-	unsigned long addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = current->mm->mmap_base;
+	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	addr = vm_unmapped_area(&info);
 
@@ -33,53 +32,56 @@
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	if (addr & ~PAGE_MASK) {
+	if (unlikely(offset_in_page(addr))) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
+		info.low_limit = current->mm->mmap_base;
+		info.high_limit = arch_get_mmap_end(addr, len, flags);
 		addr = vm_unmapped_area(&info);
 	}
 
 	return addr;
 }
 
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+unsigned long
+generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+				  unsigned long len, unsigned long pgoff,
+				  unsigned long flags)
 {
-	struct hstate *h = hstate_file(file);
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev;
+	struct hstate *h = hstate_file(file);
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
 		if (prepare_hugepage_range(file, addr, len))
 			return -EINVAL;
-		goto check_asce_limit;
+		return addr;
 	}
 
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			goto check_asce_limit;
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
 	}
 
-	if (!test_bit(MMF_TOPDOWN, &mm->flags))
-		addr = hugetlb_get_unmapped_area_bottomup(file, addr, len,
-				pgoff, flags);
-	else
-		addr = hugetlb_get_unmapped_area_topdown(file, addr, len,
+	/*
+	 * Use MMF_TOPDOWN flag as a hint to use topdown routine.
+	 * If architectures have special needs, they should define their own
+	 * version of hugetlb_get_unmapped_area.
+	 */
+	if (test_bit(MMF_TOPDOWN, &mm->flags))
+		return hugetlb_get_unmapped_area_topdown(file, addr, len,
 				pgoff, flags);
-	if (offset_in_page(addr))
-		return addr;
-
-check_asce_limit:
-	return check_asce_limit(mm, addr, len);
+	return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+			pgoff, flags);
 }
 


