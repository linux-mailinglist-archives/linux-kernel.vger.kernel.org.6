Return-Path: <linux-kernel+bounces-289586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E129547D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CD71F22481
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7A1BD01D;
	Fri, 16 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="CDoIzaxB"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967601BC085
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806913; cv=none; b=j98XZ+5pw/xlyLiRbhXbr5EdP+hX+r0Yi8XEFJxgoRc0ARHyKAPo6Xg1QQwqp1rc4PIoNd9O12kFwGheLuRuk82hTcSn6JE2izD2sL0T3A9WPntPnGAmXTHpBqQ41kDc9KyNLhk3AXGJ2M0ewi2woqrh3bEIm4J9XKwWYQn8hws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806913; c=relaxed/simple;
	bh=WACMVTtJRbP6/VuQmA7aXxyz8rWofcWfWiBEDw4Pc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ8aQqwp67DlcXAHVlrSHUnUdpRKhYkY9tDVckQnvm0lO/uVjBjEvfzaC+pAWHokWTy3UXI1wLUpgwsRxifj/JD7MggSNlaULk3Q/HJXiib7P50FfS9Sc/l/Ip2sjpp9fjWu19CWgju1IK5LDs+wwWV930imRHzDoArvovXiO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=CDoIzaxB; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806875; x=1724411675; i=spasswolf@web.de;
	bh=k8XFZH7Bl7Qh7IxzWQ76db6VsLxfjJZK9cPC/vdDVvk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CDoIzaxBSOx+BFHAyOC09H0lfePAuo0eSTtQrpwyy/FUIlVBmq/i7Gs6doZZA+5Y
	 rleI+UaIGj73m+8d9j+BXstt+9Qjyb5lFHBPCn6FjMYqVtp5e+/Fja0/quYlerHA1
	 +H9kQkuV+ABkmiOAmBi2CdjL1nfI7gDFQ4QkUvpNOqzIT0F0r70Of5h/P2ElqvWId
	 4HINhJ/CmpWhwVbURJed7joKmUv9g/g5kDtvayF/2EWG4e5n0+2Lw9xidcs/MvTtW
	 AjH2LQmDpgHPUTTTiQcSISNoQsQVMk8fAOnlu9joM6Fehbs8C9BKPY0c2N2Qq5a9H
	 n6WRQY/reqRAkApI8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MhWkj-1s0cLR3g03-00lVdx; Fri, 16 Aug 2024 13:14:35 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v5.1 14/19] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Fri, 16 Aug 2024 13:13:55 +0200
Message-ID: <20240816111405.11793-15-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816111405.11793-1-spasswolf@web.de>
References: <20240816111405.11793-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P/xRUK91XTPegJHA/ffuBXgtaC/TqoFyWMcTDzcdnF40569KBXG
 pQW00XWomIZvuJJKEKbn1BRQNTDlNEBXHadq3zw0nMLe/40mMQTWP4OHTajZY+2xHsxurgU
 gjT7AvQUG+Gd+eGpF64UV/pQKgNzb2U43GsLBPPaRXp1TVp+YPDbadmvEiwp2/Ie9Kv52KC
 vZCQURPUl4gOgHLPwFUCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MqZlFogfKbk=;jqIHAe8QT0NPe3NYh5g75v/wn+u
 lGKAPZZzXBDvRjtZ2sVmNw7N0p0EOC+oV8EAq97hoZSWSh/XfxyA2U8OU46a36J8wQpuEzrbN
 dnGLDxz2l8+a3D6c1d8Y0EyVP13gohZNWS5MSa7+KmQib4+QF+12JLEagIRgNQ7nwzHcQJN9W
 4Ud8zMmoXI1IGJttG1vqd7wPK2FuvuNuNdw68noIWwX6FW0fZLM4gDI/aobR4YvAQfxLRaF7B
 r80q6Febih540ehCEVp/O8iBqZ2j9jBp3FxW/D19zynEC44paStMuyRw7D+eK0zKfBxxg01rk
 Q1rBf7giwp4EV9NhoxytmeiLtVZN4WJB28epdMOAK2kFUfj6PuGIxq0i/kQ5Kc6YZOiqxaf1g
 CW0VrZRDPkKIWP6Oa2GFtB2ufaIZY1aeDsCCs90mv6Fu3+wzaYvsMqorY2YnYzq1jUsgJR5Ri
 5q7RH0wxeQ+QkwqjNXS71X8yGACwJQ+ifhxFrrWqcJPWQH835QPow594hs6SsuedVvjcYkWQL
 07lab8/EQQk8JibFRXLeCnNaKhrmTEcCUeFNlneLeMZse35IcCHrWx3vm6CqqfWZHb/gqBoKw
 Erp6AqiREM0cF8rqnRg4ztssr7k26YknW1MdDRi6PNFEClHxxi2I0MmDRTqKC1+Z3ypgIMDyX
 tyPPi2QXTUqTBSGQ/X2rE9J8P82PIpxsPM2BG5bVTIUgDFjNntwFfONLOh+nruMoLo5f+82aK
 95M0lvJu7OvMKM3s9x30R2AGdi9xCWyVcg5PCk3kuOqCnYbNm6xczf2n5t1d88kPiqXP/14Nb
 rKKfUzMZ8pL7Q+wiHp9i4KUA==

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  If the vma has a vm_ops->close(), then call
the close() function.  This is done using the vms_clear_ptes() and
vms_close_vmas() helpers.  This has the side effect of needing to call
open() on the vmas if the mmap_region() fails later on.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This commit drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Note that before this change, a MAP_FIXED could fail and leave a gap in
the vma tree.  With this change, a MAP_FIXED failure will fail without
creating a gap and leave *a* vma in the area (may have been split) and
attept to restore them to an operational state (re-attached and
vm_ops->open()'ed if they were vm_ops->close()'d).

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
=2D--
 mm/mmap.c | 60 +++++++++++++++++++++++++------------------------------
 mm/vma.c  | 59 ++++++++++++++++++++++++++++++++++++++++++------------
 mm/vma.h  | 16 ++++++++++++---
 3 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1f0b8dc5a089..e152b6caaf9c 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,24 +1373,19 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	bool writable_file_mapping =3D false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error =3D -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;

-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	nr_pages =3D count_vma_pages_range(mm, addr, end, &nr_accounted);

+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;

 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -1404,14 +1399,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			goto gather_failed;
-
-		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			goto clear_tree_failed;
+			return -ENOMEM;

-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next =3D vms.next;
 		prev =3D vms.prev;
 		vma =3D NULL;
@@ -1427,8 +1416,10 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged =3D len >> PAGE_SHIFT;
+		charged -=3D nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted =3D 0;
 		vm_flags |=3D VM_ACCOUNT;
 	}

@@ -1477,10 +1468,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}

 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1489,6 +1478,9 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,

 	if (file) {
 		vma->vm_file =3D get_file(file);
+		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
+		vms_clear_ptes(&vms, &mas_detach, /* mm_wr_locked =3D */ true);
+		vms_close_vmas(&vms, &mas_detach);
 		error =3D call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1579,6 +1571,10 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 expanded:
 	perf_event_mmap(vma);

+	/* Unmap any existing mapping in the area */
+	if (vms.nr_pages)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -1626,14 +1622,12 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;

-clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed);
 	validate_mm(mm);
-	return -ENOMEM;
+	return error;
 }

 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
@@ -1972,7 +1966,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable =3D */ true, /* closed =3D */ false);
 		count++;
 		cond_resched();
 		vma =3D vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 0244320d76ab..86757443a7a2 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsi=
gned long vm_flags,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable)
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed=
)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (!closed && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
@@ -374,6 +374,8 @@ init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
 	vms->unmap_start =3D FIRST_USER_ADDRESS;
 	vms->unmap_end =3D USER_PGTABLES_CEILING;
+	vms->clear_ptes =3D false;	/* No PTEs to clear yet */
+	vms->closed =3D false;
 }

 /*
@@ -556,7 +558,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
 	vma_iter_store(vmi, vma);

 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;

 nomem:
@@ -685,22 +686,30 @@ void vma_complete(struct vma_prepare *vp,
  *
  * Reattach any detached vmas and free up the maple tree used to track th=
e vmas.
  */
-void abort_munmap_vmas(struct ma_state *mas_detach)
+void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 {
 	struct vm_area_struct *vma;

 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
+		if (closed && vma->vm_ops && vma->vm_ops->close &&
+		    vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+
 		vma_mark_detached(vma, false);
+	}

 	__mt_destroy(mas_detach->tree);
 }

-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;

+	if (!vms->clear_ptes)
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -716,6 +725,22 @@ static void vms_complete_pte_clear(struct vma_munmap_=
struct *vms,
 	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
 		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes =3D false;
+}
+
+void vms_close_vmas(struct vma_munmap_struct *vms, struct ma_state *mas_d=
etach)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->vma_count)
+		return;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+
+	vms->closed =3D true;
 }

 /*
@@ -740,7 +765,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct=
 *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);

-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -751,7 +776,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct=
 *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* unreachable =3D */ false, vms->closed);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -891,14 +916,18 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct =
*vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);

+	/* There are now PTEs that need to be cleared */
+	vms->clear_ptes =3D true;
+
 	return 0;

 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed =3D */ false);
 start_split_failed:
 map_count_exceeded:
+	validate_mm(vms->mm);
 	return error;
 }

@@ -942,9 +971,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
 	return 0;

 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+	abort_munmap_vmas(&mas_detach, /* closed =3D */ false);
 	validate_mm(mm);
+gather_failed:
 	return error;
 }

@@ -1667,17 +1696,21 @@ bool vma_wants_writenotify(struct vm_area_struct *=
vma, pgprot_t vm_page_prot)
 }

 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end)
+				    unsigned long addr, unsigned long end,
+				    unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages =3D 0;

+	*nr_accounted =3D 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start =3D max(addr, vma->vm_start);
 		unsigned long vm_end =3D min(end, vma->vm_end);

 		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted +=3D PHYS_PFN(vm_end - vm_start);
 	}

 	return nr_pages;
diff --git a/mm/vma.h b/mm/vma.h
index 2a2ca489e622..73297dc7fa28 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -43,6 +43,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
+	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
+	bool closed;			/* vma->vm_ops->close() called already */
 };

 struct unlink_vma_file_batch {
@@ -57,7 +59,7 @@ void validate_mm(struct mm_struct *mm);
 #endif

 /* Required for mmap_region() */
-void abort_munmap_vmas(struct ma_state *mas_detach);
+void abort_munmap_vmas(struct ma_state *mas_detach, bool closed);

 /* Required for expand_downwards(). */
 void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
@@ -97,6 +99,13 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct =
*vms,
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			   struct ma_state *mas_detach);

+/* Required for mmap_region() */
+void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked);
+
+/* Required for mmap_region() */
+void vms_close_vmas(struct vma_munmap_struct *vms, struct ma_state *mas_d=
etach);
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -106,7 +115,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_=
struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed=
);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
@@ -220,7 +229,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma,=
 pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end);
+				    unsigned long addr, unsigned long end,
+				    unsigned long *nr_accounted);

 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_stru=
ct *vma)
 {
=2D-
2.45.2


