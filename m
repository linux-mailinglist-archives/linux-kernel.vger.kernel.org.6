Return-Path: <linux-kernel+bounces-404763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A69C47C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615431F215B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38161BD9D7;
	Mon, 11 Nov 2024 21:10:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087821AF0CC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359410; cv=none; b=YGLPPNPdNzsqKosuQb0vRom+HuH/RiP2rARyyUMKdA4AdtoIBfhgzwUkNMjvZSAXNNrOCQAL0WHD6fB0Y3Rp45ZjH6d8RbH9Fua+7mRktlofnpTca2SrbR5wXgQeIjUBfkp2JsLUMj/rvOQUQgdmFA4hV7V+hAiwVpNwsMScrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359410; c=relaxed/simple;
	bh=QFDvcNtpxJEHbf7CuNT5T4tRvh1TWnG60rp8ch5j+yI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZPrVM/S69D9klJR+mskbGnnytpdijtoO7ioA9/JerAjzP68h3YF3oXjaHHatR9zgBm+VRvn8yBWNq7Pf0KDoxDK6Bz9YPaGERnRgYsAioRPdD8C/GpvoGn4IsQxWIMeniIFEicb+AQQEllZ5Mg2FKTMjgl8u8hwgb0TOxNrLrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0354401so621230739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359408; x=1731964208;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qg+LIFk4Sy2QkwFodQyJmmT9oNoom706a5Jc1U6+V64=;
        b=CMTY9ySiLGSNWPMp3YRS+UV2giQgniZxpBcYi9FKj97xsAxicpCbinW/oKeEG3JgCL
         SlyByjK7LXl2ZxfDRJIebGRNktcPwmTg3YnyO0be2ne1FZTcRlLenpqoBZ3GgXzv0YDz
         ijUyIp1d4mkJK09oU7ahKFTorulruQSKmAjOfjI0DTEY8eJh70Kb0lR4qvGxIKikstnq
         Ir1St/4mnU5Gj0hUpTym9aPCmZqu+HKOK3JbBQO+B5S3MbF9Oyie46dp/vH1zekJYLQx
         C/LgIrwLqqsAZfK6ZmlW3xgwzJ2X/yiIu0aeIYO1RaQ6gBcB5aB0/Vi9Nzfvci/6xm81
         R35g==
X-Forwarded-Encrypted: i=1; AJvYcCVXB4e6vOPhVppUciCt9vTHd0xRc8az3ANsUFLX0t0g7M6Zij6C1WGswjtHyVENAaaHgrm8CgIWASr9l90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzonurDrD/lfrnDnWEkT5KpUqTwbMTTZe5HypOli7E0H6oGTw8
	nKx8RC6GvaHklBsiD8j1mjEDOiVELz+upL6Hv0j6gA1p3apAU7Hp5z+KhGbtEo1mf6p49FNTPqk
	gBAc80em4KkiQTmTlrv0zxkeSojfkMjyqt+aJ6LRXruHwTUPd4eVkFMc=
X-Google-Smtp-Source: AGHT+IFb2fMcWfCCLYatwtEn3VhqhT8AOb19iQUqvyj+2pJqM6i2T0jIxQgjHmtdUdS7thXXbd8ULyspnyarS/X/W3SlX4o2CsH1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:3a5:ce8e:a0d9 with SMTP id
 e9e14a558f8ab-3a6f19ca565mr156103495ab.2.1731359408251; Mon, 11 Nov 2024
 13:10:08 -0800 (PST)
Date: Mon, 11 Nov 2024 13:10:08 -0800
In-Reply-To: <9be1baa3-d2f4-4e20-9f13-c6c12f0813dc@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673272b0.050a0220.1fb99c.0159.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfs_ext_cache_extent

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_get_block+0x68d/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6011 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d3bea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d2d076474187685
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

