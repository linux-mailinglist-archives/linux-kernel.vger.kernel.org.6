Return-Path: <linux-kernel+bounces-334742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE497DB84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D41B2198E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DD31C693;
	Sat, 21 Sep 2024 02:50:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9B17BA6
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726887006; cv=none; b=vCsf2jpGcMUtxhW50W1KE/rkrAAlCsD9FR/t0uIEgvbW6JzxsvkH8sOy7fiSFyNcGHk7UFX4Pg7R5b3wzow+WHWPESQcw9xLWazKbaydqqvoM5D7AD8bx9N+q4artIo7CDBnXimWiwSTy4fiVS8WM2vwJ+qs9/SufNaphzNvInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726887006; c=relaxed/simple;
	bh=CK283M+utC8yXEWnXhib6RyS4VG/Uvx1WxK0m4/Ow+4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RrehF761zc9iMQqdFANbvFzD9+63BuGeuHYNDWJzdfFpKsBmdrZLtJHH6eKcqgMaGIadSe06CUHqji/gaEDIQij4gQ3HQegFN4itcqEf4Uf2QyrbYzaC9wd9EFPSbbX8phFcAqGIPdrsVSwgJ9scFwhkxZ6WCMq2Fn08Va/gtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so30140435ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726887003; x=1727491803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOCm5+AOP1YcJpXUziKRaj0OTSw08/b+YKj0XLQtrHQ=;
        b=gyGFk9snLBcNCI2DFShEBp17GTOotsVrqns0DJ8y8tai6sqkFxn5RFSbsgQ1FGmFAE
         SeXG7wAGOlF8uPxCZVqPRn6twh5/xtTR8/cYqRKw0NOE2FUvcMg3ZnHIaS42DtJBRR72
         jiTqEfksKAbGOiYsxltodESpx3bnbgRDS/lZ1ab6IHQmLXkFW+KJQh9xLjvvLjf3ymnU
         iZi038tEOvuEHCwWVzgxSSa/JSajGgA9edq1IZxUArNPf+oHJD9rQEjmfGdmafZ4zYgd
         JLOng70rID3TmV4PMx96mYpyNQ8WvK8c5+Dl710NoyyX8yeugpdr35ET73CwUp9MJP3H
         KpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+L7HIJOWmdaV+Kkx3THxlvMoYixBpN6/vi6NucTx1lIS01h2La72xgPquyuY/D+HsCytcx3ggLk9gURM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbn24mgIvMpKN5cUETGPRl6k4s/uxZjwdCP8KYMpqWKrspmcsQ
	RpumCowjznGlUej/gj/rgldVzHy7uYzvTy5RHLkwvDA6IAfINsScXOpvfOwi0b+wLbzNRGisGRi
	cfIvw8enHzwsbGVU49ubeji0u2PHLFUhRljXgLZklo5Kqi+dJG/OPPYg=
X-Google-Smtp-Source: AGHT+IHu27xXHxU2Ve3KeaHrWvcBEcxf/FoIJtJegp/Eg8zS8nvXAGzIthlGLlUCeq0x/fSofc365URIy8Q28YEJj/C0Jrc0sc63
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a0c8d2e4femr37935555ab.24.1726887002713; Fri, 20 Sep 2024
 19:50:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 19:50:02 -0700
In-Reply-To: <20240921020615.822-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee345a.050a0220.3195df.0027.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in p9_client_create

------------[ cut here ]------------
kmem_cache of name 'syzkaller' already exists
WARNING: CPU: 1 PID: 7290 at mm/slab_common.c:107 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 1 PID: 7290 at mm/slab_common.c:107 __kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Modules linked in:
CPU: 1 UID: 0 PID: 7290 Comm: syz-executor302 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d d0 de 11 8e 74 25 48 8b 7b 60 48 89 ee e8 35 ae 3c 09 85 c0 75 e0 90 48 c7 c7 18 bb 59 8d 48 89 ee e8 01 38 80 ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 bf af 3c 09 48 85 c0 0f 85
RSP: 0018:ffffc90002fef8f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880289cec80 RCX: ffffffff814e16a9
RDX: ffff88806be39e00 RSI: ffffffff814e16b6 RDI: 0000000000000001
RBP: ffffffff9023f4c1 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000008004 R14: ffffc90002fef9f0 R15: 0000000000020018
FS:  000055558975d380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f479381ae40 CR3: 00000000794e6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
 p9_client_create+0xec8/0x11c0 net/9p/client.c:1042
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
 vfs_get_tree+0x92/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47937e7f39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc8834e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f47937e7f39
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007f479383104e R08: 0000000020000300 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdc8834e3c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8ff00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0a1caedf9d578f
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16402ca9980000


