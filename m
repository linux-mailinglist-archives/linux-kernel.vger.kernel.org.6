Return-Path: <linux-kernel+bounces-302811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D59603A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA20EB2270F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A9154C0A;
	Tue, 27 Aug 2024 07:50:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB110A3E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745004; cv=none; b=rJKrqc/6jWuS3b6SK7/SQJiSSgYJlwiogdBQAtRfl1ZJFrYvpH4Kx6dFpTi7zpz+Dc2hHufpjTGeOanjA1LJdeNgEBe/VCgepVIuQMrv2pGaAUQa4tzb0Hp96rD/NgeOyji8L+PDPq0v+Nu1g1nCrIyKy8a+HpyzFZtk/f2luKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745004; c=relaxed/simple;
	bh=BsCcT0IKCXLDHe87TPppSZmujsUYYlaysunYv0NvzME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YHwelRcspKakL71cq+FaQfJjHQyABjf/xQwQxdhG18dD0tLNnsqhEKLa+23LgUXOJA+mmP4Z65NCfYrvfiOYGAJSgLWLg5rj0xXJ5Wr8CI94AgzKFPDowYlVMUVsqI8yautgq51SCDfnJteAbi6KSFKV3PyCwgzigtAPh3cXVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2ceca837so61002255ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745002; x=1725349802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RH5chZQXCotpftmFtLHdhhH2fsPOdfPTgvbVhXYv2MA=;
        b=RELQWxwtGBP2sCAQnilTw3iYkOrDJ59bC2iuYm6qfF04aKhZViEArYVR1fbGJDeFFw
         lTTKBgAI/qwWnYSI/xmFYMMcvnUdrCKLBiP5P2rHqYaYVdCRii0RLvPfGn2sGhPqV2Rp
         x3wMuTwOw+F4osIiXpu1Ep7nv/7rAKMPkNaMmwqFMqcISWhqpkX5uOtemFwcjlSmKcAL
         A+N47u6JLgIdL9wPCI2LdlvuAxaKsN8aTtndDpGwVMQ3P7wMWpEvAUavjSIzu7R9fdTW
         oCFxL0gUnXE0CX6Z0PwRRtqzAKAP+6CV2aIyUffq2X8xGLp7Ay/KcFayho4ATsuw9q/Z
         A+4A==
X-Forwarded-Encrypted: i=1; AJvYcCW7582rbV7SQwKnN9kXJDpSkbQz/5fVFixmAbvjzs+oNufwgq1NAZxt8sRInGAixkdv7r7QJd9NtXSeD/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxE0jHrCbOtFLLRP8fgiVO29PLEBk9ofFZE3XBOL8DMaAWaVYt
	lyAsXqzLVDusYNxa3M1kMyMwjXQbHsGeF91qjtU5Vwx37BzNxoYrIS9xSR9JlyPfu8W9eryrPTz
	BEGFVpiuYtgvmp9x7VKBLbmsIcilzZNvBKHhOEyL5PUHnMvnewmvCGts=
X-Google-Smtp-Source: AGHT+IFQyCYK/dwg+6LvtYvf14sem9pxYWUbGpAwkC60MwrzrBevgrPUyYjy/a5SRWUdedumkGhVzsg+UWFuzH5fqePVEFBHmv00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1384:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39e63dd242amr648595ab.2.1724745001762; Tue, 27 Aug 2024
 00:50:01 -0700 (PDT)
Date: Tue, 27 Aug 2024 00:50:01 -0700
In-Reply-To: <tencent_FFC8C6DF52FCC65AC992EECBAECD0CA1A706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002893750620a57d66@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: stack is corrupted in vprintk_emit

ntfs3: loop0: Failed to load $UpCase (-22).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x7bd/0x7c0
CPU: 0 UID: 0 PID: 5851 Comm: syz.0.15 Not tainted 6.11.0-rc5-syzkaller-00015-g3e9bff3bbe13 #0
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
RIP: 0033:0x7f6e3a57b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e3b384e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6e3b384ef0 RCX: 00007f6e3a57b0ba
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007f6e3b384eb0
RBP: 000000002001f800 R08: 00007f6e3b384ef0 R09: 0000000000000801
R10: 0000000000000801 R11: 0000000000000246 R12: 000000002001f840
R13: 00007f6e3b384eb0 R14: 000000000001f829 R15: 0000000020000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         3e9bff3b Merge tag 'vfs-6.11-rc6.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1362847b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

