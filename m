Return-Path: <linux-kernel+bounces-548957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC149A54B65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35434188CB77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFAD481CD;
	Thu,  6 Mar 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xi62K5+2"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE654BA4A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266157; cv=none; b=LpAHq3Y/vuwbcykja8JTU0rkBjVWvYNxiE3JUeXsjbnqj6e0BdN0x32lv2LUPiGE2HHJqVrhoeWYsu1JxoG1UzFrp3BEbRaGckUPpo0pBD4SuadQSNxt+4EKUZH1IRGGdHDAgKzqvRLrvQC5XxMZKp0eaN63QKDpXU4achTFF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266157; c=relaxed/simple;
	bh=kGatvV0Zqqqma0NSw5oHCMfRXZqT2vRuYLCascg4Aks=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lQyI4fE/M2RmBZktHMDvBLxbVvR9zdPso7FW5Lu+9Rwb3zASp0Uxyq4yh0DLhfOimpO+PH5GZY7J6gJTq+yl3xo/HQU46FNgyh7Mw/oFZ8Ib8xhv4+TUCHM2aaNTOCKIBGDigByLor74hB2hUBM9d8N6CRiUTw71+Kq6U9SvflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xi62K5+2; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741265849; bh=C0E4r+BZ2vSizCfxTCsdVdfrqmchyH9ssO+E9hWB+f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xi62K5+2xxXoBlEzTumViUIqeyetuXqLmlvF9kbsSjhPDj2t1ji8AYSIN2v6HM5xm
	 8SREwj6pBzAE750jGAUHBnLimmZYiNrNIQQbk3/j/kDmvwvtf3KCxEFf7N8tTaea3G
	 O6SjGjgDUnMqxdDb8Z+kPC2U4hrZ8nsUzblqz5dA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id E5A9F60A; Thu, 06 Mar 2025 20:57:26 +0800
X-QQ-mid: xmsmtpt1741265846tqm94ezyg
Message-ID: <tencent_3C336C9E411B294B141B23254FBAFFBB6208@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Noqgm2noJI54ew50PYrFAUrgcWNmJYXU+dD/R9FdQZP2+B/NQhq7
	 s9mIBKZ9IyjGD/2IUgjpMQPP+bYcMPFJNEe38BfMnhk0lnWAU+ovxdKq9LgsGU5j+GVJFk1o2Xsl
	 e3Nrw+776yXc4IWErB1V+w96mvzkA6iPLba+5u/BLopXNMHhBq8z/esteTdH7hM8/0CYiPdxNDoh
	 DkV0VTlfRiQGDt9ClL3BnsYgcrKVAzCOq0wwvIVMSKcmtZ5qrBEc9wpXECQj0QkAXp0ZHZ3aDzCv
	 D9yGHy2EyAFhjIHMpGMrXXk7/Zidgg7M3ChyLtaNsFRGeXHmDKRc2AWnjF7PF0WVo6fUANKFssxs
	 r66GGaM5parXKdlO3dE9jvYH7Qy2WL1wWN+W/p8foTSasU6jWRSIgrEXF2IcyIlFJI5CynMM3gJx
	 U9TWldGUFEi6dWwE4s/Gav34TcHQ/eozXgi+6vx3727hCizyVZC/2LqsrJNGJplF7MmIyzzRvyYG
	 NqbHPvjn/4qMe3z1E/ua/tfpujcsQnHI5QkafS5JGH1FgRxBBpuSXiwTvgDskC3Unav5IgeqZ4Cx
	 wGVqJncQVx1O31lv1TuGYjZYg/P61qkqHUZuzDckr6fdu8T5gqfQMyQoMhDFIZn2T9FDitdr++Nz
	 uY7uOkV8ZFTX1ZQzkGhksp8aXFmGK8BTI/WuaFyYZ63Bw/pIEPxDdmd8weGur23sLDMT9jvnYhHw
	 zvTy6RFwjS3JBQUcOhpWLpLDxAxKWstchqSolXWtq/POL5IMkApo2fby9S8Ty7p9LimDdrvfALaG
	 BUP8Cp005Bv4F1Ugx4XtGSz31MmOSG3hUB9aiGTRcY+5xlQp7GTt78vC0/RkuZvrRsta0lrgMBZV
	 Mt3JhKMrIkcyMz4ZN5SuWUshEC84Ap/yaZXYvHMl0eKbP7ned7p/VFi/ZnuLraUC8A6cf11xPe3V
	 1l5ADkA38l0TTsjPAVYkVSX3l+HLHis5GC4Y8RpzU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Thu,  6 Mar 2025 20:57:25 +0800
X-OQ-MSGID: <20250306125725.1601368-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c49230.050a0220.55417.04d5.GAE@google.com>
References: <67c49230.050a0220.55417.04d5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git e056da87c780

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..9f740d607919 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1194,6 +1194,7 @@ static int faultin_page(struct vm_area_struct *vma,
 	}
 
 	ret = handle_mm_fault(vma, address, fault_flags, NULL);
+	printk("1mm: %p, map held lock: %d, vma: %p, %s\n", vma->vm_mm, lockdep_is_held(&vma->vm_mm->mmap_lock), vma, __func__);
 
 	if (ret & VM_FAULT_COMPLETED) {
 		/*
@@ -1216,8 +1217,11 @@ static int faultin_page(struct vm_area_struct *vma,
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, flags);
 
-		if (err)
+		printk("mm: %p, map held lock: %d, vma: %p, err: %d, %s\n", vma->vm_mm, lockdep_is_held(&vma->vm_mm->mmap_lock), vma, err, __func__);
+		if (err) {
+			*locked = *locked ? err != -EFAULT : 0;
 			return err;
+		}
 		BUG();
 	}
 
@@ -1487,6 +1491,7 @@ static long __get_user_pages(struct mm_struct *mm,
 		cond_resched();
 
 		page = follow_page_mask(vma, start, gup_flags, &ctx);
+		printk("<after resched and follow page mask> mm: %p, map lock held: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), __func__);
 		if (!page || PTR_ERR(page) == -EMLINK) {
 			ret = faultin_page(vma, start, gup_flags,
 					   PTR_ERR(page) == -EMLINK, locked);
@@ -1500,6 +1505,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			case -EFAULT:
 			case -ENOMEM:
 			case -EHWPOISON:
+				printk("mm2: %p, map held lock: %d, vma: %p, ret: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), vma, ret, __func__);
 				goto out;
 			}
 			BUG();
@@ -2029,7 +2035,12 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
+		printk("1mm: %p, vma: %p, mmap lock held: %d, locked: %d, vma is acc: %d, %s\n",
+			mm, vma, lockdep_is_held(&mm->mmap_lock), locked, vma_is_accessible(vma), __func__);
 		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		printk("mm: %p, vma: %p, mmap lock held: %d, locked: %d, ret: %ld, mm addr is valid: %d, %s\n",
+			mm, vma, lockdep_is_held(&mm->mmap_lock), locked, ret, virt_addr_valid((void*)mm), __func__);
+
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..43e35a0c2841 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6206,10 +6206,14 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_enter_fault(vma);
 
+	printk("mm: %p, map held lock: %d, vma: %p, is vm hugetlb page: %d, %s\n",
+		vma->vm_mm, lockdep_is_held(&vma->vm_mm->mmap_lock), vma, is_vm_hugetlb_page(vma), __func__);
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
 		ret = __handle_mm_fault(vma, address, flags);
+	printk("2mm: %p, map held lock: %d, vma: %p, is vm hugetlb page: %d, %s\n",
+		vma->vm_mm, lockdep_is_held(&vma->vm_mm->mmap_lock), vma, is_vm_hugetlb_page(vma), __func__);
 
 	/*
 	 * Warning: It is no longer safe to dereference vma-> after this point,


