Return-Path: <linux-kernel+bounces-320615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B9970CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB331F22591
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15F1ACDEB;
	Mon,  9 Sep 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U/jGcGoO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4519461
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725858190; cv=none; b=pachhvCAJC/50v6pPcizgzKZoSs/aq/7stymVWUw8Irs50G/BvW4z8uNN6GHZejVGqrDXpwhb6zgm+Sx80QVVmWdAwnhNC/MPPTDftf28MUHm29n+XxcyfwZCfjwkc+O4u5BMx564AAlz5Kcce1u5gtJzMMvU9klEE8Pmrf03cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725858190; c=relaxed/simple;
	bh=X8VeZeARKf1dKca6XgKSeleJlx0jaAmgoW4BxJkIA3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAjs1tQ9+d04j6qW/b/dIiOoMk7X+wBrIZO2eK4/8P7XDbQ9TnOlPMEw6PAAapGeO6xAdlSop2xtYjWrR2pK+O8m/1VrKpAfoMV1lFtH4jDJYCDf+Ha3NnUwBR4huRt1JxfeX8Ys+k199T+WpVLWJB4mAE5EME9RNWxNwPxEVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U/jGcGoO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=JBh9g
	Ffx3heYPcoalbCGHCAhXyXUQUzmDtHwdRpGsi4=; b=U/jGcGoOG7tos2kQllbc6
	h9/6GvWlPOf7GtDU345cjLcRzZ9eqVVLukbcetnKBx+omyLifVQzjYzi/fkS+ske
	0psRZ2uUnx1M5bUR5eqCj+maDb+w8xbu3inI80PWTr3o4Q8/JIQls0pRpzHnugnB
	pjiyuru8b1Vx1R7+YmzCgw=
Received: from fedora40-vm.. (unknown [106.133.130.25])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wCXzkZkgd5mru5JGQ--.57674S2;
	Mon, 09 Sep 2024 13:02:30 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ltp@lists.linux.it,
	oliver.sang@intel.com,
	Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] mm/vma: Return the exact errno for __split_vma() and mas_store_gfp()
Date: Mon,  9 Sep 2024 14:02:26 +0900
Message-ID: <20240909050226.2053-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXzkZkgd5mru5JGQ--.57674S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy8Xw4fXr1fGr1kWrykKrg_yoW8WFy5pr
	93Ww1DXFZ5Xr1Sg3WYqF1jvw1Yqas5X3WrCrWUWFn3Z3Z0qws8trW5tryrZr92grZ7uF9I
	vr4DJF1fW3Z8KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinqXkUUUUU=
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwpVXmXAnu2fxwAAs8

__split_vma() and mas_store_gfp() returns several types of errno on
failure so don't ignore them in vms_gather_munmap_vmas(). For example,
__split_vma() returns -EINVAL when an unaligned huge page is unmapped.
This issue is reproduced by ltp memfd_create03 test.

Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
---
 mm/vma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8d1686fc8d5a..3feeea9a8c3d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1200,7 +1200,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}
 
-		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
+		if (error)
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
@@ -1220,12 +1221,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
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
-- 
2.46.0


