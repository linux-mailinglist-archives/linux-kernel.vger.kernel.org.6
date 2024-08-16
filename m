Return-Path: <linux-kernel+bounces-289583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400C9547D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C077FB22459
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1E1BC07F;
	Fri, 16 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vcmAT7AZ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876364A3E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806909; cv=none; b=tWWN6Np1B8tmCASkHj+BAoYy7PZFdOV1vy42QjNX7Qb7XmT/FkLYDnvRDYsi2UPvBKyqJ5rB5cAvN1tArNjlRdcgmycGCxg28L2L9vnMmAG+XeQdDaPAw1uUIau2XpERr+CrJOfpmPhdXQlrtDkBPv4VKc3WVd5uI/03NO5fZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806909; c=relaxed/simple;
	bh=YTsiRQAnJeeMaEvbrqq8FzIzjs3qJL5W8OjkL9c9l8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW5UFkgv1f1mmILl4Zk7K0VuNfJRJa70kuoam3dbDBNKZaq2AgjPSgYbye72AjmwSWWKCuY8/MF9vUTcj+s8ZR05JZ3ojnNzAn1/NqKYaqWYOiujWTF5QjNHKwWwx+dmoGGf3kkJ37eRgOlaWtDARKEgjE/WA7+KciApBFzzBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vcmAT7AZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806866; x=1724411666; i=spasswolf@web.de;
	bh=/xNMCEy6ZMUJ5jlh63sbnY1rB8O0oQ4bXvYgIo02Des=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vcmAT7AZZNkIuuRa5N9UjViGBadah3uIKAUXHavwmXLvLxIt5RP9oKIBi6JEgouB
	 79ipHY0KZ4DeH2SG4tapsi5mo4ofvs6GAzj/Z4rUREUzvK58A/IRu8jvBlaNB/fwK
	 aH2awVNT4IqfkOW+HRjowuiM/WebN1g6KQA/KGlTGwOax27iQh3iAycQ9HHF3nhPU
	 ZXlVzSQJQf4AHIrvm0hKU3px/BHuk/P54Ra/LYvVvoyl+MloYi3Lr4dSRwdLXIGfP
	 /XNzjMu7gVIOOysIjpcLOil39xWhQtIhfsxs7lplB6J47fk8RtXovyjsZVatnoCx+
	 xIn8m/lt52rruwedKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mmho4-1rvN1o2hKo-00gKhQ; Fri, 16 Aug 2024 13:14:26 +0200
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 06/19] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Fri, 16 Aug 2024 13:13:47 +0200
Message-ID: <20240816111405.11793-7-spasswolf@web.de>
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
X-Provags-ID: V03:K1:y+XNaT7VlbfKyj8mm9kpB8LHAxr/8kSf1589Zgx9DxmcEkK71iE
 myTWMxxnM/mpnLCRk/GeFj/br64MsskK235q2J6ZoUyaiYC2qHuIzQzUYO1D6zOaXdcZ3dS
 Lipz4ITTAG4vU5DKHIAxvof6OfD8+Ox693Ojg+zhMXhutl08/4i2ZAefg2oenCGJoqD6khJ
 j4QPVPVVdTsL0WzwdqJyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eZpxWICXsUE=;Mtq0GbTcN03SPFKn5s9NjDyH1iA
 ADaXYb3QSoc4pphABoI9iKY4yFAuXXkNZ0ozG+WA2t+ay95D6Q++CvzBOE76buAbcnQSicTIx
 av7VGliloCI7810rZXT4dv25+Yi9gKIafPXQn/mQ8T9zdONhBaz8QUGmijv+QsWhqA4ZAanPq
 N/tw7CXvhd7L89hVPeyI86mNaRy+EmcwhYfPs2DzCQuHAsuQIDh5VcotyUlCDQgB5atPrT/ac
 dA7/VFBhyNop0lauGUcwbCkf6+jbR8RQ50MFRMFyxlY4Fojn+foNuNiI3GGOQK+eVb6yrjjbz
 Ng+UvbdlDlESoeWYxni7UEIkmKGEsoJVezrvOjcyAGaxQjqSXw2S5MyuCD/lJWG4DHRFj9VT8
 wv3WYUNnaQuNCuXjeedWlVhI1MD6dcuCGn+6O1ylYKYpZFufQgJCLwGpPPUW7kmV2apOc4mBH
 MVxqsPQ0Q0zRezgfujDVRWz2LYCnf5gXHIImynj3IUWZoZzAnc81dbIsLHibqlMRZpGWgvJuQ
 PfSmqAIqe82Zpk8k/+0tGqN3cz7/R1sgkFGNrdVeIiVHDr0xFFgPExaJ2zAXaGYRGisgMBRDw
 XTIZLbF3hlnwORrgYO2o6kkppf117762j6uMLfQgAqrJIXCpgymizDkG1LfXcMCKSuGiwbx7h
 N5afIdOjD0Phvs6kgwCbOrh0knTF9LBgDu3MfkKfEo0Q7ufOgcwTN5Vd2RFkElexkRFHjbZOK
 AQRc8L4chhHufPE5hFpTKBOOtimLJX07uudXJ1pnPbK4L38s2jbFVVOs+HHjZn5P1RIX+HDgU
 E1QwuZRfA6gUsYKbucXtcFrg==

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
=2D--
 mm/vma.c | 79 ++++++++++++++++++++++++++++----------------------------
 mm/vma.h |  6 +++++
 2 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 9495230df3c3..816736c4f82e 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -273,30 +273,6 @@ static int split_vma(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }

-/*
- * Ok - we have the memory areas we should free on a maple tree so releas=
e them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted =3D 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages =3D vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted +=3D nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * init_vma_prep() - Initializer wrapper for vma_prepare struct
  * @vp: The vma_prepare struct
@@ -388,7 +364,8 @@ static inline void init_vma_munmap(struct vma_munmap_s=
truct *vms,
 	vms->unlock =3D unlock;
 	vms->uf =3D uf;
 	vms->vma_count =3D 0;
-	vms->nr_pages =3D vms->locked_vm =3D 0;
+	vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
+	vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
 }

 /*
@@ -715,7 +692,7 @@ static inline void abort_munmap_vmas(struct ma_state *=
mas_detach)
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
  *
- * This updates the mm_struct, unmaps the region, frees the resources
+ * This function updates the mm_struct, unmaps the region, frees the reso=
urces
  * used for the munmap() and may downgrade the lock - if requested.  Ever=
ything
  * needed to be done once the vma maple tree is updated.
  */
@@ -723,7 +700,7 @@ static inline void abort_munmap_vmas(struct ma_state *=
mas_detach)
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;

 	mm =3D vms->mm;
@@ -732,21 +709,26 @@ static void vms_complete_munmap_vmas(struct vma_munm=
ap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);

-	prev =3D vma_iter_prev_range(vms->vmi);
-	next =3D vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -=3D vms->exec_vm;
+	mm->stack_vm -=3D vms->stack_vm;
+	mm->data_vm -=3D vms->data_vm;
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -794,13 +776,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_=
struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev =3D vma_prev(vms->vmi);

 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next =3D vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error =3D __split_vma(vms->vmi, next, vms->end, 0);
@@ -813,6 +796,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_s=
truct *vms,
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
+		nrpages =3D vma_pages(next);
+
+		vms->nr_pages +=3D nrpages;
+		if (next->vm_flags & VM_LOCKED)
+			vms->locked_vm +=3D nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted +=3D nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm +=3D nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm +=3D nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm +=3D nrpages;
+
 		if (next->vm_flags & VM_LOCKED)
 			vms->locked_vm +=3D vma_pages(next);

@@ -836,7 +835,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_st=
ruct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next =3D vma_next(vms->vmi);

 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index f65c739cbd00..7ba0d71b50ca 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -28,12 +28,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;	/* vma after the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };

=2D-
2.45.2


