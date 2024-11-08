Return-Path: <linux-kernel+bounces-401933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786919C2146
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BABF1C2364C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177721B438;
	Fri,  8 Nov 2024 15:57:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8E45023
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081442; cv=none; b=OXxQAt3+Q0QCBfj6D+Pc02ZUTVt9nSg6Xfj3NKW7uqIkzFrXQ2Tul5NDvEgEG4R0SuJbCYGu+ZoRJE+UkfQezx6gCLHm+nR6UfUr/cxF9DHbLIFmZVll2Su+xlFsM0hjA72d5wZfxFGsHUEq8wAKmqM7/iqIf/iytzascqX4gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081442; c=relaxed/simple;
	bh=uzKoC6b+OvrKWbR3YzIHa2s/k1vfUkV/CpnXUOonalE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BA4QEnw0Pg5RyuOtLN84TmgMSJuHyM8a8B5yaTsFkDjNs/mqUv0gRo+RqMuR/tYJJGG61C47Wo8VpSHwuczs4G+e2LpzWqjYJLjxsWLwm9EMp9WwmxBY++OhMwdDMYs2nw9WtDoSe/eAyDMq0n0AsW4grBitbzJPpc5x8nSCvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6ca616500so23938515ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081439; x=1731686239;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z92hq+mdvzIgj8A1Sm4l7qrUAdpf5cA/4n0IdFWGt1w=;
        b=extdD5AFPEDhKE8TJzG7XY+cHmTudygEVPNEHFjaSP8VmaII+FV23Pil2NHeoN9ZuW
         9oPduMu4iZ9L7sW9TLTtZrFag1YMsFYftg0EtKSFtzswtrA5sEKBxZHfni7uGWsq2dlm
         /jbaiZJnXGSV9okDt50jG9jDo7K15l9wOdGPct5NSAMmTMoO44VgKZ/au64GHH6wzzuV
         eJ2iVLzvi9S/NjzFhsxAp6QnR93/nwPetvwOrR7jrWya7PXyPCP8mtP/wanCbJ1kwpaA
         gSpbOv/6vSm/bEglfmFp/nSHyuPu7iuXYMSP8aBgLVvvFU7pRGCiWd56AaIO+LmdDzAn
         6J9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdUi+NWtRLjgI5Y9gVpmZn0pAas4azqzfIYbTGlwk2dhIF/yxuFzdPT5qMt9+TKGCUGvFSQQvOb2H5K8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIZNSg8rWX0wMyvYEA1M8/QqO96TQv7Zc5aGbPBeVKf//2fjc
	//a7oRuVreno/OhTShahW4Ky+mAAhDtVU9kgz27NaD0NOWQqFnDfHiFGR9Hs8padINTbzM3FYag
	DXdSfme8c3m/P/uwQvI45K+B5sStNfJ1wRzPflLgCjyErlVIHos3lxsw=
X-Google-Smtp-Source: AGHT+IFArS9nGKOfzFmGQTNfBWyi/ThY3w2I60LrhBVAhwGUTuFEn6xK92wtf9/WSdcvuOb/00WTDBRrtFFOQK4jqEghkYaAXQzh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a6:c89d:4eb5 with SMTP id
 e9e14a558f8ab-3a6f1a22da5mr36540515ab.15.1731081439253; Fri, 08 Nov 2024
 07:57:19 -0800 (PST)
Date: Fri, 08 Nov 2024 07:57:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e34df.050a0220.69fce.001a.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_rechecksum_bio
From: syzbot <syzbot+50d3544c9b8db9c99fd2@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1693f630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=50d3544c9b8db9c99fd2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1391ad5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e546a7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b98f620edf1/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5d1377ba568/bzImage-59b723cd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4854d6cc2b6a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50d3544c9b8db9c99fd2@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/checksum.c:424!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5323 Comm: bch-rebalance/l Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_rechecksum_bio+0x148c/0x14b0 fs/bcachefs/checksum.c:424
Code: 48 89 df e8 76 b9 d7 fd e9 4d f9 ff ff 89 f9 80 e1 07 38 c1 0f 8c 1c fd ff ff e8 4f ba d7 fd e9 12 fd ff ff e8 e5 f3 6d fd 90 <0f> 0b e8 dd f3 6d fd 90 0f 0b e8 d5 f3 6d fd 90 0f 0b e8 1d 50 a0
RSP: 0018:ffffc9000d186b20 EFLAGS: 00010293
RAX: ffffffff8426e67b RBX: 0000000000000007 RCX: ffff88801e00c880
RDX: 0000000000000000 RSI: 0000000000000018 RDI: 0000000000000008
RBP: ffffc9000d186e70 R08: ffffffff8426d688 R09: 0000000000000000
R10: ffffc9000d186d40 R11: fffff52001a30dae R12: 0000000000000018
R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb8ac5e0b8 CR3: 0000000011c00000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_write_rechecksum fs/bcachefs/io_write.c:776 [inline]
 bch2_write_prep_encoded_data fs/bcachefs/io_write.c:877 [inline]
 bch2_write_extent fs/bcachefs/io_write.c:909 [inline]
 __bch2_write+0x2f7b/0x5dd0 fs/bcachefs/io_write.c:1461
 bch2_write+0x9b5/0x1760 fs/bcachefs/io_write.c:1634
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_data_update_read_done+0x22e/0x330 fs/bcachefs/data_update.c:426
 move_write fs/bcachefs/move.c:133 [inline]
 bch2_moving_ctxt_do_pending_writes+0x44c/0x8d0 fs/bcachefs/move.c:164
 bch2_moving_ctxt_flush_all+0x1c3/0x2f0 fs/bcachefs/move.c:179
 do_rebalance fs/bcachefs/rebalance.c:379 [inline]
 bch2_rebalance_thread+0x1a87/0x1fc0 fs/bcachefs/rebalance.c:401
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_rechecksum_bio+0x148c/0x14b0 fs/bcachefs/checksum.c:424
Code: 48 89 df e8 76 b9 d7 fd e9 4d f9 ff ff 89 f9 80 e1 07 38 c1 0f 8c 1c fd ff ff e8 4f ba d7 fd e9 12 fd ff ff e8 e5 f3 6d fd 90 <0f> 0b e8 dd f3 6d fd 90 0f 0b e8 d5 f3 6d fd 90 0f 0b e8 1d 50 a0
RSP: 0018:ffffc9000d186b20 EFLAGS: 00010293
RAX: ffffffff8426e67b RBX: 0000000000000007 RCX: ffff88801e00c880
RDX: 0000000000000000 RSI: 0000000000000018 RDI: 0000000000000008
RBP: ffffc9000d186e70 R08: ffffffff8426d688 R09: 0000000000000000
R10: ffffc9000d186d40 R11: fffff52001a30dae R12: 0000000000000018
R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfaf9ff000 CR3: 000000001fb7e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

