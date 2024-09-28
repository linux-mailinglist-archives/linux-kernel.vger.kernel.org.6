Return-Path: <linux-kernel+bounces-342403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD5988E83
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB81C20DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA919E7E0;
	Sat, 28 Sep 2024 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P1d7WOJu"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F815A8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512482; cv=none; b=pUkb0Wlj/md8G8IJPVPFbHjhD1gYYLoSVuSH7zhzb6jZv2IAgns0/5fmP3AKdQIsaD3zYHCTyehD2UicR2bPlvGaxx/KafVAJG2DIvytAIoWus721RFAevLUDahn5BKkm91t7XU95BudVmSZX1xNTlt1uQFu2JK9E5upGwSRTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512482; c=relaxed/simple;
	bh=y5/iFpzIRZorUWaS+yh00j6bqIdpWH3wkZ7kp5UYTXw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BlYHKFpQyYvES0vnhQ84PVY9t6DgEpiB5FVO6HgQFQgl86Sq2gcs2GzDkaAuIfdI0BTElm5axbGEVrMGK4sKsMAQ9p8JcBBO6A+GRioc9dHGOD9dS9JWm86BrFTOq+74YPOYCsE9Uw0pULfPfw2oBh+7vdyxKqL3SB1NhbRQqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=P1d7WOJu; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727512470; bh=DFznOupKYFNOOHxhlk72CuszPRaib9TkPPmZ7dKeocY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1d7WOJuCK8nowpAvqwFG5YIU2tmV5SqcRNw305OV+gCMQIYjnLL3phzsyddFLfob
	 tbCAxbaYQ6DV1dwKY3cS8P6wGUbMDAzfJVT/e16MY0bD5J4PCbQva1tJjnLNFHnhuB
	 1UlWDegeiJlHKGIALDNgZ3/YbSgb0BcG7bcQ+xqQ=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 5521F0DC; Sat, 28 Sep 2024 16:21:18 +0800
X-QQ-mid: xmsmtpt1727511678tm9ems04s
Message-ID: <tencent_8709932EFAAED0CCB0A7DEC6F592C9465306@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaQXVRBj81HEwijMDN0lyHr+XH42b/4lSaOVfI1kLL9OFpqU7j3B
	 L2CkCBM+q6UR5jPKma++akGY59JDSqhHgLWaQe8dKaAtstQFbu3OKNjTIxjUq0Cq0VG7NxjLSmWT
	 uw3rbHuuT4vLejzdPbMybtLadEaOgpQkTWP2n/wH7cqNUe+004QKoDeHhDKWw+2Jses4bomXUn9T
	 cZ7AXeuCASfOsqEc572P3aGNKuAfS5JSrBO6OtOmx6JY7uYqiinJk77XkeQY87U0ooPTZo6R3FSd
	 M6imsg9Qzy5QXM/Ka2isB6G9SnLIvK3EdKjDF1WaN3XRvciR3yDOK4rMWmHHCn4+wnfqLljhHr+f
	 p3zCOYNyflNJrHFBHE0wRsZ0x6GFFy+JJLwcaYYQHJtaONhVZFbzqkaaxKVrDFkOcnDxD0LzcNsv
	 7sc/3tFIfoEFsZYAS/GgNGJj1pPrtWhK5KOtCpqR1PZ8eaaXiPLh6ASD0CadZ33P7rrN+0MYIBsz
	 QB/RBuokgBUKRLJMERVt94icKqahYsoVQ6hD9ttSBWpxMjyYGFD8Eln1mutvbFsj+S6J0bgDsxxO
	 dsEhSYFk/287qzo8lnj4z+z6vXerp1bR76TADkTX1rutlv8ykqjCt61Ux62E22R4HsCFq+umdaXP
	 mrs1TTqKUCegHx76TPsLKWeyBP3AyjqD16+4sXG674Bh6BF78PzHHqhp84Y87vrwqdlaJpJOXUEw
	 zlULIIPM4NtJLdZa/UN1ZWBVj9gIOmyOYD9Sc+b01TrMY2xDusySGAv34xOdTAX8BJ84B0Wve1dj
	 akbZ4Ae8JSzxgjUkxUPrhLBIsKkVd9odwSh3to4oT8NcqPsljL1oBZNtEdFgv4aUuqJfyL5Ru78m
	 r0j3V8jHpuVWtzN7wZKh+eJM/MrJch13H/Pnc9wcdhU6aYGdtXB8c=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [integrity?] [lsm?] possible deadlock in process_measurement (4)
Date: Sat, 28 Sep 2024 16:21:18 +0800
X-OQ-MSGID: <20240928082117.2416683-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_mmap_file() don't require protection from mm->mmap_lock, so we can
remove it when calling security_mmap_file.

#syz test

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..97f5b150080b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1689,15 +1689,24 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+
+	mmap_write_unlock(mm);
 	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (mmap_write_lock_killable(mm)) {
+		fput(file);
+		goto out_pop;
+	}
+
 	if (ret)
 		goto out_fput;
+
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
 out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
+out_pop:
 	if (populate)
 		mm_populate(ret, populate);
 	if (!IS_ERR_VALUE(ret))


