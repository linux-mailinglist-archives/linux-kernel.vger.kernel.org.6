Return-Path: <linux-kernel+bounces-546951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B58A50118
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1A41894DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D241D540;
	Wed,  5 Mar 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Y7JdlIeC"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320413F434
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182632; cv=none; b=iy6ENUyXxMZR5MSwjghxeuJ8nHByLJtwvs7Jgh9Txq/12F45jWrqrwwGBYumGJWHA2HpdCUAKGD1WFAMF29RkS3EZ6hQU91B6WvLxrP6y8XDzI1pGKD8v1qn9JIZKJ8rLoHRxZM3W+G7+GFY7K0YXAZv7eSjIjMRtsxb//aH2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182632; c=relaxed/simple;
	bh=Z78A2Ut63ccQctrfEqo/o8QkPvu7dQSsf3z6DlR2STY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nFv7Ah0+tVq42OlcBnCt91pFUiqTSLABmfUrAv/VKVEq6Gw1Zd/9Nm3x6wkTSb3Ts+pPlAVfI+HCdDGudDrshyiJxokSIyIOXFNvS5xGg7SVZ3oIJRJA8cjOqDLAeoM+FzePmpfFP+88NNk14KQPhjSLIXZGBiz/7YupmJlultE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Y7JdlIeC; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741182324; bh=ccq0Av38nSs+iwKBCGzoZ5cXsA3RMZ/QqLCdQ+42KWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7JdlIeCw9NsMpDrzQaNSv2o+aWcJbRWY6IdEhPdkGQbxfg+8tHAyS8NaqaQisLY5
	 dDY035BHoK0YbvgQFvhB7Pkiv1Q+ZEvtV+QqkN36nqlAmXIVKFANu/RURbmyRmcFOn
	 kbl1UVYRHshELROpl2IH+w6Dm2cHa6z+GNxqP3pY=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id B569CC67; Wed, 05 Mar 2025 21:45:22 +0800
X-QQ-mid: xmsmtpt1741182322t02ur8g1f
Message-ID: <tencent_CF336E8362896EE3B7C45CB77E976686D505@qq.com>
X-QQ-XMAILINFO: N0jQ/i/W/QNTLe2SDmV1OE5LlP0DhzLTKi9/e+zAlGUTrLnS6rILSmuVnzmmuR
	 oYmfUwKfBrJr7JrwmHLZBJi1AG5QXXpflS2Xy535RpkED5gYHTPA9odGjMmJU9Jrr71oAFTZjExh
	 jOJdK+h4w4uWX+IehDVKHkT70klEPW8GvRPdisvjpc+ViOQWyJbjukPyOwaAdLbirHutYeIOnkhG
	 oMHpuLnlTBr7fwfW+IDlU4J3q1VIuFrVYEcgbFV0Kdgl/I69MagQklb5MALOTyY6TtiEBVXLSJoB
	 hjtsOB7gj8s1Hpg6heS8f7yqfBxCMzMq3n4yPtsQayyeuP5Wp7SqdXGH96Ridj4TgfwvXP5E18vI
	 ivvlZyYIX5LKIn6fA7yETXoigwOgsOeusV7J2ycqVWVOdXLu1xyBg8DrMwRbOBAmmSO7mQ1RpBjl
	 VfxB57W7UWqGerB8wkcSZCWHuK77Zw+3W0YoUdt5hmhQyJf7nqeeF1TJPeLCzErso0HhB6yb9iIe
	 txsZPbM24TrgLOORChJIkzgfJWQXTFs2gVhOFUxMhfP+i87/QUyg94VdfNSN7GJol3tnZ9JjHIIL
	 vhc6DVQ6i4eXO2nc67C+i1xWQ5pu0T8xukN+txlCbTVODVvozjclc5VjAjLaugBVfStAD0OsQNQX
	 6fvWfWLhsNtWcRpitnsum9whl5FZ0fINN0r2K2RCX4+x+FXe/Oqlgzom8YzY8xzbfcIaMWy3XAzp
	 v9gZ3dQPjbTcPX90W4/gBdrF7MKOyCI9Qi88XzD+L2ECmr9DP8J+TdsSkAKuvuNcTgmpRPT6W7e9
	 ykPxsDixjIots6fATOlYAPXhKXi2uIkl02dfWJDqFHTD9XdxdzSrRgPwChVIYPsqJnsaNHylWkms
	 JtgMJlnvVIz28SfdW8bi1msR0G/sBqOzup1wqHu1asI/SA5CuD3+k=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Wed,  5 Mar 2025 21:45:23 +0800
X-OQ-MSGID: <20250305134522.1522377-2-eadavis@qq.com>
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
index 3883b307780e..c32c0854dd4f 100644
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
+			*locked = err != -EFAULT;
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


