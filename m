Return-Path: <linux-kernel+bounces-310261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346F967726
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49801C20C21
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808C17E91A;
	Sun,  1 Sep 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SNUYNWPo"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D962A1B8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725202280; cv=none; b=o5COOR9Flhp7BioJGtnHbF0dWlUTowsX7yhRE78fnFZBR9xWRYI1t0Ohr+SbmSOLOB8Th5nG16U+Ut2l0DBzpPdoVtrywKIjGkuMczHrXvk3FHSdCivdMOsbyDzYWrdA1a8skHDXDZWD1Wm0/2Ix7wwBeMuxDUPyegUPj8oCH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725202280; c=relaxed/simple;
	bh=ClAEUVbqVKJD72S7dtnY7ZtcEoAx+Oqzxt9ZovDMhmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l41Cqj6xwewDXVs/dVFHfsHYQEfHmkTDp1vTktnmazsFzseoyCrcgJ6YZpf4LRCJzyvrVwxI3kUob4JcbBEwAuCcNCfelZ9wY/VuZ0/y9Vifhi/aFYFeJO5rzALBPmTqchL0KXnyuuL0o4Ru8udV0Ts0vXPrlc5OnwdAXdeTGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SNUYNWPo; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=P0iqe
	6vXWSjMmRXDrMjZrivCVdtRvOplSj137lptWKg=; b=SNUYNWPoBCluXsWkItYvY
	qyMDY62i5MFeU5ycVwREEshcJ/mIcASlz/zJlkojT6P3iqNpTOVkr6b40Ht40fpP
	ALSOteL47xEQ270K1hBPa5a0s6Ri6aLs39tEOV2OZzN6RbsqPoNd/lZAW4ANSlVf
	A6p7aldKFeYk7ORrKkJyO0=
Received: from fedora40-vm.. (unknown [160.86.227.247])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3_0Q0f9Rm6pl+BA--.39198S2;
	Sun, 01 Sep 2024 22:50:31 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ltp@lists.linux.it,
	andrea.cervesato@suse.com,
	oliver.sang@intel.com,
	Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] mm/vma: Return the exact errno for vms_gather_munmap_vmas()
Date: Sun,  1 Sep 2024 23:50:25 +0900
Message-ID: <20240901145025.2311-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_0Q0f9Rm6pl+BA--.39198S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4DtF4fArWUKF47Zw4rGrg_yoWkXwb_Wr
	W093WkWFsYkFnIyw17Zr9xtrn2grWqvrZ7GFnYkF1aq3ZrC3WrXrWvv3sxArn0qr4qvr9x
	GwnIkrZayw1j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRknYn5UUUUU==
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqRxNXmVOClPWIAAAsi

can_modify_vma() in vms_gather_munmap_vmas() returns -EPERM if vma is
sealed so don't always return the fixed -ENOMEM on failure.

Fixes: c2eb22189bbc ("mm/vma: inline munmap operation in mmap_region()")
Fixes: 5887a7ac2383 ("mm/vma: expand mmap_region() munmap call")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408312155.fd26a58c-oliver.sang@intel.com
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c1781f643046..c9a0dc035819 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1386,8 +1386,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error)
+			return error;
 
 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
-- 
2.44.0


