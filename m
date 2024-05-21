Return-Path: <linux-kernel+bounces-185531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D418CB65C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7811C1F21F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1614A09F;
	Tue, 21 May 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emT1Z9f0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF1149C68
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335026; cv=none; b=V26EXqri0PG68ZTLPH2CNgTbrnBBHQ5BMSVDQrviwWms/8M04aVDOKrFhJRysOcttorXu+kni9+IdBWNpSQHK7A1iZKNHLz4xrCWS7KTxWyrRmnC/2sOJaoaXOxogs5xIO4O1sEipEpQHs48WU4A4JzOMBCIoW+bXz+t3E0qPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335026; c=relaxed/simple;
	bh=Wp7s/NQn4Jl2DGKFYBWteCoaVEcAkgaL2FO7wK0XSlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcS8J6iGw00wjS5GEZo67WvMmRMulXBVnxyWtMwZJEhA38oRYItAHvMGu7THzPUgOcfqIFl0wRT77aoZcwdn/9+y6THnTCZORk+jl81IQl6VD3Bb9ZfPmBkBj9n6AOe84vEJ6f7yU76o0Fysq52PA0KTpgw5zbRZQ/U7zyk5O20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emT1Z9f0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a599a298990so973733066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716335021; x=1716939821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgL+VLTGJeIvjxtlE+hv8XMUHqxwxG+fmhYvBcoUtEM=;
        b=emT1Z9f07fR2cnZcUGvie9GDoKfNbu9yT7bwLeK6szmhetERDA1VIw40KEl6SrcWoO
         znb7z+V0hMGZatmh5DsUlXHVPRhw3ww/o9ovq4zpvppDluRq3nQAo4eNdVNqkA0CuHld
         n/roI9ZzLu/cv6rMqP2wz65jbjICJbP2cpJndqU/UH0PLXMW/1gXSU6zOMw0ujP+J2pH
         RHxtgDG483fYUHBKZ3zbCpOJgnWQjqfu3yw14MAPUpr8YDuVWDCJyVK6XAeMj08Jw7Xf
         f/ckuJ3i1ut/dqd7QIlBxPxy69dH8j23F0dB+sRVwnpxyrSGAxNayaUOuH3yg0OVFcu8
         U4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716335021; x=1716939821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgL+VLTGJeIvjxtlE+hv8XMUHqxwxG+fmhYvBcoUtEM=;
        b=usUJeF98qz2sgIJB98Z+H9tsjwuVJmAqNxlVe1vD7UQHZq0A7zeckG0pdJbCDuc/Cc
         FZlmZAZPUyrSwaiRHiMTj38Fw5dIW7mkuQGTTMBYFL1NDoW2lLESxRl4SnQ0STQxJb1y
         VmkUAioSmMZKkOViwyxeqFSinR60E4HnRycVHQgepcHtYZbGS6us8u6PJ0Z24BZYe2t5
         tQQTHce1EScOnpoVcrjgK+4xocgfmCjGsnjHKKrkAOMXn6qkydKyUMWQbWL0QAq2T3vO
         AMtfUAZk+dI6Tx4Uh9zB97dDxQoNfs8J8cK13fZe6h+7vu2w4yKnPTJvA4Pte6JstpqJ
         BwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVBtuBs2SHlA3DMJf+apJlVaqj4gp7Ve8bAVBhnGQEWSDUTPVgOHGYp0c8e7Ely59cP5aMmjHp2sZGYIBua+q3eCyfnX6IzP0vKwY8s
X-Gm-Message-State: AOJu0Yy93S7BUoanY3x7i6ktj+f6fUgRvXJI4tQKkn87TSh3pJMcy04g
	VVNh41fV/PsvIn4utrDFLGjT6M4fsArIQHUqwPh0mG8EKgD7nd1x
X-Google-Smtp-Source: AGHT+IEVJnoLtHuQS7gLKz4u2w8GO3mhbvPVqtIMHrs0GYh9VlCUKTba6ViUl4mlJ8G4NOISGC4spA==
X-Received: by 2002:a17:906:710c:b0:a59:a3ef:21eb with SMTP id a640c23a62f3a-a62281906f6mr16024166b.73.1716335021352;
        Tue, 21 May 2024 16:43:41 -0700 (PDT)
Received: from f.. (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd7asm1702554466b.10.2024.05.21.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:43:40 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] mm: batch unlink_file_vma calls in free_pgd_range
Date: Wed, 22 May 2024 01:43:21 +0200
Message-ID: <20240521234321.359501-1-mjguzik@gmail.com>
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

v2:
- move new stuff to mm/internal.h

 mm/internal.h |  9 +++++++++
 mm/memory.c   | 10 ++++++++--
 mm/mmap.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2adabe369403..2e7be1c773f2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1484,4 +1484,13 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+struct unlink_vma_file_batch {
+	int count;
+	struct vm_area_struct *vmas[8];
+};
+
+void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
+void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
+void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..1b96dce19796 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -365,6 +365,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
+	struct unlink_vma_file_batch vb;
+
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
@@ -384,12 +386,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
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
@@ -402,8 +407,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
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
index d6d8ab119b72..1f9a43ecd053 100644
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


