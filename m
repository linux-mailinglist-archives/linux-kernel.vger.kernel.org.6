Return-Path: <linux-kernel+bounces-289582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC679547D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CBB283EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA312C552;
	Fri, 16 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="KTIUKbqw"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA6155743
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806909; cv=none; b=NFsw4qzl11AfWpu+VgL3HA0Ur68RosgA213i8srwGkgJDdma07Rxg+2OIHbWan3fHHs7YhZXv9/ua3Rhz2HhrTyACiToKlwBY6lZRZuH7/c1CfogxylBJKLTva9WevHgluh3X5aPSXDkkm1Rqw3U5aHe9zdV3ctilc4+X5q3LTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806909; c=relaxed/simple;
	bh=u+VXuhg1wSNqx2L1AQpEiKUiBuWRDWWtLrUgD01VppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syJGXddbh6RjQIUrJealjDsev2jgowD+cujXgX4NWsHLWn8xvHkzOHwMO+O8Pm78YkBEqp5FFZEpaJk1cqTmb1CP58hcg6JkRZiOlt/Q9vm3IPeFtxN2wLcY66cMSoXyey54d9APrFN6RrDH1Wpv+q32UjFHxSeF/A/UXBKeThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=KTIUKbqw; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806871; x=1724411671; i=spasswolf@web.de;
	bh=HVP/JBjkTr9Kn9Gb734inJ0oeOamhPQyJTNaGFebizI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KTIUKbqwITLr7s3ozUruWYzgNjxVdUriID/MyHfuFupfMx1YVebgTrsoY6dLeq4k
	 OCX4U0zKfvsNLGQ2rJP6QltSstQ4NWtGZDfAKWXLD2ijVPhz8Yp2tra+fh/bcmR2n
	 SjaW5PxmbincXKXI0CjAIu5AtU5OnD8AguuHy1Z5su4mPKm1xJhkTti85JcoImI8P
	 OtsenG7/TEDcbiT1qZ1S3Mfnk4V5i71ho+DHjWSuihffRlXUHtAG+hb4PoXSQvw9v
	 aCGctUAkjVwayc8ySZmsLWTfdMtNFdNrGCWX9u4BPOncDeXhRn5a8gE6lkUBdVKBE
	 WH61SGftsH7BwAzUCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MYcll-1siVpl3UGp-00KwGf; Fri, 16 Aug 2024 13:14:30 +0200
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
Subject: [PATCH v5.1 10/19] mm/mmap: Support vma == NULL in init_vma_munmap()
Date: Fri, 16 Aug 2024 13:13:51 +0200
Message-ID: <20240816111405.11793-11-spasswolf@web.de>
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
X-Provags-ID: V03:K1:q6+PZLLMAQhWGIUUnFe+NK15H6pxq8ferPSFmbhVruB+Iqj34vi
 Vvig817bDMFiALU3jtN/o0wRK0UO1X5QqtBSqp+Iqio8LXi6y3r/oDwXXq3gx2BsHCnuh14
 AH3rPst1zjnX+pOpVIkFQyAJwYAevi5S5yMmDiVojj2gHzh4HsT4BPDOqoGBXjYpzvjLcfN
 uEY1Eo3o4fHIWymmZivMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tkq2ZyJLUUs=;NDKjhBHZLAb57n0MPvbpI3x+bmC
 GlJwSGtGlSmhH+wk8dboCb737ZESaJU11qZazsPwQL02aDo2gj6uoNqASE2fd5Q7qYBx/3fBX
 YYVZVL5dxrBbOTJ/4XNwWisEA7uQWpRyealJgCEabYWKQzQurC7FbEnZbebt0Kdms+zkl6Iq6
 tIMVtVbvp2jweIlYej6fNdhJSRvYO4lWDsrsd11PzyqmnDj8gfG+48zGHIyf5GrI0SuCjp/Qa
 F4aVFJ6YderwAViV6tmOe4QyK2oNj8VD0sUZqG/d3cghCfHpWd9WZVpy2g+XiEVnyLG6AkMG/
 tUGtex19WbBY4HH3Pjw3sJ3g18amYEJq3pa8X9L0z9FzIfGC6WK1WaYGSzKzcBM67lWcFcDNI
 UszMkBaaoIMk3gF/UEzGCa/5MTER4p6Q5O5EKovTzO2yWUz/jk4YizFGWVWmCL6elTISGSitw
 kijhC8P8STWE/Rq4s1ppo25ongtBW0trP+X/7fjfyhMORookvTg2j75x6F0U5ZNmxVgzctu/j
 YF/cmkuWSFIlxrGcmocR+F6cEDhKAdBtXJ2uY1sFCULoIxCWYHw4lrYS4vEa6hfXzBfp6AvnP
 lgLu4Bfzv00BwoOzmSFrotPuAvD0R2wSDBkmiN+hhdOmGdhXJU4jV+Tn0Ixw2nl4ujSDEbWxu
 6TYA/k45Yzzhm/ZlTAV9D3iTZQ7UPO5NU8gplaNOMwxi049jiXn8hdgPdBU+2pjmw64od2Hb1
 kOwOh1+f5JSo2mjBbkG7y5C07ptNIhZZphDvohTC3/fqdGt6GThMcac4JY/5eUyzwufcaDATp
 AF5Uqn0euHQj/wPWzjny+q/Q==

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
=2D--
 mm/mmap.c |  5 +----
 mm/vma.c  | 26 ++++++++++++++++----------
 mm/vma.h  | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 56d0aaff8478..16fd14b243f9 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1395,16 +1395,13 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;

-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, addr, end);
-
 	/* Find the first overlapping VMA */
 	vma =3D vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock =3D */ false);
 	if (vma) {
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
-		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock =3D */ false)=
;
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
diff --git a/mm/vma.c b/mm/vma.c
index e4677364082b..a5ca42b7161b 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -352,16 +352,22 @@ static void __vma_link_file(struct vm_area_struct *v=
ma,
  * @uf: The userfaultfd list_head
  * @unlock: Unlock after the operation.  Only unlocked on success
  */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+void
+init_vma_munmap(struct vma_munmap_struct *vms,
 		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
+		unsigned long start, unsigned long end,
+		struct list_head *uf, bool unlock)
 {
 	vms->vmi =3D vmi;
 	vms->vma =3D vma;
-	vms->mm =3D vma->vm_mm;
-	vms->start =3D start;
-	vms->end =3D end;
+	if (vma) {
+		vms->mm =3D vma->vm_mm;
+		vms->start =3D start;
+		vms->end =3D end;
+	} else {
+		vms->mm =3D NULL;
+		vms->start =3D vms->end =3D 0;
+	}
 	vms->unlock =3D unlock;
 	vms->uf =3D uf;
 	vms->vma_count =3D 0;
@@ -699,8 +705,8 @@ static inline void abort_munmap_vmas(struct ma_state *=
mas_detach)
  * needed to be done once the vma maple tree is updated.
  */

-static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach)
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+			      struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
@@ -748,8 +754,8 @@ static void vms_complete_munmap_vmas(struct vma_munmap=
_struct *vms,
  *
  * Return: 0 on success
  */
-static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach)
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+			   struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next =3D NULL;
 	int error =3D -ENOMEM;
diff --git a/mm/vma.h b/mm/vma.h
index 7ba0d71b50ca..8b2401f93c74 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -63,6 +63,12 @@ void anon_vma_interval_tree_post_update_vma(struct vm_a=
rea_struct *vma);
 /* Required for do_brk_flags(). */
 void vma_prepare(struct vma_prepare *vp);

+/* Required for mmap_region() */
+void init_vma_munmap(struct vma_munmap_struct *vms,
+		     struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end,
+		     struct list_head *uf, bool unlock);
+
 /* Required for do_brk_flags(). */
 void init_vma_prep(struct vma_prepare *vp,
 		   struct vm_area_struct *vma);
@@ -78,6 +84,14 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area=
_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);

+/* Required for mmap_region() */
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+			      struct ma_state *mas_detach);
+
+/* Required for mmap_region() */
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+			   struct ma_state *mas_detach);
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
=2D-
2.45.2


