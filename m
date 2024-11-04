Return-Path: <linux-kernel+bounces-394068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370CA9BAA5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A81C20AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5285167296;
	Mon,  4 Nov 2024 01:37:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D214BF8B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684246; cv=none; b=q67bhD0V7rNqdbJ/R+sdPuG5CpyjjNzP4EyO1aTTc4/RYjYHbFJMuICazRzi1GqYBBdoR6qEVPy5hlD2FATnR2GXA4SfmlQav2nR9JR3NNfq7W26dWe5cCFN3AkLKCSh3bWuImENpVXpedc0JwaGHy5umwGtvD9IC8gkg8y7Jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684246; c=relaxed/simple;
	bh=H8fPe+mPymXVAewKBFHqUr7ej9fC4Mn/Q6FCS5gMSxE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sM1tz3q7KX3X/aOGysE4eoet0rvcfa/kFIK9mYuJB22YTNOv8zSv6PLmkAroHIFW/iqR0wT7z2aT1DEFmBCLpupN+/WVmyG3LNbfdQDf6cxrRbMl5BmuOqzObLtjOvmg19ud+sOQrJAuV9uXcVci1nLRte2CyskM4rb4vmb6gEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ac354a75fso426451739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 17:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730684244; x=1731289044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmB4sxk55Zo2DNT7yybnrubdqFuzssqyysd1irwsrks=;
        b=VWVP3mWY5bnfPOXE3NxhPNw09Lj/hmBGWuRTONW9vj0jTfSX/3rlQYNUsDLO/4lSvV
         P4s40SHz3gUnIW9XUusc5cIkCSTQyqao7M9uyAVraIzKNU0d6WySKZnh7V6YXU6LeY9W
         SRfTAVilLlCANBt3V98Z4GpAb1hvl4/U0Sx6WpBMajDfDsllWzqESXr+RhyLA8Xm1KjD
         d7FTzAxUeLB35uCwSlMg5at0U8LWxPyd4h+qO0bvTjanQVyp4om6gcINkpswEQBZ3w/q
         zpSEQDinhOMA46V1FyOQ07YgCdpTG6X9JWWXjgYw93vUKJa/t7r78fee+FnHz4AIIkoa
         D4ow==
X-Forwarded-Encrypted: i=1; AJvYcCViPwxXTqQHDyo7GFQWcM8ozGfrJujoHxDhCTrDLunedRaLtdF4nd/r3phy2FqBujGfIfQ+sQ8Gen/7mEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRFHXAQZzZIu+DszuEcsgATearlEGL3NFO5oKSN0jEmPW8bKo
	9NiPKsf0Ge5x9WIbz3ZdcZ8InN3oL027ws8gbvOJ5wM69P/PISFADh+OzychOuV0Q+25NmDCA6b
	0oDrNoFzE+011AzEnI/x+sfNbhKfGNbsAPBKw1ZVE7lIvrfJ22Appzi0=
X-Google-Smtp-Source: AGHT+IHSP5nip4dDvHLMRKgwYCwauDjXmDS4ez/AJxjm2sd6nfR4u/N5XKUuSiPBrJMgttLMXxPNumwbVus8mcmvvKAW+elEb+1M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a6b0358264mr113677855ab.22.1730684243830; Sun, 03 Nov 2024
 17:37:23 -0800 (PST)
Date: Sun, 03 Nov 2024 17:37:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67282553.050a0220.35b515.01aa.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: bcachefs (loop0): panic after error
From: syzbot <syzbot+4c6e722ab29ba1d06b19@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4236f913808c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116da55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4c6e722ab29ba1d06b19
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1792c630580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156da55f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4236f913.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca5604c008a4/vmlinux-4236f913.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34ea5692a94f/bzImage-4236f913.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8ac365f356c8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c6e722ab29ba1d06b19@syzkaller.appspotmail.com

bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=errors=panic,metadata_checksum=crc64,data_checksum=none,compression=lz4,background_compression=gzip,no_splitbrain_check,nocow
superblock marked clean but clean section not present, shutting down
Kernel panic - not syncing: bcachefs (loop0): panic after error
CPU: 0 UID: 0 PID: 5308 Comm: syz-executor415 Not tainted 6.12.0-rc5-syzkaller-00047-g4236f913808c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 bch2_inconsistent_error+0x146/0x150 fs/bcachefs/error.c:26
 __bch2_fsck_err+0x10ee/0x1570 fs/bcachefs/error.c:425
 bch2_read_superblock_clean+0x3b4/0x520 fs/bcachefs/sb-clean.c:152
 bch2_fs_recovery+0x1f4/0x39c0 fs/bcachefs/recovery.c:640
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
RIP: 0033:0x7f7d3c001eba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe9e18a88 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffe9e18aa0 RCX: 00007f7d3c001eba
RDX: 00000000200058c0 RSI: 0000000020000100 RDI: 00007fffe9e18aa0
RBP: 0000000000000004 R08: 00007fffe9e18ae0 R09: 0000000000005951
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007fffe9e18ae0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

