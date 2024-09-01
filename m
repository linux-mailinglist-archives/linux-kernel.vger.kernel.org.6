Return-Path: <linux-kernel+bounces-310149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B396758E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DD31C20EDF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D621146A6E;
	Sun,  1 Sep 2024 08:24:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6B1428E0
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179069; cv=none; b=XVtO7av2Ly9ci+2MIUvuQB26oniqpfvkz5Dd9W0+VTEYEycwUFG4MOqEs7xFUwNBfIR3OWYdM7ouuFQY8Y5feo55ooBPNLGWCLJwWBhdtzkhJ47HrrA8YSsWp2WKi0Q2Wk5swdn7HUctrrQ0KC+GTUrKWCVSLmcYHGOA5HaridM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179069; c=relaxed/simple;
	bh=VfJXLi/eYBS644okY+ARvvRY/DXHIZL5ktcbxHrOGM8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oNxXoH2v+nDCahK6oLZ/Ljb0pU5bpT3u1slA4/Z4DOzjhOv9rWcsq8/rxoLZfxQCye+hpBdCL0GSAmWHSzrT7Y48Jt8UntupDu6IRYAC235cj+jK6f/8HJi3UQAUEeL5cPtmM3PtMA+tJNvq1LpdlTCg3Gp/Ae0iVsT2dO6USfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a2723a5aeso249140539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 01:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725179067; x=1725783867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6oQUvwwPMAkmGzaNGxf9cx+QHwwYGucQ4Fcb6+88Jk=;
        b=EX9Xkzd3HyhGpQftyOFwt5vZmkq2Y7ajrGL/PwCyzOEue+OJEEjuhq9cmaujAnKp7g
         FzrNv/TSix+lWUdqW7FR/xF41uQ78gHJ+JXms91DvGRunI1/adBJIKVvKC/SlcSiABoA
         RZmXIQM6P/Li4d/kWBSc4ICj47oxhykj44p2f7xg03PbQ4Cgx6Vzq8F8WN362jDUtBAW
         oOpKq4gw6eDFW41/dkPy1FwEP8kM6X2wFlAC3uXYWKBSkEgAOLolQMfWjRApgUg3AZ7I
         vpPJBXDiKQv5d1PTq+FPjfx3WF46MqPxkI0WS9B+QO+qq+eKud4LgobBwXMyBbowts26
         p7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUhRIZEWk1ejXDEcL25EFHPl/C5SJAoFq6goBn42asRQvItP+H6990W3RgrOqY96j7ItFwi+cT4Lbt5DAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlbNjrl9vUzNIyXOf70b8nXo21MTgHbgH17ZJB3cXD79o3sb4
	UWRCho684McjNS54F86pXEIkG/twF+v08UaFMiMxllbirWbc9JTrg+55vcTFjkurzGD7dLcOK9C
	lHMgJULyqPXACNtN8hd/d0OQ81jhSnNW08OV9HGc6aFdPu5QM+xLn2ow=
X-Google-Smtp-Source: AGHT+IGuK0Oea3g2cY2ppVno8G3XqkBupzbqQOjuxONfqw7esT5UgZxMFvngCGPVCxfclxjvmJPjJQ2N3urTMrvioHQYZD+qAg1V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a6:b0:4ce:54dc:fa44 with SMTP id
 8926c6da1cb9f-4d017d788fbmr413786173.1.1725179067112; Sun, 01 Sep 2024
 01:24:27 -0700 (PDT)
Date: Sun, 01 Sep 2024 01:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000782b4706210a8dcd@google.com>
Subject: [syzbot] [bluetooth?] BUG: corrupted list in mgmt_pending_remove
From: syzbot <syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe1910f9337b tcp_bpf: fix return value of tcp_bpf_sendmsg()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=171d6f7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=cc0cc52e7f43dc9e6df1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb37d16e2860/disk-fe1910f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/315198aa296e/vmlinux-fe1910f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3e6fb9fa8a4/bzImage-fe1910f9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com

list_del corruption, ffff88802943da00->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 7763 Comm: syz.0.694 Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 71 64 fc 06 90 0f 0b 48 c7 c7 c0 90 60 8c 4c 89 fe e8 5f 64 fc 06 90 0f 0b 48 c7 c7 20 91 60 8c 4c 89 fe e8 4d 64 fc 06 90 <0f> 0b 48 c7 c7 80 91 60 8c 4c 89 fe e8 3b 64 fc 06 90 0f 0b 48 c7
RSP: 0018:ffffc9000492fb58 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 5f038e50b22bff00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174013c R09: 1ffff92000925f0c
R10: dffffc0000000000 R11: fffff52000925f0d R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88802943da00
FS:  00007fb7679de6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc967a2fc0 CR3: 00000000437dc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 mgmt_pending_remove+0x26/0x1a0 net/bluetooth/mgmt_util.c:314
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0xe6/0x340 net/bluetooth/mgmt.c:9395
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1833 [inline]
 __sys_bind+0x23d/0x2f0 net/socket.c:1857
 __do_sys_bind net/socket.c:1865 [inline]
 __se_sys_bind net/socket.c:1863 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb767f79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb7679de038 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fb768116058 RCX: 00007fb767f79eb9
RDX: 0000000000000006 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007fb767fe793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb768116058 R15: 00007fffd1ff2828
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 71 64 fc 06 90 0f 0b 48 c7 c7 c0 90 60 8c 4c 89 fe e8 5f 64 fc 06 90 0f 0b 48 c7 c7 20 91 60 8c 4c 89 fe e8 4d 64 fc 06 90 <0f> 0b 48 c7 c7 80 91 60 8c 4c 89 fe e8 3b 64 fc 06 90 0f 0b 48 c7
RSP: 0018:ffffc9000492fb58 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 5f038e50b22bff00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174013c R09: 1ffff92000925f0c
R10: dffffc0000000000 R11: fffff52000925f0d R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88802943da00
FS:  00007fb7679de6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f773e8e8178 CR3: 00000000437dc000 CR4: 00000000003506f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

