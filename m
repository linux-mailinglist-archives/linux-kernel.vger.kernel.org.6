Return-Path: <linux-kernel+bounces-332364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBF97B8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849861F21497
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A644172BD6;
	Wed, 18 Sep 2024 07:58:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744D171E5A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646287; cv=none; b=evnoVlrcatTEeQUUFJ0J4FER7EWPVLo6U0uJXqE2SdpRy5+x3OYIX+ia+RSMYsVeOLy1rhK0Fic3HXEqh/8ASRIe20nbzthfSSfZfMn9umS09hyIIIX/Vx4ZjTcBl040DKfXSDGolMU0lVddt3/KyUVYqXSwVTzOmiXR9mdWV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646287; c=relaxed/simple;
	bh=1UJr3Ss4p9K2f3f7fjao1pXG3JidsEqp2RmMghHm1vE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YlfYfa2btsykTJrx2n+FyqHEBVFUi1Zla50XEHN8eOpPKzvmk+4yEEbAHhZY5sgasdlY3kC1csFzKddhawLShtlMzHvzJw+Pf7eJOj/XCqCgLZJufoKXZD7qd+4w7UrkN/ru0J1SPOAUrZeLAxxzI0I2/3Dgs96TQc+if6il8V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a08aa0f1so40660365ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726646284; x=1727251084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqb/Az+0902z894G30pDJ0WnzdO0itdMF5idFqBKRyU=;
        b=ejMRnhOUKDqykkyx8h6Sv9wIY1+o9ieHlkQAZYYAjwsupFTvjXhCu5kk2FaAiQfpEm
         SBMPKpu1Wl/Swx//QIcC/CFW8rUBByW+CuU1ov0DhHzz7NaDwvyKj/RAjIq/1IW0KcWY
         EmkXJnzmOoeHOIRVzKHTZ5bYVohMCz6L6jd7ROXZNkjc6M+W7YYVEfshv9Ovuo3WfzH1
         HaOpg4fV273Hb7jLXpo1MjslLedpC5wHfZVPviFBuDCgGbDVKesQeK1zS/0XAR6x9uAL
         PJ6JBLK5K4SlLW9iBUBcqYH8D9eAJ98Jo9QGp9djAWxDUi4bIQPaft9iRwTDc/Ot0d2C
         T0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4KwJuSo29LMPzGCIg87VUVDy4PffROc6n1w/sfZipmg/MfHrX+M+dyEeKmWu9SDHmXZq/4fODF9GzkHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERx76J3XhN9A6nHwI9RkADtaMb7VMUCp84Cwz8MlkrXH8rvYC
	DkgwGjFfdQi0lZfDAjbTAV2GL3BZgZbM1RDpsSy4Syon9Dviwk2+nydh+HNVs1BBNnvIA5ceVs/
	OCNklwVDkq5kvY+GBZb2g/FEo7jkLZVY1C0qmsEeSf/ttWEBfep1UWj8=
X-Google-Smtp-Source: AGHT+IGj7xIqYNgPhwmdqhuCmIoiP1eT4Zxv9JvtTZHsPxcf2gNMWvvUOZPG3zGChEfmS7YqYf+gti6jrBalL659fkOZP/MTOt5q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a42:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a09a32e23bmr112713345ab.6.1726646284583; Wed, 18 Sep 2024
 00:58:04 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:58:04 -0700
In-Reply-To: <20240918074624.207621-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007213100622602a43@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in ext4_mb_regular_allocator / mb_mark_used

==================================================================
BUG: KCSAN: data-race in ext4_mb_regular_allocator / mb_mark_used

read-write to 0xffff888100696014 of 4 bytes by task 3404 on cpu 0:
 mb_mark_used+0x128/0xb40 fs/ext4/mballoc.c:2065
 ext4_mb_use_best_found+0xf6/0x2a0 fs/ext4/mballoc.c:2147
 ext4_mb_check_limits fs/ext4/mballoc.c:2211 [inline]
 ext4_mb_complex_scan_group+0x7a7/0x800 fs/ext4/mballoc.c:2527
 ext4_mb_regular_allocator+0x10d4/0x2590 fs/ext4/mballoc.c:2941
 ext4_mb_new_blocks+0x801/0x2020 fs/ext4/mballoc.c:6219
 ext4_ext_map_blocks+0x1070/0x3640 fs/ext4/extents.c:4318
 ext4_map_blocks+0x72a/0xf50 fs/ext4/inode.c:652
 ext4_getblk+0x112/0x500 fs/ext4/inode.c:862
 ext4_bread+0x2c/0x110 fs/ext4/inode.c:918
 ext4_append+0x164/0x2a0 fs/ext4/namei.c:83
 ext4_init_new_dir+0x17b/0x510 fs/ext4/namei.c:2979
 ext4_mkdir+0x313/0x740 fs/ext4/namei.c:3025
 vfs_mkdir+0x1f4/0x320 fs/namei.c:4257
 do_mkdirat+0x12f/0x2a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x4e/0x60 fs/namei.c:4293
 x64_sys_call+0x2cd3/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888100696014 of 4 bytes by task 3444 on cpu 1:
 ext4_mb_good_group_nolock fs/ext4/mballoc.c:2666 [inline]
 ext4_mb_regular_allocator+0x948/0x2590 fs/ext4/mballoc.c:2903
 ext4_mb_new_blocks+0x801/0x2020 fs/ext4/mballoc.c:6219
 ext4_ext_map_blocks+0x1070/0x3640 fs/ext4/extents.c:4318
 ext4_map_blocks+0x72a/0xf50 fs/ext4/inode.c:652
 ext4_getblk+0x112/0x500 fs/ext4/inode.c:862
 ext4_bread+0x2c/0x110 fs/ext4/inode.c:918
 ext4_append+0x164/0x2a0 fs/ext4/namei.c:83
 ext4_init_new_dir+0x17b/0x510 fs/ext4/namei.c:2979
 ext4_mkdir+0x313/0x740 fs/ext4/namei.c:3025
 vfs_mkdir+0x1f4/0x320 fs/namei.c:4257
 do_mkdirat+0x12f/0x2a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x4e/0x60 fs/namei.c:4293
 x64_sys_call+0x2cd3/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x000005ca -> 0x000005c9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3444 Comm: syz-executor.5 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1353bfc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dac6637d61966e53
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fcc69f980000


