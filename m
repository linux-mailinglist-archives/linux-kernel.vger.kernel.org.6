Return-Path: <linux-kernel+bounces-423888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA739DADEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C072849B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF8201270;
	Wed, 27 Nov 2024 19:32:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A8201116
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735952; cv=none; b=ceSim2xbFTLb0cMRjVQXceN0t9MxCJPta0T/255Y85PHtVzCTXb6scuKdwtTgOnyLTdZoKWrJSvGVDpGbCJUUtBqAdq56jgc2AT1h5PVZUOIEHAJuyWaStCAvBkx4hU/yj3Xaw1j9iCYDVPojfmWm+ZEJ1IVFBNXh/tSvuriqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735952; c=relaxed/simple;
	bh=RIGEfs9cNJ/9uv+5pAUE8pSQD4FYzRXcbgOfF0nVgqA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GmW5FBMaNwUWXMwRBRPIbfI7XsujllHQu8lfej75FfFw2wZ/HP3I+SBcYfKDOPAykxQIerPHOx4wYc9HL4bbxamKbsHFB1uJmQRTao9SDDxNWid5hJ8CykmL2bvvd/0kHcXX/gK88wuJ4IpUdewfPx3BPuT0xnGRQCs9gJdMKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a768b62268so595385ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732735950; x=1733340750;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NFRVBAF5tccxDKcM9k5a2o73zbgAoDuTHDRA7ssiBA=;
        b=L4OQ2qB0mXKKRpUzjnKhuz+Fs6XLVzVQ5PunKB8vvFiJ5wjr23hAV03kplflVTphJU
         OgrzEInlCiGdNGYlu/EiuNdzoaM0HLRMFrbtvvk6gCpopvOE+HhZ1/nJ/YkOldTPQjC7
         sd6wW1dTl+/XuT43MU+ZIuj2qaqWMmPEjw6bnj7SySHc2MD4YPupWXiLuQMZNgOe9fjB
         3qPySRwCVPmXKWld1FX0/lmmfjIp3e5ru6uU+gBNbV83iLLvY6WAt5ufKa77HsUEyrxj
         2Ll3S2T/gU0rup/WTIaUQw2iDNMaS90L+/H6W0F/ZMOMkqYSchEV2d4gl627ElQ3AeYU
         OoKg==
X-Forwarded-Encrypted: i=1; AJvYcCXYq69iRX4zhCbJs2p0ENg9gBCxuzyeERBSrtqEZqISbIaU3wDLvXQkYZyHq2yVbGgobvgm/Wemp8cAl4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMT0/M+zrzc1W21f6XhxKAX/kNZ9D8uXkR7NCIQbqaTEAiaIf
	c4NPv1Js6cod7+E4Ra18DrR8vFT60BcO5h4/QI5sOi+7HzkKGtDIUekvfc6E9KxV6DW6CxYaG2Z
	oiFaDvMYljOoH+71g36RIpGRrBNDf1h01EHtimvl2GpnsxyxCVsS2ZY4=
X-Google-Smtp-Source: AGHT+IGbZHRFmksDmqi20oW+VFs2UopXzQs78egsJs6/YZom6e5Wu2t+G1qo/c0uxnF9JbE1+f66IQz4Mxua0OWUY1bBUGJHzaqg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3a7c5567d12mr44645235ab.12.1732735949811; Wed, 27 Nov 2024
 11:32:29 -0800 (PST)
Date: Wed, 27 Nov 2024 11:32:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674773cd.050a0220.21d33d.0027.GAE@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in gfs2_quota_init (2)
From: syzbot <syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=140fe530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce1e2eda2213557
dashboard link: https://syzkaller.appspot.com/bug?extid=9fb37b567267511a9e11
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120fe530580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119ae778580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fcdec73c0f3/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4dc8d1847e1/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db0e04822d2c/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c42d45c3f3cb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
syz-executor205: attempt to access beyond end of device
loop0: rw=12288, sector=2251799813685248, nr_sectors = 8 limit=32768
=====================================================
BUG: KMSAN: uninit-value in gfs2_metatype_check_i fs/gfs2/util.h:125 [inline]
BUG: KMSAN: uninit-value in gfs2_quota_init+0x22c4/0x2950 fs/gfs2/quota.c:1432
 gfs2_metatype_check_i fs/gfs2/util.h:125 [inline]
 gfs2_quota_init+0x22c4/0x2950 fs/gfs2/quota.c:1432
 gfs2_make_fs_rw+0x4cf/0x6a0 fs/gfs2/super.c:159
 gfs2_fill_super+0x43f5/0x45a0 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2344 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2351
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1009
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1951
 gfs2_getbuf+0x23f/0xcd0 fs/gfs2/meta_io.c:142
 gfs2_meta_ra+0x17f/0x7b0 fs/gfs2/meta_io.c:532
 gfs2_quota_init+0x78d/0x2950 fs/gfs2/quota.c:1429
 gfs2_make_fs_rw+0x4cf/0x6a0 fs/gfs2/super.c:159
 gfs2_fill_super+0x43f5/0x45a0 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5797 Comm: syz-executor205 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

