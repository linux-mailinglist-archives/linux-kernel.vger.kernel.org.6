Return-Path: <linux-kernel+bounces-334420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1E97D707
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C83EB21200
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736E17BEB2;
	Fri, 20 Sep 2024 14:43:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B613B2B0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843385; cv=none; b=IZeaU9MOFoeusoSWp2OidJnszweJPAHNitd4QgzDfgCNxwXZhqxpPqjstfd9L8gMOoUzJDKhYKiYj8Z2THy4d2BBPoqO62O2QhhdLKt078+++Aac5Cl08pFKicHaSEY35bFZTTirRO8fpp19om4GDizB3wl75Yt4r5X9A4HI7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843385; c=relaxed/simple;
	bh=MrOuiyQaDiK6iK8swHTqA3HcO0XEnlrOzca+LAiwTio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I3p59FwlL3rr3dlyzY8F+iosD9jsFGpebQm/N2q33SX/M8CTvgq+uT2RuN7kna1xjr5Q5pdXofPYvba6pKpmoRdfy4/UBztQ/tdaUvL+MPwN2jYkFrrQNGsrPJNZOA/Z062HkfAbU8INWsVmd2KrBhTKfKmsWeKVLGNkB1Y5ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso5247065ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726843383; x=1727448183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euNLG1Z12VFcLoSYCf4AIRszQ7wbIEcoAriM1p8HHWk=;
        b=ocYOBRaTMBp6CfDWufhcalkIDkmLtsZhtl79DcYV9NyqRN09ibKqTKy1JlDvhIl7v0
         2Esm1iI/AIPsx19ycSFv9hG2tHptmYzIhWAEzOS7mquT2xJYV6XnI+kbEYfWuDgphAwz
         3FEOuQZ9BNjJp4A0HpZCEbuvT5ptMgzneWKhaJAY8/D9u1yTTmZqlEZo5BL0IaNdyIJA
         LtsNJbOwAVrWgs8/svI6RNQwT5kk2WhVZwPP1U2Ile0uMaipFwBVdQP31S0cstqdZdew
         p0ppdG4q273oz5zC2Z1b/d7dJhIuwefID/1juLE24masEbvWFp0idQGGfhNgLc80yc9e
         K4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUgv2iVcUCU8PNd1fjniezZgHzuoUozVBu6fvRHhpBLKIzCySPcN+Bdjfo784+gsDhHQemnYPfceZGMUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPd6WX3T6CfPKtKIX13M6JFpaaMj3TFrB2Fm+KVPtMO5BjEDN2
	Dgj7wDbMkKEa6DY2ID+Ff3QW/7eH88tIYnbTGQYv0KSag7CKmINos3c+5vXsZSWCBNuhQVpQJcq
	U69Bv1vou6OThsQOBxAWQ7Y1MvDCfYqsuhZ6htlIwHOmb2ULozvcO8m4=
X-Google-Smtp-Source: AGHT+IGmxkb9nfTPPXkviRSPQqjv3M6rxNi4vOMvO+65hJJ+B5UfUUTRVhXrDH/zYdoy76jDWOUAv2R7FQWrsULNld+4c7EuYI81
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:3a0:922f:8e9a with SMTP id
 e9e14a558f8ab-3a0c9d6f2ffmr31072035ab.17.1726843383570; Fri, 20 Sep 2024
 07:43:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 07:43:03 -0700
In-Reply-To: <20240920143350.4194-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed89f7.050a0220.2abe4d.0017.GAE@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in ext4_fill_raw_inode / ext4_orphan_del

==================================================================
BUG: KCSAN: data-race in ext4_fill_raw_inode / ext4_orphan_del

write to 0xffff8881080b3214 of 4 bytes by task 3410 on cpu 1:
 ext4_orphan_del+0x550/0x6e0 fs/ext4/orphan.c:296
 ext4_evict_inode+0xac3/0xdc0 fs/ext4/inode.c:289
 evict+0x2f0/0x570 fs/inode.c:731
 iput_final fs/inode.c:1883 [inline]
 iput+0x42a/0x5b0 fs/inode.c:1909
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4353
 do_rmdir+0x194/0x320 fs/namei.c:4399
 __do_sys_unlinkat fs/namei.c:4575 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4569
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff8881080b3214 of 4 bytes by task 3404 on cpu 0:
 ext4_fill_raw_inode+0x28d/0xe80 fs/ext4/inode.c:4323
 ext4_do_update_inode fs/ext4/inode.c:5148 [inline]
 ext4_mark_iloc_dirty+0x2e9/0xe00 fs/ext4/inode.c:5778
 __ext4_mark_inode_dirty+0x314/0x440 fs/ext4/inode.c:5982
 __ext4_ext_dirty fs/ext4/extents.c:202 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2722 [inline]
 ext4_ext_remove_space+0x126d/0x2c80 fs/ext4/extents.c:2934
 ext4_ext_truncate+0xc4/0x150 fs/ext4/extents.c:4441
 ext4_truncate+0x776/0xb10 fs/ext4/inode.c:4215
 ext4_evict_inode+0x8b4/0xdc0 fs/ext4/inode.c:258
 evict+0x2f0/0x570 fs/inode.c:731
 iput_final fs/inode.c:1883 [inline]
 iput+0x42a/0x5b0 fs/inode.c:1909
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4353
 do_rmdir+0x194/0x320 fs/namei.c:4399
 __do_sys_unlinkat fs/namei.c:4575 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4569
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x0000079c -> 0x0000078b

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3404 Comm: syz-executor.0 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1642ae9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca35e71cb9a0a41
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143cae9f980000


