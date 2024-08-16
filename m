Return-Path: <linux-kernel+bounces-289585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9439547D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06531F2259F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18C155743;
	Fri, 16 Aug 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="TuCpX/N8"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F61BC08F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806912; cv=none; b=SDN0zMDErmxXXQrasNpKXgqI7moP/gdURriV8CqNnVHTBfFX2HHFfuxd4lRJg8yCSD2TkEWzVbnATnteD5p+xrOwdjBwxjLxMm2SKOewNessfU8PFbToQo47fNOwpldTvZfH06nx/HFQcxeHq/O4K1V5QYZ7kw951+truxLBlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806912; c=relaxed/simple;
	bh=ccelC0NmIjmxog5hV6t9kfxS/KddyZ6gIw9WLm6Qh1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXfnd4ARmHRytClXYO8Fj1ECku7U+OHMslKw05TjFyGYpYyKB2a3ozSUuECDTDbiQ0P4HKDrV69sK0aTdP1//xwv1SKRGfoH0wb9AVvJBoHZB57AQ68N5fl7VGoKhGwy0WjgJ11UHh3tawCZZtcw2VtEntRrQk1SJMhaljMFsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=TuCpX/N8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806872; x=1724411672; i=spasswolf@web.de;
	bh=KqLpCASAg0v6fyS+T7RSQ7Led3ug2Wk1EwA5uf3qlqs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TuCpX/N8xsW0eKxPxeG6dJ6Y77L1OkDJFkJcUm8KItesKAZyR52AGlQEUMq5q6ys
	 WXn7S2kGA6f8cFjk55BAjLFmHLJL1fBjRb6FMBUFDKPCOWqoGWP9ydRgzmx6dE1wG
	 XiPtV/FFY7ha0urhLfQB3DoWxo3X9xvkb+jKLaCEaAq6iRHSRM9OuH3AIs6DdCsvX
	 caCa6KOjN9N/VQhKMQ9ob7Qbnyx6LaiTb9bJJAtYvObM+9Z2d8hA4Rn8j63ZvFNOF
	 W1lVB6TV5pTxL4rdwuBpzrMH6ccQzjwx982zxV+mkHPsSPtNEuRJo0Vl6DdquKywV
	 0U02jpPCuD23d3SXXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N4NDQ-1sD2R73bQU-00xraG; Fri, 16 Aug 2024 13:14:31 +0200
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
Subject: [PATCH v5.1 11/19] mm/mmap: Reposition vma iterator in mmap_region()
Date: Fri, 16 Aug 2024 13:13:52 +0200
Message-ID: <20240816111405.11793-12-spasswolf@web.de>
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
X-Provags-ID: V03:K1:zz36G1dDzlpCZzGc4BqVfsIpgRKxbbe/K3KeQh0rlbU0Mr8YLuw
 KRmPeUju2SCl0xjMdC8oTSGzJLI4AyuQGa8nWVnr0TzHc7rQilOpyIbb7eeWbZiCfZPOlzY
 C0TXbu6GIHsqcTL3ZWoDPfsZLK1d9HLVwKlEFTn+qBGbvfFUdDGUTLHUVM11TQ5bvnqPaML
 my6q7cvd82jmcerhF5BMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fpY6WEjyq+g=;SpgQJJgrtJwY8xZvCyMbgRARI35
 CTPYiWacnMKnrSBypojaCzesJMxZ5Ny/w9Uq7bsQzXK2+GGz7/Z/STr/4N7M5EkxqvAaXuHvC
 6agNfpdeNsNhiXJpVzbPutK/q93Ux9MjisCqkK3PyHXsmwJjr0VCmNs4DNjgdFuUilCvUAo0N
 fWuv17vMezhbrdcgADjCTmKNRuHHvGfhQxLNuBRqVuNi1c8fVSaDJSqVx6quaKlTq4tluaYUZ
 23ynXSe3nW3GRGJfzhuc+8ae3ZfWdwlcKur5UQvL/NE+JeM34yMzfZOfAnvZt1RPtntqYsg2K
 k/QfUBKhxDG6kQP6U2fQ/k+Hz0KPUeXWzdpPYgjRbi033wRnxYyzYz2t0uxNRi8VWqjXjxmqo
 szMG7evtVEl4nYUJXK4UuTtYOcGhzfG6ovNnOEMm1vQ8DYmBaAaCFeIRIBhjdn58JzJjLfa6p
 IHUnR6P5VsYd2H+4gNni/v/vTwSizkH87kmeSD49YJuztSJd9GxE2SmTU0c++471qgHJ1PoLJ
 uJQqOncT8+h6OEOxEJvLCCeBZWeYmy5crS9coPsUQIOC0EGw6xIm9ENVl2fkBwDWbCW5dc4Gd
 R9lKHW2Y3wf2UtiYsiOAMFYYy9spXOayuJock2n+3XIinz16oS/C5NuIzx5418VXHapthlkeD
 7foCQptAJPpEZ5ojiRjQJB4mmGN5Uh4NPNqbY/+of6WlJbSAAp7ymvETcXn4xSZyJ2GTH7ygh
 meQzNGeDH6a7u5DCZEOs3vLenyd9P3RbGeEkM8shaXtTrMSjajyFshiiQndHLeRUSaXP+pe3M
 qIGfesomTvLtCuhzCwX+9dtw==

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 16fd14b243f9..6720b55b47ed 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1404,21 +1404,22 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+			goto gather_failed;

 		/* Remove any existing mappings from the vma tree */
 		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+			goto clear_tree_failed;

 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next =3D vms.next;
 		prev =3D vms.prev;
-		vma_prev(&vmi);
 		vma =3D NULL;
 	} else {
 		next =3D vma_next(&vmi);
 		prev =3D vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}

 	/*
@@ -1431,11 +1432,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}

-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}

 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -1456,19 +1454,21 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 		merge_start =3D prev->vm_start;
 		vma =3D prev;
 		vm_pgoff =3D prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}

-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma =3D=3D prev))
+			vma_iter_set(&vmi, addr);
 	}

-	if (vma =3D=3D prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:

 	/*
@@ -1629,6 +1629,12 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_unacct_memory(charged);
 	validate_mm(mm);
 	return error;
+
+clear_tree_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
+	validate_mm(mm);
+	return -ENOMEM;
 }

 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
=2D-
2.45.2


