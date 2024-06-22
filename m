Return-Path: <linux-kernel+bounces-225499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D61913167
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E631F2360C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5E4A0F;
	Sat, 22 Jun 2024 01:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7E1C32
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019504; cv=none; b=Ei0yt9UO+SdalL/eE/f+4LB9tmlGKVEkd7RiBXpF+63+liVuSOAxfcUiPGil3fRCCJwr3CanrnCCt0Bd+tfxdnQcq8uPeir5mt5+lDhObizUk3BGedm0VKSm7JM3NPy27oX4OLxETsiKYTilg+hrYIhFHpD1kb6B9B8p0HoZOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019504; c=relaxed/simple;
	bh=0QIsuPo3L2dOT57AOa7K/6Qdh+1jSl7iUQKUik6TD5w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DVjh7LuKhCT58NZ04Nf3eZ7KxMSJK/W5NVcHnPvt3ChwPyRDJGk57zBB2QyCoU1OJ4GvC+Pd5r9uASxo4wGQA/OQCYjunD66zm8UOF9oaUnE8LFjE9uXHIBcm4ZCRqzqRG6nvCUa7ZLf8DkU5vhhKyneDWRR4K8ZWMBHvbsrQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebeebdc580so296404439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719019502; x=1719624302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JrrFOuzdxB0PcduFsa1C2IWjXsA8qYk2lFd05cZWsI=;
        b=UePAJ5p/qVFEph2c4UmCnnI3Tpm40Rp7jiKIDWK7XkXisHRMbKhRDYifAAVSc+VEkr
         WLcw/FA62YM2woa4EPV9fwdFOUAtPHLR/yJQiEeFdUU2xbKw9mlvwA66p5TihSa0lLAI
         zlPMZW8exWjijVQgu/HyqRNGQaui1+kaPpd9Nt2hSKWEnyPHdCyVUTzghE5dGIcRSC+E
         JFOkN4LaAuBQDGr5ABJSDi9decl08ZPQJUAHNOdyto9y9m07L9E2DRyAQq4CMWJxHxH5
         3r/aQRlDjTP14O6Eub0rVVtk0QT15dIg+/l/JuHmgKbh3xyVpzNsR9k8BYywmRf2u5Rn
         u8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBgOp0ZBGcJOkb9xeVf8FBOP/LB4U0Hk0QzzbHXh3EfWnq5089mNFIMcA2HxrQ6HWr3fM3fdqp5BOL5lj4+f82CZe+hlHMZRx2iNX1
X-Gm-Message-State: AOJu0YzAddsRsLRnQ+72oWHSUkpgZdhXyPi70wyBTK4CBPjH8MRuo6qp
	8PiVIcB1BDxyeQYdX38C9TCFbO0J2qZSs4MJcacc8NpBhHU5A6JakXyd5pcmx9p3JyVHyTw6KJL
	D9MuRkufidSSPi59Dpqn7pIQvGVKy3finFNm2wcfkHc178I5RJOyNKpw=
X-Google-Smtp-Source: AGHT+IF5KMcdkvWq3TQCHcrcuCWqETJhwMNPVbuBqj4QRbdiumXNaq0bk9pV10iAbEA317tZ9KF/XffY4nDYJL6J+xrMDFV5qaNu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1302:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4b9abe2c204mr377819173.1.1719019502615; Fri, 21 Jun 2024
 18:25:02 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:25:02 -0700
In-Reply-To: <tencent_492ED0AECD4C9AA7EF06DD92D60679099D06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0d3ab061b706a20@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in l2cap_sock_recv_cb

Bluetooth: hci0: command tx timeout
Oops: general protection fault, probably for non-canonical address 0xdffffc000000002e: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000170-0x0000000000000177]
CPU: 0 PID: 4480 Comm: kworker/u9:1 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_publish_rx_avail net/bluetooth/l2cap_sock.c:1137 [inline]
RIP: 0010:l2cap_sock_recv_cb+0x1a0/0x520 net/bluetooth/l2cap_sock.c:1515
Code: df 80 3c 03 00 74 08 4c 89 ff e8 bb dd 7b f7 4d 8b 3f 49 8d bf 74 01 00 00 48 89 f8 48 c1 e8 03 49 bd 00 00 00 00 00 fc ff df <42> 0f b6 04 28 84 c0 0f 85 f3 02 00 00 41 8b 9f 74 01 00 00 49 81
RSP: 0018:ffffc9000d37f468 EFLAGS: 00010207
RAX: 000000000000002e RBX: 1ffff11005827494 RCX: ffff88802f763c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000174
RBP: ffff88802c13a000 R08: ffffffff89459100 R09: 1ffff1100582760c
R10: dffffc0000000000 R11: ffffed100582760d R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888069fbd500 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000001cb4e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_publish_rx_avail net/bluetooth/l2cap_sock.c:1137 [inline]
RIP: 0010:l2cap_sock_recv_cb+0x1a0/0x520 net/bluetooth/l2cap_sock.c:1515
Code: df 80 3c 03 00 74 08 4c 89 ff e8 bb dd 7b f7 4d 8b 3f 49 8d bf 74 01 00 00 48 89 f8 48 c1 e8 03 49 bd 00 00 00 00 00 fc ff df <42> 0f b6 04 28 84 c0 0f 85 f3 02 00 00 41 8b 9f 74 01 00 00 49 81
RSP: 0018:ffffc9000d37f468 EFLAGS: 00010207
RAX: 000000000000002e RBX: 1ffff11005827494 RCX: ffff88802f763c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000174
RBP: ffff88802c13a000 R08: ffffffff89459100 R09: 1ffff1100582760c
R10: dffffc0000000000 R11: ffffed100582760d R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888069fbd500 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feea42b7ffc CR3: 000000007cc74000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 80 3c 03 00 74    	filds  0x7400033c(%rax)
   6:	08 4c 89 ff          	or     %cl,-0x1(%rcx,%rcx,4)
   a:	e8 bb dd 7b f7       	call   0xf77bddca
   f:	4d 8b 3f             	mov    (%r15),%r15
  12:	49 8d bf 74 01 00 00 	lea    0x174(%r15),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  27:	fc ff df
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 f3 02 00 00    	jne    0x32a
  37:	41 8b 9f 74 01 00 00 	mov    0x174(%r15),%ebx
  3e:	49                   	rex.WB
  3f:	81                   	.byte 0x81


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=115864d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1106883e980000


