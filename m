Return-Path: <linux-kernel+bounces-289429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1C95461F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4EE1C23ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50516F0E1;
	Fri, 16 Aug 2024 09:49:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF913B593
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801767; cv=none; b=aiE+QG+8vnBIHsmLaaubeAQlnvPdSNYY9OygqPA7FLXwbt55a8+itTcCbQ1K06P/Ot9fZfudxdUpHvFd96THMjVo2G7ki2MJkxO+QqQGkj9os4kOwFrGcWW9Zr9ZV0kZ95CLFNneNYSGs7IppV8auqlejZ7k/JUkuwC741Om0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801767; c=relaxed/simple;
	bh=8AvQNGoR/PmGVi6m/LmAzliuLmbrZjBfVHNA4IUYJWg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M1zwQKbUIGPLGD7r5+JLeBf/Kz5S94YQmOZNV3lI0aurmtpFA0K7ndJcngp1o4rD5CpqKSZ+Yi4Hbt2jj90bfG08GcPucwqDQ25PdFGFmSpkZZlz7lf4s3iN1kIIGRJIq28TM0WmzhIhD3w33J9WmZK8WtUF9MYx69qOH8xWE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so179619739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801765; x=1724406565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=397CwoA2n1vqpZP3/oyDV0Ku2aBi9nDUe1IaLKIBrDk=;
        b=OnIjod7T/yIBoEbMRVk2kksDBBGCq1kRgzd22y2JjXWikyHQVxZ6HvPKdvVLy4QQ3b
         skV8nVM71HgN+8sCCr+TbNMI1mK9W+/YhlW7uZRMYhIItk5pA9e3PeitnKIZ9Zo2UH/M
         DB2BWUQl5Gevh6BJnw3IQCHvZ0ZxQz3fWuIEjySQVZs6jadCEN76HtLGv9kV++JtAkIl
         wCDTzEbxjmJrd6Fqvb5Pk2SSOQaLMb5OJvmdggeobqkFYUaXGHPS8Eafp8+KC5g8Lhdp
         sNmFJDLQfNGjEX7x6HnhRMn9u/CcQ25NlNliRhIATwjDn/Ty/r2B7Ih4N5DoEuPjmPeZ
         GZRg==
X-Forwarded-Encrypted: i=1; AJvYcCWm1BxMCOS4gZvfW4dlgxuXTZANRuRmTZ+zmCUmo9mWIUnaTECrT4glFRDVWa081Rs2f9v+DV2XT/D19L9ZzJb61VNq+EPSnRInYAx0
X-Gm-Message-State: AOJu0YyYA+d0c9qPHKe2fiMkw+U2W2Nyv2WVW8T5868a5iCHw7eCyCe0
	kxHeh2EJ2vMOF4n0KtAnaq3AnrVVAKP4n4C0PDfw50EsGmTIYiZCbjmXfsoU8rY+2O/gcCf0dLx
	A20U8NLPJwyQns5ZF8z56FqK/79A+fD7BiMPzMuhSU23p1ytKz7yQSVA=
X-Google-Smtp-Source: AGHT+IFOhHqeLmolbAb47oP5Xh/Gms41oUsdkn9VE+7RAxS+SWH/WXMl2G9vquC8lLrMIJDTjTxSEBNXsFb9hTm4d8B20uNUIvoE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8416:b0:4c0:9380:a262 with SMTP id
 8926c6da1cb9f-4cce15bec24mr107811173.1.1723801765115; Fri, 16 Aug 2024
 02:49:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df840a061fc9df08@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __bch2_fsck_err
From: syzbot <syzbot+e3938cd6d761b78750e6@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16583409980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=e3938cd6d761b78750e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143ab6d5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142c33c5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd6e8883313a/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87b718d2d1df/bzImage-1fb91896.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9597d225acb5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3938cd6d761b78750e6@syzkaller.appspotmail.com

bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5090 at fs/bcachefs/error.c:242 __bch2_fsck_err+0x130f/0x14f0 fs/bcachefs/error.c:242
Modules linked in:
CPU: 0 UID: 0 PID: 5090 Comm: syz-executor348 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_fsck_err+0x130f/0x14f0 fs/bcachefs/error.c:242
Code: 25 df f5 41 bc 5d f7 ff ff c7 44 24 10 00 00 00 00 e9 83 fa ff ff e8 c0 25 df f5 90 0f 0b 90 e9 4f ee ff ff e8 b2 25 df f5 90 <0f> 0b 90 e9 98 ee ff ff 89 f9 80 e1 07 38 c1 0f 8c d4 ed ff ff e8
RSP: 0018:ffffc9000b056f00 EFLAGS: 00010293
RAX: ffffffff8bb463be RBX: 0000000000000000 RCX: ffff88801a9c4880
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc9000b056e40
RBP: ffffc9000b0570a8 R08: ffffc9000b056e47 R09: 1ffff9200160adc8
R10: dffffc0000000000 R11: fffff5200160adc9 R12: 0000000000000071
R13: dffffc0000000000 R14: 0000000000000071 R15: 0000000000000006
FS:  000055558f5d5380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86d3431ad8 CR3: 00000000399b4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_trans_mark_metadata_bucket fs/bcachefs/buckets.c:914 [inline]
 bch2_trans_mark_metadata_bucket+0x5d2/0x1640 fs/bcachefs/buckets.c:999
 __bch2_trans_mark_dev_sb fs/bcachefs/buckets.c:1066 [inline]
 bch2_trans_mark_dev_sb+0x520/0x720 fs/bcachefs/buckets.c:1079
 bch2_trans_mark_dev_sbs_flags+0x6be/0x720 fs/bcachefs/buckets.c:1089
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:183
 bch2_run_recovery_passes+0x19e/0x820 fs/bcachefs/recovery_passes.c:230
 bch2_fs_recovery+0x25e8/0x38d0 fs/bcachefs/recovery.c:852
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd61/0x1700 fs/bcachefs/fs.c:1946
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcdecacfeaa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0e399998 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe0e3999b0 RCX: 00007fcdecacfeaa
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007ffe0e3999b0
RBP: 0000000000000004 R08: 00007ffe0e3999f0 R09: 00000000000058a9
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffe0e3999f0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>


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

