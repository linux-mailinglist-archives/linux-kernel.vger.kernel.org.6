Return-Path: <linux-kernel+bounces-303026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF86960656
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C191C22886
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B819DF5B;
	Tue, 27 Aug 2024 09:55:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FE18D65C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752525; cv=none; b=MuO59Ug+in9Itg3Z9gIL0AbiN93MYizM8f8RL2Wo76a11wpP2tM0HWnmxWXHdcXzRjPt1VAQkysptIKbjUqOTPUviFhSXP04o8gkpiU35ZaZh/Bu8WQg8BdUpWU29m7POKEdlEiyAhDmCFRoCx8a95nRkYjgesCQhOny/MQPsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752525; c=relaxed/simple;
	bh=wWnyctfdCVn9IhNbl2qDxTmXpoL0S8pz2qiqAEKkvrA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k/c1tYJyaA7uiD/hfOGjKK5iQhY9DoTdhPEymDYTDfVXnYlFfY7vxpMzf7zMvwY3f6FqOFGBkr8huH2DxmuQ/qZci8judD3CAbC1WaFZv2oT/z7QiBZSLm0F8ic2ndPVTc2SlPdFth5IG6SkA5Lc68trTEEuukAfR4geYlcNbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d49576404so58650415ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752522; x=1725357322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0kNyv7fNXRKOPzrM+ThwbmBEMrRU1hCayUpBO5ejJ0=;
        b=rPz7j7jLxFzMkGSk2r7f6XVQryItHahMqhi/xbV3ChldEA2Oun3eA/w3xSfFy3NfuF
         nGeVWFnE71Yp+m9iYlqXnWhdsyX46pDVX/JXB6hgrynLjPCd7HFH4NxfzTA0e1Yic87P
         vqBvcjupyzUw1em8Hf2MFy+LUBWYtnEDPXQ0NSrf9YvaAAfUZw3bJTGLEte3wPNKXw9Y
         iNjWRngCUn8rOfs+p8YThz/q5qqqf/qYiBrsEucLK3Faoqq4aqMtVbqe0s+A0DY2mWrY
         ko6fR69aUyFZxQza0tN23r72SQUSGFuBGRSnupJwTFS4GTBuPO2AwZHWeuLknhWfx0ol
         8e7w==
X-Forwarded-Encrypted: i=1; AJvYcCWFv7efG6JF9IyvNFfSG2hk4VBjrysdNRqOnS7EwxDlwirO5rl+lNnA17lfmVm+DQafzT46OLIrdYqN3dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHcx82XGwX1nA2kfiVGiCojhspUATvYfQOGnJILj4LOfRZ3nF
	GEiTobuhVjq1STMj55XR4UKJsMWMKkwFlIARi6lzpGOUqmTv6JfK85JTfkUOalUzzjEKu8is3fa
	qOvu8M8h52cNrlYekwB/2EhvtBXm+g4tXl/Xepjx0pOz2y7BPHnbUkKU=
X-Google-Smtp-Source: AGHT+IE5oFjr2H4O3YDKEgFXHtzDMB9o0CBTA893gxQPt3zb5iv06tv44u2SVyPDiMUlyeRbJCqvfH1m/YdcN7LVdekvB0LsXjvQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39e3c8e3417mr9353125ab.0.1724752522567; Tue, 27 Aug 2024
 02:55:22 -0700 (PDT)
Date: Tue, 27 Aug 2024 02:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ef2e80620a73de3@google.com>
Subject: [syzbot] [mm?] general protection fault in ksm_do_scan
From: syzbot <syzbot+ab2cf748d72119c9c291@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1112122b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=ab2cf748d72119c9c291
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93f88e5414fe/disk-3e9bff3b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e9efe39c78f/vmlinux-3e9bff3b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9963bfff0cc9/bzImage-3e9bff3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab2cf748d72119c9c291@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000084: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000420-0x0000000000000427]
CPU: 0 UID: 0 PID: 36 Comm: ksmd Not tainted 6.11.0-rc5-syzkaller-00015-g3e9bff3bbe13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:scan_get_next_rmap_item mm/ksm.c:2557 [inline]
RIP: 0010:ksm_do_scan+0x792/0x6700 mm/ksm.c:2669
Code: 89 e7 48 c7 c6 ff ff ff ff e8 8a 72 b2 09 49 89 c6 48 85 c0 4c 89 7c 24 58 0f 84 c9 0a 00 00 49 8d 5e 20 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ff 60 01 00 48 8b 1b be 00 00 00
RSP: 0018:ffffc90000ac7b60 EFLAGS: 00010217
RAX: 0000000000000084 RBX: 0000000000000426 RCX: ffff88801b6b8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000ac7d90 R08: ffffffff8babb624 R09: ffffffff8babb4a9
R10: 0000000000000004 R11: ffff88801b6b8000 R12: ffffc90000ac7ce0
R13: dffffc0000000000 R14: 0000000000000406 R15: ffff8880628826c4
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556f065808 CR3: 000000006e7c6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ksm_scan_thread+0x110/0x490 mm/ksm.c:2694
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:scan_get_next_rmap_item mm/ksm.c:2557 [inline]
RIP: 0010:ksm_do_scan+0x792/0x6700 mm/ksm.c:2669
Code: 89 e7 48 c7 c6 ff ff ff ff e8 8a 72 b2 09 49 89 c6 48 85 c0 4c 89 7c 24 58 0f 84 c9 0a 00 00 49 8d 5e 20 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ff 60 01 00 48 8b 1b be 00 00 00
RSP: 0018:ffffc90000ac7b60 EFLAGS: 00010217
RAX: 0000000000000084 RBX: 0000000000000426 RCX: ffff88801b6b8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000ac7d90 R08: ffffffff8babb624 R09: ffffffff8babb4a9
R10: 0000000000000004 R11: ffff88801b6b8000 R12: ffffc90000ac7ce0
R13: dffffc0000000000 R14: 0000000000000406 R15: ffff8880628826c4
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc1b0e7ab8 CR3: 0000000023394000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	89 e7                	mov    %esp,%edi
   2:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
   9:	e8 8a 72 b2 09       	call   0x9b27298
   e:	49 89 c6             	mov    %rax,%r14
  11:	48 85 c0             	test   %rax,%rax
  14:	4c 89 7c 24 58       	mov    %r15,0x58(%rsp)
  19:	0f 84 c9 0a 00 00    	je     0xae8
  1f:	49 8d 5e 20          	lea    0x20(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ff 60 01 00       	call   0x16138
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	be                   	.byte 0xbe
  3d:	00 00                	add    %al,(%rax)


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

