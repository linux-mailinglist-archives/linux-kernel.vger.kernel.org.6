Return-Path: <linux-kernel+bounces-350046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126498FF19
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951201C21E89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D814B13D2BE;
	Fri,  4 Oct 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Db0aqtP3"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3613A3F3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031895; cv=none; b=g5TUG+HLNMtvCuDoHM624uX3O43X2XDReU2uwqtVyZVpbklL8E6Rg1qzfTsw8FF7A/AKnerg55PpbIaEjAQH9WNlrtpf8zzrETv1QNlb8l3UidivGB/cUWW1KR7Nb609EYI5dBlnNuooxkIkXJx7ORFLCgO0jTTxMGxxiLtj/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031895; c=relaxed/simple;
	bh=xJ0ft+C2X3X17zkTC7ZQe+PtmBa8kA1tpN9J13s4k+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCb8C0+otOomsNM1xqxq7J4EgTamPeVswkk2onzya6nvH8uURcQUUispHSG5azpcw6bvqKe56iTajWqEgo/gZTq8KD5XTr785kVgPvhzohrAKHwW60yML7bi0MzsLKyT1j502D7AkJ3EsJixOSHGmZsHuYeLmuWwEy1UZAj0/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Db0aqtP3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728031869; x=1728636669; i=spasswolf@web.de;
	bh=qyX2o0w0xe5dxuVoW8m3wVlM+OHHHG1klc7E/BhHbBU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Db0aqtP3mx7/YiNwihDfuwQ8N+E2UUMfnTG5UDeQQZUsTgV/0bGWX6j50hzbiqZW
	 ujKwl9Zu0vcpkYebAIjMpn07DWR6GjqTA0DJH/4hbo6RzAKNG+3KiLN5qfua6FyRx
	 vFADB7T8LtH1ZoEaBELo6WZ2eBSGeCqbUPYRa2v9b+DVNU2tnr9pIM4zcNNnnMDeH
	 7SiYEpqB/qUu7VEt/2QtcBvEb3Vx5/IFA8F7cHYE5idaMYAC4oV4bXXB1MrHVgXxR
	 hsFD5c5+dGwYj+AEVhScE4Bv0pYPgNYm9VN0Xm7D2DXeZpvOQo9rFPdvEZ/UZLW1f
	 IGRwmN1lpnf78Y1o9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M6pUK-1soOx83zLi-004P2r; Fri, 04 Oct 2024 10:51:09 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Fri,  4 Oct 2024 10:51:05 +0200
Message-ID: <20241004085107.3165-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240830040101.822209-15-Liam.Howlett@oracle.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ynyX5xrMgLnCqaHxyR1FeRll0tBK7ezATAENx0u3Fdo+IPthDYW
 QTKGx4zDHK75/FitG0tU38XBy2g3c98crL9eUO0o2hMwMRJFjIJ/7bo55nP+qTteBVoNGnS
 QOmvWs2ps2v+o75fjwqizPkqk5yjbtst0GrxyFJJtopK397Th4cx924zhEnfYfStHo1Oq3S
 +yOp6EK9rES31TrvoURFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xBWd/BxrRrg=;wB5rVy4Z9JPFTQBsroyKHDA5JsO
 Vir/xEVtICgsyb9Ah8Y3LoWTF5txfdtgMYmHFczAR/mogB6L7jPBqvNwbZHiHSXNUPIscxMmk
 5mRyKdp3gOibBwcGPyhovD1BT1JukPZQuv//3Sw5DoZ39BlfgIAMww4o5ovNHRsQnzZ9a/zU3
 XTNUgOe6LLL0Z5+5EP330fStGnBZDWDgWNxSIwKQ0xwdWIAZILmeLNzbVUf2K+3x/vrYFwtTK
 bNHQBCzMpszju5G8aEuxYI29GAGrr17AwTA0sfCK9d4NRe/K6tb9BwEr9T4l2ZlprCraagdJv
 JQRIhJSKYwXUE19O5VCIEDSQCYSgYnAyGUKR4yYoTSxxzfZvbH6999dTPUQmyrKvZRboB/hE6
 BBfCOkLgWsTVi/7va6C8YOfMaASBWUgcTDj5nbxXnyC1AIifoXnDdOc4up40ac08XdlgM7ETV
 CX0Jg8X6h4OFkAxW7vmCb9zqcFrkvteN5fQ8vwr1NcYWK+mo5X2DUTNY1niqSIv7cPdv57/Kv
 T9Cgbqmogtxt2TyDyf/VFgamyp701O9qzHGnRnAlW/GYQPNDYDtjo1gDk15y8baBRBrTNfcrm
 SyaJHCtErZZtL7M8uNXzMAQ0j+D3476dbkH4yNjEL+yJ4RaSfbSv5Nq+1ocJb+TE57AJJkZcU
 F8gXVDxd9oXkhFxp+xRxdl+9wM9V0PJIiiRLB49gW1YvaixxO6Gmv+ZcKj8+GSDA0uifJmivR
 nZLT4MCSz6Ckrg0z5RYYFJ0ImFDgwGv/z4j6R+wGiKnKyL2JX+2W3jMgVIWlEKb9iuthsTnFw
 YlIpxWFsc7vm7DcrkOOGWMxQ==

As a sidenode I've tried to figure out the minimal patch it takes to trigg=
er the
crash. The first commit that triggers the bug is f8d112a4e657 ("mm/mmap: a=
void
zeroing vma tree in mmap_region()") so I split this commit into two parts,=
 the
first part gives a working kernel while the second part gives the bug.

First part (to be applied on top of commit 94f59ea591f
("mm: clean up unmap_region() argument list") in linux-next):
=46rom efdd914b012b35d34d1cae469f199023e82f7a15 Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Thu, 3 Oct 2024 23:59:30 +0200
Subject: [PATCH 1/2] mm: mmap: Prepare to avoid zeroing vma tree in
 mmap_region()

In an attempt to create a minimal patch to trigger the mapletree
bug apply parts of patch [v8 14/21] which still give a working kernel.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 mm/mmap.c | 39 ++++++++++++++++++---------------------
 mm/vma.c  | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 mm/vma.h  | 22 ++++++++++++++++------
 3 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 304dc085533a..da9bfb899eec 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsig=
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
+	nr_pages =3D count_vma_pages_range(mm, addr, end, &nr_accounted);

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
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;

 	/* Find the first overlapping VMA */
 	vma =3D vma_find(&vmi, end);
@@ -1410,6 +1406,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,

 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
+		vms.vma_count =3D 0;
 		next =3D vms.next;
 		prev =3D vms.prev;
 		vma =3D NULL;
@@ -1425,8 +1422,10 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged =3D len >> PAGE_SHIFT;
+		charged -=3D nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto clear_tree_failed;
+		vms.nr_accounted =3D 0;
 		vm_flags |=3D VM_ACCOUNT;
 	}

@@ -1475,10 +1474,8 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1605,7 +1602,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	return addr;

 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
+	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);

 	if (file || vma->vm_file) {
@@ -1627,7 +1624,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,

 clear_tree_failed:
 	if (vms.vma_count)
-		abort_munmap_vmas(&mas_detach);
+		abort_munmap_vmas(&mas_detach, false);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1960,7 +1957,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable =3D */ true, /* closed =3D */ false);
 		count++;
 		cond_resched();
 		vma =3D vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 83c5c46c67b9..648c58da8ad4 100644
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
@@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
 	vma_iter_store(vmi, vma);

 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;

 nomem:
@@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }

-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;

+	if (!vms->clear_ptes) /* Nothing to do */
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap=
_struct *vms,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, vms->mm);
 	update_hiwater_rss(vms->mm);
-	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_co=
unt, mm_wr_locked);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+
 	mas_set(mas_detach, 1);
 	/* start and end may be different if there is no prev or next vma. */
-	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_e=
nd, mm_wr_locked);
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes =3D false;
+}
+
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+	vms->closed_vm_ops =3D true;
 }

 /*
@@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struc=
t *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);

-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -702,7 +727,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct=
 *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* =3D */ false, vms->closed_vm_ops);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -846,13 +871,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct =
*vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);

+	vms->clear_ptes =3D true;
 	return 0;

 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed =3D */ false);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -897,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
 	return 0;

 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
+	abort_munmap_vmas(&mas_detach, /* closed =3D */ false);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1615,17 +1641,21 @@ bool vma_wants_writenotify(struct vm_area_struct *=
vma, pgprot_t vm_page_prot)
 }

 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
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
index 82ba48174341..64b44f5a0a11 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -48,6 +48,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cl=
eared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be clos=
ed */
 };

 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -96,14 +98,13 @@ static inline void init_vma_munmap(struct vma_munmap_s=
truct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
+	vms->mm =3D current->mm;
 	vms->vmi =3D vmi;
 	vms->vma =3D vma;
 	if (vma) {
-		vms->mm =3D vma->vm_mm;
 		vms->start =3D start;
 		vms->end =3D end;
 	} else {
-		vms->mm =3D NULL;
 		vms->start =3D vms->end =3D 0;
 	}
 	vms->unlock =3D unlock;
@@ -113,6 +114,8 @@ static inline void init_vma_munmap(struct vma_munmap_s=
truct *vms,
 	vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
 	vms->unmap_start =3D FIRST_USER_ADDRESS;
 	vms->unmap_end =3D USER_PGTABLES_CEILING;
+	vms->clear_ptes =3D false;
+	vms->closed_vm_ops =3D false;
 }
 #endif

@@ -122,18 +125,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct =
*vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);

+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked);
+
 /*
  * abort_munmap_vmas - Undo any munmap work and free resources
  *
  * Reattach any detached vmas and free up the maple tree used to track th=
e vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool cl=
osed)
 {
 	struct vm_area_struct *vma;

 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
 		vma_mark_detached(vma, false);
+		if (closed && vma->vm_ops && vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+	}

 	__mt_destroy(mas_detach->tree);
 }
@@ -147,7 +156,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_=
struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed=
);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
@@ -261,7 +270,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma,=
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

And here the second part which causes the bug (goes on top of the patch ab=
ove):
=46rom 312feab01ec0a2562a1e44e231de12cc3dc3cce5 Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Fri, 4 Oct 2024 10:28:12 +0200
Subject: [PATCH 2/2] mm: mmap: Avoid zeroing vma tree in mmap_region()

Now apply the parts of patch [v8 14/21] which give the crash.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 mm/mmap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index da9bfb899eec..405e0432c78e 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1399,14 +1399,6 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		if (error)
 			goto gather_failed;

-		/* Remove any existing mappings from the vma tree */
-		error =3D vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL);
-		if (error)
-			goto clear_tree_failed;
-
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
-		vms.vma_count =3D 0;
 		next =3D vms.next;
 		prev =3D vms.prev;
 		vma =3D NULL;
@@ -1424,7 +1416,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		charged =3D len >> PAGE_SHIFT;
 		charged -=3D nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			goto clear_tree_failed;
+			goto abort_munmap;
 		vms.nr_accounted =3D 0;
 		vm_flags |=3D VM_ACCOUNT;
 	}
@@ -1484,6 +1476,11 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,

 	if (file) {
 		vma->vm_file =3D get_file(file);
+		/*
+		 * call_mmap() may map PTE, so ensure there are no existing PTEs
+		 * call the vm_ops close function if one exists.
+		 */
+		vms_clean_up_area(&vms, &mas_detach, true);
 		error =3D call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1574,6 +1571,9 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 expanded:
 	perf_event_mmap(vma);

+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -1622,9 +1622,9 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	if (charged)
 		vm_unacct_memory(charged);

-clear_tree_failed:
-	if (vms.vma_count)
-		abort_munmap_vmas(&mas_detach, false);
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
 gather_failed:
 	validate_mm(mm);
 	return error;
=2D-
2.45.2

So the moving vms_complete_munmap_vmas() to the end of mmap_region seems
to be problematic.

Bert Karwatzki

