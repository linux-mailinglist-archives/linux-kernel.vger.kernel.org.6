Return-Path: <linux-kernel+bounces-309665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CFE966EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16665B2309B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA245009;
	Sat, 31 Aug 2024 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5tgvcG9"
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172082E405
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725071917; cv=none; b=bLcpz4uCd8eDxtU9bSS7lGiazalFiUbTptiSmGBh6u462/vevGlzC1RlVH35G9YCIpOzk0Ab2+tQNrgGzDC3SQgIamclyBY91bK8tx7lnaAQc+CFOm83CXiaA6KxGgT00a3H4urQ93jIVBqmtkd3qF0ZX+uxXmFCJxkMQbm4C7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725071917; c=relaxed/simple;
	bh=PG3U5H7vwlb/RcTAXZNzHcUER7odcs7WGoGi8f+QOHE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tkSJautiQ3RQvUc1wEICromDuUeMltxF39xt3RXFgDHEMqWP9rtCgWUl255A0U9eYVUJo48f2hztyxA9d37vRTum/MIPGJLNdUXUNyXS3wBITycvgejAX2Pohguz29v4PGiSYzFhBUS/K5cEmZbYWFT/vJSVzhUHh4WewVITLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5tgvcG9; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-4fcff944d1dso677757e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725071915; x=1725676715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PG3U5H7vwlb/RcTAXZNzHcUER7odcs7WGoGi8f+QOHE=;
        b=U5tgvcG94P3eiEFA22EsFaAacBOWVVnrlyrIfV+8vJN5OjJ4zH1R1xqgQ8W09Oh6PQ
         wJMc5/MDlM6wgdeW2hnWFhH5BelJ9cHj4sgmzGsY13B9ou5t6q31amJZ/rsIXxCWblVA
         g+scRHrhxip0tKzGDiIwOnkokgR8KkVFw0XgHEDHh637yOXN4bxAY5yagS4zlW9KH3W4
         OVZsAadHA9UDsSU5HdQ68CWw7l3O5JuemR2AEyZ6oO2fp+MGBRY2mYWA91SXI8PaDVyB
         cTpXgXkmvjeDZ5xKbq2rsUKRBkVBpgvP9lTnr1pqXH9bnwT5Sn1xo/MQK7VRhT2GWiC4
         qHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725071915; x=1725676715;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG3U5H7vwlb/RcTAXZNzHcUER7odcs7WGoGi8f+QOHE=;
        b=jv+wl+N6wv+EqZofwO/B73YPBkcMhYCX8oqhIc2oCJeJzITVxtoHyvPKlfS4zbUeOn
         QzDuZLmmnGGHm3alnSUwrG+VY7vAu9HUnEdHdLGkAwtxSyleaQXs6/Bx3VJnaSZn3m8/
         rNB0Sw16EsS7tblO6GNMo8xA94gahMUj4iCSRZr2g+qSsmIjgI8UbshDimCkJSymyr27
         M54zWB/3uSAlpdNtNbqJxXxgcYrhFIuXdMtVFnGOEmaDOySszKiSj0Ps5sNpROnSOua0
         7lDLBjD9ZNtufSunkAB4WhEnT/hG6IK+yYwLNeO5+vNVa4kzh8n6/r14ZLX9Iw0k8s+n
         JZkg==
X-Forwarded-Encrypted: i=1; AJvYcCVbM3gaIKD06Z4AWCjZlQQkw6gfLOTsiFjWZ7lQgmQ+aO4tcHy54lv0/0s6iq/e6uXNmx00AJitW0KXhtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3gUq8P+XYRKqvsNAb2KayN3AbA+IvGzbDKBxVxGuWA7Emi9k4
	/LqfGA5O4FG0dCu2Yr3VTUWy5iNvkR/220jZ/eQUNcFzktASrHWrB6GxEXTYjewphijGjSB2kX2
	Ab/PK05Z2mmTXbMShcwYElUCfkh4=
X-Google-Smtp-Source: AGHT+IHIC/QAnFC3t/yasHNAaOsxF4Cm/UqgySqL2shtYQwUtb0BoPGDcfNsBVOa6x/7O+Re/+FeljfblzRShjTAE0E=
X-Received: by 2002:a05:6122:20a1:b0:4f5:2276:1366 with SMTP id
 71dfb90a1353d-4ffe4a58f0dmr9000808e0c.3.1725071914691; Fri, 30 Aug 2024
 19:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Sat, 31 Aug 2024 10:38:23 +0800
Message-ID: <CAHOo4gLpD0G6e9LAb3b8tRaEjcw1vo3TsqL7BV8ouv=dtnsJEw@mail.gmail.com>
Subject: kernel BUG in gfs2_withdraw
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
we found a crash "kernel BUG in gfs2_withdraw" (it seems a bug in
gfs2) in upstream:
This bug seems to have been triggered before and fixed, but it can
still be triggered now.

HEAD Commit: d5d547aa7b51467b15d9caa86b116f8c2507c72a(Merge tag
'random-6.11-rc6-for-linus')
console output:
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/log0
kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6.11.config
syz reproducer:
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/repro.prog
C reproducer: https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/repro.cprog
the state file of fs:
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/mount_0.gz

Best,
Hui Guo

The following context is the crash report.

gfs2: fsid=syz:syz.0: fatal: invalid metadata block - bh =
1125899906854035 (bad magic number), function = gfs2_quota_init, file
= fs/gfs2/quota.c, line = 1432
gfs2: fsid=syz:syz.0: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:340!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 12970 Comm: syz.1.390 Not tainted
6.11.0-rc5-00081-gd5d547aa7b51 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:gfs2_withdraw+0xf32/0x11e0 data/linux_kernel/linux/fs/gfs2/util.c:340
Code: e6 e8 52 02 d2 fd 4d 85 e4 0f 84 5d ff ff ff e8 e4 fe d1 fd 4c
89 e7 e8 ec 3a 36 07 49 89 c4 e9 13 ff ff ff e8 cf fe d1 fd 90 <0f> 0b
e8 c7 fe d1 fd be 08 00 00 00 48 89 ef e8 2a 3a 2d fe f0 80
RSP: 0018:ffffc90017a8f6c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88805ab0c000 RCX: ffffc9000f4d1000
RDX: 0000000000040000 RSI: ffffffff83b80071 RDI: 0000000000000001
RBP: ffff88805ab0c0a8 R08: 0000000000000001 R09: ffffed1005885179
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000001001 R14: ffffc90017a8f750 R15: ffff88805ab0d1f8
FS: 00007f0c2d8db640(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc52c957a8c CR3: 00000000633d4000 CR4: 0000000000750ef0
PKRU: 80000000
Call Trace:
<TASK>
gfs2_meta_check_ii+0x65/0xa0 data/linux_kernel/linux/fs/gfs2/util.c:501
gfs2_metatype_check_i data/linux_kernel/linux/fs/gfs2/util.h:126 [inline]
gfs2_quota_init+0xfda/0x1360 data/linux_kernel/linux/fs/gfs2/quota.c:1432
gfs2_make_fs_rw+0x3a2/0x5d0 data/linux_kernel/linux/fs/gfs2/super.c:159
gfs2_fill_super+0x2887/0x2c00 data/linux_kernel/linux/fs/gfs2/ops_fstype.c:1274
get_tree_bdev+0x378/0x600 data/linux_kernel/linux/fs/super.c:1635
gfs2_get_tree+0x4e/0x280 data/linux_kernel/linux/fs/gfs2/ops_fstype.c:1329
vfs_get_tree+0x94/0x380 data/linux_kernel/linux/fs/super.c:1800
do_new_mount data/linux_kernel/linux/fs/namespace.c:3472 [inline]
path_mount+0x6b2/0x1ea0 data/linux_kernel/linux/fs/namespace.c:3799
do_mount data/linux_kernel/linux/fs/namespace.c:3812 [inline]
__do_sys_mount data/linux_kernel/linux/fs/namespace.c:4020 [inline]
__se_sys_mount data/linux_kernel/linux/fs/namespace.c:3997 [inline]
__x64_sys_mount+0x284/0x310 data/linux_kernel/linux/fs/namespace.c:3997
do_syscall_x64 data/linux_kernel/linux/arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcb/0x250 data/linux_kernel/linux/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c2cb9b45e
Code: 48 c7 c0 ff ff ff ff eb aa e8 5e 20 00 00 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c2d8dada8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000003b2c4 RCX: 00007f0c2cb9b45e
RDX: 000000002003b2c0 RSI: 000000002003b300 RDI: 00007f0c2d8dae00
RBP: 00007f0c2d8dae40 R08: 00007f0c2d8dae40 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002003b2c0
R13: 000000002003b300 R14: 00007f0c2d8dae00 R15: 0000000020000000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_withdraw+0xf32/0x11e0 data/linux_kernel/linux/fs/gfs2/util.c:340
Code: e6 e8 52 02 d2 fd 4d 85 e4 0f 84 5d ff ff ff e8 e4 fe d1 fd 4c
89 e7 e8 ec 3a 36 07 49 89 c4 e9 13 ff ff ff e8 cf fe d1 fd 90 <0f> 0b
e8 c7 fe d1 fd be 08 00 00 00 48 89 ef e8 2a 3a 2d fe f0 80
RSP: 0018:ffffc90017a8f6c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88805ab0c000 RCX: ffffc9000f4d1000
RDX: 0000000000040000 RSI: ffffffff83b80071 RDI: 0000000000000001
RBP: ffff88805ab0c0a8 R08: 0000000000000001 R09: ffffed1005885179
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000001001 R14: ffffc90017a8f750 R15: ffff88805ab0d1f8
FS: 00007f0c2d8db640(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc52c957a8c CR3: 00000000633d4000 CR4: 0000000000750ef0
PKRU: 80000000

