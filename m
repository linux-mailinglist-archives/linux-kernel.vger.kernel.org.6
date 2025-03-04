Return-Path: <linux-kernel+bounces-544448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7CA4E14B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F717963A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89825F79B;
	Tue,  4 Mar 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Oi+bbtNM"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82B25DD1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098822; cv=none; b=KqqEhE35cuDGJAf47jJLzfLoKrjHG/BKStOcOtwdxhfERBxrh60hQzswCYJ2frdz0sRwqryh6O7Vi7K5rRizCIgLBwi/GVHyx/rTtIZ7aYGqY2mvaZenpCW4LJoW+mP/FuNbCMCfsWnEE0CxWNDCOtxVRpUASWOZRwsAAc7iLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098822; c=relaxed/simple;
	bh=MfPB0AXrCqimAWl9QsJNkee4yf3RByVXZa+CKQmFha0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PEaIYgwZC/9m56fZg61BP7q90RJ2Zlrd2c4zbvWieVAaVfgyYIag1Emxf2MjbZqp9mWyw/grRIFnuuPbkobwAk8kS2EWYQvdojwrsgnE+jNKq9FRwQY/N3csW7PQYwI54+Pu1YWN8zkK5cQIFwvBb9+wFWnNUSHg4STiwOa0Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Oi+bbtNM; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741098814; bh=0ikGs6lnN4gL0JwJG4gCkAexvVRrBkUfdcC1d1luqRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oi+bbtNMHxa/VXQP27lh7WcHo7/2JO9krJXnLn3BclFHR7hr5PVvIbrIA6E0Pm7ho
	 BBz2nzGGgpPOTk3cBsf+nt2NPn94ZKUb+6M9lBYAVqAR2LHkuExXMpjl5zgGEvfPYL
	 k7E0M6ekkyRQiprzy5J1XVYmINGiHu7k0FozDNwE=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 8608FC22; Tue, 04 Mar 2025 22:33:32 +0800
X-QQ-mid: xmsmtpt1741098812txb42n3l3
Message-ID: <tencent_46109430EBAEEFDACC98796A6F202EDD6C0A@qq.com>
X-QQ-XMAILINFO: MY3/p6yUwwyTAdLTR2lJNjXXm3RQ+APND/WJismhJK9dIAWRs6UlZ6OKwBxJ+j
	 kCw7IrWMp3EBFhQNt6aQwS92i8e8NK85EELfTBccwllnEB7jXw+813CkfVl7aMYL5UW+y4M75t9H
	 Hl2s3qYXlPugwa0vpzNT5hvht9V915P/HiPbxghv3dKHiTGlDaXll3bXT6xLI4hO7BDMuooGuvuM
	 7ixUK625ueFAa1e1oHNKwSWpnVEz7RyzeaXfeOHO4eYJLlAlu+KkhpKokPph49fiB0ltiMStOmn+
	 XMmSP8OSnBsEF+jWmMNX7qhcYRyuNwIXFnCESeuDxpLLOXMvqemLJkb+0gR1v2UpkYurR/ACKUXu
	 EzrbcbYzzLpEyah0yx4OszAeaAAL4y3Q0GdfsEwXXT4SkBSUbPAx5Iwlmafh8iwhdaVsBfofVeds
	 D4hVey6RLIeRRCW6GS5wKbY/iRRFvHxZ4LWorfYEOnrzXoxpq/F+6IPMoaJtLI9EIffijHmZ6xSJ
	 J6xv7aENw7v5+2SFxC1wyFKSKEpwof+7JYwmlEcDXlpX4nfwa5r0EeOeo4UoU1uh2n+GfJmPmjSw
	 o+XX2PzQ9oNJ0NbxDYnf1ZKvicrmnIrpAmefelCLtj5VSBOL1kllf5dpp1OTQPLup4VmAozeXi0U
	 iGhT9F1Xc10oN6Rlk3K2hZxQW1E4f6UDRKjQ7YIKUs+ioaY+7Ef6Mpa0945fCQFeNd6ubWb3JoO9
	 tlgsEjnj+Iy0tp64rLLOU74Zeu4u7w0IE69EtLw1824znb4qBVUj86pJ7YPAA+SSG/v2Zbp8MCXV
	 JJyPkVxPw3a4IiKHQTOzAxzW0hVd+nVASJI8i9sppFl07IikNLwnEIA553GtfOW8FUPBZq1YPLIy
	 qWABrrmQVSpJRTspDRmVvh6uT9zOCoQd5qvUZbsi9TDmCEJFaWDHiTt/yOMCXt9w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Tue,  4 Mar 2025 22:33:33 +0800
X-OQ-MSGID: <20250304143332.710850-2-eadavis@qq.com>
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
index 3883b307780e..10be47b303a0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2029,7 +2029,15 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
+		printk("1mm: %p, vma: %p, mmap lock held: %d, locked: %d, ret: %ld, mm addr is valid: %d, %s\n",
+			mm, vma, lockdep_is_held(&mm->mmap_lock), locked, ret, virt_addr_valid((void*)mm), __func__);
 		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		printk("mm: %p, vma: %p, mmap lock held: %d, locked: %d, ret: %ld, mm addr is valid: %d, %s\n",
+			mm, vma, lockdep_is_held(&mm->mmap_lock), locked, ret, virt_addr_valid((void*)mm), __func__);
+
+		if (!virt_addr_valid((void*)mm)) {
+			return -EFAULT;
+		}
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
diff --git a/mm/util.c b/mm/util.c
index b6b9684a1438..f6aa733b9563 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -576,6 +576,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 			      &uf);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
+		printk("mm: %p, pop: %lu, %s\n", mm, populate, __func__);
 		if (populate)
 			mm_populate(ret, populate);
 	}


