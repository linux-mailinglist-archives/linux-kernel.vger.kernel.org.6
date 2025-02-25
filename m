Return-Path: <linux-kernel+bounces-530755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44FA437E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ABE3AC35F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3C25EFB5;
	Tue, 25 Feb 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NhL55zdV"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B41A4E70
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473024; cv=none; b=DjbJ/m5tVlEHsm1WF3V51MiWvpDyCW5QUWqtF9eUd2ok039jVM/IeFA1HVIb+/m/wB1TEbCugmwqv8zboaAO0c4hOxUfSMFVbj1ojbkM5nUvJu4AB2ek/2Z8LPC9/ebPghzGIYzdVn2uZO+QTZeKHxmrt7L4N6VeT0fMzgajlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473024; c=relaxed/simple;
	bh=nYzmG5fGqyJ2/BnvAMcEEuMW7ccLQ6/I9/n243p9qqk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=i+4TEs8jR/lNKGPhOziA6/FM5Bxb8ima4psc1hLckDKd5ye6msMRoAZi4nMeXSy3xonlIGF6kOm2xsld6oQ8cXTDgQy1KBZGxIvVsohyJ4Mcx6rREI1Sxma2diOBOcGlxT/v0SFb6CvCjrBw8sI/Ez/vETkxh2hh9hmiAcvY548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NhL55zdV; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740473017; bh=EFnITfDpz4AeZkC0s+o9ISgPM4kN3o13RbvxeE+/mJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhL55zdV/7lMJVozpzg7fDHHzeOYMoInti98HvtXn7z4qSzX6OoSx2LGMtFBv97/S
	 5eAPCtpcbL+6qi7+iP5g46RyWut3yV/sYXoncp/UufyUVSDeM+uYyR/4IN02Dvyyo+
	 ZB+k1D1+0WWLm3nI94azva8nso8K9UFAzkSt2F2w=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id AE3910A9; Tue, 25 Feb 2025 16:43:35 +0800
X-QQ-mid: xmsmtpt1740473015th8qz8g06
Message-ID: <tencent_A58D9392315DBB5DE51976CFB48D98A58207@qq.com>
X-QQ-XMAILINFO: Njb1gVDhFoIvkpvG9Aa537mtaux2kXLQCoz/2bHiEA1ls6KTeAPhekk2HxfpL1
	 siBxeUzJzlqg7OwZ1mCfq3xgB29KvRwJZoB/WlSRkWeNBXQVXRF0aialg0J9lzO9DeciqiCwS1If
	 XcTKiA0pSzfOmUDSbKFCpo9kkHC2voveMspC13TaVOp7TrZXIYTu9Xms2ImP4r9OYWsbSlEsdZ7N
	 bV/GLp6JDHMtefh1dfWjUBsFHdbmv0AsRNoHN+s65lpCCShCiF+lAnsVxoLDz1bFfBZ3odAw8fFo
	 xZ/unhePcpKMluvEKVmY5U6aGd/h69x1qqLTjnh7OjPv0Z9wrjp7F4MoiamOJMDMzCfBGKn+5SvP
	 +nRdc2MOmuldvIK5LGHr3Z9FJ1pRCp9yaF/AqwMqXCoyLYI0KO74LiPIwRoG7xappwxpIoVUOvDf
	 FtXmpPbE4HxdnqqzywFokPIV27ZbLbNqO8sYVY8X5TeF4kY34tBVm0wp4CGggRtnl7p3uFNYdaK2
	 FKhLH0ILkyD78d9/+Rl31pJW/DvY0MYScZC756RotH8BXDnp3FeMpPzUwHmJ9Lth0emenLmSyLrF
	 mnK+Uw5c54JO971thZjrqND419WF+kixFDulD9fTK9M+OZ2bKYDlkQ0IF754Y+xfmpP1EZ+GWbg5
	 QNhha81oneP8wtHXiflD5zSUSU2Fh0dt96h7WgAooZBlp2iR3DocGqUsCKHKUodYjJH0PEMWzQTL
	 et8/iZR1M52sCNbn9gDnzf0hzJ1CIZzH5Zp+wLmSpofd7VHDztaqkir7BEE+WfJJDATFunauAyIi
	 yfGj85IvIX5OUbY/f655t5/dOMFavBZC5aJzgxqQxM6cPv5il3SlcOednbFKn+p8/oYfpMdF+gRp
	 Mqsx68mhNMujuzLpMCnjkjQ48sLQ3+oW2lnDzY/LZHIDdXP6k9nw4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+556fda2d78f9b0daa141@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] [mm?] general protection fault in lock_vma_under_rcu
Date: Tue, 25 Feb 2025 16:43:36 +0800
X-OQ-MSGID: <20250225084335.1222336-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67bd7af0.050a0220.bbfd1.009e.GAE@google.com>
References: <67bd7af0.050a0220.bbfd1.009e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/memory.c b/mm/memory.c
index d5c4f932b399..f67670cb2e22 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6484,7 +6484,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address)
 {
 	MA_STATE(mas, &mm->mm_mt, address, address);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *vma2;
 
 	rcu_read_lock();
 retry:
@@ -6492,10 +6492,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	vma = vma_start_read(mm, vma);
-	if (IS_ERR_OR_NULL(vma)) {
+	vma2 = vma_start_read(mm, vma);
+	if (IS_ERR_OR_NULL(vma2)) {
 		/* Check if the VMA got isolated after we found it */
-		if (PTR_ERR(vma) == -EAGAIN) {
+		if (PTR_ERR(vma2) == -EAGAIN) {
 			count_vm_vma_lock_event(VMA_LOCK_MISS);
 			/* The area was replaced with another one */
 			goto retry;


