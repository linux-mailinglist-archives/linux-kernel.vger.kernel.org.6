Return-Path: <linux-kernel+bounces-311398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CEC96889D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B38F1F22E40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64A20FA9F;
	Mon,  2 Sep 2024 13:20:03 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361320FA8E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283203; cv=none; b=iKrVb3o5hEAZ8vfkBOQJXrW60Uvy6olhtrW2w4Hvv+Yh4RbdOu6SMsupxJKaghwrRdEHXyz/DlCOO1OG7FCahSE8NkhbJjlDPeBl8hPpdjekmAmLDZwpRxvzeICsj/sKp6cuy1t+nUatWvd7CiL7Iw09Qa1BkQ4B9x1U+D/igKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283203; c=relaxed/simple;
	bh=9PyFQUaV/sWZor+6/9dpnu2FT5fKB1l2mGgMu3cwr+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E/eitfsJCmDpb+1s0SHFNHnw3fKdEzjqARh+e/E2S8pkQH7THPoBTPS4jl9i0mrzCkH9Vrg4RUVmXjovJixvpcWPa2b6cZuw4Cp772ani/pM6DWQrF+6ZzhUj0pxlwXp7Vmc9Ut7pgwZwkSkVAKqdQ4VnVwfFd/I8k7oNYtbH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2dee9722so57590925ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283201; x=1725888001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOubH5tw99fL7gFojN1O8E0oGj/guUZZiM/m+dPpPL8=;
        b=XO5UEfrgAqkkIhMdGQOYiQEiXt5XyMcND5m2/b3EafbTuYJK/bhb+m5+rsA7VXBWxx
         bBX3wkuapxIb7GhYtrdMDWDACa9NyrwFOVGYxQUVeS0OqbDHF5RxiW7ah/vMhmd378Xb
         o5P2rc4TU22UDQwiHYlKBt8memXMlYCUAyd7tajtJtWWZ7ilzw3KIfssQD4OOMEuyK/V
         PUwB4PR89qNj/UqwZyltZX3Qo+w0W1wNeE1N71NyuO9RLSODeaZlugKDdr9TXjfzmBR4
         68se1VOv9aVU+D7lnT5liEHYeQHlYDiOcc6gz/W+v8dMYP8xHzIxuAGtVhZHf4SAHXoN
         yGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVjPkDctOQEDBaNTnomoYaC2mJ8jHLbFnrGsJ1qph5qwPi+MHxHYse7FqZ3HIcePZX3hkd0XNCrV3uMbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFW/uvacRzr085vAUl/k8ONE8/G9ZMz1L4KaBBxgHeqPTBJTdm
	krc1+zuqsn9uY4kv6DLx/2CXVdfmzhPSGEF86knREqYh8z7uTaRfdJcjqRrQ9TRnTmKHDJRKVq6
	X/1HpKhh22bhNC3CbtmkILgaY5d0UysxzsoxfuGTiu6O7qGZOweBUR7I=
X-Google-Smtp-Source: AGHT+IEdE51dIAMId5oBPib81NfDK4MV/Bi4N+XnfFkv8PaOFAe5DNmAFB5/OCPdyQVMus1mzBIlw6mydc3JbeD4KmXt4UILuwjk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:39a:eb81:ffa8 with SMTP id
 e9e14a558f8ab-39f410c647bmr7298145ab.6.1725283201321; Mon, 02 Sep 2024
 06:20:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 06:20:01 -0700
In-Reply-To: <20240902124544.6293-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a1dda062122cc9c@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: stack is corrupted in vprintk_emit

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
ntfs3: loop0: Failed to load $UpCase (-22).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x7bd/0x7c0
CPU: 0 UID: 0 PID: 6111 Comm: syz.0.139 Not tainted 6.11.0-rc6-syzkaller-g67784a74e258-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:827
 vprintk_emit+0x7bd/0x7c0
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 ntfs_printk+0x3ad/0x420 fs/ntfs3/super.c:93
 ntfs_fill_super+0x2eb8/0x4730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77a717b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77a7f23e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f77a7f23ef0 RCX: 00007f77a717b0ba
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007f77a7f23eb0
RBP: 000000002001f800 R08: 00007f77a7f23ef0 R09: 0000000000000801
R10: 0000000000000801 R11: 0000000000000246 R12: 000000002001f840
R13: 00007f77a7f23eb0 R14: 000000000001f829 R15: 0000000020000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1323d0c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d34743b6e48523a6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125833db980000


