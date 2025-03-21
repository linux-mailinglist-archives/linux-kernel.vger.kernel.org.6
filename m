Return-Path: <linux-kernel+bounces-571151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC2A6B9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37BE18997E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746E222582;
	Fri, 21 Mar 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFu4hC1N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC051F03F3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556213; cv=none; b=qI5d/SIL/SdOdjxgJpTBpwJqXEL2nZr/BNK05l/J74vk18JQxENuo4zpr1VhZuNCe1vZrIlqsDITlOck5jH7GrvU+S3N5vhs+kZ2SI0h1mcvlECxFplDkiptDDe/JE5KH4q2BkkMg2KqyojP4lHh+69f9hl6rwxpb8kn4FYlBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556213; c=relaxed/simple;
	bh=OgTMpAOzLMbPPHCzEavmMQWVrZMLgSwbobYSoT2Wjy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDAoWmZsEaKipy6LVH5+j19gXEl5E1eW9CGYLmvbYWj8q8rxFYSR6iv8jabRyv7VHC4wZ6jRYUSLt32XO2Y8bIr92nALa/x7NiFAg8vWkQXyPIiLq7QxC73w56zEHbqSSl4RW0WfY4R5vB86vBsXqF3LvVRB9Z15EexSsFQObbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFu4hC1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/md+4NTjaWUNzHR/fDVjCHKrpiH7LiUEFL7MRG8nvU=;
	b=RFu4hC1NHjmSHZMnTPwYSAnw3RzKKPMMP6RKbn6aJ2H+2EkwHZjkukobfq7mFdUtZNLsdX
	dQaIzYUbacLQ+cdqLoiL8dfsaD8bJ3tkVXTWvxn5Ihk03ETYSCHYLIwvle2cpBBp3JlV8n
	8qJOZ6dz+ZdnH9D+Qy0idHkh9OBTgqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-qlFhi1SsMtaQFlLZZ3gZ1Q-1; Fri, 21 Mar 2025 07:23:27 -0400
X-MC-Unique: qlFhi1SsMtaQFlLZZ3gZ1Q-1
X-Mimecast-MFC-AGG-ID: qlFhi1SsMtaQFlLZZ3gZ1Q_1742556206
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-394bbefc98cso1116125f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742556206; x=1743161006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/md+4NTjaWUNzHR/fDVjCHKrpiH7LiUEFL7MRG8nvU=;
        b=WvY8VsAG49I6dnB01evsCev1dKcDbwWHjzUqVmewet2rIrWoeG4iNEe7BNgjdl3qCs
         IC0x1KHoEPozu5Nb+1Og0qSxXOkvNTwuOQOLXd9rr4pOH8JJTP3VgqMnu7NG/ABYs5qQ
         62lKcIXoPIyd4+1SE6Oi31vwspr2pUu7+CjfuZ+ko0MnHhdd+zMLzAo1dQyFnrKH5r4y
         SeoF9gtOmHd0QG4EBklzYWYSGx2P2Jq6nHiCKRZB92xdLVho/E5n2CaxQF5NIIvteTuT
         8Ojx9jeaOiSW2sZwzAYA1ibULAnWd5PvNN6S/XD3voh1ihc+bXwHHsVHT0iudiOuFyqZ
         vzPw==
X-Gm-Message-State: AOJu0YwuyPxyfOeOwPba6WRGKGy8A9qZ0BjWz8VNXKGBj8rsop1D7Luq
	RYEdeoh4LIQIN6k7iaqsALCepFKVIRBSmiMj0FgUy+kKkV7O5V2WPf1cOqhRuz688OhZKQVkyaB
	8EhP5hF+7MLAOMjFgKXnFCp0xgptReA+gZFGqs5Y5nG34qA8twiFmj+7675u8tCh7Ie25UFVWA3
	fQgVLI65Rg7bQsc/AvMC8iw/X/pfoFIJB7EQ3eozh2lfiO
X-Gm-Gg: ASbGncvLaexHwO7bsfhsFs+0bcTm7NiJmv9LEVFu7f7wZFKncRjrWFbSn2wD++7aYvl
	yKGISW3YVdjTDgZ8cuEI6mGZMKK28kSJj75lYDzZTFbT5/fgsNW6A6ChXpkFFPxQk7iMhJU+Y1t
	mpckqQogG1wcVfhlKcesL05MenIvto0JXEnYwVJyal/qoH4CePNcH42UusnycQRX53EDGnlIOKU
	H7WXbAj8tSpD6g1smDnxOtuAArW+zbSYy5C3wjkyjwy8fLxA5ZjDFWqf8KVvFzH//LFTWCNqRO7
	3dqv143Ie/nUbwYowwNEv00T/Wt46fFAIK9w5kJPBLacIlSTi2dE3ZuaIuYR7titJ65Or8ntBLh
	D
X-Received: by 2002:a5d:64c7:0:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-3997f94035cmr3215268f8f.47.1742556206332;
        Fri, 21 Mar 2025 04:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuZSe0DTbFu+RBbXBxnS/gPdmj7yPzI1Yx5Cf0QQX6uqSW0HICnEbt4GhRaACxTadtFYxEw==
X-Received: by 2002:a5d:64c7:0:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-3997f94035cmr3215219f8f.47.1742556205703;
        Fri, 21 Mar 2025 04:23:25 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd27b59sm24111505e9.23.2025.03.21.04.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:23:25 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2] x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()
Date: Fri, 21 Mar 2025 12:23:23 +0100
Message-ID: <20250321112323.153741-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

A reproducer can trigger this usually at the first try:

  https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/pat_fork.c

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

Likely this case was missed in commit d155df53f310 ("x86/mm/pat: clear
VM_PAT if copy_p4d_range failed")

... and instead of undoing the reservation we simply cleared the VM_PAT flag.

Keep the documentation of these functions in include/linux/pgtable.h,
one place is more than sufficient -- we should clean that up for the other
functions like track_pfn_remap/untrack_pfn separately.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>
Closes: https://lore.kernel.org/lkml/CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com/
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
Fixes: d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")
Fixes: 2ab640379a0a ("x86: PAT: hooks in generic vm code to help archs to track pfnmap regions - v3")
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
* Avoid a second get_pat_info() [and thereby fix the error checking]
  by passing the pfn from track_pfn_copy() to untrack_pfn_copy()
* Simplify untrack_pfn_copy() by calling untrack_pfn().
* Retested

Not sure if we want to CC stable ... it's really hard to trigger in
sane environments.

---
 arch/x86/mm/pat/memtype.c | 43 +++++++++++++++++----------------------
 include/linux/pgtable.h   | 31 ++++++++++++++++++++++------
 kernel/fork.c             |  4 ++++
 mm/memory.c               | 11 ++++------
 4 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf2..ffddbf52cd478 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,26 +984,30 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
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
+		struct vm_area_struct *src_vma, unsigned long *pfn)
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
-	}
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
 
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (rc)
+		return rc;
+
+	/* Reservation for the destination VMA succeeded. */
+	vm_flags_set(dst_vma, VM_PAT);
+	*pfn = PHYS_PFN(paddr);
 	return 0;
 }
 
@@ -1095,15 +1099,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
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
index 94d267d02372e..df2aff504da69 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1508,10 +1508,12 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range(). On success, stores the pfn to be
+ * passed to untrack_pfn_copy().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
 	return 0;
 }
@@ -1528,8 +1530,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
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
@@ -1540,12 +1544,27 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
 #ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f32..ca2ca3884f763 100644
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
index fb7b8dc751679..dc8efa1358e94 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1362,12 +1362,12 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
 	unsigned long addr = src_vma->vm_start;
 	unsigned long end = src_vma->vm_end;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
+	unsigned long next, pfn;
 	bool is_cow;
 	int ret;
 
@@ -1378,11 +1378,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
 		if (ret)
 			return ret;
 	}
@@ -1419,7 +1415,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1429,6 +1424,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, pfn);
 	return ret;
 }
 

base-commit: b3ee1e4609512dfff642a96b34d7e5dfcdc92d05
-- 
2.48.1


