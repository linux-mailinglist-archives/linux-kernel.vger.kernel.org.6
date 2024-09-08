Return-Path: <linux-kernel+bounces-320024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15EF970524
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E83B221A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAC4778E;
	Sun,  8 Sep 2024 05:39:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6851114
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725773944; cv=none; b=Sr173dxeAjXwWEpQReRNrR2358XblpWWKAu4ucmNwXFUgP4f+z+5aOe0FkUSKF1Ayv8qGYuSJgiMuueW1at4M+jKZNn73mR3m8IIegwi4r4JKi8boC6bZRjT2IsM9JZBfxbrqLvKNagc6Em5KKCw2Ri78q+vV0VPrjjRrDaJmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725773944; c=relaxed/simple;
	bh=poGalDcET4RTTkyp3nP4JH7jsGhyxh5AUNlBCTilN9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MTG2j2UPXPasxWWwyoFtIj5885tmLhHY55LvZriXGZEyUqV3QxE3hzfZUXqDmEfRuwK72zi4lxbWBsQrUC1kx+IZGVDVHtSWXcF7xWC22R+he9OV05Mi0Ftgcq1PrKNzV7MYavuK5k3yvJdPxa/VGgj5PBl5tzHYVV3mzeFQcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso55667765ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 22:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725773942; x=1726378742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBhJUxcBgSA5iRS3h1YcMTK9YoNeNTsPIchhWvKUDgY=;
        b=nEuxcCYqLwY4iuhfFazlLH7b+ZdBqX3vQOpcOpdXWK3q+5U8E5FfEHj0fbngTKn6cg
         GGP/m9NUO5EZx8R9EFNFWbKwGr3bqb/H/KjrhCHiyXQ5+fMr1NAijqckm1HoHWprI8Gn
         gyhnAVQfdz5qaeFomfMZJyD08xKgcKXi92UaOw8zg06ZXwfGXmidH5rC9XatVKSop6V1
         QYMUnwfgE7zw0SO7Pyp9m/g14y656l+DIXGHxEqyblSJwpx0php6g8+LG5mozMaKviHi
         kSaFbrp0ALL7xgacHPTOTIpIf8YYDYDkVRrgmVQ4lvcQ4e5NmSor4bGN916WY2KmttsG
         zrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVELRsfu+HoaCN/EtzlrRVBw2POiAcR3bvyeD+u0TkgjBQeIQeXfhf3OunV3Kopz8fY812kCierAYJdocc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzV7JyXkXDL77vQajXM0oSjVo9p24TLc01YvXnyHieR0dATpaF
	l/6QheUm5oWnjaL/YwB1lhcnpagEcmwcl/3Ak/78yhqstKQpzOGWeAsmdDqtN3IFz3o9/jg1X11
	oJkJFvRgMh7NKRetTLr9XEHNSZnrV2j3phfpVxQarWQnnkrwakt0pGNk=
X-Google-Smtp-Source: AGHT+IHkzMyEUc+APF9QQVCmNZp9X+YExnOidxZzQyStC3C/0trh1+v05d9mjf5ibPjHwHU3nL9DnFg0kQgaFH1PhXkDcsimvScC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a0576ae034mr39991735ab.22.1725773942312; Sat, 07 Sep 2024
 22:39:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 22:39:02 -0700
In-Reply-To: <20240908052338.7283-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb63e20621950e5f@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

==================================================================
BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

write to 0xffff888103fc500e of 2 bytes by task 13551 on cpu 0:
 ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
 __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4568
 do_symlinkat+0xe3/0x340 fs/namei.c:4594
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4607
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888103fc500e of 2 bytes by task 13552 on cpu 1:
 ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
 find_group_other fs/ext4/ialloc.c:594 [inline]
 __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4568
 do_symlinkat+0xe3/0x340 fs/namei.c:4594
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4607
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x185c -> 0x185b

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 13552 Comm: syz-executor.1 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ffef29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d10e00580000


