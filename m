Return-Path: <linux-kernel+bounces-289577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9C9547CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1CE1F21F61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220581B32C5;
	Fri, 16 Aug 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HIKle6HL"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE319A28F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806901; cv=none; b=eI3xMDOucmz9V/pcsolJRdgTnMaDZn/9/EpfIxNxeAYEEKmORPmdvf8bBWWs7FU9A6534cfg5+jjC0vK+iZQXZILnIJ3Mvzwx1AXILQTbefc18LmDYIdOA7QNosnMgfCOV6+4h/7yhbntwCsl/SfF5FggD3olGW3zaZJbjv2/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806901; c=relaxed/simple;
	bh=F3THs/rtPtxbfXfgPMwuGFycFlQdUFI6S6RxH1o3lHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4lqEkdGW92ZqJ4BPySObBF2cy3Ki7gwYuF6cBTD9N9bsikyTGMEN+WD84RxiyAspYoIm2WLEZxCG0Ml7X3UMK+VRP+zgonHCCPiv3PLzhbke0FRC98V1worMd1VKHfkak3eqRJmNEiwmOCJY6jb3Ex+z0fKzWrAGykhAahTPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HIKle6HL; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806861; x=1724411661; i=spasswolf@web.de;
	bh=0obejYoa2r7hw/w5zRqv2QmgIUrn0jX3NuGgwo7FlG8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HIKle6HL3gik2rTP8fMx51a1KXQCUfWcUkbj5im6liQLmMAMbETBT2P/PLQLctmI
	 wB+KQZZnNgoMVsc1pUf96GR1kjXkPYZ9JvI18CLEWXeM+77LTAhc0BV0GMtlkl/xJ
	 Zm8uq3dJ3tma0hkBl7mf/G06FaKbgB347mJTgVkUpGMr6cSG6u9AFKZy6QTVGLzWq
	 WDiS0ifH6K4yAwyZGy+Y81+uO3DfQ1HJ4+SCRLxzQeFCV0vcsIQlozGMFNHEHZ+u6
	 PffBHx58cNAZtZavb5XQ6IO6ft8FSWLz8pYeZcUsGAnV+oI2DsYScTd0vNO0EkTww
	 y75iYhSdrrG+Nl466w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1My6lR-1sEzR41xWx-00zkD7; Fri, 16 Aug 2024 13:14:21 +0200
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
Subject: [PATCH v5.1 03/19] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Fri, 16 Aug 2024 13:13:44 +0200
Message-ID: <20240816111405.11793-4-spasswolf@web.de>
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
X-Provags-ID: V03:K1:eqWc1iB4g+G2VRb/rfgfTQ4sRq2PmtECXZa+ZieLZIbxA1UeXNo
 0Ym4FiJ7Auovew6A0uW84ljNoqkHTaxNAX4YQto5wUKBt5IU2jTjlCP7i2csrJfTUb8dW6l
 WiqqSYLmF7P4CIJdkfkyCm/Fe1bLnggOsqruJeBk2lff+eAhZL2is4UG4EynqYVqTE4hNLz
 3zIfEnBggLKafepPJI8xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0ZOF32seaA8=;vYnMaxAP0Qy1WSqp1i/hpOix4hI
 +RotyKtfiWNyobKZ9g1oSvEzRj/DTuKmFp/3GtpTLajVktOeGnEeUhqL9RetMT554UOrzAtu1
 8M9+dpLjy8uPqlatJFFm7ljzWJ5rPPxMf3WfMzPk4MjWMPg4c+2DoMSyLsx6BG2uypX7Bh9Sb
 +K+it78vLrj8y2RzaQudTQbG4bFb5jG0CAOpRFUqpVtY7bCoB/m6+RLFhziMN0OYRQUOHkm0n
 O8OhBsrVo4goCDNXcl2UwNrfRf+COq6hQzp3qHermgG3JPBFObWCE74wqqyW1AgPQiYlMtxE1
 U5AOHYQkOa78mj4CEuXzlxJH6fWDeqA8Dgstc5jfRIk/xYhbis+T+hLXH63lY5ICFzdVIlmGu
 ldLL3bjpEvfhj/qYYzXDDnYeiYhFmXFSr7itdp41w/JD26XA4MGAD6CbXBMyQ/EIupiKoerkO
 EWy+fIlyUucumAm4fzX1KKJzbu9BaIncMCDFDaoaD4hwT6kmNvAhAI7HnQIbSJeOTzecxFbvX
 6FiG0MXdSwNAVBZHKWdEkCOBzTxqJgH11Oy0rwJKGSRQvkYF870pVhrkEYoVigGnfNhdVNvDE
 1jSULfEgKpVfaWpfKZF0QsjnG0Hvpxi/tBxXMkQM1N9iRbPz3VJeYMwnipGDvKsX50t3t+6v5
 mFxmysHS6s6I2Qt5Bej8admktNyFjT0AzYXKEzvWb20aX3rbV9WzaqZgQ4vL11FW6BitkzqB9
 FlGBC8/cKI83JyRd7RU2Zvcv+k4RSfadHhDabsNGu5vdCQgm/MRhf9FOWha53dGJWSMPKtZbg
 PKWVm4bn4VtBl2RxjijWKlFg==

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
=2D--
 mm/vma.c | 81 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 83260a3142b3..d331ba575019 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -684,6 +684,58 @@ static inline void abort_munmap_vmas(struct ma_state =
*mas_detach)
 	__mt_destroy(mas_detach->tree);
 }

+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the reso=
urces
+ * used for the munmap() and may downgrade the lock - if requested.  Ever=
ything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct =
*vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count =3D mas_detach->index + 1;
+	mm->map_count -=3D count;
+	mm->locked_vm -=3D locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev =3D vma_iter_prev_range(vmi);
+	next =3D vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -703,7 +755,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next =3D NULL;
+	struct vm_area_struct *next =3D NULL;
 	struct maple_tree mt_detach;
 	int count =3D 0;
 	int error =3D -ENOMEM;
@@ -807,31 +859,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		goto clear_tree_failed;

 	/* Point of no return */
-	mm->locked_vm -=3D locked_vm;
-	mm->map_count -=3D count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev =3D vma_iter_prev_range(vmi);
-	next =3D vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;

 clear_tree_failed:
=2D-
2.45.2


