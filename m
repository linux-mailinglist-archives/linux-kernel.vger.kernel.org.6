Return-Path: <linux-kernel+bounces-547011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF668A501C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768FA3B0B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCF24BC0B;
	Wed,  5 Mar 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L4LvnuYy"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4B245009
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184429; cv=none; b=Rz7n4y+QhEqq6wLgDylcm9tr2OcfYFiQkBIBLL2TFOX3O1pj87aS4s4xsPsI00eN8CAUWBmN544fXGc15BZ5dIRfOCuCK4sW7ASIYIR5sLRQImzEx5r0SenhBPfJY0gHxGQuPMYlX0rktGWQYaPu3daar2qj44fq4nNS7wQZOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184429; c=relaxed/simple;
	bh=+C6+kiSpVE5KfXsZ+T78U7flNYEuG4uRKZzZ3SXkawY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EpUxq4WU9FPjXe+rWWN/HhLA5fR9Fe1RwmjUcm09ROQWUqhnJW+Rxe3Ge3YQGmkrE9yGQ7cCMOMO0ad7o+8qYl6/dGSjaBT/V5mGh+g9Lx5wQBieABun/xw2KaGBf+pS7gIS8FV3UDzhejle25880K/X8e4v4K9X7pwO40ZlJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L4LvnuYy; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741184116; bh=acioOzHhQ2ctbG30Uphm9oLX1bxxFczzdidUNA2813k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4LvnuYyzfu3l+hiNg5mVqw5Y23Q+dHvpGe8uSrcOlYG4yJhKlhhpyRMux5HE2P7i
	 Fv5IWUEFzJoSO47Asr3KmMTXp9FcN0xH/m8c4E3D8557QQyIn0nWu3kYH90XsZgzQc
	 KJQFcIH1a1+VQ49bVTi7R9TfIlNQJqWqwWVE9nv8=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3CEB345F; Wed, 05 Mar 2025 22:15:14 +0800
X-QQ-mid: xmsmtpt1741184114t8ehv03j0
Message-ID: <tencent_10C152FCC67009A26ED12ED48CB0E7C28606@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Jup2Xm74q428qmahtaGlLadXgv5ntn9kJGPloZGZ+z8q83vHazmW
	 tyqF0S63gsDSyHT7VwVsAwowVOmtQSrwMlsvnFjDGeirmEb4X69du1pvzuSIORu9E5Szz9A7ZLL7
	 oeMTHgubWSoMPv+Ua/NgMrGlXv4lsnyPDkzNWExv5mTiy6V/Gl6CrB/7j5iKoBxHU9vzSjnS7d38
	 +QQ0FAuuM+8KcYQTvovwjj4gyt4FFGBR2NKwoWtHWkTL3Sqp6d/hahQjVUK+FP8tl4NtxPDM3724
	 C2pN63uSqWUSyVK52YdXr1Ub8nZ8X4lH2LOtnK/DE7JzF/ezUVExElGttqhZOllgYI5oGsuus3hH
	 eLkpiNc9uRAY4i74tC96eLzDSjdN1DnPmGd21/QG9Y6u2ze924N/P4B1trGeDFcryahEXSH0tz06
	 89DQchj8WWkuFSWYGWY7zELEvEu1KJUcm+N5IprYZLaFqv2NThIV8jS3bTwo169lDimTQpC0Vgqc
	 voLbfJGjnqewikIqX5+4iwH7vbbCCY+opG/OIuEnQiMdxL70jQvMmBitn3GpskiW8lgR5Ec0E9e1
	 BfMGIS3bLRIpX31i2Km6AvC7ZFE33gbeOVNYSjiop9sjmQp9ciyUrMw8rh6D/S7hJTbxXqZOArg7
	 w7N97pT5F5xt+zUiXobLSf9kWXxFE1kb+bx1P/qwE6NgibvwBOQ0Iyr4kmSFg25iCx7PNG/XDlTa
	 /ngi+rF70fEoAIgPinNTptb8V0QPeYCQzKWW2s2tBSrSBcrMT2ulGg9I66MmsD3SeTBFOxuxHXqO
	 95qwI83Xy6c0MrxzANNCKnWvq6XU75vBgzSfhKy5ySdURMIJ7oaeBcMCA6uv2s2rdyOzP5lHVZKB
	 xeeUGwE7HNb7CabVT5UI3nYKwQ8QgfQA6+xCPWP5N1AOmqxekemUYSZKVaP+1hVvFLHl6TmVjr37
	 LR4p3pEbptcaSc7fPf7Byat3R4jJmn9MnSRkBW9gc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Wed,  5 Mar 2025 22:15:15 +0800
X-OQ-MSGID: <20250305141514.1549498-2-eadavis@qq.com>
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

#syz test

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


