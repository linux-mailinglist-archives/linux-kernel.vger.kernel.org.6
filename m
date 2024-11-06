Return-Path: <linux-kernel+bounces-397687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215209BDF03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78E51F23C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0E192B9A;
	Wed,  6 Nov 2024 06:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4F192B61
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875925; cv=none; b=RG/soDwTPqnCtzHxnk5zo/z/tzbFZVp9BomryAjxIABjhQfc4WlQ9XvslzylIzj6KjECLN44nLFH4aa1YfGirQSspgF1HhoGSzCYJjl5VECbiEieqAIqBI7wRIMq+h5tlTGgUvfiPuiz8jG9bc09r9zEHvRj38t6VRtpOVIX928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875925; c=relaxed/simple;
	bh=thZ78sQ1wX7huDUFTibHs6FAEpjcm0/kmHTe99mV+CA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=um7AFLMuS3pGxGGkFbhoV/uXfAmYF4tdBwBkvTeArubPhr6YtRpCppGGCO8x+CjZY9QB/8EDR3cVkhFd5idC+ffB1+RAC6puHHDXjA7Gvxams1Qe3BzFDQRb/cAT3ikrofME7el/9V7AKS/BMqfmHo5nj9NH1w7i2Pp/chKly1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso5367915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730875923; x=1731480723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDAowEPN9O9rsAiw3oeawwDgbLMeqyiOzdmicIqSLSs=;
        b=D0y/5CMfILcsQKPpVz5BNN/DYT3kF7hYhg4PwluwzNirIae5yZrSJ3KLj1YNwzBC/M
         NwWDImUxceAdNCKwYkNpmBeZRWQ8HgIc/nlz9FfqsG50S2oAZifyfvbjGwA6NUCc45wD
         zkLVxlpdxYCIOGA6ab4d99hcoZcA8r3nykTDQ5+StmPfjpy0DQZ7Qkmz78gAbYFVL3F4
         A6W3ZsIkL/wqo9Z4OAwhv9ZVrb0nkek6MRFJFSyY+rx4SxhCjpTgVQHA/7nQbhQ13mm7
         7ExsJoJ6e88/IF4xUy2zhEY7Czh+909wm5ZqwF6SchRzJdOs/ZxFBPhhBIihX7cFvVY4
         3URw==
X-Gm-Message-State: AOJu0YxOJV2DT0xv02W8XwuzDVruKjDBwQX6uP79lb3xpnMx2KQn6qs/
	9nQCK5MPImlls5ZZr2EX7vDeuvTcx2oWwFKKILIaJKys82/wa35C2PpXBa9vkAty4VjKiSTjk1Y
	uRawmEBvPqJV1dsneWiFpQ+b7aa9AlMXsdpz2Nuy8zl2JyQMwhQwtFUA=
X-Google-Smtp-Source: AGHT+IHC3NMphGFt5y38jPKBo1hFcmS3BXLjH76aJnuiazbnogSJ7305vJYo31OdXtdzuf4nKlOnwf12pr3d4A5S91XRx2p/lTbI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c203:0:b0:3a4:f275:c7bf with SMTP id
 e9e14a558f8ab-3a6e2a2970emr11204375ab.6.1730875923528; Tue, 05 Nov 2024
 22:52:03 -0800 (PST)
Date: Tue, 05 Nov 2024 22:52:03 -0800
In-Reply-To: <CAN=OONzCeRjbK6TbqenTyjYSpPh4f1-5UmrzeYcW2anq80P_EA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b1213.050a0220.2a847.1b9d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
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
 hfs_get_block+0x73e/0xf60 fs/hfs/extent.c:366
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
 hfs_get_block+0x699/0xf60 fs/hfs/extent.c:366
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

CPU: 0 UID: 0 PID: 6025 Comm: syz.0.15 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cbf587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8a4f4c5365f96b
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15185d5f980000


