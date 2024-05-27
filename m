Return-Path: <linux-kernel+bounces-190186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE468CFAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0270A1F2169B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0473A1DA;
	Mon, 27 May 2024 08:04:29 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1F22064
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797068; cv=none; b=iGpd2s+LNj07tIPcW1IJurcbXeGeoFP94dMy47CyYqdJ9aJA91TIhgCnfcFRJ478pwrBYI/GNhe2Y+R9WVMW0EGfClBUEyYpI30DSSzI5VVIUTqK+ynYjzsmiLqdFvGzLMwAz/wY69f4jYCis8sGGgalSS8lzE1qPrkQnL3VlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797068; c=relaxed/simple;
	bh=AfSO73Qrh/3Mw8AbnC/t+TvIjVNrBKuYlrZrfvjnKQM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f007SOX2U4w3cZcxt9WPIZBvKgHX0wA3iwY836DQOpfbWzaf0MQJ9fuuPwZRq4QuZNEGsWmsE4HBwuJ0dvl0ADTEN9xRVR3LWMvB/Z5USYEu7L+zIX0X066IsA1Q3zuIoKLp+B+FEmID8hL8qOeLEbpl/XahUF9OysOyKhvyZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374519f6ebcso11611395ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797066; x=1717401866;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+eBWqb4e1Ene9RwI9BwzzBZjWNZjdIK7/uuJSEFxis=;
        b=P0G7OzdUuskIyN4UwP+1oj5lLkux0kJiILEfTuoPeQTRaSj2Atn7Hipi1/wqwD+CyB
         GhPzwVOpATussZMHzqnGNna5AChtoQRR3Ap/oxUBi4pgv3KRkG6+5gWtYbOHLSWAE+EM
         QhkRqJV0Pn3RxcONFccywToWRBcbzaD2DTCoXuLmqyWQFppGjvjA6H/c8aroRXfHH90l
         3JYW8hiq9iEcMrT4y7eF0B8cJB6CfgSG44RzR7BsPWVCyh5JHANGSSBnoxV6vWVKfdAV
         GVbOLX2ITsbF5qAiqrPTnEkw2R1JPMJuXmmu7S5H7gKpQkUaAv5140wln81Zk5YcXSBC
         abFg==
X-Forwarded-Encrypted: i=1; AJvYcCXfXTH0ENKfLAQDTUKgCvRiD5vuyEa2ua/rVNuDmkkaoYqTBfVLwJo8sbP19yg9ObPqR+GKwWTSYw6nVeoLKMgScxP6HrbHQGOnA6ND
X-Gm-Message-State: AOJu0YyyDIziBUhwtrWPxrekl42PxELzg3HYgUHRdrXpfTJoR5Nww7nY
	Ivl/dvbqWz7WRxbn0OfJiF/VN5kldzQjua3NH+w3iC5sifq8meGN2PzAFhj5R1csO4oqQRQoxLH
	fJ/WcQvgLkb1zfgrkLFMs7FxCS7u1i9cKESXkJNf0LMk2GF7wpZ0e9HM=
X-Google-Smtp-Source: AGHT+IEeXFqon8I02w/CLJia8Zi02CalzyA7PJiTLYrtmN0xWx61/s8V2nFl2bxwXtL87t9SqeIuAbF/qcHGT3HW4tGO83CcXhcO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:371:139d:ba7e with SMTP id
 e9e14a558f8ab-3737b37afe1mr5439875ab.3.1716797066553; Mon, 27 May 2024
 01:04:26 -0700 (PDT)
Date: Mon, 27 May 2024 01:04:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dbd4f06196af76f@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in deactivate_slab
From: syzbot <syzbot+79388700e25aa19555b9@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1613e604df0c Linux 6.10-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15410752980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=79388700e25aa19555b9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1613e604.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdfe02141e4c/vmlinux-1613e604.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e655c2629f1/bzImage-1613e604.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79388700e25aa19555b9@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000001
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 256e3067 P4D 256e3067 PUD 4977c067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 PID: 56 Comm: kworker/3:1 Not tainted 6.10.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:PagePoisoned include/linux/page-flags.h:296 [inline]
RIP: 0010:page_to_nid include/linux/mm.h:1664 [inline]
RIP: 0010:folio_nid include/linux/mm.h:1670 [inline]
RIP: 0010:slab_nid mm/slab.h:194 [inline]
RIP: 0010:deactivate_slab+0x1b/0x4a0 mm/slub.c:2880
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56 49 89 f6 41 55 41 54 53 48 83 e4 f0 48 81 ec b0 00 00 00 <48> 8b 06 48 89 54 24 08 48 83 f8 ff 0f 84 c3 03 00 00 48 8b 06 48
RSP: 0018:ffffc9000076fbb0 EFLAGS: 00010282
RAX: 0000000000000002 RBX: ffffe8ffad339190 RCX: 1ffffffff28415f8
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888021133540
RBP: ffffc9000076fc88 R08: 0000000000000001 R09: fffffbfff283ee5e
R10: ffffffff941f72f7 R11: ffffffff81e16fea R12: 0000000000000200
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000001 CR3: 000000001b47c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_slab mm/slub.c:3100 [inline]
 flush_cpu_slab+0x141/0x410 mm/slub.c:3146
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: 0000000000000001
---[ end trace 0000000000000000 ]---
RIP: 0010:PagePoisoned include/linux/page-flags.h:296 [inline]
RIP: 0010:page_to_nid include/linux/mm.h:1664 [inline]
RIP: 0010:folio_nid include/linux/mm.h:1670 [inline]
RIP: 0010:slab_nid mm/slab.h:194 [inline]
RIP: 0010:deactivate_slab+0x1b/0x4a0 mm/slub.c:2880
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56 49 89 f6 41 55 41 54 53 48 83 e4 f0 48 81 ec b0 00 00 00 <48> 8b 06 48 89 54 24 08 48 83 f8 ff 0f 84 c3 03 00 00 48 8b 06 48
RSP: 0018:ffffc9000076fbb0 EFLAGS: 00010282
RAX: 0000000000000002 RBX: ffffe8ffad339190 RCX: 1ffffffff28415f8
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888021133540
RBP: ffffc9000076fc88 R08: 0000000000000001 R09: fffffbfff283ee5e
R10: ffffffff941f72f7 R11: ffffffff81e16fea R12: 0000000000000200
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000001 CR3: 000000001b47c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	55                   	push   %rbp
  10:	48 89 e5             	mov    %rsp,%rbp
  13:	41 57                	push   %r15
  15:	41 56                	push   %r14
  17:	49 89 f6             	mov    %rsi,%r14
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  23:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
* 2a:	48 8b 06             	mov    (%rsi),%rax <-- trapping instruction
  2d:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  32:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  36:	0f 84 c3 03 00 00    	je     0x3ff
  3c:	48 8b 06             	mov    (%rsi),%rax
  3f:	48                   	rex.W


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

