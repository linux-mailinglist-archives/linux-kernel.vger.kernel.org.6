Return-Path: <linux-kernel+bounces-289578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00D9547CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F53B21DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B11B9B5B;
	Fri, 16 Aug 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Ct60w/Lw"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146319DF4F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806902; cv=none; b=k/zom2LkmnwRBh7Z4tC/LoGNruqhu/ttvWdd3+GdNXCnB0DGtYPtgbEcamCN2mcuMZ6L2YgU3NIMlf1d1EIE5P8VmMXDd65cRLY1kWxmOiIOFpUsOzggd4wi/RxavjPmpdUQzKwD2Z8bGiSMWzFNLSgwrjYoH1/ayVoxDEZuaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806902; c=relaxed/simple;
	bh=ADbYtdQRncULWvphk7zU4FcSys84YfcQNRe74L+d9ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/iuAc/XfvainSaPm5vb1nbrS8zZCRf43VDrbdSgnrz/emFJUBwI9yslOX40CjPFCO5yeMICnOkCuq1fTGWqMfASlTYQi8033o6UyDA3g373GnL9/YSoljjxweImMMYzqVYr9klavwftAxlGoWqgAGeZ+X0AwXbpStyVTkGszeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Ct60w/Lw; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806865; x=1724411665; i=spasswolf@web.de;
	bh=O94QRspLCb1Ter1jcWYZ79/yZW2oVM5cQef3hvy6a+o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ct60w/Lwqy4o/CiqVarKJpz/BZNpHxc8rnDQDS0jM2EggTw5K0icYoDzM5efaME1
	 PaAn0gr9OzHRMFbZKuFuKLaa/wXUPVZiUQtgVJUJ17n8LZ5kkgwpen1oBH/45R3+O
	 k/dc0KnrP2wke/EsEH3k+GhMOgC5oNfaz5myT36Xzb/FPoLoN5DylhjH9oURL7FtW
	 Ij13b8IO/CeO1UuhBGN+uoWOaht8dMZR9odCV021ddL25UclyPk7raZfE2MoE7jFy
	 uDFBc8MwGcxvEskoOKhKy35ulalEsiLoXx+6MgZqGsB3pO1rCz2zclJykvNTEuRZU
	 PIiLmAsygSzoOLxbrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M2Phc-1sb4d51SAw-00DZT2; Fri, 16 Aug 2024 13:14:25 +0200
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
Subject: [PATCH v5.1 05/19] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Fri, 16 Aug 2024 13:13:46 +0200
Message-ID: <20240816111405.11793-6-spasswolf@web.de>
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
X-Provags-ID: V03:K1:Xow6P1CPkv9JrFgOzkYeaVlz5A5aXI9IPW6ca4u3EDYV+mRkkdZ
 L6Dg2AQnE6KRQjW5Yp6edvS/sQZKPYTYy8A+LxRdVZ3eJo0j6GYc/K/7V/wG4rn/RHYJkyr
 36rmbdVbCKbBsbYi8YC/jcUkt4uEeB2sz04s+YlXsEji5due2wWJcWhQOE6Ui83SPjUsSk5
 xchSGYI5N5yH1HrU90Ftw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:11uR2nMLhjc=;FW3YfgVlt+qM5+KL6eDuIuCMv3a
 3u6qUP9IgPVWokBcxNBGReXjgEaP1qMLkKfKehaspiexAQCFNUIbitE6lHu41gfXWiy9vmUsV
 fUbwNY/8yv8exex9+JnONdYa2BhSU8cYPAZMoUs/wp9qJJP19yuva/Lz4CoYNj/8MIr9TqRmI
 L1n1eFHZezNWQfKy9QZNJl6qaojp3THGq6kQtPeZvMPK5M6Ae6eI56XWLclkkZ53nCl7a39DE
 TLDp/2ylFG31K+g6LGNEj+XdyJ8oTcBTmp6aHhyQAaTTVZ/0YHovJ+v9nn66QCaZUfBIW8ZG3
 OIJ9QryAOgoFIPP+4wg3u1fu4rcGKVWOz2tY5yPvyT6Zfwlj2tZNQk69QJK31RAOmLGTTS+uz
 w4VtjiOIYf+SpKzHCqTYePSeNI5itKUyVAewdXGD8QNcXtOytDTjLE7qMjcFOs6+JwRmMazjH
 +e6uj9dBomVOGqBk4XEt/Kc2Y05i03Ba0Q80PkQIpImpqdtWvECriwpfTwYXp0Xos1GO6J/Tv
 GgnR9YlmdCqVwyBqafdvDTlxcyqrys4ANXnvLwJsSQ2TQm6REMe2o/iHZGqcUJUWRBKXqF2Wq
 P5MwlQDrl1gChorq2bGDA0BBniDejITQPvdWbAtRV3PMlJ8cCD7qEsWyUxnPOnshJmk0xmPIq
 VOLNDDExZz08TPGRkk/kcIDbacU/0gIjOzpknlkfe36GxtB0NeG1oWg8yQsUH0qP8MlhV/DOU
 dpc2+F6kcVCIfwgVuxNAHG8dmGBZqehzowfBi9iSVQMVxJbrkf6CMbC4zRZHEeWkR93rp31Sy
 mZjrmgoLmAMkiQ3x6J7LdTdg==

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/vma.c | 140 +++++++++++++++++++++++++++++--------------------------
 mm/vma.h |  16 +++++++
 2 files changed, 90 insertions(+), 66 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a980837eefd7..9495230df3c3 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -365,6 +365,32 @@ static void __vma_link_file(struct vm_area_struct *vm=
a,
 	flush_dcache_mmap_unlock(mapping);
 }

+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi =3D vmi;
+	vms->vma =3D vma;
+	vms->mm =3D vma->vm_mm;
+	vms->start =3D start;
+	vms->end =3D end;
+	vms->unlock =3D unlock;
+	vms->uf =3D uf;
+	vms->vma_count =3D 0;
+	vms->nr_pages =3D vms->locked_vm =3D 0;
+}
+
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to alt=
ering
  * @vp: The initialized vma_prepare struct
@@ -685,81 +711,63 @@ static inline void abort_munmap_vmas(struct ma_state=
 *mas_detach)
 }

 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the reso=
urces
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Ever=
ything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct =
*vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;

-	count =3D mas_detach->index + 1;
-	mm->map_count -=3D count;
-	mm->locked_vm -=3D locked_vm;
-	if (unlock)
+	mm =3D vms->mm;
+	mm->map_count -=3D vms->vma_count;
+	mm->locked_vm -=3D vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);

-	prev =3D vma_iter_prev_range(vmi);
-	next =3D vma_next(vmi);
+	prev =3D vma_iter_prev_range(vms->vmi);
+	next =3D vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);

 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);

 	__mt_destroy(mas_detach->tree);
 }

 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tr=
ee
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tr=
ee
  * for removal at a later date.  Handles splitting first and last if nece=
ssary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next =3D NULL;
-	int count =3D 0;
 	int error =3D -ENOMEM;

 	/*
@@ -771,17 +779,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 	 */

 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {

 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;

-		error =3D __split_vma(vmi, vma, start, 1);
+		error =3D __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -790,25 +799,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next =3D vma;
+	next =3D vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error =3D __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error =3D __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm +=3D vma_pages(next);
+			vms->locked_vm +=3D vma_pages(next);

-		count++;
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -818,16 +826,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error =3D userfaultfd_unmap_prep(next, start, end, uf);
+			error =3D userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);

 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);

 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -836,21 +845,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;

-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test =3D mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test =3D mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas !=3D vma_test);
 			test_count++;
-			vma_test =3D mas_next(&test, count - 1);
+			vma_test =3D mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count !=3D test_count);
+		BUG_ON(vms->vma_count !=3D test_count);
 	}
 #endif

-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);

 	return 0;

@@ -886,11 +895,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm =3D 0;

-	error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;

@@ -899,8 +908,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
 		goto clear_tree_failed;

 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;

 clear_tree_failed:
diff --git a/mm/vma.h b/mm/vma.h
index 6efdf1768a0a..f65c739cbd00 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -21,6 +21,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };

+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr (inclusive) */
+	unsigned long end;		/* Aligned end addr (exclusive) */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 struct unlink_vma_file_batch {
 	int count;
 	struct vm_area_struct *vmas[8];
=2D-
2.45.2


