Return-Path: <linux-kernel+bounces-332338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C4D97B885
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAAB21847
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB916BE39;
	Wed, 18 Sep 2024 07:28:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807682890
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644510; cv=none; b=o1BhX0AzBhoYU/pK9Rgs0LiI+V6tzEk6JNLE/Pzn/k4XlqFbNKa7GQHh/3p5cTR6kP7QmS2E2KRfG3lNTZMtUwW4OSLn9N8FHc0KRKi4EQ54jjtHhewl2TH8KYwteJ2tdIRHlE9jlPg00lAVnC87ORpX9EUa87utNXr1jkQlRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644510; c=relaxed/simple;
	bh=quudFG6ATJVC+73WT7CSi1zGKFnZkl2FtqkvdJeN//U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nRsLpI7PTOk6FY3lVyVxlfGzyh1lv0BLbiw60Kx/eHU8GxD30+ZAunbpUAH4GhRoopZRhwBk7qZFfTY/GA3lyUdRUPrO+iI1gsOSMUzA7PfxqhZlz9ucgoBN3E1t6R3NoPD0MgySkvYJAgZ7rxZmfLeFI4jhvyJ27jH3835d8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa3ff05b9so139794039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726644507; x=1727249307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49Qyapllfd1/wfnsaMvYUaS0OYq6dOLB8t0ucGwGY/I=;
        b=f6RhqbqxBlxP1fmRdslrIZT4BK4sIvRhXB7xhJHYmAGpvwXmYOYaXp4SVtKbDh0Cj7
         fFUG+lAOU4HMbnZc3CLNHXlvzp1c6uMg612s3MXUGLwkY+z59s7jauy6jc70wEofn4rb
         AiihblQkPtrjzyTZoD1LoGJ0NiVV35GCcFgO8WOOdDkGdS/XDkpeLiT1Hqq5m22AZTtI
         1ZWGhIdTcNSuSrE+bZefndBGQovK9aaJZ2bQKpwIcVv/EuMl6aCotbG7PYURTaIQPN+q
         oq6yASGW4oDqlCNIWrpMtGe0g0U7D0x8ZNVII0LGKoJtEegnt8UQnS1EqasP+o+N8bbW
         ocOg==
X-Forwarded-Encrypted: i=1; AJvYcCX888wwhfNGmHWcDlBLSwV5BfVB83uX4Yw88ToZWqCmwKXut0h5NM78MexlUve8N6L0M1fXH/ZQGrILY7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4Eu9CPgqxbudpEYctGnyJHAWzSS12zTcyYt1x2SpbkpW6OYs
	d681NodpzzF0Sjmf7DFN2kr/0VQOuVzjXqQ084WrvMuvazvRSPA+BuSmXbn/SLrzzIh7Rpgr7RT
	BjeeZQJT8910j0FNLzuC1Ce1qViMxBK7l2k5Na9eP2PEl+D62d81UaVc=
X-Google-Smtp-Source: AGHT+IFgDwejasYFP804i7/Yss/h5titdQpltfBp3V3sbE9l7c4VLZ378xYTOfwe1XABh8jCCYHvBJpzLkXODuegY6/zSuP3dhBB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aac:b0:3a0:57b5:6b66 with SMTP id
 e9e14a558f8ab-3a08495a5dfmr61363025ab.7.1726644507591; Wed, 18 Sep 2024
 00:28:27 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:28:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087599b06225fc0a0@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_journal_flush_seq_async
From: syzbot <syzbot+d119b445ec739e7f3068@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14a284a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=d119b445ec739e7f3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a9869f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a9869f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a5dce0e82b0d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d119b445ec739e7f3068@syzkaller.appspotmail.com

bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
requested to flush journal seq 36028797018963972, but currently at 14
WARNING: CPU: 1 PID: 6404 at fs/bcachefs/journal.c:672 bch2_journal_flush_seq_async+0x668/0x6c0
Modules linked in:
CPU: 1 UID: 0 PID: 6404 Comm: syz-executor187 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bch2_journal_flush_seq_async+0x668/0x6c0
lr : bch2_journal_flush_seq_async+0x664/0x6c0 fs/bcachefs/journal.c:670
sp : ffff80009cb678e0
x29: ffff80009cb67960 x28: dfff800000000000 x27: 1fffe0001bb69537
x26: 1ffff0001396cf20 x25: 000000000000000e x24: ffff0000ddb4a9c8
x23: 0000000000000000 x22: 1fffe0001bb69539 x21: ffff0000ddb4a9b8
x20: ffff0000ddb4a380 x19: ffff8000927b7000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800083032784 x15: 0000000000000001
x14: 1fffe000366d7a5a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : ab30ddaea468da00
x8 : ab30ddaea468da00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009cb67038 x4 : ffff80008f65b620 x3 : ffff8000806051a0
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 bch2_journal_flush_seq_async+0x668/0x6c0
 bch2_journal_flush_seq+0xe8/0x280 fs/bcachefs/journal.c:759
 bch2_flush_inode+0x220/0x390 fs/bcachefs/fs-io.c:185
 bch2_fsync+0x1a0/0x44c fs/bcachefs/fs-io.c:205
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fsync fs/sync.c:220 [inline]
 __se_sys_fsync fs/sync.c:218 [inline]
 __arm64_sys_fsync+0x178/0x1c0 fs/sync.c:218
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 71336
hardirqs last  enabled at (71335): [<ffff800080388420>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (71335): [<ffff800080388420>] __console_unlock kernel/printk/printk.c:2801 [inline]
hardirqs last  enabled at (71335): [<ffff800080388420>] console_unlock+0x18c/0x3d4 kernel/printk/printk.c:3120
hardirqs last disabled at (71336): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (70998): [<ffff8000800307f8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (70996): [<ffff8000800307c4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

