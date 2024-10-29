Return-Path: <linux-kernel+bounces-387688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD919B54AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C845FB216E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5C204011;
	Tue, 29 Oct 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyWTU2se"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916443207
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235831; cv=none; b=sH71ywo7tQt2YMQzAcZYl2v2u64JKsNeZy1B9jWUTRHBN8uCpUssmPl5dh481xPLvJer6VBXHJKyc6v5WQK9bXA5Oun32IuKCxk2FRHazeqHQEY5H54KyQ/pF9WecKFs6qYfa/b+GoywbW8X708WRveyUVypgcVaGkwNemMl4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235831; c=relaxed/simple;
	bh=qsBXdfTsNrkhamOAmEwRSPxNYazNiwCrN8PjaAI3aXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkZYMVtVWLT9KBXxBbKTQn9lSZOwdqvrr/tu/AIPZhxbQioCPkCZVVUg9Zesf+Za6kn1XahkmmUtoyO3lIx//z1UK3KGonuCYJrJUEYLqJfZfBOGgGDTaz/WPPG4lkQsT+MnuR9NSCr1+6Mziovx4nUT85sOcN3PoqAPH8P3YM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyWTU2se; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730235827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pwj4NlTv+aGn9kqoGEJUhJSZhDkCLWi15FS2ya73Nww=;
	b=CyWTU2seC1O49kqvHSMBCTbhv0j1x0Z5ic9lr0FwZU9oktKgQxsD2aDEulAJOlrd2Ef4vc
	X81ODx3/yReBjyJOKIEbvYC0fz9xN7QiwZtEf4rWr9PGQiupjIn5BO9/tBvv3kppS0J2lL
	/sIdleNZ5TsXIGeuOEU1WSYvvRHXEcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-mLd6iII3OAeZerlGltp2QQ-1; Tue,
 29 Oct 2024 17:03:42 -0400
X-MC-Unique: mLd6iII3OAeZerlGltp2QQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C3D41955E9D;
	Tue, 29 Oct 2024 21:03:39 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.64.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2715919560A2;
	Tue, 29 Oct 2024 21:03:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ma Wupeng <mawupeng1@huawei.com>
Subject: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in copy_page_range()
Date: Tue, 29 Oct 2024 22:03:31 +0100
Message-ID: <20241029210331.1339581-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If track_pfn_copy() fails, we already added the dst VMA to the maple
tree. As fork() fails, we'll cleanup the maple tree, and stumble over
the dst VMA for which we neither performed any reservation nor copied
any page tables.

Consequently untrack_pfn() will see VM_PAT and try obtaining the
PAT information from the page table -- which fails because the page
table was not copied.

The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
if track_pfn_copy() fails. However, the whole thing is about "simply"
clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
and performed a reservation, but copying the page tables fails, we'll
simply clear the VM_PAT flag, not properly undoing the reservation ...
which is also wrong.

So let's fix it properly: set the VM_PAT flag only if the reservation
succeeded (leaving it clear initially), and undo the reservation if
anything goes wrong while copying the page tables: clearing the VM_PAT
flag after undoing the reservation.

Note that any copied page table entries will get zapped when the VMA will
get removed later, after copy_page_range() succeeded; as VM_PAT is not set
then, we won't try cleaning VM_PAT up once more and untrack_pfn() will be
happy. Note that leaving these page tables in place without a reservation
is not a problem, as we are aborting fork(); this process will never run.

A reproducer [1] can trigger this usually at the first try:

[   45.239440] WARNING: CPU: 26 PID: 11650 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0xf6/0x110
[   45.241082] Modules linked in: ...
[   45.249119] CPU: 26 UID: 0 PID: 11650 Comm: repro3 Not tainted 6.12.0-rc5+ #92
[   45.250598] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[   45.252181] RIP: 0010:get_pat_info+0xf6/0x110
...
[   45.268513] Call Trace:
[   45.269003]  <TASK>
[   45.269425]  ? __warn.cold+0xb7/0x14d
[   45.270131]  ? get_pat_info+0xf6/0x110
[   45.270846]  ? report_bug+0xff/0x140
[   45.271519]  ? handle_bug+0x58/0x90
[   45.272192]  ? exc_invalid_op+0x17/0x70
[   45.272935]  ? asm_exc_invalid_op+0x1a/0x20
[   45.273717]  ? get_pat_info+0xf6/0x110
[   45.274438]  ? get_pat_info+0x71/0x110
[   45.275165]  untrack_pfn+0x52/0x110
[   45.275835]  unmap_single_vma+0xa6/0xe0
[   45.276549]  unmap_vmas+0x105/0x1f0
[   45.277256]  exit_mmap+0xf6/0x460
[   45.277913]  __mmput+0x4b/0x120
[   45.278512]  copy_process+0x1bf6/0x2aa0
[   45.279264]  kernel_clone+0xab/0x440
[   45.279959]  __do_sys_clone+0x66/0x90
[   45.280650]  do_syscall_64+0x95/0x180

Likely this case was missed in commit d155df53f310
("x86/mm/pat: clear VM_PAT if copy_p4d_range failed"), and instead of
undoing the reservation we simply cleared the VM_PAT flag.

Keep the documentation of these functions in include/linux/pgtable.h,
one place is more than sufficient -- we should clean that up for the other
functions like track_pfn_remap/untrack_pfn separately.

[1] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/pat_fork.c

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>
Closes: https://lore.kernel.org/lkml/CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com/
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
Fixes: d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")
Fixes: 2ab640379a0a ("x86: PAT: hooks in generic vm code to help archs to track pfnmap regions - v3")
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 66 +++++++++++++++++++++++++--------------
 include/linux/pgtable.h   | 27 ++++++++++++----
 kernel/fork.c             |  4 +++
 mm/memory.c               |  9 ++----
 4 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..3a9e6dd58e2f 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,27 +984,54 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	return -EINVAL;
 }
 
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
 	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
+	int rc;
 
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!rc)
+		/* Reservation for the destination VMA succeeded. */
+		vm_flags_set(dst_vma, VM_PAT);
+	return rc;
+}
+
+void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+	resource_size_t paddr;
+	unsigned long size;
+
+	if (!(dst_vma->vm_flags & VM_PAT))
+		return;
+
+	/*
+	 * As the page tables might not have been copied yet, the PAT
+	 * information is obtained from the src VMA, just like during
+	 * track_pfn_copy().
+	 */
+	if (get_pat_info(src_vma, &paddr, NULL)) {
+		size = src_vma->vm_end - src_vma->vm_start;
+		free_pfn_range(paddr, size);
 	}
 
-	return 0;
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+	vm_flags_clear(dst_vma, VM_PAT);
 }
 
 /*
@@ -1095,15 +1122,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	}
 }
 
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
 void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vm_flags_clear(vma, VM_PAT);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8b2ac6bd2ae..616707b4ecb8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1518,14 +1518,24 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
 	return 0;
 }
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
@@ -1538,8 +1548,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VMA after the page tables were moved.
+ * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
  */
 static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
@@ -1550,7 +1562,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..02a7a8b44107 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -504,6 +504,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
+	/* track_pfn_copy() will later take care of copying internal state. */
+	if (unlikely(new->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(new);
+
 	return new;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 3ccee51adfbb..f7fbf099e8f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1372,11 +1372,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma);
 		if (ret)
 			return ret;
 	}
@@ -1413,7 +1409,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1423,6 +1418,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, src_vma);
 	return ret;
 }
 

base-commit: 0f4cb420b38489c9bab9d091c3815714be8cb69d
-- 
2.47.0


