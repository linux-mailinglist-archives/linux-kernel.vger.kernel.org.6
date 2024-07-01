Return-Path: <linux-kernel+bounces-236162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82791DE49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877C71F23EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5413D899;
	Mon,  1 Jul 2024 11:46:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F739FD0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834364; cv=none; b=OmHE/q3V2bZ0TugZc6QrYmLPsa8SCmR24FaS7fUEDpZM89AQCkYPjfK6J/DXJn8TsiqlUJNrx9qRszRsWpLIVI72eA0QcK2izxRufWrB3lPQUTos+iPIUlg6Kb7Y4q+WiqBQlBnpivCvD27AjqhNYNcrvVocQPRMM/JOwjW+G94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834364; c=relaxed/simple;
	bh=hdPKoylG40W7zl1aTrckDFgmTI1Hbv3Y8O/dZxpHRaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sogWj1MEexjtIrd2k/2mUiQ1Ucot3bvMfvcYWQpdLAuSoFqIOjqipuB/rqQGxKN577RxrPc7ER+7W9JTH8Xb4Vj3qnaU6g+FebXd034Sm9geiq2tHXiVCxuNAAIiYYtAW5kbFP41aUkK2JbmQ6tHpGTR8OPRvFRtcKzs6wltX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb01189491so326912339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834362; x=1720439162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuvPc09B6zLoBMrrjxwzhjQ5I76x5n0j5Rwuao9taCY=;
        b=P08WfXCSMphznB9uneMex92iCXdsDkxGmweRDN7FrNb3exYyhHla0WMkFjKOITUzxZ
         iky1PB3sUdGcClRokOjm4apUA3rZRPU4u++jLjlVzj5/d/aQTHeMprZlNbpEsMDEIM5I
         365IbCIBncxZXmqfOyzF+oeBDhQS+S2qU/+xmGB5YbK4rcMRlkLp1ar5CTs50Z0AeUZS
         +nU+PFteWGjq+oouuJya8SwGyEQEnhGO4+oi7pnFsCvEFfQyg5eZ9RfoMUQpIHne7T+Q
         G+VEG/8mm2uiKZdddJ/tdvmrZKPR8ZXFgTFusVYFcXMaJKIlfbYi/ZAd1pE0JabWwH3X
         fsqA==
X-Gm-Message-State: AOJu0Ywv3NhBysdPTsGN2y29rndQ2Q8DJMEPlD5Vxmo1oOdS21au2KUT
	0D7vSVYUcgYv/aruQSVJuhd9XmjDkL5d4WIP7FFVKxf2nWm8g6mBx9Zr7ThZTblH+wmNvLX8mAP
	HX2H3yzOzmH0gd5ZuUd9zkSzSuc9WEcfh9J6drJfbbe18ew8C/OFhxdM=
X-Google-Smtp-Source: AGHT+IGf5H/026/2sjPnOMNgqW04h0GGiyEvCnLqkb47chVHykRq6OTMa/WwDP0FkQRghOcmSGfZa1p0QDLLi1EpnrkeCkOdx32G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130d:b0:4bb:5dc8:5a77 with SMTP id
 8926c6da1cb9f-4bbb669a2aemr321902173.0.1719834361996; Mon, 01 Jul 2024
 04:46:01 -0700 (PDT)
Date: Mon, 01 Jul 2024 04:46:01 -0700
In-Reply-To: <20240701084542.24151-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000383721061c2e247a@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in __block_commit_write

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 10062 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller-g22a40d14b572 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_commit_write+0x64/0x2b0 fs/buffer.c:2190
lr : __block_commit_write+0x3c/0x2b0 fs/buffer.c:2183
sp : ffff800098507600
x29: ffff800098507610 x28: dfff800000000000 x27: ffff0000dfe252b0
x26: 0000000000000000 x25: dfff800000000000 x24: dfff800000000000
x23: fffffdffc3a7e460 x22: 0000000000000020 x21: 0000000000000020
x20: 0000000000000040 x19: fffffdffc3a7e440 x18: 1fffe000367b23de
x17: ffff80008efed000 x16: ffff80008af20c64 x15: 00000000200000c0
x14: 1fffe0001d3f2204 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffdffc3a7e440 x4 : 0000000000000020 x3 : 0000000000000020
x2 : 0000000000000040 x1 : 0000000000000020 x0 : fffffdffc3a7e440
Call trace:
 __block_commit_write+0x64/0x2b0 fs/buffer.c:2190
 block_write_end+0xb4/0x104 fs/buffer.c:2276
 ext4_da_do_write_end fs/ext4/inode.c:2952 [inline]
 ext4_da_write_end+0x2c4/0xa40 fs/ext4/inode.c:3025
 generic_perform_write+0x394/0x588 mm/filemap.c:4026
 ext4_buffered_write_iter+0x2c0/0x4ec fs/ext4/file.c:299
 ext4_file_write_iter+0x188/0x1780
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x828/0xc78 fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 97f8507d f94002da 91008356 d343fec8 (38796908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f8507d 	bl	0xffffffffffe141f4
   4:	f94002da 	ldr	x26, [x22]
   8:	91008356 	add	x22, x26, #0x20
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38796908 	ldrb	w8, [x8, x25] <-- trapping instruction


Tested on:

commit:         22a40d14 Linux 6.10-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=135d71c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f85e95b525c28b48
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

