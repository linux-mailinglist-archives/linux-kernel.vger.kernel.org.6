Return-Path: <linux-kernel+bounces-404678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CEF9C4723
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57035B2BBE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD851B5338;
	Mon, 11 Nov 2024 20:21:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2A1A9B43
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356467; cv=none; b=eQXePGrkQpXMaCTqFGIUdQ+g53/ukmioQiBQSpF1TdNc7nlofv0TyvCwN1+p8FC2hOcW1OMaaPf8F/YgGBq9X4Meyumu7j7ap8a8cgPM2RKEQbDOZJsAbLlf8e9q7eoTYPx6N3T7BPXqwAFg3BFXKOKCUq7BUmypcda5TIbpCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356467; c=relaxed/simple;
	bh=hTylQsIGxZP01gpe0GZrAezmiPGied2LFpEiNI7zlSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B7HUidpkt/xyNuAcXFjaKg3HzlM6b43svaK1gOGh3YZikMHjvTmpeakUQ3Qd3l5g5DD4XafnPFu+z3Zw4vFEaaEns1S0WO5tn5Mgnms0e8jLu9bezd+3u2pOsn61PXqOX06X3wTet9ox4orYBEeKSvUok4J7U0FLlQigM65wx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso64122865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356465; x=1731961265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjZ5SqRctnO+A0pJrtUMXXQwVg8cH99u+5XIT9ZgSds=;
        b=tUs+8Q5hhr4qZN+InP6p6Xq/6O9aD8B0fwhqmeH3SVSGtkoxWVvZDiTJr/+s9BHcW8
         yq9B2r3dML7ha8T13zKXJZSzfhUZljgGZpnGpdaAlg8wQ/5RLZcqYn6bqnzCboGS23HD
         +ukqiZa2wUoa4SLNK9zzkI+aQ4u/MoeAwb9xsen7OJcjYvsnMOHvq7bqa+Z6YdfNyDVE
         yeKdwhKQwOiOwAnVdSCE2lHKz5FuJb/Jtl9M4tP9MXcTxes+2VT23NR1nNKbeMOYHphg
         rJ5Ue8VI0MrP7Y0YePhzLus7jp1QcLk630JIappIHc4eBxlUEoNpWXMf1/EUOxnDh2Zs
         Bwyg==
X-Forwarded-Encrypted: i=1; AJvYcCXTQ95H7j28b/yOGfBVpWdyDgL2sc3m8WXQunQnJ9nXZXminw4BhyCFTp7+SpbaHN03Z/rg/MPFKmix6zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKLSpcrTFfo+lzN11+ii0T8oP45KzZSIAFzX8HXVaHt3S9vIo
	fz84CgPkdwMI1xziQxpzENZR0e8++iVwO+iffAqBPQHSHlw+nLjVbjFQ5E4zruBE0FWp6NhlkDR
	FSBqQfHwdfU6FoKDbZ2fF8sbXb8+AtZLGFygi5hNnwm7rH5c4hXhbhHI=
X-Google-Smtp-Source: AGHT+IHtDZ3qZwAVlyhJw1Na0QsYuXhcWRu+ctbhVLZqM6EcRVkGNZi9V1A7H+qmyrS9iizYHaY79zL9AVsLAwokaFo0Q56zJec2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a87:b0:3a6:ae3d:920e with SMTP id
 e9e14a558f8ab-3a6f1a0ead7mr132035565ab.13.1731356465610; Mon, 11 Nov 2024
 12:21:05 -0800 (PST)
Date: Mon, 11 Nov 2024 12:21:05 -0800
In-Reply-To: <429d2bea-ef68-4130-bb8a-0fb5fd38663c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67326731.050a0220.1fb99c.0155.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hfs_free_fork

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa90 fs/namei.c:4469
 do_unlinkat+0x823/0xe10 fs/namei.c:4533
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x76/0xa0 fs/namei.c:4579
 x64_sys_call+0x30d3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:88
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
 hfs_free_fork+0x3bb/0xa50 fs/hfs/extent.c:316
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa90 fs/namei.c:4469
 do_unlinkat+0x823/0xe10 fs/namei.c:4533
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x76/0xa0 fs/namei.c:4579
 x64_sys_call+0x30d3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6013 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd38c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1e659028faecb9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

