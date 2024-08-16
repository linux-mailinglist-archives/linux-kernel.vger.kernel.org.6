Return-Path: <linux-kernel+bounces-290020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF2954E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718EFB24525
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A921BE873;
	Fri, 16 Aug 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="qZjuni5L"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848017710E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824656; cv=none; b=LRziNufe8fyENNmflD8Tzhxz5nv3UZSSRSoXNLWkxe0zSNPIfh5u7SCuIDIY1lbOc+XO851IoJu+Qex7k6rkfA6T9Lj8JUpP86j7tMbVUL/Zw6iOWYrCu7fZ/mjjbbEmX3lxez+F641HzV27/OWNnKbDzr0lVRTtg/heEN7/P08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824656; c=relaxed/simple;
	bh=yIk80ZRGADSAjYqhqMG31u7sVGYT+56BfhDfvWeKUew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0ADZPuLdV4Hfrq+Xpr7/eJbpYdcjkKempMAPoWNnYpI94EeZAC1N2+YQBzbC8PTb60Jl6ePA4RGFycnoKGq9qsRMHbC/CiYO5WAS9pof90LHGrN+jq1TGdcL7DauOHX197ubnalYOIt+YRe01ZeFlzXhBEUT4ze61Xd4HZMubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=qZjuni5L; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723824624; x=1724429424; i=spasswolf@web.de;
	bh=AqH8ZahU0Ew/z25cFE4au3x3zvZRx/o0pPBf330Utj0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qZjuni5LCs4oYuVCZusa6gqTmhASB26+km+807lc16rRQCXxjNmVnGenGI353vWZ
	 YUaFhqmZxlGsp9npjX3QqYw/U1u8tPFj33qXVOaffgyanCdqmipDqeRa7x6iGXHKV
	 O9IwLuk8F6hnFzqM4rwY2T8yoLwZsZpJJv3U3zRNf7Ly2l7R27497HXNRSy8vDu2s
	 DjUrlK0mHhGSggk2WKCVba7PUKnW7JlFVqfQrEH66pZDzriYX95lJF4+w5mlSDEA7
	 g2jywPtKZRB24Jkap7rpYFsXZmbEvy1ifI8I4UYV7Kyt7i7lwxvM6sIfp4ORqH577
	 qKHlkvP2kbmKJRzddA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKuKH-1sswPS2QWr-00Lcmp; Fri, 16 Aug 2024 18:10:23 +0200
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
Subject: [PATCH v5.1 18/19] ipc/shm, mm: Drop do_vma_munmap()
Date: Fri, 16 Aug 2024 18:10:19 +0200
Message-ID: <20240816161020.2845-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pG5/9OccDc0jmknnLiMC90N3TcGHFcL+ezavX79zPFVjOUla0KP
 8ZdVhdU/iTbUmFt/RfpHAzG2yCA9a4ZiOpoksJz7cBSVm85f3uHKhKAIaRorQspNBFnzeGm
 bDzqstp3/21sQy5rU4iBk8fZQbv3hyPxbSvdW25SfKghV/VOT4cFF9eUMZPkEeieMrujo6j
 v/eoITaqZ+PtCqam4e0Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eYlzR9waZA8=;X2ciPsgPNvjP5nI2TnpdJPGQpTl
 ZGbpSOwDaVm5k/sSYOr2VTEIHeTvCjtWQ2bvND3mBcq4ssJ4Be+fMKt1Z4bB4RiT2RM4RfsZV
 BuyBUSKFYD47YkkHMm6TqgHiwrQZAEVb8QQXnYl534UVjW4WC09jHMSJVKt6cgaCu6n/jJf9/
 FWa0xEThkn8DjzmmMKgqR8yXouWYgP7O6YToci1pn/Zyimqf6JcN8vzVs8jOKPDFJdw0bUJjX
 63JiWjWs778Ybdm5x1QJupMw0hYyxAzNbctfeH3rDNuuk/0qTAuF2NMBNnPfl21lF/0UUvUd6
 xewZ8FhVtfAr/A6lUPAS4FAepYzao8RKRaNoYwjQ4eUx+sPj/DQRLr0Q0ZPVNPPKlvSkLWyGa
 o5gtJLqgMr4sSc3SArDITKaGf2N3fbEom82k4iK8q9ILREJVeijK3Mwgmsj8KOh/u2NXOTnWh
 1G6gJg2RZJZhaINrW5tAn2dLjepplmhCGNdDeSI2XIaZCZZ1lO4JAydRwJ39x9GTME6mpPQtj
 TyFnRYi2Kwf52MKLCLpOWm9eJQ326jKjXQfCUZknw1+IP7meLbuTWxKzdZRd5p7kzfIhTDpkB
 /ZrViptLTW5MuilUD4Z1nNGGeVckAvz7nUiKAMN3WZmIrj3cQ7GeKz9uAzIPltCyTK0hBaTPW
 oIusx3li8L3Dl2ReYZdSAzjDx1t37H2jET/faXZ3xrH7gRe3DbcrC8xMAlQskJseQD6D4JoZI
 DlftLjMzMoH43BGtPbki3ST2Ip5yC281Uy16uPt2qM2kp6eYq7/dBTidKNMBsUxbJvRejE+5+
 nGPF7cZj2glANQ3dcMJAzDHg==

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check of can_modify_mm() has been moved to do_vmi_align_munmap()
and the vmas are aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
=2D--
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 31 ++++---------------------------
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 653287396808..2dccdc7ba09a 100644
=2D-- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3292,14 +3292,14 @@ extern unsigned long do_mmap(struct file *file, un=
signed long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_s=
truct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t l=
en_in, int behavior);

 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct =
*vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
=2D-- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
 		    (vma->vm_file =3D=3D file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}

 		vma =3D vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index ae74d0674b6d..d2f47cd66650 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -169,11 +169,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk =3D brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock =3D */ true))
 			goto out;

 		goto success_unlocked;
@@ -1747,30 +1748,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 	return ret;
 }

-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure a=
nd will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	struct mm_struct *mm =3D vma->vm_mm;
-
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
=2D-
2.45.2


