Return-Path: <linux-kernel+bounces-289587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F819547D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D081F223AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E44A3E;
	Fri, 16 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="gtijZp/r"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9E1BC9E7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806913; cv=none; b=scjOINxD9OLO0NArXgyBqdYAs1vQcaY9/4Y+gnoTP9vycpfv8EmTrh2C0GjFQPtSUvwcyRQjzUYCmKhW5FQKzSJeLdzYcuiC4TZ1eofNVLGnVzuXhh3BqIJzdDGFxzpmclgfWi4V9gcMLd0bMNfnnnDutbW8L4G7nc/zoUE2kAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806913; c=relaxed/simple;
	bh=GyAP1PkD1aEAZYpORcWiFwQcCtS5O6Ypot2AZuMI0w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md6z9ERRgNpK6DDwFIPvDol/VVcTXKBRrDOJGe6Jc3d4JSUUl7Gj5+DANAyJho2fJ2sbUaF5BVceGyrt8KsfgTNNCanAwl0zT1e/YtELKgebIc5tDyWWtLvU4bd40FoI3OEm53njAWGH0zfjBThmxgw9Zlj1W9e06BdI+ecAiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=gtijZp/r; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806873; x=1724411673; i=spasswolf@web.de;
	bh=75LYP4e/f3KZVW22gX/HhYvcu5dNO1K9ehpMZYRgA08=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gtijZp/rFtCnJ1o1PQUYebo2XlRds1eLxKf6Mx95uKNKUaLb6pOcQ6pYdti5x1WT
	 DPnvHsrW2M6hKNk74IXRx2nEtwO8G5afY+pGqGrG2ueM/aspIFWDkhqk7s5YqTIWv
	 MK906rspw0smKTxQG1/JtdlQhannPTRkpDzrDTTAXJPM4y84ChmQTFMt32Oqd51Q9
	 EdS9ihY4JknA/T1OhWa/THYCAKnKTwlArXrL517/DWJUM8F1flwyX/qp1CY/uo1Bm
	 CyYuhuCfQoTn0aSGTmtIhOnHSIRgulY1nKtuKb7fNfmGi0+gQymX+R1oDrB4cQ/VS
	 43P2L6E/OIvpvEOPMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M9qd5-1sZ7cL3LBl-00BcKV; Fri, 16 Aug 2024 13:14:32 +0200
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
Subject: [PATCH v5.1 12/19] mm/mmap: Track start and end of munmap in vma_munmap_struct
Date: Fri, 16 Aug 2024 13:13:53 +0200
Message-ID: <20240816111405.11793-13-spasswolf@web.de>
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
X-Provags-ID: V03:K1:cbjrIoJH4StOfzxVC0jYOdFmhLzIj9iUOdmwhMv8XfbyJCJ1jZR
 m8w1W7pGwWq9jr8ErUhTvmF3eHtQgkmvMmMxE9tOnaY6uMCYoZ+eVq9e0myVBBYELu+09Fz
 dL4xEbKcgcX5oQNJgB7liSOz8RjThl8DdHr4wexsPI9oAm/+phdztagTKvXgFZKFBh6SV2c
 AlMz2WsyCWWssRMqUeiRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yNz7ixttSuw=;bJKS49+ZB3xXUwJ7tz9w0l1BtYu
 +3ktfsJIJg+2QZxau3/Tj0cgCwGX01o6/lpObmmDpPmUdczRHn3x4NwJtHh6NYDxX8zoo0zon
 ORvGiMg8KAy+qcTibVrXeRBamhdpN9D1BlaabB76p60Ks7K7CJ8huAwbeBR2QdwGmWYTc67iO
 6BQ73NGcU4njcfbzzRup1ura5038Hmu6Bx9LPq9CYQy62EGoB1+TLQt+6LIBDNCS0J3nGsUhk
 M90+h+haevDMPtECgdC/Ee0kvnK6DyE2M9zenQOimKFsNiJDtiKdp35sIs7js0hshWH2/W5rX
 vcii3dSbmV/CEn97/EEu1hoNsRPEvyQeoQoA6EGMduW8NcsDPR1m5mA34x3YtL3KNJnnCp80g
 /vVxPOXxBNSBnNkXp/+EHBN3uDiuVlD9VDao7PdNeLMN0JzJWaMnwweM7NaAtiitLHdWtjICl
 cDpYwPs8gM2oSvkAIaJPXi70DvNXpaGuRDDduGav2TczmxYBoVMSiqXFXqw+mUtUC9exElHKq
 IB0wiJ5/P5kIFmyvduEDSJuw7YTy3UZVP9KXP20C9CDsR5huxG85xckAUGBQWi6bz02aq9fXu
 o/1XpkPgXSD80EZdHEWvnx1PpCIsSH4RxICE3vN85cOiJrijaswWhMTYvdAj0GwJAUXs9IqCe
 q0emqiYWkUZb1H3IMVZxw5qGeX0cSvHP9zNb5hnS7/JeMWvbwPQldlzucTbCFAfWGg2F1jGA3
 nqPD3Mp4bV/PplVGv8h1sdjD6agUVzrZywmNowMQV79+Iit2QnxDKts0HddVAgZf6LDaw1MCf
 KCyNyerw5fYEulUEIDR9YSaQ==

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/vma.c | 38 ++++++++++++++++++++++++++++++--------
 mm/vma.h |  5 +++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a5ca42b7161b..e106d412c4c3 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -373,6 +373,8 @@ init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count =3D 0;
 	vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
 	vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
+	vms->unmap_start =3D FIRST_USER_ADDRESS;
+	vms->unmap_end =3D USER_PGTABLES_CEILING;
 }

 /*
@@ -684,7 +686,7 @@ void vma_complete(struct vma_prepare *vp,
  *
  * Reattach any detached vmas and free up the maple tree used to track th=
e vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+void abort_munmap_vmas(struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;

@@ -695,6 +697,28 @@ static inline void abort_munmap_vmas(struct ma_state =
*mas_detach)
 	__mt_destroy(mas_detach->tree);
 }

+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -717,13 +741,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struc=
t *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);

-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -785,6 +803,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *v=
ms,
 			goto start_split_failed;
 	}
 	vms->prev =3D vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start =3D vms->prev->vm_end;

 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -846,6 +866,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *v=
ms,
 	}

 	vms->next =3D vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end =3D vms->next->vm_start;

 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index 8b2401f93c74..b857e7dc4bfe 100644
=2D-- a/mm/vma.h
+++ b/mm/vma.h
@@ -33,6 +33,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
+	unsigned long unmap_start;	/* Unmap PTE start */
+	unsigned long unmap_end;	/* Unmap PTE end */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
@@ -54,6 +56,9 @@ void validate_mm(struct mm_struct *mm);
 #define validate_mm(mm) do { } while (0)
 #endif

+/* Required for mmap_region() */
+void abort_munmap_vmas(struct ma_state *mas_detach);
+
 /* Required for expand_downwards(). */
 void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);

=2D-
2.45.2


