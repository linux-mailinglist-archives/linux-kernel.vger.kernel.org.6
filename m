Return-Path: <linux-kernel+bounces-320055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD49705A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC9F1C20FF9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365EE5FEED;
	Sun,  8 Sep 2024 08:01:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05517BA4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782464; cv=none; b=a+44SZUtFz6XJNCvfpw+nutJP8TqHhAxV1T40M5KcOKzFDrG7cs72tJwx1JEh0UyfLXUXq+VZku1a62TcNQq3x6Km+3+GN3zcz4FzMoxCpTqF9e0qhYqOTMwR5nurjwjBj+W3q/dg876rZhGUNbUoK7SQsU4psv+gDJXyiZGYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782464; c=relaxed/simple;
	bh=MgQ5kkdmmjKKEqvs/ok+0LUVcRj+7qMhTerJ+jcYmzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=joDcwUYNZzX3TjiqEjZgRo/dD0UIuWeQ1HXIj3r5ZnjaIlGoSqKgI3wK8jvwsAxDFXjX+4lwV9xgkTq1cBwbP/DTDzOOnT8SrKa6VomIpHZiPn/dahhGDdgxX+nsCRTs3I91TNPIMZRpxqkG1TYZqHzrtJpBq4xpNWZ8Vb7HCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cdc7b7debso71490339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 01:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725782462; x=1726387262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dj53MgpjqImcqnTIiClZa5M8wkQOA7r/GcFou0UMC0o=;
        b=K4UeIoUi5s1kNYcdXIBJk/CCY3EDFsm93LKbpP5IyhQJyT3UpIVg7YwKm5IqdGVsnC
         nbJpXtY/OA+es9mnFIFDbrUeAtTpZ5d4S0GoaZ93kvzn2dTEokka5V+X5EDJdlJDuQ/x
         hLF9WTSxeN+9pdoFvxRXKWe9ciGUn0TNZULKTkme/fTXfiAodTBpT5PpOg7DzSDSYFIc
         mPIX7yZaZBqFV9VLGbK0tL2joXLNlveYYFi6x9eXmlQZ35VuzmZxBlxHo1MvEgA+1Gce
         M0VZzJbdChcHbJqy9dMU2Y2+Da9B7zpvCBHsFngOfmB29qWwpZ3C6Bjkk9GTy79WF13j
         /Idw==
X-Forwarded-Encrypted: i=1; AJvYcCWxirT2EnTf0CQq411+kEg+fts/dXdc151pDbcR7bIvW6BBph0xV/nihjuo2lHZGsh4KGVz8pOTgSjHpA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkESS7+1uxHgiXWAkGjBROIUBo175JkeCe5MA7uZ3D+N09PUS
	dxPnD9RuA347m2MCvXddxFljhkSVBvSy6+GqWl7dsRABEX3yxfxNAgTloWUT35BzUD/76p9MRyq
	usR0ptcodC9p1eHxTG+4r1nKOM3P9JaYd7ls3EQewYHRnfcuVB0o5ntY=
X-Google-Smtp-Source: AGHT+IHpBu45aYzb7as3tfx7l1VYXY+P7ResQkYWihv9GOv2sSsqHfHwX01WeUaKDe714uJyGxHvjZz0JmuIF55jET/ac8ecNLGn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c4:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-82aa4475e7bmr416211839f.0.1725782462212; Sun, 08 Sep 2024
 01:01:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 01:01:02 -0700
In-Reply-To: <20240908074757.8436-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009eb8fe0621970a98@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in pcpu_alloc_noprof / pcpu_free_area

==================================================================
BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_free_area

read-write to 0xffffffff883f872c of 4 bytes by task 3378 on cpu 0:
 pcpu_update_empty_pages mm/percpu.c:602 [inline]
 pcpu_block_update_hint_free mm/percpu.c:1044 [inline]
 pcpu_free_area+0x4dc/0x570 mm/percpu.c:1302
 free_percpu+0x1c6/0xb30 mm/percpu.c:2277
 xt_percpu_counter_free+0x63/0x80 net/netfilter/x_tables.c:1951
 cleanup_entry+0x195/0x1c0 net/ipv6/netfilter/ip6_tables.c:671
 __do_replace+0x470/0x580 net/ipv6/netfilter/ip6_tables.c:1099
 do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
 do_ip6t_set_ctl+0x820/0x8c0 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x126/0x140 net/ipv6/ipv6_sockglue.c:998
 tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
 sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
 do_sock_setsockopt net/socket.c:2324 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
 x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffffffff883f872c of 4 bytes by task 3374 on cpu 1:
 pcpu_alloc_noprof+0x9a5/0x10c0 mm/percpu.c:1894
 xt_percpu_counter_alloc+0x79/0x110 net/netfilter/x_tables.c:1931
 find_check_entry net/ipv4/netfilter/ip_tables.c:526 [inline]
 translate_table+0x921/0xf70 net/ipv4/netfilter/ip_tables.c:716
 do_replace net/ipv4/netfilter/ip_tables.c:1137 [inline]
 do_ipt_set_ctl+0x7bd/0x8b0 net/ipv4/netfilter/ip_tables.c:1635
 nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0xea/0x100 net/ipv4/ip_sockglue.c:1424
 tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
 sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
 do_sock_setsockopt net/socket.c:2324 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
 x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x00000005 -> 0x00000006

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3374 Comm: syz-executor.3 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10691ffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117d8877980000


