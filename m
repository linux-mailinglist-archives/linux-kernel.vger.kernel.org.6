Return-Path: <linux-kernel+bounces-229369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F15916EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586531C226E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEF176ACC;
	Tue, 25 Jun 2024 17:13:22 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D98176ABE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335602; cv=none; b=rZvDSL0xvWLJKEMNYc6/aLi/KOKHkD+uKO/pgdn97ATzzviw7HJLjnCDOYYAMNm/72ZM0snYem1G44cZRIVw2m3wfAgr7dO3w4NLfruO8hwAACvKFAwLYaq4HFcID/CszxUsEMH1C/HafLzG2qf9eJOAYTETMS0c3ajvyllj9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335602; c=relaxed/simple;
	bh=EehPf8S1tgEOAWW0oPbZjLhqaVxYgZ40z0A2C7d2k6o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sBafJi2hk0PCjtDCbAp/s79CUZGUTNVLqptTYR4/4TZXyEhgC8ynpGPHxhFwUJ+FxiHMFBRH51BLm+dLI29g+IcS79Q5O5+HRmVg8HE4u4rAd7gdUnPvSN0KDp1vAPcKi5rWsRSmaA75Niprs/6Om3NOG1m9b3nXa6hoQo9r5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3761cec5b39so62034315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335600; x=1719940400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/qpoSgxuUceFvD4VRDBoC7IsPLM80+SNtA4vfaQkEw=;
        b=rpgAxyzA+duSUDNxCx/rY+9pQsb9B9JjH38Wj1+aS3I/0WZhXVBQHsHF66AGspPPhH
         6Qp83qVgdscHx66oBLztWDFDcfW2TBbhWqu1DJMBrcwLS8o0YrSYRbiEgnVjG6FTafV7
         9oB5WGeonD/sqW/y85qghISyHGfSTKebHfxSfm9OzmalIrrlyD4BQVHMfhlr82JfLdSr
         EZ6Fx6MuemZ67wvA3kRV9s+opBB6bylnwdgKLcR7rs5hiBRRy7WC6nHfsVv3pvhhKOkt
         ExOlm1/hdCI/MGgAAUyow2+q1MZtaWO8Y5vCuldnHO7w2JnmXtuhPVXRqcVaYLKMMSeU
         eyqw==
X-Forwarded-Encrypted: i=1; AJvYcCU32zZqYJhlnC2WeviC0JRuwoDBnGLmMoovDShoXGqboNnOaNX4J7JFO5H1DWGYN7Bynq58P61ljlyo3wfBC51M9BgQrWkQrmo6uyXx
X-Gm-Message-State: AOJu0Ywa6d/zalxvwF5Dr5g44BS/T6FpuPxqBz9d/Vkfk8obl3Nca+Ab
	G4GJvAtOgwwQ3iPEcE3PcXDISIdrOWiD8X70SmG8KgIrNIZ4wCIDj9lGotz+ggO/5Bj+oumiPtI
	uQvgOMxDEs+NqL4rVvQXew7hBm8C1oFixhrgua593if3MXm9yfnQfQ98=
X-Google-Smtp-Source: AGHT+IEzNRf2/MSDtxakbi0yRTo7gC02MYQqkN9MGDLUKIi2E8FczcX1nty6mwWbRCYomjwgW5BlwR1JfQnDBYF+KAD40RDqJCKR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-3763b339fcamr10239155ab.3.1719335600174; Tue, 25 Jun 2024
 10:13:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:13:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2c201061bba0374@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_blacklist_entries_gc
From: syzbot <syzbot+835d255ad6bc7f29ee12@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    563a50672d8a Merge tag 'xfs-6.10-fixes-4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1286cdda980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3820d4fff43c7a3
dashboard link: https://syzkaller.appspot.com/bug?extid=835d255ad6bc7f29ee12
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e2d08e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1009808e980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-563a5067.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ef95d163dde/vmlinux-563a5067.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0102d9e1ac9a/bzImage-563a5067.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7fdc5cd163b4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+835d255ad6bc7f29ee12@syzkaller.appspotmail.com

bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in ./include/linux/log2.h:67:13
shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 5189 Comm: syz-executor355 Not tainted 6.10.0-rc4-syzkaller-00283-g563a50672d8a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a5/0x480 lib/ubsan.c:468
 __rounddown_pow_of_two include/linux/log2.h:67 [inline]
 eytzinger1_first fs/bcachefs/eytzinger.h:51 [inline]
 eytzinger0_first fs/bcachefs/eytzinger.h:194 [inline]
 bch2_blacklist_entries_gc.cold+0x35/0x56 fs/bcachefs/journal_seq_blacklist.c:235
 bch2_fs_recovery+0x3240/0x3e40 fs/bcachefs/recovery.c:897
 bch2_fs_start+0x2e9/0x600 fs/bcachefs/super.c:1036
 bch2_fs_open+0xfa0/0x1110 fs/bcachefs/super.c:2128
 bch2_mount+0xe2c/0x1230 fs/bcachefs/fs.c:1926
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd8395e2bba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe022b6078 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe022b6090 RCX: 00007fd8395e2bba
RDX: 0000000020011a00 RSI: 0000000020000040 RDI: 00007ffe022b6090
RBP: 0000000000000004 R08: 00007ffe022b60d0 R09: 00000000000119f4
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffe022b60d0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
---[ end trace ]---


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

