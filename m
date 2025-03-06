Return-Path: <linux-kernel+bounces-548954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7751DA54B58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11E7172642
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8C209F55;
	Thu,  6 Mar 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VJfDy2DU"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBC20B80B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265950; cv=none; b=WXJQjLCLXTPr8dDSX4JtEqIq0YvvDPpPS/n9biKbOrzSiI4DYZ4KohNSOl94naLgqKXYHZZ7CvpoXAXZITYLxeA/jAz6Njy6RndqT+axZbBj5FhYHlqipXGAa/9uXKuP7OxPEGCiGZcChbxpyiYfSICNl/YbXVk5U8gW4r48wk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265950; c=relaxed/simple;
	bh=+C6+kiSpVE5KfXsZ+T78U7flNYEuG4uRKZzZ3SXkawY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rzPWkjOrswTj0mRMGOu6ZyC0ykEWduKt2pdOerY++V6OYmz4f7KBucMJCDL7xdUfLGYOzwsxgtjkavVEpuVI7aq4jwFglgif4yKPP9DOWm8PqWT/fR8+dbnaFKLeGqJ5rJ8h4uGKfUS5pTrkZ4QnRavBQHuaW8iTFC8RwICXkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VJfDy2DU; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741265941; bh=acioOzHhQ2ctbG30Uphm9oLX1bxxFczzdidUNA2813k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJfDy2DUwpX5XfCKnT0SUoEzvWeH9nTnFPFakMr1K7ZpOakNSaCfgmDEw3qWIpvnA
	 4+mUqdK8KuOHSGTrY9sITRt/EaZVuFMwXfPhYIf2X4QDpovhicV4ACz5vko6Zr25om
	 5akRQMRXH8/XC1fXcYEyOB54ZPnvaVnmltu/9mVY=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id D35AE069; Thu, 06 Mar 2025 20:52:53 +0800
X-QQ-mid: xmsmtpt1741265573txfnhenz0
Message-ID: <tencent_B91EEF32CDAC780A6FF82FD56DE49590EB0A@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DMOHggUw40dwNIxovu2BK7gG0Y0hWe4T/kSZwlFD3oUyW85KZ6wS
	 0X1MCZvQyVnv6eQhg72SoVrBTk5q2K3vWqOb+cgYNOcnhlT+rRDEjlDFKrIUNtPTBVvUlGAWVpap
	 UGaXd7G1CKuTYztCzvW6RvdM/vjGJuwI4h/BWYnaIozso92qrkMmY/+d7h14CMtw5+LaKVa1hV3A
	 IDDAn6jN00lHHUKscSp6tc9nR7r4uppLQUf/fshYLONN8Gs9FDqoaFMVAmUr+c9IC2xBxuySJuvr
	 1Mk2GkpYgkX+kVU+q9pbSkne+u5ubQ+afTOaI3WXYnf1GIZJBGXmDDE1aprRddu4WBMICygKvCZx
	 It/2zw3AAtKUSZqzkavuQXxImH9x92oqq/GG6J2iFsZG1Hd4suVMkUWZyz0JNPhsRzh5JWbaitpS
	 USYtetgLI2NvNd1TRCfpZdA9Zekw2pGwLgCE/LBL1MnF0ReF+9cnTRJ16II87RLlkcHMrNVpa07J
	 b3Sy87wfrh8T4PquJVgtZTyJSutc92xlbv/g3dxo3FSwBDIJnWQdxNkovfMqzYYlGXWsaf5eR5qk
	 ltUUXpLaV4wn0t6eZiTowL/76oPysfpEmfzNjee7D7KQOJaeVosVy/xedc/okRWoCI8KdAIDCedX
	 3cLf1EfJnvJdriU+H+AhUEOWspTMXohyi8M1NSJE6ONuUbe3Z0IWadOOvow38hiix0pNC7XiPcN5
	 x9pI2S7pR2ZxRSaKdAR1eKVv9ZBRSRozfJ3JaXBPqYmkR2tr/OulrCkKH897MIi/FL/Ae3KsL5+e
	 o/p/+IZSVDxPmN1TBXE0y42cBNGVyAU7vZz7omz8ybZhY1K2W6RPrROT0JS6bqI+Dh5BxG+sM2QB
	 TJFwcXv5mZqRo4TP3kSqHFv2IVYD8YTfF6oe8tYm6n5lu97adDbCpri57Yz0BorA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Thu,  6 Mar 2025 20:52:52 +0800
X-OQ-MSGID: <20250306125251.1597826-2-eadavis@qq.com>
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


