Return-Path: <linux-kernel+bounces-289574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817299547C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB81B21BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919621A4F04;
	Fri, 16 Aug 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="j0eUVv6E"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1B1991AA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806899; cv=none; b=QuOe74Fuv0Z3WtvU9/XoqNcFcd7Z5EO9eEUTvU8zlFkNpVJ7kSPJtcjWKP4cT/6rjvlysJShH2YWzoTKEmXwiFTalB7STCyLRA0E7EtnGPxFL7CKcMomEf2ETS3Jp/J9SjdoMxP7eB8JXkul4UYdXngpEgUKmJayKhAhXUwtRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806899; c=relaxed/simple;
	bh=SNA3tamyuMQEiGsm5qKKc7eSznDnbWiaHRoA/u7ALbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPuYXHbqyj5JutEHYAvbbuUyDj6s3KASqCSWnyVWLYHugI1rUayFOiGwHQUcgcELrQnwY1eFn/eEuOfnKBzAyHNRE9WjufM77WlugnjmrKihQ+0xk9z3mhyeX3xoVMWy9J22t8C4VcDYnkqNYZoUZAAwA4KcHjVD6HQxsPTVjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=j0eUVv6E; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806863; x=1724411663; i=spasswolf@web.de;
	bh=l3TXWV1Tp/aKQfD2gCIur/5ETslPLQoSLhNXx7Vp5IM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j0eUVv6E/rG8Cnhu49wfDc3ZjB308tJTF6zB2+RJHsRCdCi+Zt4nyYI/ByvcxKzC
	 nVunB31UCoLPS33iT3ORKWHQQyKlzZ/JUPT+PsSdWbVi0fWF2M/U1wFDR/Lg2bjCF
	 Q0npjb/EFieS/J9QGRtwhXo79AwYsiCtYyIFc6uBoEiCEKaoSJSKvqHGBr9cRQMkL
	 2beEdqQLnqppjuv2iCHHC0+kbttT04abwSRndJRr9/uFNu+0fmqum8Y/8bauO9niL
	 yGHoJZ0JO1zYe0Gy3e9C+zsBHQia0yMzeLrLAtdpJ67ueqEjSGlzbxG/HI+H95Tjd
	 Molvf+0gFkyqCuX+OQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MnG2Q-1rvuzT0Z0O-00gsfG; Fri, 16 Aug 2024 13:14:23 +0200
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
Subject: [PATCH v5.1 04/19] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Fri, 16 Aug 2024 13:13:45 +0200
Message-ID: <20240816111405.11793-5-spasswolf@web.de>
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
X-Provags-ID: V03:K1:wTQCai+xUeqxjSfq9zUCYkHRj+YFQBFLdsczal4zW75GOviwbTE
 x5RrT/HHxU8w23/NaMxYwThD5F3v/k6iYpTCuPKN4+IZLXDz77gixcKc5xsxLMJGJpPw33+
 NxS7VuPndRr7JacDCDCtI4DAOrxeM0LcCIN+QdLH94axfZqSq1ebKnJzFtIXaDiLwYYVOWO
 0QvJxWvDPIwKjLFdsaA5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yr2ZPw4vKiI=;FDy6r4s5ooBsVf9RgTeJNvQhI8e
 ++0xFb6KVDhYGn7fbXxa0mFvvKvxPwVHl6FgqboR1sowyn0v9bqG/2SifVm/mLHHJ9JcWNZ7o
 XAt1Mz5L/MpDEOq9L6R9jMhjy+v7cwoCgYdI1gDEUfuWMPvyXik4dcyDcbKxdVLEcU4KzXAgJ
 SpU8X6tuTKQFY9JTKhMJ91fTXNyRE4frpvxnhIF3mrqVC221p0zePFEyLGZMksN3gAI+uHoox
 844WAkat4ZyrPqFMJsYh+y+Kid3V7Ot3Yz6aeQ8J+qVZpeg771D33TDB/IJthuXI7FjwZBP0Z
 WlKXgTmqhjdb+to3KFRPBEzp5/IpH7SZ7JywG00FFkoov9U5h4f9WRQHgPgrZS0kPT7MOd0bH
 YgrvIwW4DXvvgXM72GS7se+JxLMz6IwIA/hWuf/uWGZztLfA7t+lNltlLR84XMoHkPewjbnEh
 j8tYgfZbANYsqMzctXp557BMtciWVS2R24ebHDno/VqDm5LgeUr80MdV8dlFr85LsB0nNa6jx
 tgg0NZTZqrqUeeqxdn+430+tg+3DiVzcs9B9sXW/RplcTqVE8Sc4qogZAEuGM50USDJE54ygB
 6LsfRUw/ppPsf3Maa2ktIVxeF51kS0wNk+zcL/38/zlfihnMz7YAzOrTTaCP9a0O/BEIRd5ds
 Dx2p8YgxIXqu+ay+PSWP6M/xbCIKQr0oIdinqGnrqiTlO7tsu0fWqACKPF2RiSkzLAJw0mzq+
 sSua4B97tMDhCm594KVCKAsVMfFW0a6Bo/9sYkmCakdr0ZrzW2uVt86GhDFEWdyip1eSre8FM
 dCyqm6BMTC6wa0h1SHKSGo9A==

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/vma.c | 80 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 22 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index d331ba575019..a980837eefd7 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -737,32 +737,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
 }

 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tr=
ee
+ * for removal at a later date.  Handles splitting first and last if nece=
ssary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leav=
es the
- * lock held otherwise.
+ * Return: 0 on success
  */
-int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+static int
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next =3D NULL;
-	struct maple_tree mt_detach;
 	int count =3D 0;
 	int error =3D -ENOMEM;
-	unsigned long locked_vm =3D 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);

 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -801,13 +799,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error =3D mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm +=3D vma_pages(next);
+			*locked_vm +=3D vma_pages(next);

 		count++;
 		if (unlikely(uf)) {
@@ -834,7 +832,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;

@@ -854,6 +852,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);

+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leav=
es the
+ * lock held otherwise.
+ */
+int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm =3D 0;
+
+	error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -864,12 +904,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 	return 0;

 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
=2D-
2.45.2


