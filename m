Return-Path: <linux-kernel+bounces-290018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62495954E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146E41F22C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7C1BE854;
	Fri, 16 Aug 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="MxouhEGH"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CA1BE235
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824642; cv=none; b=JwMTEgfOwo8h/NY4/lqnNPdRyug3OVCPW1DQEpfLXxOtfmfXQquBfS5Pph+EIbQbNYgJjiUh4Fx/ZSdyd5MeRR/VLDv5/pAN18V8IFo8/Z54IUvwhJ6wQZycl2xFeLP2Htrb5Q3By7rqqoAmoT5+ZLFsvQ9+InLCAcuS2Va8syI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824642; c=relaxed/simple;
	bh=VL43nYnWYoohfTmXzzkN70RgbAPkE6iKYphIUAM8O/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZq3E7F4cQQSX6eFo3cROSM+uxxeOvPRMA0Pyd6ghFX2BnQARhZYed5TvgxVnsaTuEouCriBZ52fE9MIsDY3kUilSAE+E4gysxQViWUIgy71RNsiWrwgqtnVrYKpWqQU8Ji6KNNk61k4aHzGZPg0re3OvHPrqAgglHobUYB0jlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=MxouhEGH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723824614; x=1724429414; i=spasswolf@web.de;
	bh=Jt4AnDxa2v6eX4uy5aSPJq3B4MFKZYmw5hpJKYIii18=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MxouhEGH9zQ6cxHiav2M2R3Acaoqrud4CaCithT3Ew3Q0P6JhrAV4nE/lmfLaw4f
	 wo04FFwJWEi4ag11Z3XZ5GfwHFY84o71uiXKBD0z4qja50wtU7tTm3gXEm1SnGa6a
	 osxGYi+DVAauuml38waCGmM16pjlz6rCvegzE+mbOl7TgXkfnjxRh92qwkiyesUiH
	 lD3u06kf9KnJPGsim1AQnD+DXoftqCeXv30rDTqkCLCDcOKRaEK0xns205vzTOYLS
	 sNEtDXYTzRSJ+q+BTmEZvDM+yiRRxV5OAhQZHd05cLCiKilrAoRH2yPlfqXA0vY/B
	 XSciziARwlzCA1AHaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MFJnX-1sPFwV22DR-000iNq; Fri, 16 Aug 2024 18:10:14 +0200
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
Subject: [PATCH v5.1 17/19] mm/mmap: Move can_modify_mm() check down the stack
Date: Fri, 16 Aug 2024 18:10:09 +0200
Message-ID: <20240816161011.2825-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/tV0rt25aiRoq8ZeGhSC0y+MFw2Llz1W+RtwQXZFZS8ngpSyUwR
 ZlYPrOs/5YpuIlkc4v9mISTRyh9FIgZuLuz4zRDC5WAuBRlyBNyaYiLwKoBViTLOXlSmOli
 GUqpe01cAngade7VPcZd1EqoFxPaUELhrATcqcXc1JuSljq+WgsANILkPZpf7xvhUl9c871
 a5CLtKPrKTA2qruM7TDvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZLsp+uOi0sI=;LqAopercSIFXhWS3BGil7aB/SAJ
 FaNIYjzqw7t+vJnAznefAIq5b6ZlKE7eas1V6s2sFhWNKFcZSvnsJYRT39Q5jNuHQSgST+1m+
 sWtiL/Ck5APRGSetgJtG/qw2jQUqIL/Ro0bv5WcioNotj4xNpEZPPWaHJ8uYyImq8NLZCFm6F
 9n0yX86IpIthnt1qb9povfIHQIdhofw7akBEgRtSwrX6GS3GnU9XpdgFH9ood+iYUciXSDn/Y
 ThGeGQhNMeOY5OG26fVZIpEWOEDlnA0Ec+WdMJSN9fR5aoXx8HAbrUKoBxdyXHY2ikYBft54s
 N+pJFpshxyTAHrQ+caSBGw010Um3nuYK9EjZ6vdOuNZs5e3H8DTAMuN8nv1c09nQIu9Ezyn6h
 L7bp8Gf8pDpBpErenkg/3Drj7a5kCzKlRk3i5RiQoQ00MnkP6mOuCsBku1+QCAqICaMXjf5Fo
 eJwZSBFj61DfFIAnEiMBkNRZWp4pG4xtQvDdpD3VZvGbekjYYQ/rFfX7gOdsdr2HnkJCYKFvh
 v59d7ErXSN/IV282AmNolHiYsE6MAXwDZYr9JQtML/i/L/DFEDpg9jGszSFfEpTKyT+pfNUb4
 xn+QSb3WJgcP556QW+YomvwMtqBDwSxSFdcodXUbtuzt1vT6Lim/2XpAoHVtrQ0yIKJOf9MgN
 wiIq7Nd+Ljxg2COnSU6hVlqUgCux0CLR3pGGKNOj6aZ9blJzfwabIVuK+7OTnufFBuo/BQiTp
 HHoDVemLsDrC0ZeZMa+lshVYvC5nntbZXuToHbZyP9c59u/W4BESG7XHVPlEghPFrXuX+qwl/
 +PsSe7LRfZMu8Lnsz7ygSz9Q==

Without an arch_unmap() call so high in the call stack, the check for
mseal'ed vmas can be moved lower as well.  This has the benefit of only
actually checking if things are msealed when there is anything to check.
That is, we know there is at least one vma that is in the way and needs
to be checked.

Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
case of mmap_region().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>
=2D--
 mm/mmap.c | 13 ++++---------
 mm/vma.c  | 11 ++++-------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d0942b1a62f0..ae74d0674b6d 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1387,13 +1387,15 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;

-	if (unlikely(!can_modify_mm(mm, addr, end)))
-		return -EPERM;

 	/* Find the first overlapping VMA */
 	vma =3D vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock =3D */ false);
 	if (vma) {
+		/* Prevent unmapping a sealed VMA. */
+		if (unlikely(!can_modify_mm(mm, addr, end)))
+			return -EPERM;
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
@@ -1766,13 +1768,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 {
 	struct mm_struct *mm =3D vma->vm_mm;

-	/*
-	 * Check if memory is sealed, prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }

diff --git a/mm/vma.c b/mm/vma.c
index 86757443a7a2..f267b2552c8b 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -957,6 +957,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;

+	/* Prevent unmapping a sealed VMA. */
+	if (unlikely(!can_modify_mm(mm, start, end)))
+		return -EPERM;
+
 	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
 	error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
@@ -1007,13 +1011,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct =
mm_struct *mm,
 	if (end =3D=3D start)
 		return -EINVAL;

-	/*
-	 * Check if memory is sealed, prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	/* Find the first overlapping VMA */
 	vma =3D vma_find(vmi, end);
 	if (!vma) {
=2D-
2.45.2


