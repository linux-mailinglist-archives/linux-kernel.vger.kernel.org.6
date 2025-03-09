Return-Path: <linux-kernel+bounces-552887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82144A5807E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 04:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0581E189147B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521DC18E25;
	Sun,  9 Mar 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yEwr7QtH"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE629B0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741491525; cv=none; b=W4SxpxJLN3l+FmzlnyFuXw31M39bpq/DBrMwfy3iT/gZynvMzecFtPKF/mAY8dIvmkBa+ihlhCss4YcpeY5Zv/ZxUBZPv/xF0b80mLyFK2ID5eJi5XbpIzAwrm1hWpHil/hk2kLPG8M4vtUyNFzZb9HbD9OlYEPg2ekNf81FQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741491525; c=relaxed/simple;
	bh=+C6+kiSpVE5KfXsZ+T78U7flNYEuG4uRKZzZ3SXkawY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dMw4K9mlnStQ8weetzU7tItxLnBi8wRxbm21cGuSF1NhzYDrDFV902mIUJl64SiNrYamYzK0GyiRPVVUUJ74eN17wWz+ezet7KK2RbfB65g/EYvw5oWj1yBib3OlaOZ9iY0V9JcHVrG7s8SBgGTHV76+wX8bKT8rkciIFDxeTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yEwr7QtH; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741491510; bh=acioOzHhQ2ctbG30Uphm9oLX1bxxFczzdidUNA2813k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yEwr7QtHrkZO+GeC9ADyCgP1IepCdez0VGHK4Oiq+SqX3gGqrTMDi2e14YUOq12Vk
	 NfFpEk/oqHkpMEZts0J0pKgddWjLIngu3KKaf1Qeiq2m07RNUaziHgilNijkMk/G0J
	 BraQ+lhtqIvH99xGdEqRtOMtI8/ecyKTiW9bFgog=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 78EBDC07; Sun, 09 Mar 2025 11:30:14 +0800
X-QQ-mid: xmsmtpt1741491014t7e459r1h
Message-ID: <tencent_8D996B4FAD8DDEA5E10D92922A5D9C5DC907@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTFtyx5PXP19rP43oQA8R+lsKbTA/9G4hLaJO0M+imBXITCl35Hr
	 9Bt9DYmCvRQgFBzRq2nrD1laNJSe0mrcubFHzPbkWo5Uvq3bvbZ68q9t7EBqXRhogzVnOp/mdqvB
	 QY1ij6MHvcwdb87xpZJi3mREAig7iPOGnH6akL7RO5TaPCtIK4J1wlx1k+7fSU3UAjbfTF8hu2JH
	 VpLAd+HNYLm6nPMug2IG+DuVUFyC/3MY42TEeRXyHtlKt+xelzXDvAp/oSuygfwsEOmo9+QXyjIA
	 7G/Q6mhnbip4AzetKcjy6OvcLAw6kQK1XbxeMcuWNs0YWPm6GspH3pTNhwmrUNfCsu6/gpYTQH3m
	 rBw5GHq/iObwwusKk3217xpg30+snB8b1Ps7jzkIpvnxzX9lEOw/PCN+YiKWSkpA9evPu8VT/HTn
	 zjxKbCWSxd/fH02RvAUxWv4QO5hWU1IlKLIZRE8Mym5yw2QDyEvmmyw/xiJs77Nsesnu7cBvlgXY
	 0S/xhv6iRPsSzyQtW4NkpxYBMQNKBqfRRq1TwIJTDCqLV1FOG0E7dkNpwf3oz90porap5dV5afXs
	 1LWWl2hnk/4ouvXRkNBZlbr1WRFhYzfrS+zQhCJsggT0iVdNpYXVhj9aA1g+ZYz+TCy04CNa6bRd
	 ooFcOqYOocNV51QuTkcbFX/5V/U9fubZxcsstdNWU4DBl/Hw1akJ+jFBbJp0+nnudjLRzyAfK/7W
	 sGqqmB1iS4bEIphgoXX9zo0v6EjDAWD8IbL06yKJwyTZmB8FOg/rVlxgPX15Nz8msDb3fC2HISvG
	 d+obODof7qhDJsFVG6AvU6eR15U7h4tGIiDa1kAjxy/1oUZZtyPx1dRIEccE5T8vFHkb0xx6a5CE
	 TAyG+MnPWSxhU4EoEYsN7ixiXxMHC3lbLhxf7cDbENPbzJIvgdyf4=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Sun,  9 Mar 2025 11:30:15 +0800
X-OQ-MSGID: <20250309033014.2572812-2-eadavis@qq.com>
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


