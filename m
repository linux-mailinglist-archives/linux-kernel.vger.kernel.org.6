Return-Path: <linux-kernel+bounces-187420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BD8CD18A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9168D1C218D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4213C3F1;
	Thu, 23 May 2024 11:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9A13BAFA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465065; cv=none; b=QzWuw36gi8WTUz2MtL7Er99eGZHl4OlXlcuuJVCS7Ry1107tRR2Xw6lNJk769YxgdNArapOKoPyKTrxfr92wYQyPyvhk3/Xgzz0k5iwekilajCDsJSP0PPDr3aalwz98hkZ4mhYhBeYTI4/6/ImnJT0kwIZyFxEmUA/Boa6FmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465065; c=relaxed/simple;
	bh=2NGhynkRxTUHrWt8aNScO4zp5tz5nZiX9q+gOQ8JlvE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NgTC+ufIp2dpW9/SpIT2qJ6pYbbXoGPvVpuR1ZBBdTfiwfMXrncl5rfXP99QoWj5v+6JS8lhAYfVhyH/7DGsXzqhbo4HYsN3+cV/KBfwykset2siX5vZ2oN0K8fVz3Hjy52imTCJ4QlkkB/GP/pjb1hQjK3GERCAIl93lvB8Etw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36d98ad0c7eso19058685ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716465063; x=1717069863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oggesXSuG6glIzqzQ/IjsAzHmi/r6S7I3rPrwVr6uog=;
        b=HEB0jrebrmFtZvMSkQCAcJ7tUy963JpV9ibW0GZ4XXWVWupPHQ2rgbcVvrM3MW+YpW
         VCxL8KDIxmO/m3TTGysXhgfzxWhZ5fqPKQzZfJSedDkyEuhR2F98CRq4s/rV9Jyt+zVe
         NS8hVft5BQ/VGAsmf47z5+9hlcouCxXzoQeInW/Dim+nvFqp922ULZZNYH3Qd16L5Pna
         B402ALdkengibH6b3i5EZbwhm7Co6Qcm/GBslwqtQ/cgI6Qz5N1FsYGaAVP5JS21bC3M
         wJeL13Rh/E+0yxEr22abQeT8KLpgmwu1sQwNqYODeqgbRe+PkennpOqNAtIiXSvjaimz
         Wz5g==
X-Forwarded-Encrypted: i=1; AJvYcCVnbbpX+402IqkO5Je+hkfPplNpDuA5/il3P6N1LhLPBJz4CI5J5NwZRIMmpO6UCyG+UIqw8qMBrYeQtdpwvEB3SN4rhQhfbRf/rk2e
X-Gm-Message-State: AOJu0Yx6oyzJK3IGtj73YymgLwQELX38kORG1MpO8NNFVFcmvA/HnplZ
	WNK6KAblsw12q2Mz7p1f+VO1esBGx62aLx9iF3jetyS+hTxffeQlp+H32ueTtDN3WiemhNmmZ6S
	4ReACLxRKBCOAD0bhaUk1csHRGeN8JBptPsDPdQ33iPBxzxTaCIo9ZN0=
X-Google-Smtp-Source: AGHT+IE6/Hpwn3ZywrSUQHJILlbWupXANHm9v+bdqN3myTQ3tAqxX3JpY8V+wnZz51lUAriPOgZK96MJurhmQhX51mTRz4gFnxcY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:36c:2ed4:8d4c with SMTP id
 e9e14a558f8ab-371f96ed3aemr3641515ab.4.1716465062989; Thu, 23 May 2024
 04:51:02 -0700 (PDT)
Date: Thu, 23 May 2024 04:51:02 -0700
In-Reply-To: <20240523113057.2386-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005966ed06191daad8@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in uart_write (2)
From: syzbot <syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in uart_write

sp0: Synchronizing with TNC
------------[ cut here ]------------
WARNING: CPU: 2 PID: 5387 at drivers/tty/serial/serial_core.c:627 uart_write+0x2c3/0x3e0 drivers/tty/serial/serial_core.c:627
Modules linked in:
CPU: 2 PID: 5387 Comm: syz-executor Not tainted 6.9.0-syzkaller-11924-gde7e71ef8bed-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:uart_write+0x2c3/0x3e0 drivers/tty/serial/serial_core.c:627
Code: 00 00 48 8d 98 9c 03 00 00 48 89 df e8 e6 c9 ec fc f0 ff 0b 0f 94 c3 31 ff 89 de e8 77 dc 90 fc 84 db 75 72 e8 ce e1 90 fc 90 <0f> 0b 90 31 ed e9 23 ff ff ff e8 be e1 90 fc 4c 89 ea 48 b8 00 00
RSP: 0018:ffffc900036a7bd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801f5a8f00 RCX: ffffffff84fd0ab9
RDX: ffff888021d00000 RSI: ffffffff84fd0ac2 RDI: 0000000000000001
RBP: ffffffff94de7028 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffffffff94de6f20
R13: 0000000000000001 R14: ffff88801231cf01 R15: 0000000000000293
FS:  00007f2677c386c0(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555575a07788 CR3: 0000000020ab6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x93b/0xb30 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open+0x9c/0x120 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x318/0x720 drivers/tty/tty_ldisc.c:563
 tiocsetd drivers/tty/tty_io.c:2439 [inline]
 tty_ioctl+0xbdc/0x15f0 drivers/tty/tty_io.c:2739
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2676e7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2677c380c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2676fabf80 RCX: 00007f2676e7cee9
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007f2676ec949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2676fabf80 R15: 00007ffeb4e97fa8
 </TASK>


Tested on:

commit:         de7e71ef mm: simplify and improve print_vma_addr() out..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16d0ae1a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d62832ec0fc911
dashboard link: https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a3a51a980000


