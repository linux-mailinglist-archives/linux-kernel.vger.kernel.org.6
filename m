Return-Path: <linux-kernel+bounces-321410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582C971A23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8911F23765
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62391B81B6;
	Mon,  9 Sep 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nqqDcqUc"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9C1B2529
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886622; cv=none; b=JP9Qp6Rxe/NBlad//tBRK+qE/UoDBvJ3jmIbVaDZJ8bCkaQM3lMIX8xkC5GQjxMkpiyNyxUwxNUB902NWegtFUBv/tJlc/PRMRRdiestpqfPBrF6eS1sENuBra6nHX0DkCKYG3S8eRYOkxb1muICMDSgrIjzd4J8e1yxr1Fvj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886622; c=relaxed/simple;
	bh=1uXxAD+XEEYPhdTmZstA0HW7wY7h8tyGGxT9tjDx9LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2s0jrMNaBRe8RM2GOg9hW6JVI6Atub7By99JdgCTdmGKj4beO3Uy/RRy4GlkyTXRhdmE4T4iKRIBQpruypTk6MnevITm+R7L+MmMLbtpbUQpoPHVEB2mZALk53WyhSphOnwqBgFKv+WrkPVAIu8GqNbrj1hubt4nPy6DGGQTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nqqDcqUc; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=WwFKI
	+bxvE/sH0jt32LyN7fO/Tl860tFmSw7h6gPV2U=; b=nqqDcqUclCM9m94XLC8a6
	fBVJ4W6RknZd6ElHvyedVV8+Ns4nOVZbcwMZiQa/rraX4q1VMbnpqXE32JBkgXyV
	4vNzYTPI/Zeqos6Xa5B12b2GpePETHvtT3zgSC7DocOjEk9xM0tmOOwO7J4hAqmH
	i3Vz/KKrZlz5yCbq/KQwTE=
Received: from fedora40-vm.. (unknown [160.86.227.247])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnT2B38N5mBtdlGQ--.6710S2;
	Mon, 09 Sep 2024 20:56:26 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ltp@lists.linux.it,
	oliver.sang@intel.com,
	Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH v2] mm/vma: Return the exact errno in vms_gather_munmap_vmas()
Date: Mon,  9 Sep 2024 21:56:21 +0900
Message-ID: <20240909125621.1994-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT2B38N5mBtdlGQ--.6710S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWkXryfJrW8Zw1DJw45GFg_yoW5ZF4xpF
	93W3s8WFWxXr4xW3Wagayjvw1Yva4rGa1jyrWUGF1Sv3ZIqwsIqryrJFyFvr9rKrZ7Ar9a
	qr4UG3WfW3W5taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pZg46tUUUUU=
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMx5VXmXAnvb-xQAAsR

__split_vma() and mas_store_gfp() returns several types of errno on
failure so don't ignore them in vms_gather_munmap_vmas(). For example,
__split_vma() returns -EINVAL when an unaligned huge page is unmapped.
This issue is reproduced by ltp memfd_create03 test.

Don't initialise the error variable and assign it when a failure
actually occurs.

Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
---
 mm/vma.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8d1686fc8d5a..dc5355d99a18 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1171,13 +1171,13 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
  *
- * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
+ * Return: 0 on success, error otherwise
  */
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int error = -ENOMEM;
+	int error;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -1191,8 +1191,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
+		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
+			error = -ENOMEM;
 			goto map_count_exceeded;
+		}
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
 		if (!can_modify_vma(vms->vma)) {
@@ -1200,7 +1202,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}
 
-		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
+		if (error)
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
@@ -1220,12 +1223,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
-			if (__split_vma(vms->vmi, next, vms->end, 0))
+			error = __split_vma(vms->vmi, next, vms->end, 0);
+			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
-		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
+		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
@@ -1255,8 +1260,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
-						   vms->uf))
+			error = userfaultfd_unmap_prep(next, vms->start, vms->end, vms->uf);
+			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-- 
2.46.0


