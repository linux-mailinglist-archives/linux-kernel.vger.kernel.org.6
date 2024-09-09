Return-Path: <linux-kernel+bounces-321365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BB971968
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16C11F239BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF31B78E2;
	Mon,  9 Sep 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4T1W2Kd"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9D1B375C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885372; cv=none; b=ai4Boa9lVpMn896SPKnEG84CUObVfVjd7A3GyuiTS5iHOXWH/0ygFDYmjDYwB9zFb0E0ER2az/5ATnTwKljAjWtkbUZmDjxcuPhH7qijFYFL3z8VB1HwoyLE2WxRNbQUOrje5GmBbHgTUHV7WvZZGefc7VLsSBqKPFhBurSzliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885372; c=relaxed/simple;
	bh=bVr7v07kBdbfWKQdyxbRWrItPMObhkNqpjGJIx5SzFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WfPQ3/ZH/eUzv9WCZOa1vo1utVePcLSYH2pUb99vwPUAu47zRWmzVWkUq7jRJ/UgZX/hM4A3UIUT6eurSC+tAf0joSgthsIBTkZXg0ofYRzx6ZJW57qQFIgmYXAyT+SR9qqpXOjJ7KngJIVFp6tK+uetDP/XzgQoDLtLzjt8OX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4T1W2Kd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d86f713557so2783493a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725885370; x=1726490170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfypXLGaZAPVclPLNzooswj67p19isoIT0RiFOw1X2o=;
        b=I4T1W2Kd4ys4NP+7CsQncEhaWQ/AyxTLH5adQuXimior/AWVRaAr/qKhZ2T3t9I8+W
         zi6/X83rXvBtcUhoWlppIdN46asmzlcvhwY55aGJ1OfB6G9IE9LZ5uxW/fIBcUhTRjeZ
         H48sYO8+CZEXQBpdV+RYRATf4Tii36ZkNt13aM/jL4e7JnaKmhI8gi2L4NAZCLikc5c5
         M3fJBeN4UBm8A7zO+FRSeKP6MJm0GZmjRqWJCKrl0Bc6raKxdE16U9OkBiij/GdCO5Fm
         M3OvgokCEbD67CZP5N+sHVMKkbjka8mfW2y281PpVnKMxRTzC8W+6bXHxh1HCbYaLp6t
         77Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725885370; x=1726490170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfypXLGaZAPVclPLNzooswj67p19isoIT0RiFOw1X2o=;
        b=n6S3oj9lDYIMK/0sErlLv2KAO5bRIA4WAfFkcn/n2lD3EpNKAvzptG2z6eYu4Ocpiz
         sN0PAJS2NItsojDKtnR1dqGIQndrZkG4SwajgJNEXy5omnyeSczg1O+xD+sJ4gS8A93H
         XqpfL95GRQ9V4Ppfl6YStzxs8fYRTfGPPIwgK1T9H3s/f/b3Ep24xSEV4KyZEj5NhtBP
         t8PbFt0CWqpCKsXjsgn5htq+qzorZQIynSbJwKUc+j7T8iZ2+iY+M5EMg7J9W+A6CZg+
         2xIx0vQPQIAZIHkYZDyo7IWbOInqoJt8TLoe7oHSggb46k3CPxKGZqPlevq0Gl+agR/8
         Eh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqIvwHNRwEMrlzi4Uzc4v+kQ2yD62K2dpCGKBDjWzYbSRe9XZZvY0YlTrmoAGJrkrVT2/4Nsrz7GChJ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/33fewtWWHlsr0S3+vJgOc5L2Hi565Q3It7LNsMhDheL34o4
	5Qn+PpjCMjDK0EN+dOg6qAwoKvZg8B+wSpE+sDTOVWOOsdg0jRlg
X-Google-Smtp-Source: AGHT+IFTlbXzR0Bbw7kRJfnzor6ociJNUZaXmtN4Cv+Nm/YlTlMIuS2+sEqY91krmH+w93FB2YuZ8Q==
X-Received: by 2002:a17:90b:681:b0:2d8:8bfd:d10b with SMTP id 98e67ed59e1d1-2dad50cbe2dmr12937786a91.26.1725885369547;
        Mon, 09 Sep 2024 05:36:09 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadb42e6fasm6583860a91.0.2024.09.09.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:36:09 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: hughd@google.com,
	akpm@linux-foundation.org
Cc: yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzkaller@googlegroup.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: shmem: fix data-race in shmem_getattr()
Date: Mon,  9 Sep 2024 21:35:58 +0900
Message-Id: <20240909123558.70229-1-aha310510@gmail.com>
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

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================

Since there is no special protection when shmem_getattr() calls
generic_fillattr(), data-race occurs by functions such as shmem_unlink()
or shmem_mknod(). This can cause unexpected results, so commenting it out
is not enough.

Therefore, when calling generic_fillattr() from shmem_getattr(), it is
appropriate to protect the inode using inode_lock_shared() and
inode_unlock_shared() to prevent data-race.

Reported-by: syzbot <syzkaller@googlegroup.com>
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

