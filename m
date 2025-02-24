Return-Path: <linux-kernel+bounces-528312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5009A41622
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB4D16C3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F1240610;
	Mon, 24 Feb 2025 07:19:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D51891AA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381566; cv=none; b=kHgrOxadtRMOXlfupQVn86RsRC8eoto4FY3LVBlh9JvTQch0IWP3eSdjO12JOrsyIlAq9JwQpJJea5pmbWokQLM87uCZQf9MfdJIY5D9+finv+RWdf04AO9VJAIC6h9yJP+dGf5tJYzYPLMv7dXGdtbSIO9O6XeyyD6kaZR/mak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381566; c=relaxed/simple;
	bh=0uJbn71cDREIut6aW9DSundgpH2t2lV86CeMP7GozNM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o2ueqS8G7UZ5Rmt3ucgRvxQoQYqtA4oJJM+jMTWKGoJ7cSfQnisM+djiQeh2z1XKYTt1Yxn5zloevHsmxoTVma/ddikZq4FtT7vYGNtnkYB/t2YucuWkWqEWE3JLZ1acHSya2go0G5cBXBEOCXSHCIUbD36SZmkdlJDby6ve4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d060cfe752so32781525ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381564; x=1740986364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AB8UU/MfSjsKfvUTLzniioAspdMinQ/5oUQ7XX3COHM=;
        b=MIrFc6vUHdKIx26+ShQN3fbcnDmINt9oC8DJQMUSj1wJF+4D4l1QgBkBW/fwCFbuk6
         OVt3OJU/ICeR2lDEKniow8WCMcSkGL0DYzz545dzj+zUVWTfVmRk/Xzk1GMpKatnkZ4t
         LLWNWMwwQ79BWidZvJiA81oa0rKf9CyO8CupLen10tn7yhTZSGU4s+oz37QmAdGSEPHi
         9DfUQlT+Lj4vN4MhyIvz5heH4s6MA+OKhNII6JAYs4gmdsvZUZuPDMEFHS7a7BR+UM1c
         aEPSsaUTbENQH7mjqFzOYTR5w4Gj0jTJb8p+DbxBpATuxtBfndAnSETY0DV53ZEEWmg5
         yiRA==
X-Forwarded-Encrypted: i=1; AJvYcCUTJ7E/QAwiGXj8ifAYuEbSvVOGUHpxBNIW3ywTR08muUZA+Y86NvzA16tH5Gu8SM3aghdtrRBrRz0VH5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRLWBOTidL8NfaFkTnWvvDrRR04o3/JtzS4XnZomwARqLbapf
	8TFBpqhsp5RSzBpxvVPS9Prwgolz4k7tngnUqJsxrY4FvVk9HB4B5KagwL7UzHPAtMd1JAoIUEj
	IOL9Z1muZDHpKO+ZXX22nDS/7DHBK1vIQRUlMBn1DrBhr1vwdQV2M4kA=
X-Google-Smtp-Source: AGHT+IFmf6Og2sXFMIDQxDSf8J/a1KYOGrdPptHe7pxCfNc/c/DoiIPgi0fB43E7yYkzBDI7PXoKKi8+IFToCYujS0v5X8KoyW9z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3d1:966c:fc8c with SMTP id
 e9e14a558f8ab-3d2cb514b1emr109060995ab.17.1740381564438; Sun, 23 Feb 2025
 23:19:24 -0800 (PST)
Date: Sun, 23 Feb 2025 23:19:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc1d7c.050a0220.bbfd1.0046.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: user-memory-access Read in dqput
From: syzbot <syzbot+49423de13afd058db22f@syzkaller.appspotmail.com>
To: jack@suse.com, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27102b38b8ca Merge tag 'v6.14-rc3-smb3-client-fix-part2' o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e6f498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=246f46d6db29b555
dashboard link: https://syzkaller.appspot.com/bug?extid=49423de13afd058db22f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1d3b8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128fcdb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2324227e5d74/disk-27102b38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10e721e73827/vmlinux-27102b38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a3889279a6e/bzImage-27102b38.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/63597cabd128/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15ae27a4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49423de13afd058db22f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: user-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: user-memory-access in dqput+0x79/0x490 fs/quota/dquot.c:868
Read of size 4 at addr 000000000074020f by task syz-executor195/5828

CPU: 0 UID: 0 PID: 5828 Comm: syz-executor195 Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe3/0x5b0 mm/kasan/report.c:524
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 dqput+0x79/0x490 fs/quota/dquot.c:868
 dqput_all fs/quota/dquot.c:422 [inline]
 __dquot_drop+0x20b/0x420 fs/quota/dquot.c:1608
 jfs_evict_inode+0xbd/0x440 fs/jfs/inode.c:167
 evict+0x4e8/0x9a0 fs/inode.c:796
 dispose_list fs/inode.c:845 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:899
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1413
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 ptrace_notify+0x2d9/0x380 kernel/signal.c:2522
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd7fefe407
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc5f71e678 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fcd7fefe407
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc5f71e730
RBP: 00007ffc5f71e730 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffc5f71f7a0
R13: 00005555914236c0 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
==================================================================


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

