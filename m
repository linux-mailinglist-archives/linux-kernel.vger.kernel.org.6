Return-Path: <linux-kernel+bounces-320034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE8970543
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32159B21566
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FBA31;
	Sun,  8 Sep 2024 06:49:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1533398A
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725778144; cv=none; b=o+HPnRCtqZK3PfACP+QqpGgzw9MMBsDG6GNzGinmjPcxGtUT1Ed9ekCzQ4UzricHWVn7+Qe5SMyCmt8E2zdHJnEDo6X2wYe+DInmpcmkasRB27+vY+SoIMKkT87WqUmly5+yR8/jx0rJNAuVPzHafFaNc2WmarB/fnihD31625k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725778144; c=relaxed/simple;
	bh=ij+Au5mVznGuTpA26ZHeOGyFweWsxWBKAQYSJCK9TUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gdDOHFePjko07aeZ2TQvnn7xvg5vjo0I0doItz9zxcj3kamyZ1EoEsxtn5by9y8HhCqMiG4RNRaKwBjEGml1ev1MgyDTYQVwcjj4OQVG90ALTg4vTNbCDlXzkVrHEf0pQYxdosmIq0+tzYIx0N4RdvrcUPYvdS0mM4iuJn+O7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so61882135ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 23:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725778141; x=1726382941;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHa7DT1ZibHCI99N5ws0ECD/5jKptXCLTBdHxdxwN20=;
        b=LdDDbb8XLeA07TieCVYHQOlMIySs87rJRLVlCLADhbzUgle44+AK4Tj5govT68pRtK
         +yyV9gbLaN0rNW9AEVJqkhd/ZQXpXbj0zX/EFjNuDUY1FKSnpx7Axn3LaAtDR6rfyCUG
         noedzCexeYvN9nKRkNOJir5BJ+4hz9+fRGdekaBE0lIFIaMsRsjltsP05W1/lh10zOu0
         OaMLYaD1pS4Tewl2vKNvdCErAvCmnxTftclY96RFDWNVY4u7Raz6RyF9xJh05F+G/1Wa
         ZbW9y/DhyAMEU5cWwIoEVEyGzHTSVnXK2Nx5Jgb3W1iu9pUHVFrS6KDNJgj6sY7+dZb1
         pm5w==
X-Forwarded-Encrypted: i=1; AJvYcCUbTXLRcH3hxadkdFY4TG+0MNie0l+GTY0C/qaOVqKvzVKc2J9dxqRI7XkRJb6GK394QYET1o0PcOCVBPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw888rdAj63H67PvEtL5a88V/Tk3toIKIACYF75S2BLHfE0+TOW
	F/Oy1Qm6+4Za7aCYLAJTCiDV1yQCKI6Vz94Kh0pwZ51Mh4+dzVz2Izs0w+eJq9T3cZaeJWDPbqQ
	i4BS3xkJZoN08yVzaNEzSLnK7yfqGhUjcbW6LZ42o0u18O2XZU0k0f1I=
X-Google-Smtp-Source: AGHT+IGYWKlwnXRvVWKG1gK4qh6Tgw+2FbwyiJREDH/VhZpe//Yl8wU7pupZ7l4j581ptJadv+mcJMLm6YuadgArBQKY51bx4Bqu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:39f:5c5f:e487 with SMTP id
 e9e14a558f8ab-3a0568a3cc1mr42377405ab.17.1725778141511; Sat, 07 Sep 2024
 23:49:01 -0700 (PDT)
Date: Sat, 07 Sep 2024 23:49:01 -0700
In-Reply-To: <20240908060931.7380-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016108b0621960915@google.com>
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

write to 0xffff8881054ccdd4 of 4 bytes by task 3372 on cpu 1:
 ext4_orphan_del+0x54d/0x6e0 fs/ext4/orphan.c:296
 ext4_evict_inode+0xac3/0xdc0 fs/ext4/inode.c:289
 evict+0x2d7/0x560 fs/inode.c:704
 iput_final fs/inode.c:1838 [inline]
 iput+0x432/0x5c0 fs/inode.c:1864
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4306
 do_rmdir+0x194/0x320 fs/namei.c:4352
 __do_sys_unlinkat fs/namei.c:4528 [inline]
 __se_sys_unlinkat fs/namei.c:4522 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4522
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff8881054ccdd4 of 4 bytes by task 3392 on cpu 0:
 ext4_fill_raw_inode+0x64b/0xe80 fs/ext4/inode.c:4348
 ext4_do_update_inode fs/ext4/inode.c:5151 [inline]
 ext4_mark_iloc_dirty+0x2e9/0xe10 fs/ext4/inode.c:5781
 __ext4_mark_inode_dirty+0x314/0x440 fs/ext4/inode.c:5985
 __ext4_ext_dirty fs/ext4/extents.c:202 [inline]
 ext4_ext_remove_space+0x28ca/0x2c80 fs/ext4/extents.c:3038
 ext4_ext_truncate+0xc4/0x150 fs/ext4/extents.c:4441
 ext4_truncate+0x773/0xb10 fs/ext4/inode.c:4218
 ext4_evict_inode+0x8b4/0xdc0 fs/ext4/inode.c:258
 evict+0x2d7/0x560 fs/inode.c:704
 iput_final fs/inode.c:1838 [inline]
 iput+0x432/0x5c0 fs/inode.c:1864
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4306
 do_rmdir+0x194/0x320 fs/namei.c:4352
 __do_sys_unlinkat fs/namei.c:4528 [inline]
 __se_sys_unlinkat fs/namei.c:4522 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4522
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x0000079a -> 0x0000078b

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3392 Comm: syz-executor.1 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151e1ffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

