Return-Path: <linux-kernel+bounces-289579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457CA9547CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C801C20FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5D1B8EBB;
	Fri, 16 Aug 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="PnWlvgWq"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3419EECF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806902; cv=none; b=e9/xfqu4BVm63JGgwhEo3Xce7EA1QH4wm1jgrKQub+ZpqiY5YS1JJ1og7hBZezLWBZ0125+RPsYLSbLKGa+kYpFBki5DXokzUgbvrSYNNzKZZ2xf3wfor5+kWnoyhO94LuNLjuQTJjwObztPAdNNfbAbvTX6f8rEFnJHXqJgtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806902; c=relaxed/simple;
	bh=zXztDRhL1in+c/jUKZ7ukTEPlmhSqamu7SJYxSMHrak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp8fr6UHIp9whl1VZ76mVPyneWeK1usaXIQoaNl2SogdYhnMNMeRGLpgp30CeClG8eVPW4uFgkljmlflGensn14KcyIN4DP0OS7t+Xd3cAhrbI7Jbt5/hqjblnYVBLDVjohOfMWy2637MPYnQspqceWY4bx9rLbUwM+6SWWneG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=PnWlvgWq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806874; x=1724411674; i=spasswolf@web.de;
	bh=/7yEM/06EBzG8T4jP9FKzjOed5lkzr+9lbfhTuSKD54=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnWlvgWq07rw5K2AbEW/W0YHB8+83pEqmsERFc8LTpYPSnQO8i5dBCClBupZILvI
	 nKHQwo/AFeV2PU+bLnYTDKjxej3jlSfcDzypXbta/Gik8nBeUCaVNKEjXCBynFJOL
	 OPI4SrrhQrhv6Frf9je2f+Bn+s/Y3aCogMQHw/+p8AfzHwHiCbSvrsb5G7aN7Y7si
	 ein9Sy73F60/nCHqyHj27HrLYc8Cmh52Jyx0yzl4uVmnm/uYFfDD63/JlPQ/bn5Hz
	 yJGo7Fn0OU8aUJUe1mIVTSvgRgMFFEMha4RJo0Q0IVnzArcj/PrHS+8EzwRQRNGiY
	 Rq2szIHGOqxaInQABg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N0qr9-1sHjG03Qph-012U23; Fri, 16 Aug 2024 13:14:33 +0200
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
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 13/19] mm/mmap: Clean up unmap_region() argument list
Date: Fri, 16 Aug 2024 13:13:54 +0200
Message-ID: <20240816111405.11793-14-spasswolf@web.de>
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
X-Provags-ID: V03:K1:jcyktmfYp2H8ZpYasihi+6y9QqrVM70RvOr4ii4E0k7G04jdQfr
 WRh/wc07K8NzAyi0df2eqblsJNtMNODFUvfx0e6ON3i+aUPh3lth9islkc/OC61HvgNrx1j
 rwhjBWEYxangRdzx7VNJCcfzL8YnfnreVppys89DZeALsqEsuEbG6hFOK20dXCS4kT+YZbz
 8aOg+qnqVRU2DwJjE4l3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VHYw7/oy+O4=;fk6pGRSVvznfcKvi0qmAW8Ep6CK
 c5YlN2Zten+WKPKObYsf9C5Rm6XRw+TpsPsCsKoPEv0DGQK99PqaG7cSJZnaJFxEdbOsgW+D/
 1Gto6bNQtmjC2OAKM2rmGqo6eyd8T1Ik8DeSRhb6z/f/eMrddrolne26e82y6Kj56qAyOrGSc
 zg/Dkic8BqxoV4O67b3WNXhSO4+wHnauvRB7Zm+z1pwmGoNKlf+R9SAXI1gvYvTzb1Yhn6xjI
 Zm5M7s6XN0XrYMrMNcklkTWOq9Sm81li/QX0bTvZd5Y8WMdeLT7gAPPqs3EFCgtnfk1vaEQmo
 z41Y47J7zgqGIJeS02BHwtBDjEbpYkWtztxiYFkl1zDhyjiegvjsRuK9dq8Md3Jx6ddwXuK56
 zoJb4GVg3jLHjDqA6gqqJtAQEFVLAqWyYZYJiCCGQhMRx9yTOc6vzBEZOd98Mqd8HwihboxcY
 uRxTnGTJBKfGG7kt12cHEAc+jSP5puYOKRNcHni3jRmRW/6NA/OOFlar/+M19A7Nx3YAMAq4j
 q1tAfYraN1Aogkbq7wBA+Qf9XENmJf3SHeLJCNmyfFVcZs2GPhE2aCUd14sAC11FAzIcBgFY3
 wLCU5tz5+zZm+wXSpp1lx8cIYIF5a77fTqr3JZl/CHZd8+Q5MekCI9eH2Be+fYRAttIwx3UER
 kt5M09QDera6ZPDAt8s7SeQOqcjd7xDLdIkdjt1A9SuSFtdQmvCgn7VUhJOkiCJufl1Bs7Uhb
 SOmY5FmmPRsuWNyDTJeRPGioO5+17UX7WcFOhXxBgY6/XlfThiDbYqLpTEcRgpvsFlsbopcg/
 sxnq39j0dwq7ATBKZUuegfKg==

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

There is also no need to forward declare the static function any
longer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c |  3 +--
 mm/vma.c  | 17 ++++++++---------
 mm/vma.h  |  6 ++----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6720b55b47ed..1f0b8dc5a089 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1617,8 +1617,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,

 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
diff --git a/mm/vma.c b/mm/vma.c
index e106d412c4c3..0244320d76ab 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -155,22 +155,21 @@ void remove_vma(struct vm_area_struct *vma, bool unr=
eachable)
  *
  * Called with the mm semaphore held.
  */
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm =3D vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start =3D mas->index;

 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked =3D */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked =3D */ true);
 	tlb_finish_mmu(&tlb);
 }

diff --git a/mm/vma.h b/mm/vma.h
index b857e7dc4bfe..2a2ca489e622 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -108,10 +108,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm=
_struct *mm,

 void remove_vma(struct vm_area_struct *vma, bool unreachable);

-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next);

 /* Required by mmap_region(). */
 bool
=2D-
2.45.2


