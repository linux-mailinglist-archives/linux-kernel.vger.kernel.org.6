Return-Path: <linux-kernel+bounces-225918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1819913776
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282DDB216E2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D70DDAA;
	Sun, 23 Jun 2024 03:08:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51664D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719112084; cv=none; b=cwL5xtToQ1+9auuyHlCyVEmR/FtXWYQ3RwQZzlhoaVOsKmA5mzssLM94wkFkpzdrArGCACMIHcWjTsUuNTIiKbpv/OdGxAr4RwYa5qvJS2kVFmHHFKmGASnritVFU+6CtJHq9rUei+SMBk43uxTR6D+PSXX+ugaTz/q+gMaFB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719112084; c=relaxed/simple;
	bh=6Ingg299o3d9BmICJ8ewIYl8k+dIaQ+HOQct2+HEk6o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JzCDPHsJZNzAiPXMtWl5OcorZx26mUtkAu2TGQaqdNjEuVBN6jdOIuY3JiJ+2r1QQdxp0d79tPo2qdS37amWdYtDK5a0HLDmIQ0ik7es6R5dXhNrLO4QB028iabL8t1IbkerF8LiAXs9WemIn+d2Of+2ESmgo4QjxTA2/6/bu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb01189491so399028339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 20:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719112082; x=1719716882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2od2LA0kBS0NGhuH3zHU+QPbyOIpbQTqAMzkw/s/KLU=;
        b=sInXNqZ7nJM2aVCg+yu/cDRGwadioFGPgDNgA8D544O+990b+uHR0JNjE1UJWsXqeP
         iIeI2Iqtn2s/Z/X+DLmfXvyKWD9W9JFSdz3DMrxzky7Ruriyj1wT0KvkMCrnOyAqkfST
         c3TXmZgLg0QJHGM8aIxdvrOe9KQedKGuM7qJb2lB0puP5XjLeD2AGGv1XxMy32Hok3GX
         ECpEB7LMH1JPeofle3HY8WuAifBpgfFQHeWhLhPRLq/R0Uv+kUEbTAvR1zDp23yN3YKt
         HrAt6D02rypWHvSrUwjO3RWgtq+2YmnuvBhUwqbqxucfhLMdWiMLZ6Tr26XC/uEOvsif
         03IA==
X-Forwarded-Encrypted: i=1; AJvYcCWseyLS+q2BtMWmd/kgmdcnoZ97yJ2dzPHKYeu9tovWxJIE5u1nwr3KO6bHXzi+Jxzc50kk3LHAIciwKugSVlQqD8ChKhxq1/7u0T+T
X-Gm-Message-State: AOJu0YzLa4IsjwCYlK3NA4Upn0J9cpMKQtzNPRu7MQCU+x95vAOlxJgS
	KLjblJZ97UWJJuIOOYaS+nvblZw89TRRuFol1/AYOeDOjfcJiS9OlWIeSLtU6/nBLMzDoiol5CM
	ROX3WXyAmD3QOaT0RduLN5GIhK6yKguxAsDDc8Gu/cXKJOIZA8mQmHDs=
X-Google-Smtp-Source: AGHT+IHeW5YFkur8ep9FTJEQofvaP0e701lxjLEIxVK/UxSTRFgUR+pdLJMrVSUJNYHFe3R31cqsmslIPRUzCGDRUM6e9Sqn+n+/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629f:b0:4b9:a647:36d0 with SMTP id
 8926c6da1cb9f-4b9ec60ef56mr75407173.0.1719112082020; Sat, 22 Jun 2024
 20:08:02 -0700 (PDT)
Date: Sat, 22 Jun 2024 20:08:02 -0700
In-Reply-To: <tencent_F6252CBAF6BB6C338E9E2C1BFF4B971B4308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa689d061b85f8e2@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in hci_req_sync_complete

skb: ffff88802ca99900, skb fc: 0, rskb: ffff88802ca99540, rskb fc: 0, hci_req_sync_complete
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 PID: 65 Comm: kworker/u33:0 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci2 hci_rx_work
RIP: 0010:hci_req_sync_complete+0x217/0x3d0 net/bluetooth/hci_request.c:110
Code: 48 c1 ea 03 80 3c 02 00 0f 85 76 01 00 00 4c 8b b3 08 0e 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 7e 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 3a 01 00 00
RSP: 0018:ffffc90000d27b10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88801edac000 RCX: ffffffff816e69b9
RDX: 000000000000000f RSI: ffffffff816ef706 RDI: 000000000000007e
RBP: ffff88802ca99900 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000005 R12: 0000000000000000
R13: ffff88801edace08 R14: 0000000000000000 R15: 0000000000000c1a
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f599deb91b0 CR3: 000000002af2e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_event_packet+0x963/0x1170 net/bluetooth/hci_event.c:7479
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4074
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hci_req_sync_complete+0x217/0x3d0 net/bluetooth/hci_request.c:110
Code: 48 c1 ea 03 80 3c 02 00 0f 85 76 01 00 00 4c 8b b3 08 0e 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 7e 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 3a 01 00 00
RSP: 0018:ffffc90000d27b10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88801edac000 RCX: ffffffff816e69b9
RDX: 000000000000000f RSI: ffffffff816ef706 RDI: 000000000000007e
RBP: ffff88802ca99900 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000005 R12: 0000000000000000
R13: ffff88801edace08 R14: 0000000000000000 R15: 0000000000000c1a
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f599deb91b0 CR3: 000000001a976000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 76 01 00 00    	jne    0x184
   e:	4c 8b b3 08 0e 00 00 	mov    0xe08(%rbx),%r14
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	49 8d 7e 7e          	lea    0x7e(%r14),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 3a 01 00 00    	jne    0x17a


Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137c4c8e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d3c1fa980000


