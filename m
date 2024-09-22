Return-Path: <linux-kernel+bounces-335064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007A97E081
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC91C20AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D7153BE8;
	Sun, 22 Sep 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAHXh5Hs"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312F28F4
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726992528; cv=none; b=ucmP3PiJTe+gpdp084mhA4QMUVBJsgaBdsJyvRSiOeCT3BSGDJ8Iu4nqwjAihATJ97UhSlLwX2Af9VAlcJb3//corM0E0xLWpUN5eXw6FD9An5TiHLbv+Zsj8KxmbJMzqPZcn87ffbp5+L4D7Bi+Bn20hezEsQWy9UC/qYSX2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726992528; c=relaxed/simple;
	bh=sGGOXf7It1E0bmPo0m481afkzrdPxuJ2DG/zH5rpjSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLTNOsjscimmfeiWMY53tcrSv+tZXFfxPjJKVWc0z3TM1akQ6l0dpskrmPBvu7yrBravtdYhEy2ZpXj9kUL0dqFeEFlR9AtYqRA8N9S228SdrxWx3d9yRrYBfVNDZ6pg2NnAuDvyDHP8y2sSRl9Of96sBKMmqOPMNinhzHDPaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAHXh5Hs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71798661a52so2552796b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726992525; x=1727597325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3FsihmhCrs+dPbCmmFqmu8S8SyW6nS0IMPoboRbafg=;
        b=XAHXh5Hs9Yf1D0y8k4hVcX44yYzahufQphvcHmKqLqDWRMYld/HR/Jl0T9NWrirEX4
         IRpvOq8MvKPun/xD+rlCGh9TDajaSE1AZ/hwg+XQAy8KWpmy3yy787xF3aA8MieaKz18
         n0iPZvvbDaQH85p6Jd5l9lsMT1eYU3SpgKKegbPrbbIXJn+lQKIR0N+CLXN9PMWV0/9l
         LpdskCohUwIDn04iA2wZABwBjHMTeuUsKNHp2O5l7zCB8Jk1TVsn2enejAj2amw25NGu
         aBDKqa8LPgpIgGHUVEt/crRp6NhPMN96uvwOJTvQ4GiKLP3YA0qWiJuqCjI+eN/5YBLA
         2vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726992525; x=1727597325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3FsihmhCrs+dPbCmmFqmu8S8SyW6nS0IMPoboRbafg=;
        b=bSY6JJEP4ttDdW+6bWMA7OgbCtOaYmJA9JLEcthHmNpbh/BUUee7/C0HWXiDPW8Fxh
         /sc2svoonMFHgm44gTkwPr6rq8AxVkrlShs08Tuc0sE63Va0kxSrNGJJZGfl3aMnwbaY
         X2Rw61ClRMV8eGdSj2MY2hr8/K5FTGTQyKe/zcbHuIvVyLLtS7LIPNiYm2z8m99KTAqr
         vDCVOiCbtAH1qTmn13eY4KQRjVcbgDJ4PNYRE0KsEmiIGVKnI9ghG9L1Y/+UkemRVADi
         vn0Mj/ofkuABELhG75EEvayFzIsAfJ86KiFrx8+tILBnvWGR6Z/itbQbq7vqxI+cQk09
         oWTg==
X-Forwarded-Encrypted: i=1; AJvYcCWFup+c9RWhKYcxa734QtIpw+Nqm4CzU8kbkUakjT8+w9BajIKTwoQgiarJYgUgrCyZSUmASI9D3iJbZ04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94kFRX7fyglkOVYGv5Ac+BzmJaIc27Tr1kojtP47cLuBSIjhT
	CiBDnSsheI+5dnoUfyj7yr8aUfEISOaPgvnBnyCySIJ/urdwfDPK
X-Google-Smtp-Source: AGHT+IHpk0Bc6lWPro4iLJbr05T92LGyxhPyen4ubXkfG4rEh2xJJ1L+/TSCfeFZkozx8z949PNa7A==
X-Received: by 2002:a05:6a00:3e08:b0:718:eeab:97ca with SMTP id d2e1a72fcca58-7198e243aebmr20456882b3a.2.1726992525347;
        Sun, 22 Sep 2024 01:08:45 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7afc5sm12214321b3a.122.2024.09.22.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 01:08:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH RESEND] mm: shmem: fix data-race in shmem_getattr()
Date: Sun, 22 Sep 2024 17:08:38 +0900
Message-Id: <20240922080838.15184-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got the following KCSAN report during syzbot testing:

==================================================================
BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current

write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
 inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
 inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
 shmem_mknod+0x117/0x180 mm/shmem.c:3443
 shmem_create+0x34/0x40 mm/shmem.c:3497
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xdbc/0x1f00 fs/namei.c:3883
 do_filp_open+0xf7/0x200 fs/namei.c:3913
 do_sys_openat2+0xab/0x120 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1442
 x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
 inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
 inode_get_ctime include/linux/fs.h:1629 [inline]
 generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
 shmem_getattr+0x17b/0x200 mm/shmem.c:1157
 vfs_getattr_nosec fs/stat.c:166 [inline]
 vfs_getattr+0x19b/0x1e0 fs/stat.c:207
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x134/0x2f0 fs/stat.c:315
 vfs_fstatat+0xec/0x110 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
 x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x2755ae53 -> 0x27ee44d3

Since there is no special protection when shmem_getattr() calls
generic_fillattr(), data-race occurs by functions such as shmem_unlink()
or shmem_mknod(). This can cause unexpected results, so commenting it out
is not enough.

Therefore, when calling generic_fillattr() from shmem_getattr(), it is
appropriate to protect the inode using inode_lock_shared() and
inode_unlock_shared() to prevent data-race.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..9beeb47c3743 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1154,7 +1154,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(idmap, request_mask, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
--

