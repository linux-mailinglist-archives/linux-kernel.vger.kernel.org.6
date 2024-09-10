Return-Path: <linux-kernel+bounces-322545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86B972A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5429828571C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66417C7C1;
	Tue, 10 Sep 2024 07:25:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD75174EDB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953106; cv=none; b=Lw63nYnIjJ2HtOoyJcNMfeomuSeV0j2Y39+vpNoHqqKrPcAnWeYtVuyUpcmqLND6DV8X7Q13Je4qH5RpMMKZD9MTULnZr/zdxnHnMe0JghXzw7Fs/8BQx1NndoAeJV43VrULBn08dGKQYahCdrfIzPHJ+Qef7T++s1/z0WkLAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953106; c=relaxed/simple;
	bh=WzCwEcj6er+NidPqBCxkfOUPi91wQVRo269UbwbyMCQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p0dkF8ruhnanyDk16AIyaZoc2IEvJ4klNQWVLm9LwOKVI+sQT+O4QPBnoKq/9+Y2uv8EPtVVlj7kZs2G8ZUYCqq0r/3bDPTXQZNJcPe/bAYJs/6cG64EC3SFEMkEd2EzEPkDty4WCJqSOpkjbOxwDSrP/1/1/iGoCoQlAY0mK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so388232539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953104; x=1726557904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSZ5UiMjogl9Ew9C15Ok50TsgK/Xx0+es/RbB0vZS80=;
        b=Mv69k2pVCKrJr7V0tZ1E8CJ87FL437qzDgH8WJh57MhgVB3ejdMhRel6PaxzTW2Lwa
         EBu73Dh6baJGInflAxeUV+mT7AOKWVMsQ7f/1mim68zABvsDZWA55+pDW1PVnE1B9Zh1
         Nvdq0DjUlKUv+M0SgPr0M04jYTv5V8RGpIw+B7VKLfMuPPjJdK58xHZw+FpEgg5vCumC
         g0KcqsN64tsYzf/4kOA0OwSzZ9wieN+f4D6boFoSeQUldVl4FJmBVbWWUjUqVVHqpmU2
         qCvbNjlyEjWWuY5IptJTNeihSXuONP7QDWjvFXL6/qFOGlA7+giSzwPAgpdXUmMvrlwO
         sARA==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ2NB+t2vM6f3IMuUxVPGPPZlvIod0xTK2yPMvAcRRGLx6ZgcbhrO1N+c9SuTfaijlEIG5K1f5GP2BhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqJxlFGZ1fzy/xxbARBhTZIUTEQTNXq0XerqRDCsBjnkCZUdm
	T49wsCJzIa5k3Sm4dLBo3MOlkM5xECdcnd4Cf5kFFXJtyE1t5ks+0rdk6jfD5MrMQuKPI0+4MLU
	VayQ1mdY70XMC6SmLJs04DT6Vlq3YpyPx0F1h7IJcea96w9rIHNgYFko=
X-Google-Smtp-Source: AGHT+IH+pejJMDt8pCb8uGpN41SBBQbphX38bPUUpeCes/gAhLExQwSlDQg6sbxQuhnlx8JedBkn/AGRVtqF8v9e++SDJ/WH+JCl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b11:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-82a96186a78mr1946120939f.5.1725953104094; Tue, 10 Sep 2024
 00:25:04 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:25:04 -0700
In-Reply-To: <20240910070746.7269-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab391e0621bec510@google.com>
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
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x764/0x770
CPU: 0 UID: 0 PID: 6009 Comm: syz.0.65 Not tainted 6.11.0-rc1-syzkaller-00017-g689ecd06ef8d-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:348
 __stack_chk_fail+0x15/0x20 kernel/panic.c:821
 vprintk_emit+0x764/0x770
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 ntfs_printk+0x3ad/0x420 fs/ntfs3/super.c:93
 ntfs_fill_super+0x2eb8/0x4730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1fc857b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1fc934be68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1fc934bef0 RCX: 00007f1fc857b0ba
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007f1fc934beb0
RBP: 000000002001f800 R08: 00007f1fc934bef0 R09: 0000000000000801
R10: 0000000000000801 R11: 0000000000000246 R12: 000000002001f840
R13: 00007f1fc934beb0 R14: 000000000001f829 R15: 0000000020000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15632a8b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1025a807980000


