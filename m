Return-Path: <linux-kernel+bounces-428473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FD9E0EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8958165706
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7991DF74B;
	Mon,  2 Dec 2024 22:32:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54611DF269
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178726; cv=none; b=V8bz7+NJvAb3aZ6+hRGHEhEOLnHopWrhJvkmSrlkE0s5hBrT0ajyiiVC0a25T7STydRN/PaBVq/FFKHzEwGx318sVzjiFQKB7xMI86TFCdDxhBmXMp98vwxjnLG7BFd9WoRNW16oBSec6ulb1MshV84y317rqZKap3G5U2cO9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178726; c=relaxed/simple;
	bh=dCZDK+vl2Dd3aaqFcMdXizoRo5sRnJPo4C7k7UlM9e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qcMiEL7W9xuuHkcZxL/57D+NUlyu9xyFjQa0FZhkHnyCCU9ERS8beTR4ZdpWMUPO3Dlbu7OB/rCVux36/Llr0Qw4QK9saj54IJ3Gtil4kwtJN/P8gsUueZT3pUadkxTs4dRv5KBpzTWZAQWy9qMnTAW+YZNAWJzWYjPfzLRk4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-843eb4505e7so786781139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178724; x=1733783524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F2PU8DMqXk2Fv8z4fRATKfAq/6ATp/WUTRvinOQpf4=;
        b=ZW9yy/Y8e37DaLLtjjrb8/CGGK1kg5r0NKiHa/bqCIFYoE8b3BlUiN4+ea+L+lx22v
         en+xHM2qRFxI7IF31bXEKLZQstRDWWClcHI3IqOwcZuMtV7ulttlCYtffcHKdSHIPJXc
         z3iMNcM3p+BVfeUVBy+BjzrZLXBqkx3H7icl8YBMns7qWo5vv5ScKGZhaONdb0a0yZ9k
         GZsdM0OE6GV92upI9hwgPzYkn8uBqiGMnwEl6S10DeeVsj2QkW/amqKutPelyMs06Ja/
         vxqPHx6b2xrFd5Vbd2vrOvIjWUZlaPvFSMSP6FGE+Lj/n8P7AkEc06mI9FMvQ/Dpuv7V
         8esg==
X-Forwarded-Encrypted: i=1; AJvYcCUN5SjHld9dDdX6HjbbkDsjY5sd3MWrvuaLmwys2JCTThOtp22iY83JsDG2XAzcxIWZKJgWKZMhxKEM/4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMQzOb6+cLG05gkM49zYyVPa74b6ysZaK32SL9ejOeezq1JpI
	CIApHivPb0dPtmrLTcGSOZPq03fYbQHx+9k39tW8lt5Y3F+wRyBy5uH/OK/Un4349P0PH9YNrbN
	V+EOMwr6cu788mtmUFdYge6gsiex9tXElf9TpEXP5Q3+xnofZPXZ40u0=
X-Google-Smtp-Source: AGHT+IEXRO3mmwNt+nb2XWtfIXvacrHvenp74XOqWRxZfNUVgec6cONtY/FpCVRSpmuGUyaDeequdwlJ07oHXLGsEFBXCtj3NkKT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1382:b0:3a7:7ded:53b9 with SMTP id
 e9e14a558f8ab-3a7f9ab0ef0mr2228445ab.20.1733178723867; Mon, 02 Dec 2024
 14:32:03 -0800 (PST)
Date: Mon, 02 Dec 2024 14:32:03 -0800
In-Reply-To: <cb177d36-82c1-4dbc-8f77-2619c79f93b8@fastmail.fm>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e3563.050a0220.17bd51.003c.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: bernd.schubert@fastmail.fm, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in fuse_copy_do

fuse: *val=0000000000000000 buf=ffff88807d82c550, cs->write=0 op-code=15
------------[ cut here ]------------
kernel BUG at fs/fuse/dev.c:810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6694 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-g4e968a4c8fcf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:fuse_copy_do+0x334/0x3d0 fs/fuse/dev.c:810
Code: 74 05 e8 7f f8 f5 fe 8b 6b 3c e8 67 10 93 fe 8b 4c 24 0c 41 89 e8 4c 89 fe 48 8b 14 24 48 c7 c7 40 05 a9 8b e8 6d 48 72 fe 90 <0f> 0b 48 8b 7c 24 10 e8 50 f8 f5 fe e9 2e fd ff ff 48 89 df e8 43
RSP: 0018:ffffc90003407898 EFLAGS: 00010286
RAX: 0000000000000048 RBX: ffff8880249eb220 RCX: ffffffff81794fa9
RDX: 0000000000000000 RSI: ffffffff8179f976 RDI: 0000000000000005
RBP: 000000000000000f R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffffc90003407978
R13: ffffc90003407ca4 R14: ffffc90003407c60 R15: 0000000000000000
FS:  00007feebcbfe6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000a000 CR3: 0000000037394000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_copy_one fs/fuse/dev.c:1072 [inline]
 fuse_copy_args+0x1e6/0x770 fs/fuse/dev.c:1090
 copy_out_args fs/fuse/dev.c:1973 [inline]
 fuse_dev_do_write+0x1cc1/0x3720 fs/fuse/dev.c:2059
 fuse_dev_write+0x14f/0x1e0 fs/fuse/dev.c:2094
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feebd97f2bf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 8d 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 8e 02 00 48
RSP: 002b:00007feebcbfdfd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000020008380 RCX: 00007feebd97f2bf
RDX: 0000000000000015 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 0000000000000050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000020000c40 R14: 00007feebdb45fa0 R15: 00007fff5d43f8a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fuse_copy_do+0x334/0x3d0 fs/fuse/dev.c:810
Code: 74 05 e8 7f f8 f5 fe 8b 6b 3c e8 67 10 93 fe 8b 4c 24 0c 41 89 e8 4c 89 fe 48 8b 14 24 48 c7 c7 40 05 a9 8b e8 6d 48 72 fe 90 <0f> 0b 48 8b 7c 24 10 e8 50 f8 f5 fe e9 2e fd ff ff 48 89 df e8 43
RSP: 0018:ffffc90003407898 EFLAGS: 00010286
RAX: 0000000000000048 RBX: ffff8880249eb220 RCX: ffffffff81794fa9
RDX: 0000000000000000 RSI: ffffffff8179f976 RDI: 0000000000000005
RBP: 000000000000000f R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffffc90003407978
R13: ffffc90003407ca4 R14: ffffc90003407c60 R15: 0000000000000000
FS:  00007feebcbfe6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000a000 CR3: 0000000037394000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4e968a4c debug folio conversion null ptr
git tree:       https://github.com/bsbernd/linux folio-syzbot-debug
console output: https://syzkaller.appspot.com/x/log.txt?x=114a2fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

