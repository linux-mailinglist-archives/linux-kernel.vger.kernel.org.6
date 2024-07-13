Return-Path: <linux-kernel+bounces-251500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395593059A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAC284275
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090F130A40;
	Sat, 13 Jul 2024 12:38:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253E41C79
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720874309; cv=none; b=GVUYyBd5AagxNgBqqMXyJFdilfWbKLjIgejEoYbpETwPo/oa2cZXzuxxptN6RnDS/dpbGtocJe1BTfcDIeHpNkH7m5aexS4W+j7TdX43UOv1m5+S8rY1BTzbQuQd1fMyreR4Etga0M6q6HPQ8ZGIyWKPweTHDryikCK0pctmW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720874309; c=relaxed/simple;
	bh=CyBaGJoTD+P6AXcRsXv1NSHzFThYQ6nvyANCOigkDtQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ItzLYFC5JGSLVm9UP4zhsdvQuw9z+rfaK/uvml4ouwlfU6kjU7diHU3oGbOg0qQEaNJHgVlFkJo4+/RQPYvXs62OUAAcshLUqG/ORn4zF6mrhOiMUPIEkU3bxNnfG8AkTX3FokwUz2TN+oYrClSTDo9YAXlp1yL0gv9srzIosRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f684ab3f9cso225321439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 05:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720874307; x=1721479107;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbdmrFkaTmpVzzt/gdKNXifzm0BEY4POC6QiUarBLtc=;
        b=GJ7A8316wBrwtaP86whYCIl5PpTdrnqVM9gHbt8zn49EhPSTtvP52kb3mIF8ZW/vmy
         rX8zYYoA4h+ocmEpV1giaxR7m3SMANhvbBDik238zSpMqEAIR+UMeeQCxWPuNTnZQJ6Q
         GBpANAc6LTjC6yfrtk7LhPE+VY67BdbP+aDdE1yp2Wo1IB1brh5oGpSpUTUglPleHZhE
         TRpmHXSG+WDoUyOAemnqGyTuRXFZGzhnKuGEFMlhPdz1J1e4xLh9Mk6V8cc5oLgH1832
         IXO6Xm9c3SgeUs3rtFUKPByb8RWe/EnhNRsnjglDQ7nq+i8YrwDEavN8AaEk3626fQvb
         OdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYTLYdQNynq6I6nFXiJjO9v40MVSKY1Iiwn2a4hANhkM3V7oyKbDeMrqc5391KCXS3wiZlXIdkMttiSPrHFJDHdDKFvx58AZboR6Qc
X-Gm-Message-State: AOJu0YxFH1TMw3q+/kVhRcIjVwvGFvY4YeCXfXrv7qll10RqQqfoAA/n
	J/5xF+u2yr1VWXQ2QiJcmweyK1T/Bep0BHwxIL/0mhDpzZ8B0IlOxkaQ+k8dHfZf34B7vDUuE6W
	IpcovUpIF0gd7Ieuo3gR74evC6WfT+QiyhazQpC8xnKX3Wj6BFwck/lQ=
X-Google-Smtp-Source: AGHT+IHJ6RQI6UMUE8vQTdzq4LsVtJ07j4Qwpi1Zv7lL7eFnEJg0rGCZvi1k7ZqcZ5Qu53SrfAyXQfJ4TW0p618azEUuGbHSUbE5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:620d:b0:805:e4ad:66d6 with SMTP id
 ca18e2360f4ac-80986887221mr27083239f.0.1720874306774; Sat, 13 Jul 2024
 05:38:26 -0700 (PDT)
Date: Sat, 13 Jul 2024 05:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c23a1f061d204564@google.com>
Subject: [syzbot] [mm?] general protection fault in khugepaged (3)
From: syzbot <syzbot+33287c327c3bcd4ea552@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    528dd46d0fc3 Merge tag 'net-6.10-rc8-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f9d0f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38e374b1a3185897
dashboard link: https://syzkaller.appspot.com/bug?extid=33287c327c3bcd4ea552
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01b3c6d9bec7/disk-528dd46d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7db1f2513396/vmlinux-528dd46d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfae1c808981/bzImage-528dd46d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33287c327c3bcd4ea552@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000084: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000420-0x0000000000000427]
CPU: 1 PID: 37 Comm: khugepaged Not tainted 6.10.0-rc7-syzkaller-00254-g528dd46d0fc3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:khugepaged_scan_mm_slot mm/khugepaged.c:2365 [inline]
RIP: 0010:khugepaged_do_scan mm/khugepaged.c:2498 [inline]
RIP: 0010:khugepaged+0x8ec/0x1820 mm/khugepaged.c:2554
Code: e8 39 6d 9d ff 83 44 24 14 01 e9 9b f8 ff ff e8 2a 6d 9d ff 49 8d 7c 24 20 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 ad 0d 00 00 49 8d 7c 24 70 49 8b 6c 24 20 48 b9
RSP: 0018:ffffc90000ad7ce8 EFLAGS: 00010217
RAX: 0000000000000084 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88801bae9e00 RSI: ffffffff81f1c0f6 RDI: 0000000000000426
RBP: 0000000028100077 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000406
R13: 0000000000000200 R14: 1ffff9200015afaf R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020027000 CR3: 000000006a590000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:khugepaged_scan_mm_slot mm/khugepaged.c:2365 [inline]
RIP: 0010:khugepaged_do_scan mm/khugepaged.c:2498 [inline]
RIP: 0010:khugepaged+0x8ec/0x1820 mm/khugepaged.c:2554
Code: e8 39 6d 9d ff 83 44 24 14 01 e9 9b f8 ff ff e8 2a 6d 9d ff 49 8d 7c 24 20 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 ad 0d 00 00 49 8d 7c 24 70 49 8b 6c 24 20 48 b9
RSP: 0018:ffffc90000ad7ce8 EFLAGS: 00010217
RAX: 0000000000000084 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88801bae9e00 RSI: ffffffff81f1c0f6 RDI: 0000000000000426
RBP: 0000000028100077 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000406
R13: 0000000000000200 R14: 1ffff9200015afaf R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2eb1cff8 CR3: 000000001fc08000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	e8 39 6d 9d ff       	call   0xff9d6d3e
   5:	83 44 24 14 01       	addl   $0x1,0x14(%rsp)
   a:	e9 9b f8 ff ff       	jmp    0xfffff8aa
   f:	e8 2a 6d 9d ff       	call   0xff9d6d3e
  14:	49 8d 7c 24 20       	lea    0x20(%r12),%rdi
  19:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  20:	fc ff df
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	0f 85 ad 0d 00 00    	jne    0xde1
  34:	49 8d 7c 24 70       	lea    0x70(%r12),%rdi
  39:	49 8b 6c 24 20       	mov    0x20(%r12),%rbp
  3e:	48                   	rex.W
  3f:	b9                   	.byte 0xb9


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

