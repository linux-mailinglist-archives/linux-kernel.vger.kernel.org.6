Return-Path: <linux-kernel+bounces-545885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88769A4F31C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC93AAD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A214012;
	Wed,  5 Mar 2025 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i5vxH6rp"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE7146588
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136178; cv=none; b=lxdMW2HSdCyaYh0yXNyQ7RTRA2O2jErJdhA7IXZuIQIHh94QBTogLvAVCGN6ZyBNZmqMijUN6KFumX+NcxJRKIS/uBIxB91xautVo7YX+2syhX8e/kUxJaEoJ/EVzDMSTOZWOtaikrIvdmb2wiQoit86kHubA3pz7C23TI3DVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136178; c=relaxed/simple;
	bh=9XuTRNQpajUsqm8YGl0Z8XTpnAZlMs+LncVN04YwQZw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TsFLg6T8LaNNlEtybYPbtNoZC0b50QV7B/7PC7iUx1egqYC9bsd8eNkF/heaMgc3YsE9/As5GhhXNwMgvqq6foipX9OXgleJg1moEDYD/LXmSQjFZR9jXemJUAT79BebfPZ38HUYq8SDNfgfd7c/hlu/0pHW2Zgntikg2u0rNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i5vxH6rp; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741136157; bh=gw3mJpMcS1EeUbLN6n29/qqIqgxUrwjp/KpVGhI/RDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5vxH6rpxA+OlM4jbmQsHSu8Z0GiU2EWB5JEUbLJO++Xi3LUWGgifZxBoU03k3vm/
	 yGy2no2xVZcMA1S52P5eQKhkuncKR/laYPiswjQ5eixOVyhKLBMwhGlRiLCA5uxVGY
	 g1b8QmPbVPOgReTn0Aoht/4gnIS3Oi/dwJR2zQ6U=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id DF799882; Wed, 05 Mar 2025 08:55:55 +0800
X-QQ-mid: xmsmtpt1741136155toimiy42v
Message-ID: <tencent_DBDF1933CFD60D9B25D30DB592655DEFDD07@qq.com>
X-QQ-XMAILINFO: NwU0tZNR0OQKAL3eJDdZkpTX0JqDaxLjaJYsQBfOgtnWlgzo/GHBNe3d1vET9i
	 QTHj75H2P8DAdmv1pT4J91yA8iWjjPleHl4JCBcOnnE+Hj7GcxeyicX0CzF1uS0sscXkqSL1Z+du
	 3XblQ44T/5ETHjtktiAbANBY5UhsQJaKJKFFQ7j8S/ymv1zqwaMK2lrlOp2xeHDi36c3B1hhH4t+
	 JN5J3ap+j2mLRPrxZldbQAxfW/RVAsdSlwPeQ05LO1ypXDu0hXr6MTnVWCjse57O1gvSiLuvxbFP
	 6q3RMh74vi1v750Lm10rMrX2FqSvW6bcu7r19mqyzcgPPJoe5dLWeFdVSCR85q1J3NHn55ioaaKc
	 F6DBNNO7hnAeb6T5/zOCBPWfg4tmlpoSSpblpb5pLF/Fkx/lM0fdVDBY7Wk7BB15Gy9vV4DhLx1H
	 mwmFf/rxN7mdL11BTWk63FzPBQV23sqE8cmLkt1X9oCQRVc6GBJMgoaSx41ad2WCpqKYxoSdRZ25
	 2StsUHOGXMhjoEWS/WMgGJqbeqB/KIeiPmiCeF4x7IyabLvhHlQ+udL/a7aA5mRq0QMgbJY9SBaM
	 5PdQ2YFyKpqzsXuzGjWj31hl+4Zcc80p9+t3mKVigJau0Gr6UWpIytT2DqivgBPLJk7seANgOjHS
	 fk9e93P5+iHg+C8t+IztTcmTcWT/p29qffPuO8liAxmPoFE+BDVcXaxBDc8XAm3TWhHR5uopo65V
	 HhcZtZzOYnmSQaOQizaIYjiB419M5N+uKciCrNCJRDJs1sTx1MKwCP/vdAPMvlWR/PpjbG0dU5Qz
	 Dc2x3YdW96vQzmZB9JwgSesXjXnNAesYU749FGYZqPdN4a7URWoJyLJj5HhI6VXq9zNuK9hsx2h9
	 DOi/iNaS4Fm+C0m45mLwXFOeIlvLjZDw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Wed,  5 Mar 2025 08:55:56 +0800
X-OQ-MSGID: <20250305005555.790594-2-eadavis@qq.com>
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
index 3883b307780e..66c28dea091f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1434,6 +1434,7 @@ static long __get_user_pages(struct mm_struct *mm,
 
 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
 
+	printk("mm: %p, map lock held: %d, locked: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), *locked, __func__);
 	do {
 		struct page *page;
 		unsigned int page_increm;
@@ -1469,6 +1470,7 @@ static long __get_user_pages(struct mm_struct *mm,
 
 			if (!vma) {
 				ret = -EFAULT;
+				printk("mm1: %p, map held lock: %d, vma: %p, %s\n", mm, lockdep_is_held(&mm->mmap_lock), vma, __func__);
 				goto out;
 			}
 			ret = check_vma_flags(vma, gup_flags);
@@ -1484,7 +1486,9 @@ static long __get_user_pages(struct mm_struct *mm,
 			ret = -EINTR;
 			goto out;
 		}
+		printk("<before resched> mm: %p, map lock held: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), __func__);
 		cond_resched();
+		printk("<after resched> mm: %p, map lock held: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), __func__);
 
 		page = follow_page_mask(vma, start, gup_flags, &ctx);
 		if (!page || PTR_ERR(page) == -EMLINK) {
@@ -1500,6 +1504,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			case -EFAULT:
 			case -ENOMEM:
 			case -EHWPOISON:
+				printk("mm2: %p, map held lock: %d, vma: %p, ret: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), vma, ret, __func__);
 				goto out;
 			}
 			BUG();
@@ -1552,6 +1557,7 @@ static long __get_user_pages(struct mm_struct *mm,
 					 */
 					gup_put_folio(folio, 1, gup_flags);
 					ret = -EFAULT;
+					printk("mm3: %p, map held lock: %d, folio: %p, %s\n", mm, lockdep_is_held(&mm->mmap_lock), folio, __func__);
 					goto out;
 				}
 			}
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


