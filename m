Return-Path: <linux-kernel+bounces-448574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F359F41E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD3169627
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EBC1487FE;
	Tue, 17 Dec 2024 05:09:29 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3170827
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412168; cv=none; b=eCTRFq7i2EV5UM0hpCAkOE2bJGZknsQrpOK9rIFfU/ypvxH2lXyWdlaHTTTtrgundJrIlDmWP7A9wiUWB+j74gxpjJVAzlA/U9fGM3+/V31e7nLK5QvIdfUPaNqffGCYBZXd0A59FsUUhUkrDrRr5/lVbsmWD9JMmeKb58aZuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412168; c=relaxed/simple;
	bh=lRT53tnMpIkVZbU2tynbVlZyVKxCwls4sQu+kuKIn6o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V8sZygIRmFocFg4Pfqroz2Nc5wZWHA7D3Cq9OA5/UcoEBarJNxAkqEfuPysCyXIvxjoYoi4oTsNC8T8HUEwXFXZRkLAJo0sfgaUSNvUbD5CedCl0AcuGRTrZm/OZfQwP0fNB5W1TG+XgIcjLEwc2/ZfkG4HZo2Vt/GEeAY4FYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844d02766f9so398419139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734412166; x=1735016966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAWUH+vcmwxxItz1fFrTGcQLivAWtcTVB12gHeyDmAk=;
        b=V4O6ho4526K1Nzu3nu+3ylK8qjMIXVuqxSuwcb/7O8B7Yocf9Kl4eqjKA8oMP+BwFF
         vv5NdRCmAZTGXojhgFJ+AxhLo6jX32t6/TyueCSu8N+cbxuB+YXJ01NbtlvXwpiPF7xL
         MbrFoNfSIZIoEnwC8JDB9yTCl1zStzW1Ld+m1EYdaD1M+qUoy5maQWRxrHrDwSuw2sO3
         u/wJiAcRf4SL+NvZdWzVz/62oIyn4vuxxPV3M7tLlru6SiFJ2gu8TDDxq5AhFXpuqOdD
         TMoOzMprM6+Rg+9gzM37hZHEvbPtl3uRCllNjnwSa++PAGv9pZn0Vy/veN4G+7/5UJ5H
         XZjw==
X-Forwarded-Encrypted: i=1; AJvYcCVUIJVlsmfsJAnEy+wAxgkYRs7htXBOMLIpsAy5ECTau3lFzwh4hPYo2nKXJHvbgz5luO5A4jC9Zt4Ho+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWloCVhzpE3P9+fz4v7GesBZXylZWl6HQ4n0rAfj+OB/8ALCEG
	aBMJGhAfljEfIP/y1CK34OHPSbN9XR95SsIz9z17p/yVmZ9+mjDjaWXM+f/BExZBfHFUa65kzSs
	22XF4+ekv7fyNxKGWP1jCcuYCl45S37MhGlN1koFJBWLmvZnHELFELNU=
X-Google-Smtp-Source: AGHT+IG3N4EKJPQrzwwdyNhp9xhkkg/O25whQYjpvd6Xn8Pztd4Tfg5Ks9RVASfGDU2J6NmdjTcZyRYBsad1mMKQAfcu+tNcDdt3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3a7:e592:55ee with SMTP id
 e9e14a558f8ab-3aff8b9d0admr177433655ab.20.1734412166306; Mon, 16 Dec 2024
 21:09:26 -0800 (PST)
Date: Mon, 16 Dec 2024 21:09:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67610786.050a0220.37aaf.0149.GAE@google.com>
Subject: [syzbot] [gpio?] general protection fault in gpiolib_seq_stop
From: syzbot <syzbot+b95d0c98f01e7a95da72@syzkaller.appspotmail.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d8308bf5b67 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1383bcdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=b95d0c98f01e7a95da72
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1189c344580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103b94f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66039e873a32/disk-2d8308bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60744ba3f743/vmlinux-2d8308bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25731ba013ad/bzImage-2d8308bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b95d0c98f01e7a95da72@syzkaller.appspotmail.com

RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fffecdd9167 R09: 00007f4106f40032
R10: 0000000000000005 R11: 0000000000000246 R12: 00007f4106f46618
R13: 00007fffecdd95a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5829 Comm: syz-executor520 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:gpiolib_seq_stop+0x4c/0xe0 drivers/gpio/gpiolib.c:5067
Code: 48 c1 ea 03 80 3c 02 00 0f 85 98 00 00 00 48 8b 9b e0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 60 8b
RSP: 0018:ffffc90003e1fa58 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88802463a018
RDX: 0000000000000000 RSI: ffffffff84cc96be RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000dc0 R09: 00000000ffffffff
R10: ffffffff8df7c5d3 R11: 0000000000000001 R12: ffffffff8bb596a0
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90003e1fc40
FS:  0000555557ff9380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e43c381608 CR3: 0000000076408000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 traverse.part.0.constprop.0+0x2bd/0x640 fs/seq_file.c:131
 traverse fs/seq_file.c:98 [inline]
 seq_read_iter+0x934/0x12b0 fs/seq_file.c:195
 seq_read+0x39f/0x4e0 fs/seq_file.c:162
 full_proxy_read+0xfb/0x1b0 fs/debugfs/file.c:351
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_pread64 fs/read_write.c:756 [inline]
 __do_sys_pread64 fs/read_write.c:764 [inline]
 __se_sys_pread64 fs/read_write.c:761 [inline]
 __x64_sys_pread64+0x1f6/0x250 fs/read_write.c:761
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4106edb2e9
Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffecdd93c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00007fffecdd93d0 RCX: 00007f4106edb2e9
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fffecdd9167 R09: 00007f4106f40032
R10: 0000000000000005 R11: 0000000000000246 R12: 00007f4106f46618
R13: 00007fffecdd95a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gpiolib_seq_stop+0x4c/0xe0 drivers/gpio/gpiolib.c:5067
Code: 48 c1 ea 03 80 3c 02 00 0f 85 98 00 00 00 48 8b 9b e0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 60 8b
RSP: 0018:ffffc90003e1fa58 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88802463a018
RDX: 0000000000000000 RSI: ffffffff84cc96be RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000dc0 R09: 00000000ffffffff
R10: ffffffff8df7c5d3 R11: 0000000000000001 R12: ffffffff8bb596a0
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90003e1fc40
FS:  0000555557ff9380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000076408000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 98 00 00 00    	jne    0xa6
   e:	48 8b 9b e0 00 00 00 	mov    0xe0(%rbx),%rbx
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 04          	lea    0x4(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 04                	jl     0x3f
  3b:	84 d2                	test   %dl,%dl
  3d:	75 60                	jne    0x9f
  3f:	8b                   	.byte 0x8b


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

