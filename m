Return-Path: <linux-kernel+bounces-182782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972598C8FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1127C1F23015
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034BCB661;
	Sat, 18 May 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkrV1U1K"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586F2CA9
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716013226; cv=none; b=ZHsmiRuLjePyoQ3sLjQxyP6y9EqCJG/nnlr9NFnNZlJ2ydgu8t9i2Q4FxjiyvarOdJ+/Z9WOsVVye4WPT/Z6HIePkuacNwkcJluxB/Y1bkloXLLQaXcB5UZM7Yqx+oJywSi0v6HCBSWw4y33R4cV5Cf8jgHG5Oyk0Mn+yIhQgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716013226; c=relaxed/simple;
	bh=c5aitRGk6FM8pDf3Yxg2qRteApNxDcUl17sZCEsoYUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8q0i5zTw92KEUu6oy+IGYD0gg3vxhMsSO+iy4yhz0vthbXzYwlXY+G0qkMMDQrLA7H4pJVS/w3mJvWurA91gYS0V+Xkry77ZPsnh5Es4ibDFaoc+VwGQQIJJAk8K0hzDGZb70rAFZbc3V/waN9QGEbVbiEH4/s8S6guekv04Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkrV1U1K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso7224675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716013217; x=1716618017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwaRs7iveAf1QbDUF+8bWlnvNsmKULYKCOVL/wSWrtA=;
        b=dkrV1U1K2a+7DWpdTX4mBXmjKrT1H2DbKBy4TFJCPkUwD5cyuNYv19U5+jf+Lw2Cgp
         aZceXYc70GQ2o1d/sVapD9DlnZEmNaVJrfSjFdWwnt6R5G/xNE0V8XFGEfdzULrfehK1
         kaCKeFDbcKoAdx97FjrqzrVxzZEG+ZKIheDzCjU/hFxr5FpUMvYx/yDxkIt91d+VZyDB
         tO7kX3w8h+U9wRMasG1GJ+HYKkW3Rt2NEL8dUaeczk+nX7JyYQ2zzNv3W98eW5TVPtXC
         A2+jpfntD7se5NrHIhfOen62Uj443pQ26aDc6TR5YakQlnHlICyZySIRiASYctFjGKR3
         Nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716013217; x=1716618017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwaRs7iveAf1QbDUF+8bWlnvNsmKULYKCOVL/wSWrtA=;
        b=aBUFDgaZ/gdRh8tpmf+tegvBhXACw/o/K0YxfmKcCPUnXJuOxzaik6Hyi2fn3wcBxR
         +YGotPdvswdoRZl5HkWfV7v++siaZ6tatMyr2SbaQJq9KsoloIdrCJv3ayTSVOZbo9CJ
         iMqNnhhHztEh1np8C0j7tDzf5n+Wh9ssDniHzAseEtwxcH1f+7qjCw42vjjt/Vk01vzn
         yEHyownljNQYNS93hmxMBs335MlsoTOc9WW5TAAAVyBvC5whMa3gzCFjivrph6qdUizQ
         dQKlWueBwcSXClSEWt27m6DyDY2rGZ8lvK+unEgm5X9EZWyswb7PfHglnQ26a14KkiJY
         CVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/hf8IvoKn7B+M9nWM0zK1de8AFnnpniBUrcpRUvkKWbsCqiG/4vCZh7R561cw/MQpUSmkbrX+aEOW9iipL9lanabLqye6O29vWKiF
X-Gm-Message-State: AOJu0Yx9hd+vX3SKGT5t75ZVl2gTeHWEfjvbvN2ihu461P+78v7ZrcjM
	fZdTtbFP6o/jJoYkBNPq8rkKZ3CN5sP57w/hoxS0axi+TGeJBU8D
X-Google-Smtp-Source: AGHT+IGmSHzs7IwvzbAbCrroZTGxRdcS97V48M9qbrTe2xuZ6s70b310WbPNimYYXrTnuD7Ta95MEg==
X-Received: by 2002:a05:600c:46d0:b0:420:2df0:1a9b with SMTP id 5b1f17b1804b1-4202df01ae0mr45887775e9.18.1716013217037;
        Fri, 17 May 2024 23:20:17 -0700 (PDT)
Received: from f.. (cst-prg-73-12.cust.vodafone.cz. [46.135.73.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7748sm23446687f8f.49.2024.05.17.23.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 23:20:16 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: batch unlink_file_vma calls in free_pgd_range
Date: Sat, 18 May 2024 08:20:05 +0200
Message-ID: <20240518062005.76129-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Execs of dynamically linked binaries at 20-ish cores are bottlenecked on
the i_mmap_rwsem semaphore, while the biggest singular contributor is
free_pgd_range inducing the lock acquire back-to-back for all
consecutive mappings of a given file.

Tracing the count of said acquires while building the kernel shows:
[1, 2)     799579 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2, 3)          0 |                                                    |
[3, 4)       3009 |                                                    |
[4, 5)       3009 |                                                    |
[5, 6)     326442 |@@@@@@@@@@@@@@@@@@@@@                               |

So in particular there were 326442 opportunities to coalesce 5 acquires
into 1.

Doing so increases execs per second by 4% (~50k to ~52k) when running
the benchmark linked below.

The lock remains the main bottleneck, I have not looked at other spots
yet.

Bench can be found here:
http://apollo.backplane.com/DFlyMisc/doexec.c

$ cc -O2 -o shared-doexec doexec.c
$ ./shared-doexec $(nproc)

Note this particular test makes sure binaries are separate, but the
loader is shared.

Stats collected on the patched kernel (+ "noinline") with:
bpftrace -e 'kprobe:unlink_file_vma_batch_process
{ @ = lhist(((struct unlink_vma_file_batch *)arg0)->count, 0, 8, 1); }'

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/mm.h |  8 ++++++++
 mm/memory.c        | 10 ++++++++--
 mm/mmap.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6bdaa18b9e9..443d0c55df80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3272,6 +3272,11 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 /* mmap.c */
+struct unlink_vma_file_batch {
+	int count;
+	struct vm_area_struct *vmas[8];
+};
+
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
@@ -3281,6 +3286,9 @@ extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
+void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
+void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
+void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
diff --git a/mm/memory.c b/mm/memory.c
index 0201f50d8307..048fde0e5a8a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -363,6 +363,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
+	struct unlink_vma_file_batch vb;
+
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
@@ -382,12 +384,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		if (mm_wr_locked)
 			vma_start_write(vma);
 		unlink_anon_vmas(vma);
-		unlink_file_vma(vma);
 
 		if (is_vm_hugetlb_page(vma)) {
+			unlink_file_vma(vma);
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
 		} else {
+			unlink_file_vma_batch_init(&vb);
+			unlink_file_vma_batch_add(&vb, vma);
+
 			/*
 			 * Optimization: gather nearby vmas into one call down
 			 */
@@ -400,8 +405,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
-				unlink_file_vma(vma);
+				unlink_file_vma_batch_add(&vb, vma);
 			}
+			unlink_file_vma_batch_final(&vb);
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
 		}
diff --git a/mm/mmap.c b/mm/mmap.c
index 3490af70f259..e928401df913 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -131,6 +131,47 @@ void unlink_file_vma(struct vm_area_struct *vma)
 	}
 }
 
+void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
+{
+	vb->count = 0;
+}
+
+static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
+{
+	struct address_space *mapping;
+	int i;
+
+	mapping = vb->vmas[0]->vm_file->f_mapping;
+	i_mmap_lock_write(mapping);
+	for (i = 0; i < vb->count; i++) {
+		VM_WARN_ON_ONCE(vb->vmas[i]->vm_file->f_mapping != mapping);
+		__remove_shared_vm_struct(vb->vmas[i], mapping);
+	}
+	i_mmap_unlock_write(mapping);
+
+	unlink_file_vma_batch_init(vb);
+}
+
+void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
+			       struct vm_area_struct *vma)
+{
+	if (vma->vm_file == NULL)
+		return;
+
+	if ((vb->count > 0 && vb->vmas[0]->vm_file != vma->vm_file) ||
+	    vb->count == ARRAY_SIZE(vb->vmas))
+		unlink_file_vma_batch_process(vb);
+
+	vb->vmas[vb->count] = vma;
+	vb->count++;
+}
+
+void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
+{
+	if (vb->count > 0)
+		unlink_file_vma_batch_process(vb);
+}
+
 /*
  * Close a vm structure and free it.
  */
-- 
2.39.2


