Return-Path: <linux-kernel+bounces-385304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4649B354D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB25283178
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149B1DD9A6;
	Mon, 28 Oct 2024 15:49:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1D1D79A6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130572; cv=none; b=ocUqxdp16hrcrYz3TRN0G0FTKNeWN41FrRuFLr6Zsjugx8EC37lWNVIj75oMdELzc4adLKan+NppZgaaqA+TbS0unAuTjduA17F6SDKgePvHm1UIhGRogHNIFuu9ylMeB0eb5p+ciAoou8gqL8CjUpfF6ZjyL3naq0dZJRg7mcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130572; c=relaxed/simple;
	bh=LJoDKM8wjkvoLyCQBNn/d7JQttEMEDg9y5eEhYKUR5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KWJEwK8stiiLPnhqHAW8FuaEC/ngHxDIKBmcLy5A160VZbrwThFXc1guxx66iW3dqNiXrgrvSw+r5xwtZlNs253ScKR505uo+fIfERYoqO3nA8uepnKoLpyUpk9WOpldEdHKDGGNpInpd5tVjRHXQEhydtwXzBxAEDUZjev49fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f01d43c0so15871985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130569; x=1730735369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/I2AMnc2H7mVtlHflwpGDiImhQbiuif+aPXizJLpQ8g=;
        b=d4Mml6a2yPRazY1Bi8QAXJqYaXXkxpWtwscp33hx/4Ja6k5MNDkLuCWt1ripX85dXe
         46T4ssPSfnbZPYhPMY8LnG7v17WaJUHeC0etXAxGGz5xWE7Qqg9sG3jjQ6cWxQE7Jczn
         g0cBMAsX2O1vnYxm+IXtF887YIislSoed3J36nWa2xfnK4IJ6bvm0G1S2+SrdlahWyiD
         z+Mz7seqKkrNKb09v83ss3GUpvH3kVZcDq7IBqfuTyxshsXwYHFe0sMKcphiw+92o52H
         prw8aMVRBzBrPdtVVRmZoeJ2md88Cx9AUE5wubLm9Ei6AWjkYcdH29mxvFKF2BGmbPcE
         ZW+w==
X-Forwarded-Encrypted: i=1; AJvYcCXuDFHMf2G8sMLviWYJmwHiYQ8vjekbm6vmkWxvPdfXFwfjaGppOCy9YbvzVwTgGYxqULgOboN929tOi+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpAl4QnDbPmyRZICfciI9JmECOz8ZmbfbOnzVLrbu/kS+VoV2
	WOZL/Za9sDlUmBvNNgRefcr1lzUhs4PLeryqKo/32+hNogYyN0q+zVhcsssmNJ0QCCI8b8fIP7z
	zHkZbogjo+g546dIWRVDZUIrXOIKlIK/jl7YXQoci69nGXnECkMGxigU=
X-Google-Smtp-Source: AGHT+IH3/o0TupI98nogU7j/qQZ/nLvHyNkngezb9QE8qdaVud1eef0+C9APE1vWK8oaP4T4fks2+y4XuloxjEqCKG1lDkhafEIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a4ed2d0bbbmr64137145ab.7.1730130569372; Mon, 28 Oct 2024
 08:49:29 -0700 (PDT)
Date: Mon, 28 Oct 2024 08:49:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671fb289.050a0220.21b2f.0005.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_write_buffer_flush_locked
From: syzbot <syzbot+4aff7bdaa254c1d9f008@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126f1230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=4aff7bdaa254c1d9f008
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ddaa87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166f1230580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-850925a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c831c931f29c/vmlinux-850925a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85f584e52a7f/bzImage-850925a8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c55dd771077b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4aff7bdaa254c1d9f008@syzkaller.appspotmail.com

bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_write_buffer.c:147!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5308 Comm: syz-executor416 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:wb_flush_one fs/bcachefs/btree_write_buffer.c:147 [inline]
RIP: 0010:bch2_btree_write_buffer_flush_locked+0x5695/0x59f0 fs/bcachefs/btree_write_buffer.c:375
Code: 31 05 f5 ff e8 8c b8 70 fd 90 0f 0b e8 84 b8 70 fd 90 0f 0b e8 7c b8 70 fd 90 0f 0b e8 74 b8 70 fd 90 0f 0b e8 6c b8 70 fd 90 <0f> 0b e8 64 b8 70 fd 90 0f 0b e8 5c b8 70 fd 90 0f 0b e8 54 b8 70
RSP: 0018:ffffc9000d0de820 EFLAGS: 00010293
RAX: ffffffff84243204 RBX: 010000000000000b RCX: ffff88801f6ca440
RDX: 0000000000000000 RSI: 000000000000000b RDI: 010000000000000b
RBP: ffffc9000d0dec70 R08: ffffffff8423f47f R09: 0000000000000000
R10: ffffc9000d0de300 R11: fffff52001a1bc61 R12: 0000000000000000
R13: ffff888044468000 R14: 000000000000000b R15: ffffc9000e600000
FS:  0000555592722380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe145a6dd8 CR3: 0000000042f12000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btree_write_buffer_flush_seq+0x1a43/0x1bc0 fs/bcachefs/btree_write_buffer.c:510
 bch2_btree_write_buffer_journal_flush+0x4e/0x80 fs/bcachefs/btree_write_buffer.c:525
 journal_flush_pins+0x5f7/0xb20 fs/bcachefs/journal_reclaim.c:565
 journal_flush_done+0x8e/0x260 fs/bcachefs/journal_reclaim.c:819
 bch2_journal_flush_pins+0x18a/0x3a0 fs/bcachefs/journal_reclaim.c:852
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 bch2_journal_replay+0x270f/0x2a40 fs/bcachefs/recovery.c:384
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2170
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1770828fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdda0a8558 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdda0a8570 RCX: 00007fe1770828fa
RDX: 0000000020000340 RSI: 0000000020000000 RDI: 00007ffdda0a8570
RBP: 0000000000000004 R08: 00007ffdda0a85b0 R09: 0000000000005927
R10: 0000000000800000 R11: 0000000000000282 R12: 0000000000800000
R13: 00007ffdda0a85b0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:wb_flush_one fs/bcachefs/btree_write_buffer.c:147 [inline]
RIP: 0010:bch2_btree_write_buffer_flush_locked+0x5695/0x59f0 fs/bcachefs/btree_write_buffer.c:375
Code: 31 05 f5 ff e8 8c b8 70 fd 90 0f 0b e8 84 b8 70 fd 90 0f 0b e8 7c b8 70 fd 90 0f 0b e8 74 b8 70 fd 90 0f 0b e8 6c b8 70 fd 90 <0f> 0b e8 64 b8 70 fd 90 0f 0b e8 5c b8 70 fd 90 0f 0b e8 54 b8 70
RSP: 0018:ffffc9000d0de820 EFLAGS: 00010293
RAX: ffffffff84243204 RBX: 010000000000000b RCX: ffff88801f6ca440
RDX: 0000000000000000 RSI: 000000000000000b RDI: 010000000000000b
RBP: ffffc9000d0dec70 R08: ffffffff8423f47f R09: 0000000000000000
R10: ffffc9000d0de300 R11: fffff52001a1bc61 R12: 0000000000000000
R13: ffff888044468000 R14: 000000000000000b R15: ffffc9000e600000
FS:  0000555592722380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a002f01098 CR3: 0000000042f12000 CR4: 0000000000352ef0
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

