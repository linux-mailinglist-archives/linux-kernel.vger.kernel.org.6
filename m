Return-Path: <linux-kernel+bounces-329690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9529794C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FE41F2212E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FD182C3;
	Sun, 15 Sep 2024 06:37:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAB1B85EC
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382226; cv=none; b=Cw3liwDqH6TDXA2FMpIxH7RjrpS1OCMbVhEkF4lrxb2xHMDjk4eI3yR1B7/HcrK6lnku0druatNY/cL4o9wcobcRp1WP60eVsCoO4PBJSbZG541hWER5xN+m0LQQCQbF5aEo3u2bQQld1hn0OQ+wsX/zmAe1zCIPJ1L9LT3yL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382226; c=relaxed/simple;
	bh=Jeq9g1EVn0e1rImbpD4xE1bDgDzTm7r1xLB5EfOdgRw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E20wfkYxrZe9H7RkSfbLX3af1bzlrFmCnxHU9kh1gPTMyjLeu0rFslQYlyNWOEKjqnLHumh2cD75njKvWAWNHKMFuTIpE/CHfzLnn4xetN5hj7MH81qgN45ft3yHDb5rCAOZPjLq0sL3TBHc8yterfwh7s1isWkQMp/+Ulnb6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so77861255ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382224; x=1726987024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypphWypHoF0L+XSfbD47L87RzngigBSDDcHldv2D2mc=;
        b=QVxMNl2Oxf/c/D0wleMRL3v4el005SdmnzMPvtpgokZy0tCAljRkl62g68MRPQ14fy
         CvcMsIMrLeNW7UXx1stdHtlAXijrd7NVeTN+elkGSn3deCaAJKH0gziVxH5crh0k9m2H
         1+dEZLuO353vvDVwBMWIL18rOGCwc8i/VP5+EifV2oPTMsnDCnB2EEukWtSnvB7RTbDt
         9bXBNyo0Tbr9qjrWTAMuP+BAd3ElfViLt/D27eAOwPRs4+XHEHqkjasiZN8+9IqmMkR/
         R33G9U0fsJvM2LSMRVour3Bi8EuJTtvMcKngWY9qP81s/L+6T4Y2dP8kZdJzqqU1S6pZ
         d3ug==
X-Forwarded-Encrypted: i=1; AJvYcCX0HZmhQWL4OQSbtbHZW6JsQpP2A5El/yrplL2Bpj13IsTbq3djOsfrRmK47GaSfcax85tcV741VgbyMos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwt1dqyqVJjuzDymoczRSTSPeOManPEkdPBrJc6SDl2ojkajpg
	B6oRziG11hmJVuCccCFl8mHrbmVfHIIVD0Ts7tJp9KbgIWW4vSdKJL8JS9RFkmss8YT27yvQ+OO
	bm2AxSsCIn3T5ffACzqSps13GuhuWFhZFbeI8loiVPPX/jjD2zDLxv+8=
X-Google-Smtp-Source: AGHT+IH/Nopdxom+QwoYSkYEbwMDc4ITO4dz64DvobjgergWm1KT8QzyXt2GUrE44fwZ4ZLqbfFcvhi8VoBnu+mYm2+mgZgYgaLa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a098b2908fmr40529385ab.7.1726382223929; Sat, 14 Sep 2024
 23:37:03 -0700 (PDT)
Date: Sat, 14 Sep 2024 23:37:03 -0700
In-Reply-To: <CAGiJo8QvTyC9NpS5XMy8CzSYv1suZarwWnGdYmXAXhR+NuAhgg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034483d062222af77@google.com>
Subject: Re: [syzbot] [mm?] [exfat?] memory leak in corrupted (2)
From: syzbot <syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in corrupted

2024/09/15 06:35:20 executed programs: 1
2024/09/15 06:35:26 executed programs: 3
BUG: memory leak
unreferenced object 0xffff88811efdfc00 (size 96):
  comm "syz-executor", pid 6043, jiffies 4294946716
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    bb bb bb bb bb 00 00 73 79 7a 30 00 00 00 00 00  .......syz0.....
  backtrace (crc 3da58c63):
    [<ffffffff8163e352>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163e352>] slab_post_alloc_hook mm/slub.c:3996 [inline]
    [<ffffffff8163e352>] slab_alloc_node mm/slub.c:4041 [inline]
    [<ffffffff8163e352>] __kmalloc_cache_noprof+0x282/0x320 mm/slub.c:4188
    [<ffffffff84a65f10>] kmalloc_noprof include/linux/slab.h:681 [inline]
    [<ffffffff84a65f10>] nr_add_node+0xd0/0x1440 net/netrom/nr_route.c:185
    [<ffffffff84a67ed9>] nr_rt_ioctl+0xc49/0x1710 net/netrom/nr_route.c:651
    [<ffffffff84a6025f>] nr_ioctl+0x11f/0x1a0 net/netrom/af_netrom.c:1254
    [<ffffffff843b1052>] sock_do_ioctl+0x82/0x1a0 net/socket.c:1222
    [<ffffffff843b327e>] sock_ioctl+0x14e/0x480 net/socket.c:1341
    [<ffffffff81717166>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81717166>] __do_sys_ioctl fs/ioctl.c:907 [inline]
    [<ffffffff81717166>] __se_sys_ioctl fs/ioctl.c:893 [inline]
    [<ffffffff81717166>] __x64_sys_ioctl+0xf6/0x150 fs/ioctl.c:893
    [<ffffffff8512561e>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff8512561e>] do_syscall_64+0x9e/0x1d0 arch/x86/entry/common.c:83
    [<ffffffff85200130>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811dc39ae0 (size 96):
  comm "syz-executor", pid 6045, jiffies 4294946717
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    bb bb bb bb bb 00 00 73 79 7a 30 00 00 00 00 00  .......syz0.....
  backtrace (crc 2e887761):
    [<ffffffff8163e352>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163e352>] slab_post_alloc_hook mm/slub.c:3996 [inline]
    [<ffffffff8163e352>] slab_alloc_node mm/slub.c:4041 [inline]
    [<ffffffff8163e352>] __kmalloc_cache_noprof+0x282/0x320 mm/slub.c:4188
    [<ffffffff84a65f10>] kmalloc_noprof include/linux/slab.h:681 [inline]
    [<ffffffff84a65f10>] nr_add_node+0xd0/0x1440 net/netrom/nr_route.c:185
    [<ffffffff84a67ed9>] nr_rt_ioctl+0xc49/0x1710 net/netrom/nr_route.c:651
    [<ffffffff84a6025f>] nr_ioctl+0x11f/0x1a0 net/netrom/af_netrom.c:1254
    [<ffffffff843b1052>] sock_do_ioctl+0x82/0x1a0 net/socket.c:1222
    [<ffffffff843b327e>] sock_ioctl+0x14e/0x480 net/socket.c:1341
    [<ffffffff81717166>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81717166>] __do_sys_ioctl fs/ioctl.c:907 [inline]
    [<ffffffff81717166>] __se_sys_ioctl fs/ioctl.c:893 [inline]
    [<ffffffff81717166>] __x64_sys_ioctl+0xf6/0x150 fs/ioctl.c:893
    [<ffffffff8512561e>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff8512561e>] do_syscall_64+0x9e/0x1d0 arch/x86/entry/common.c:83
    [<ffffffff85200130>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810c3ea180 (size 96):
  comm "syz-executor", pid 6049, jiffies 4294947314
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    bb bb bb bb bb 00 00 73 79 7a 30 00 00 00 00 00  .......syz0.....
  backtrace (crc 7ec7dee2):
    [<ffffffff8163e352>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163e352>] slab_post_alloc_hook mm/slub.c:3996 [inline]
    [<ffffffff8163e352>] slab_alloc_node mm/slub.c:4041 [inline]
    [<ffffffff8163e352>] __kmalloc_cache_noprof+0x282/0x320 mm/slub.c:4188
    [<ffffffff84a65f10>] kmalloc_noprof include/linux/slab.h:681 [inline]
    [<ffffffff84a65f10>] nr_add_node+0xd0/0x1440 net/netrom/nr_route.c:185
    [<ffffffff84a67ed9>] nr_rt_ioctl+0xc49/0x1710 net/netrom/nr_route.c:651
    [<ffffffff84a6025f>] nr_ioctl+0x11f/0x1a0 net/netrom/af_netrom.c:1254
    [<ffffffff843b1052>] sock_do_ioctl+0x82/0x1a0 net/socket.c:1222
    [<ffffffff843b327e>] sock_ioctl+0x14e/0x480 net/socket.c:1341
    [<ffffffff81717166>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81717166>] __do_sys_ioctl fs/ioctl.c:907 [inline]
    [<ffffffff81717166>] __se_sys_ioctl fs/ioctl.c:893 [inline]
    [<ffffffff81717166>] __x64_sys_ioctl+0xf6/0x150 fs/ioctl.c:893
    [<ffffffff8512561e>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff8512561e>] do_syscall_64+0x9e/0x1d0 arch/x86/entry/common.c:83
    [<ffffffff85200130>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810c32eea0 (size 96):
  comm "syz-executor", pid 6051, jiffies 4294947315
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    bb bb bb bb bb 00 00 73 79 7a 30 00 00 00 00 00  .......syz0.....
  backtrace (crc f02899b5):
    [<ffffffff8163e352>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163e352>] slab_post_alloc_hook mm/slub.c:3996 [inline]
    [<ffffffff8163e352>] slab_alloc_node mm/slub.c:4041 [inline]
    [<ffffffff8163e352>] __kmalloc_cache_noprof+0x282/0x320 mm/slub.c:4188
    [<ffffffff84a65f10>] kmalloc_noprof include/linux/slab.h:681 [inline]
    [<ffffffff84a65f10>] nr_add_node+0xd0/0x1440 net/netrom/nr_route.c:185
    [<ffffffff84a67ed9>] nr_rt_ioctl+0xc49/0x1710 net/netrom/nr_route.c:651
    [<ffffffff84a6025f>] nr_ioctl+0x11f/0x1a0 net/netrom/af_netrom.c:1254
    [<ffffffff843b1052>] sock_do_ioctl+0x82/0x1a0 net/socket.c:1222
    [<ffffffff843b327e>] sock_ioctl+0x14e/0x480 net/socket.c:1341
    [<ffffffff81717166>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81717166>] __do_sys_ioctl fs/ioctl.c:907 [inline]
    [<ffffffff81717166>] __se_sys_ioctl fs/ioctl.c:893 [inline]
    [<ffffffff81717166>] __x64_sys_ioctl+0xf6/0x150 fs/ioctl.c:893
    [<ffffffff8512561e>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff8512561e>] do_syscall_64+0x9e/0x1d0 arch/x86/entry/common.c:83
    [<ffffffff85200130>] entry_SYSCALL_64_after_hwframe+0x77/0x7f



Tested on:

commit:         0babf683 Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1772f49f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aff2ee6dd356627d
dashboard link: https://syzkaller.appspot.com/bug?extid=e1c69cadec0f1a078e3d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1682f49f980000


