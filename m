Return-Path: <linux-kernel+bounces-200527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805998FB147
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B9D1C221B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123C38B;
	Tue,  4 Jun 2024 11:41:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E07145355
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501285; cv=none; b=Sj7jRVqjtFT1dVah94/LewtwI7RDKfcDYpMwr5gJN4mmChmUrduuxB5f+dp2GrhJcCPT7QYFexXJkXE+mpTo8kjaEPe1LGs6fNyrrKj3A+5ftI7x65x7JbwUKhtebDbL1GNWI9X5iuqmdK8OKa/1kDTlUqVD3hwVe+QI0TzJXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501285; c=relaxed/simple;
	bh=gHACCEMoOIJa9RmUyIRHfHOzk5s4iq3m2RGLK9LJ/W8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YZ5ZNI+IwjUn48eF2ceeqwNE8inKqDsPSk0QD1ZS50GUynyDXqmHxK8CambiClQFrlWItDTxr5OZYRRtBVPq0jwtgHBh3BllEWaLNeYeaCJgULJ+19/+TgdCjgVvAnDgi0JtIlIXOSly2S5t9B676Wr4ScMJRBW++EqLQgUV3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-374ad7fa4bbso3195805ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717501283; x=1718106083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTpb3uKczqp0F+PBMbqK9H6iMeeem8QEL5nf5oF+VAI=;
        b=r1BgAeU/MMF4ZOlEP37dyIhw5GmWVCqwHvGnXVKIl8tibx/VOMQixLQlIZZcR/PQgT
         ptck+yANxrxJi0396GlpUnfteKdW4k0xWCeGF3H8Ad26BoPuawW83smX8kl4mCWLihbT
         y/5Rvs9WykhGBcd3hVNYd30ixqYuTxBAeUfXZyp3xHCr4OORhhyhcalPGm6ODg2lC560
         EeBWz0rimf/DTCAg7vpuTP9AI9pLMV7DPIpveu6JWvFcSfc+ZbnAUpDv+oi7rqio0kl+
         UojuznNwNp3eW3/XTG/ufXoDpKLvu993aIAmK/FGSGsnEkumnFiFdert4YwZIOu/uIe0
         Cpqw==
X-Forwarded-Encrypted: i=1; AJvYcCVl0w9E5/LbGRvoPMpBG3I+qL4ivy9dJJ5nhmlNBikJgUEFjJACjHCryMtFzUcUnbeIiue3yKkGQFXz7fOXw7b0NCirqQY25Zofh5fE
X-Gm-Message-State: AOJu0YyltRF6kcDo16An2KWIbU8vJ4u/NOPtr8GX8HEKswQFJsxZUhfq
	bB+tS9RETR+3P5VrTNYQB/tlwya9Lq/eGCmC1DSFeH/hF3nZtq6+I6vlaeeDdGlLo6FBWa1pJHK
	r88OuoZptelGgVL9FkRJCDa9Jilno8IhaziH0oULmmOuoEcMcFlitacY=
X-Google-Smtp-Source: AGHT+IFoeslpOI+LQbyCqA+o2joY689BYWfQLzxVtxK5pkY3YJ7uG1CFSaCaeA6V6yi2a6kObIQ5Cmd3WKrbR06ze6pTe6Ap3HTG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:374:9aa2:9155 with SMTP id
 e9e14a558f8ab-3749aa2952bmr6213855ab.2.1717501283485; Tue, 04 Jun 2024
 04:41:23 -0700 (PDT)
Date: Tue, 04 Jun 2024 04:41:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e75d35061a0eed82@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in gen_poly_key
From: syzbot <syzbot+0c7a9c4a5a4b3730d4f6@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ae4d14980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=0c7a9c4a5a4b3730d4f6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c3162980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1432099a980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e90895495e65/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e28d1589c72/bzImage-4a4be1ad.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/83e4344d1bf8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c7a9c4a5a4b3730d4f6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000903d: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000000481e8-0x00000000000481ef]
CPU: 1 PID: 5189 Comm: syz-executor842 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:gen_poly_key.isra.0+0x10d/0x330 fs/bcachefs/checksum.c:191
Code: 00 00 00 00 05 00 00 00 80 89 44 24 0c e8 db 56 f0 fd 49 8d bd e8 81 04 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 01 00 00 4c 89 fa 4d 8b 8d e8 81 04 00 48 b8
RSP: 0018:ffffc900031eee48 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff9200063ddcb RCX: 0000000000000000
RDX: 000000000000903d RSI: 0000000000000000 RDI: 00000000000481e8
RBP: ffffc900031eef20 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900031eee98 R11: 0000000000000000 R12: ffffc900031eee98
R13: 0000000000000000 R14: ffffc900031ef028 R15: ffffc900031eee84
FS:  0000555568ecb380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055954aed89d8 CR3: 00000000236b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_checksum+0x1f9/0x2e0 fs/bcachefs/checksum.c:227
 read_one_super+0x567/0x1530 fs/bcachefs/super-io.c:672
 __bch2_read_super+0xc81/0x12a0 fs/bcachefs/super-io.c:797
 bch2_fs_open+0x3e5/0x1110 fs/bcachefs/super.c:2070
 bch2_mount+0xdcc/0x1130 fs/bcachefs/fs.c:1917
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
RIP: 0033:0x7fc8c1cf78fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfeaaa7e8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdfeaaa800 RCX: 00007fc8c1cf78fa
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007ffdfeaaa800
RBP: 0000000000000004 R08: 00007ffdfeaaa840 R09: 0000000000005d9b
R10: 0000000000000480 R11: 0000000000000282 R12: 0000000000000480
R13: 00007ffdfeaaa840 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gen_poly_key.isra.0+0x10d/0x330 fs/bcachefs/checksum.c:191
Code: 00 00 00 00 05 00 00 00 80 89 44 24 0c e8 db 56 f0 fd 49 8d bd e8 81 04 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 01 00 00 4c 89 fa 4d 8b 8d e8 81 04 00 48 b8
RSP: 0018:ffffc900031eee48 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff9200063ddcb RCX: 0000000000000000
RDX: 000000000000903d RSI: 0000000000000000 RDI: 00000000000481e8
RBP: ffffc900031eef20 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900031eee98 R11: 0000000000000000 R12: ffffc900031eee98
R13: 0000000000000000 R14: ffffc900031ef028 R15: ffffc900031eee84
FS:  0000555568ecb380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055954aed89d8 CR3: 00000000236b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	05 00 00 00 80       	add    $0x80000000,%eax
   9:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   d:	e8 db 56 f0 fd       	call   0xfdf056ed
  12:	49 8d bd e8 81 04 00 	lea    0x481e8(%r13),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 ce 01 00 00    	jne    0x202
  34:	4c 89 fa             	mov    %r15,%rdx
  37:	4d 8b 8d e8 81 04 00 	mov    0x481e8(%r13),%r9
  3e:	48                   	rex.W
  3f:	b8                   	.byte 0xb8


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

