Return-Path: <linux-kernel+bounces-347101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B498CDC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC62A1F22B57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0E194089;
	Wed,  2 Oct 2024 07:34:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD12F2D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854445; cv=none; b=XLIt8dbZ4T022rb+v49s+y23hSI0s0rGSf0aK/VxdwM2ypajZmseH9KxCj4UVmtHlU+D0Zx/0Qzdk2IR67KguImWiIfKcqp4PdLYzDXxIM8nIH9ymJpojYMF/oCNJhf0Qk7oma5/O+7RDgLLch+agZiENAQT3nqG4Ny/jZ2T0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854445; c=relaxed/simple;
	bh=Saz7Ixy7m9Z4lN6PLk/3SPgzyxPZ31aoNX5hYUu0d20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HVYjOwZAU16Sv7hk8JBD7pCLbvxR3ncJ8PLegv5yPTtrFfCERumufjRmh8vWPKECPACTfRiGONWsy7cokixkBUk/+fevDQ/ZZ49SbMEEkHLSbPEgtGHZnvqSvWMXt5L0c8g7wmrHiuRygrvPTD9S+NpNuQnTQOmA03u13tXRsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19665ed40so5643895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854442; x=1728459242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZxOhMPh2iWlxjmeb7PL4ZKwLVUnpX4oxvotAq44LqM=;
        b=DqTYnbm6yrsKqQCG1HAKGEdEKP/rfgnQuqwCwozosjb4ES4YFG+1rSRDqNzpnxYbUT
         fR1v1BjMolb+0cGI8Zw/qwQciNwO4Qr1LxXZVJnbdVXU/NktU38coGjj2GrxySbAgu1N
         GEjnfCYQ/JfLh9BKuixIqeZLNGQDhV8MPBzqK001r0t0AKoDjHSr47Sk4eDUWGrgTFrc
         jERftAikA7mDEbpZKUClRAsWptOD4xByReh/Z57qXS/wugcnFXBFiIBR+LOpEj9KWD6Q
         i0Wli0gq0UL10tCG61NTbF/ptxsWXs8qFVQPtL7hMn6PpIHMPXGq3B9mNnuPq1kuAXAI
         TYqQ==
X-Gm-Message-State: AOJu0YxpXhHzGFNcKDc0UcmdqXLkKgdSJAhX7bdeyuw8O5MG2CN9A2Ta
	10n/UE1pCV82T4B+JnOCZBTzE4FqbPnynaVK6efg+2PotPUB74Q66ru9HXMSBA0jjG9f5z5KrcB
	t+vu1VuuEKF/hFak+7eSUcz5B9SLWsBlWvEChrOz7aV7D4lUJpdhamSI=
X-Google-Smtp-Source: AGHT+IGMEKHKo5tRcggrK4y/Qle/NZKbxKBiyBE8PXLxmfdfJCAP0FKezsw2OLLxNnDOQd0T/t4kdo7EiQA2jr7vzZdzVk42cNrp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a35eb0c259mr44896045ab.5.1727854442163; Wed, 02 Oct 2024
 00:34:02 -0700 (PDT)
Date: Wed, 02 Oct 2024 00:34:02 -0700
In-Reply-To: <CAHiZj8j_3jKyqB=_KB9ctK_hYu_gS6nn0VtDokTrnJ=4P9OGWw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcf76a.050a0220.f28ec.04fb.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfs_ext_cache_extent

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:161 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x6d4/0x820 fs/hfs/extent.c:181
 __hfs_ext_read_extent fs/hfs/extent.c:161 [inline]
 __hfs_ext_cache_extent+0x6d4/0x820 fs/hfs/extent.c:181
 hfs_ext_read_extent fs/hfs/extent.c:204 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:368
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:496
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
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x68d/0xf50 fs/hfs/extent.c:368
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:496
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

CPU: 1 UID: 0 PID: 6040 Comm: syz.0.15 Not tainted 6.12.0-rc1-syzkaller-ge32cde8d2bd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1106539f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1fd45f2013d812f
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1363a580580000


