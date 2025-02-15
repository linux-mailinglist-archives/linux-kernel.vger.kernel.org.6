Return-Path: <linux-kernel+bounces-515972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A721A36B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EEF189590C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D2126C18;
	Sat, 15 Feb 2025 02:19:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3270824
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585944; cv=none; b=tR+twIp5LAAvB1m8P1MGXL8IIFQd8OL04h3HMXzQpcfSMIcKYRFXjx7tTg0XjeODLYHmkOqOh9lwhbIhB2cWBK7ZTXAEfW2zxr8OSaHMNJ4t/o6r78VvLvZkhHJXN/HDzjka5ExGqJjOaXDImJNDJ+stTyFBBEHuWRxOF4axNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585944; c=relaxed/simple;
	bh=lxPDGbyVPSQxHP7kTKcKnHS3TLXKcjjx+xqMr4CeR0c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TwOKAgaoh/AqYYb1ExgmwlRaylSx11EFLlctgTEgXmtDOPgNaqE9InWO7jduPeXE1vtS+r2r72+V/ssPmlBES4ZN1rxF3AkH7hQCXt1QEa+ihutGkiBAQg4p9uzK0yGY2HRIdXYOGnWOpDHrxJ2aAQVyMPW5fbeJjmu1JvhfEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d14c647935so50576805ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739585942; x=1740190742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCdLeRAixg7qP339atoYXPGN9YAQS4BvMK2Qc1Uwszk=;
        b=PcKwbB/FMEMTp0DgqZdgrNAvLGq6iEpyYnzZMNQWM1eGAdvaDp+6yAlTcUVEb9QgJ8
         N/vRgbum5P7nVgCwDrT2XlShOsOBu7gax0/s3BFUHekAuKFiROlD9bLYqDSnULrgayEr
         ss40+oJ54ehkH5W9he9JQng3zFLptHMaILTelSwElLuTN231y2JjciyHBENT/tMIOFoU
         VIZTukcFtYHhPj3Lf7y+h4ES05/jh6X6vU0SLuVtE5t9v1oT/Kq0YO746tGtyLS0qa0V
         +jbTLsCejV9i0ftMbPNuiah44A7JExHASCuK8hMgXyIFYfue/PXjM7odHOrl1Ry8u5RK
         37uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRTJLeZ9swvNje+Rwx6mz6yTaHoQS6Kngw7BIqzo9PwKnHFPjGqFKwO7+2lIN1JDJmYlPE2WgitdxQnQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5HU0fjC8wp9ESD+EJKhcmFIbMCjpHcut1Qs6RIXVecxswLyk
	kBt6rY6iKFHB2X8mV++LSZqJLAfVvhvHnITfybw0UrnWk0UPyvAbN5KFCD76z8TZaRrXVmD5MUC
	nf2uKRShRk/EzyPt196KNFw9KXQSdNH6Gz+n4H2ecWRpjz93jcJMG0c4=
X-Google-Smtp-Source: AGHT+IGnByV2PJfl5K4GHZNUdD71Y2UsGpXzyzcyZjla+PdtbxRNbQssZFZInQP5aHr7x4bJzR00tDTVrswzAcaGIqcY+JepgXul
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b29:b0:3d1:8c0a:df5c with SMTP id
 e9e14a558f8ab-3d2809d97fbmr12540725ab.20.1739585942244; Fri, 14 Feb 2025
 18:19:02 -0800 (PST)
Date: Fri, 14 Feb 2025 18:19:02 -0800
In-Reply-To: <tencent_531E37224ACA755D7751666E3C2736789709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aff996.050a0220.21dd3.0062.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in netfs_read_collection

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 103 Comm: kworker/u32:5 Not tainted 6.14.0-rc2-syzkaller-g78a632a2086c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_read_collection_worker
RIP: 0010:netfs_rreq_assess_dio fs/netfs/read_collect.c:374 [inline]
RIP: 0010:netfs_read_collection+0x3045/0x3ce0 fs/netfs/read_collect.c:440
Code: 0f 85 16 0b 00 00 4d 03 a6 88 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 65 08 49 8b 6e 58 48 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 de 0a 00 00 4c 8b 65 10 4d 85 e4 74 7d e8 e3 55
RSP: 0018:ffffc9000171fb10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88804a5f6dd8 RCX: ffffffff82668821
RDX: 0000000000000002 RSI: ffffffff826680c3 RDI: 0000000000000010
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 00000000ff010000
R13: ffff88804a5f7008 R14: ffff88804a5f6d80 R15: ffff88804a5f6f98
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3185ffff CR3: 000000002a4a6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:466
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_rreq_assess_dio fs/netfs/read_collect.c:374 [inline]
RIP: 0010:netfs_read_collection+0x3045/0x3ce0 fs/netfs/read_collect.c:440
Code: 0f 85 16 0b 00 00 4d 03 a6 88 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 65 08 49 8b 6e 58 48 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 de 0a 00 00 4c 8b 65 10 4d 85 e4 74 7d e8 e3 55
RSP: 0018:ffffc9000171fb10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88804a5f6dd8 RCX: ffffffff82668821
RDX: 0000000000000002 RSI: ffffffff826680c3 RDI: 0000000000000010
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 00000000ff010000
R13: ffff88804a5f7008 R14: ffff88804a5f6d80 R15: ffff88804a5f6f98
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3185ffff CR3: 000000002a4a6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 85 16 0b 00 00    	jne    0xb1c
   6:	4d 03 a6 88 02 00 00 	add    0x288(%r14),%r12
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 89 65 08          	mov    %r12,0x8(%rbp)
  1b:	49 8b 6e 58          	mov    0x58(%r14),%rbp
  1f:	48 8d 7d 10          	lea    0x10(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 de 0a 00 00    	jne    0xb12
  34:	4c 8b 65 10          	mov    0x10(%rbp),%r12
  38:	4d 85 e4             	test   %r12,%r12
  3b:	74 7d                	je     0xba
  3d:	e8                   	.byte 0xe8
  3e:	e3 55                	jrcxz  0x95


Tested on:

commit:         78a632a2 Merge tag 'pci-v6.14-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109b19a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17df8bf8580000


