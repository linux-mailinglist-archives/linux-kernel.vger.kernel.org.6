Return-Path: <linux-kernel+bounces-562829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E8A6337A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 04:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABED16C4E1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033D54F81;
	Sun, 16 Mar 2025 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DFXekqkH"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E829408
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742096286; cv=none; b=I4qHclBzBB2P5E7CBNipfThLe1bgywxhpO5ns7G7ROHSx9zXvRZk/gLwR9mMSDjMJ11sbqApFToVc8RuaVDGESXHbqv3aBZtkcypWKAtPfxeF67nOdH7aKHclpEuPCrYqsBudVbI+7Y2Fq/LdZPJl9Ri/OXey+fns4T87oFZ2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742096286; c=relaxed/simple;
	bh=+C6+kiSpVE5KfXsZ+T78U7flNYEuG4uRKZzZ3SXkawY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bu76NfxGnY2ShPHGZz5OA3KGnOvXIdgOql/ctnEckeSTRZHCcExdEANNqL+hEN4Uv68s+K7EH0URRGh8GrQAM5MZOkwJhx24/rPWLSROV/enUUUz8+qAEG5J0J9lmqqywd0zhQwcqnF/PA5E4nou43J2qgXwlmPvHxZCY4XrriY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DFXekqkH; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742095978; bh=acioOzHhQ2ctbG30Uphm9oLX1bxxFczzdidUNA2813k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFXekqkHddx6LNqBqrjM+HjEsf+nlz2/jyRx9p17XeE5GkFvBXDXNL0HwFffWSxwV
	 846B4WJIYjlzGEDkCUFoR6gcPDqNRQUTJvjhig66JB9HUqgKnaOAGM6iKo5HNSDZV+
	 MNAbfZuv3ByQGFwpvZSZbjSc3obWPI8wESJncZYU=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 83816868; Sun, 16 Mar 2025 11:32:56 +0800
X-QQ-mid: xmsmtpt1742095976tbawdce02
Message-ID: <tencent_4C6B86C5F36DA367696783A6A449977BF705@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aB3IEmjKRN4pJ4jPViHOeHZTG4w4wG3J6RsZKiiDb0JcamcusO8
	 pdX5+EC11Iq8Z7V06+E2WPftwiciWFV4JWYa/O4ttUMlOw9yR0nADIF40Y88K/rKS30pwDgNu7qR
	 kcxUVkHDIwFsdu9c2M4ie/+fRWDKlGN87kv4xd8yKSTz1SrsU2AkATHhJ4JXRnxW0FAkWa6Y6E2u
	 4mmaKCyujaBVgxPIrPJeddThdF/clBZnxDqJM0knUYY6VXo8Eea5lOjH/h/c8rRQyVJ71eG+IaUv
	 pfd+5Y/4dHf2T6vxzRaSipbJqzg1hi/UmLjKMzyv3sKTXDODJxsotRR0fsQqKWhP3ZrOjXG4gziO
	 IUcwSEmSxW/jCQH2IaZT0GUprwvx4+xhbkepdWEyKLFinyoT6WYnXNchHEY1WgLcJoduvORytai7
	 LWXerTIeOrmqU/e6/P+SRC0SE/4DSZC6GYsl5wOQhkmelW6ydQaVplr6kTOo71vLls4RlLELSovk
	 dOgtj6dmTxA6SOOpmnr5irg58205/tQXljSieh4geErpuPxGYqJ4oL60B5lco8tWeimwLDQRBbcY
	 +h2SLnntM6mScO/sZLIKCgSIG+8EPEGzci92SHcgy3amsoD0OAu4p6dt6b4ZMUzNFgZCg449ibf3
	 Y4bvDczkj9GXQ/+czS0G/DjOLwnyKYsYgEM2dSMuU5c9OcTuGjRz/c3XzeC62Dh7H/rmwv9dEQrJ
	 64U9TAAtzTravhuFajNIAioPrJ7n2srSm2hNUuOGbc4GuQa7FgoS/E2n+eznPSFrCih6avb/8FV5
	 Q1Ws170tC3zLMiXRXB1S3KvR4Mj2gpBwkuk7d95r6auX9Ugz4Lvvb9K9cro0G25EDjJxbmr6jYr4
	 keuq8U0EeoaKDmuFApIrkWhuOtYrZfcxHbmBq76U2IvhpuZNudahjn9fFgcz+HkQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Sun, 16 Mar 2025 11:32:57 +0800
X-OQ-MSGID: <20250316033256.2210272-2-eadavis@qq.com>
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


