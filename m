Return-Path: <linux-kernel+bounces-546749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BFA4FE49
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D998C170E95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE2242936;
	Wed,  5 Mar 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wi5k5bHk"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6721883F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176642; cv=none; b=dlyeFHsCT5T8iQHa+23Ex35BPQ72eKr94/1LuV+F8Cc1Y8zcgFZ8DqVaLSFK44OpcCpyyWz3Eo17aW1vrZROyGZi667yYCJs4fQ7SK83WiiajqhHN0I2ToRH5s2AGCFuewDOl2ajOsszu10nyDvuKKcSJK/uQNAzsDZuyqN1g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176642; c=relaxed/simple;
	bh=pesCab7gQVABYGDPnJ+4A3gANtiUYP/fvVBks/ZKlsI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GplYYspwEgCtpX2iBvUOoCTi7VFiSeaiocL3Hf68UCmf1ODMcDbcEF5CboNYU+OEBlZecp0ROaKkzzUUBOx6OnUiC2UNVcOLt1xQjpGalPzFZyLQy2ZpdtfCq9YnwrGDQUO1FGfxRFXcOVEVevo4N+6Vud00Sty4vENt3PRUEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wi5k5bHk; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741176632; bh=uA77RbgZBhyga+OoCM78KebxRD6qy3kfz+qf44g/TPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wi5k5bHkirRXKpuL1UrN3JZl+dunLVL71PJJB9CWh0ng0QNnnGaNhZanWxbYEHq3p
	 Bc8dSj/ke8rEc2N135sjXpN2+7YmtYo3FWlEcoDoLhewS5Re0pUVLmBveyRxJu0ZPw
	 MhVYVcuinW1h+UCHzOrscLZE0Hv/PPxJOchVbVEo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 216B54C2; Wed, 05 Mar 2025 20:08:22 +0800
X-QQ-mid: xmsmtpt1741176502tlrv0k0lb
Message-ID: <tencent_39D0AED84CBEE7DC86D712DEC64CC9AFAE06@qq.com>
X-QQ-XMAILINFO: OP01qWhGSBjQJ/uRF+1v7NFNTcwPHWnQ8uY3kjrixVFVbUFlHhD4hmt9iSEvns
	 XMGOuroiTPLk+qGdIbSivu7R7/mMZ5uQ9SPrcoGRaQgRNv+gQR6Y1JgjCRxZlEuO9TcrB2BrY29y
	 wSC9BmX/W9eIb6yiP9YtHW1ObQ9LBGl7zSiiZDOuMPAvhZDLrcOe+cRvvVwGylewPCb5aqhlA8B+
	 LuMeIr33iFk4qb+fUvbOfwilaoDXUhiO1OzGFT9sfKl5g03QLAeUzQ1beP1COSXUSPFVdp8OdmsM
	 SNb2RGeybiyHl2RT52UJkuPyVlcz7nQOTwBqlXS7B/z58YZw18s8q49UiZMzbyBphh4LhlAHYY4s
	 TS3JqbP2J0abHz7EW3d8tBYdH089yDaa5/b1i+M9e5ot8AbG8KGlWUgOMC8xNzzfznZZRVQczHqJ
	 78ctl7IMwVwBunv4bKYG6tE7YSAZI9IZuxOgl+gGlopZFmr3B0zDVcFbkC/ZQN5xoTHzZSQ7RsdX
	 SK1U6wXy4GVQFFzafbI8uuiuewo1wCe/mv/7sOnlGprIqz/zi3fjrDKhSTFZfpB5iAbM5ffc7A4J
	 MP4i6FPZKx/SqY30apcgE/MIFQtLL7nilk5P0OnJ0MO8ZVmUhhx+M7hAasRUA94lVz3FL03OalfN
	 MYkifAdPJsehlT2fr2Oyt8I9TNFUKt65f6kN/q9i2+kfZ/YhOcSu91naFuuTrtXiRv0Ssc61F5Cg
	 VK5vIqY349GFflFt6MBlfMxYeHkYi+P1tGc70DewY3W6dcgiKOhYwNjTv0Rxje9Ud9qFe7TOhayF
	 IjbMZyKqzJmCzkz9/EL96Xfp2CkaYVoAcuNR2HQKJB4Uw3AqvatskyhTukHo18ksMCD9eKZyfkCo
	 rq+3WJbP9cNC+nDBCwCG9IpY+yNPYqgraJUwDwAYbD
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Wed,  5 Mar 2025 20:08:23 +0800
X-OQ-MSGID: <20250305120822.1427223-2-eadavis@qq.com>
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
index 3883b307780e..ecf64fc1e0ce 100644
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
+			*locked = 0;
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


