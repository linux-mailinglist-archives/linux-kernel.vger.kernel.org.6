Return-Path: <linux-kernel+bounces-237919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93440924011
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A0328193B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6691B5837;
	Tue,  2 Jul 2024 14:13:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E31DDD6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929588; cv=none; b=MR45NRVXGwaUBphz0XOk1hmH9mlXjh3NIbXo4Z2aWgxN1DnS/kjy/e59r2GoreFNbpVyi8tnBxrOhH5NHmFBDVxjJGUUYWCOIzn+tJZBUsBMQqj9e4IGcEwE1WlXtYciLJhLuX+63lybNn/LJkoTC/K8K+36s9iUXsXXGajW1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929588; c=relaxed/simple;
	bh=jnV58NGzdZFz1B6UB5rm7b8El9vmE4DV3XzFj/69DAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TW8dGOxPGt18XNWkvQt6I4GmBaI9aXkd5t5DblYcfGUJtFZvFWcWi21UttzRL3T2vGOJ9O3EyMli2vhxgO3553RAdQZ1ZuP0sNxoOJ1aClGQVFnvf2N5izdtOUZbY3h6dFBQgu/jHodyI1TuHkwZRa0QwiOnyKmndHD7xPZSd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6486e0fabso184448739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929586; x=1720534386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZKFhY+i4wgEUYsIi/DCT1nrrM0HKhwgitg/WofMAjM=;
        b=laQa7u35nPCLjW+t5OfSdfLkW1ZzJRierKjXO5LLQscAiPCe1j7NkPs8crVOwsOB+0
         Ur6SGHPUtMH3Ge++Qg/dIOZcv5r2D6JGaAmQxPh+FqxqF8OE9hD130CVnKgR/CKUYMBC
         lT3VoKzW5TbC40c1c8btK2ohYfeRhqSYT1mOp/4iHSICYCZMMjDp2oZ7EFFLeaIrH9/k
         jk0jVvxbe0XrSK83J/RbEohUjmFQmzOpsICHVh9xzGjYM46NGe+f6rOdm2ZW6jizCLce
         /g1W6Fe/C6TrggxJcdoiEqDRvpSieM9sEkvPnfUcHJXuByJX0gxXZ8I1GZ3eGfnd7kdw
         StpA==
X-Forwarded-Encrypted: i=1; AJvYcCUfEk/Ondj2/g1xXCXGQiRdiqov3jh+D/uIe9F/aEMmxPQExWzf4ltH4i70f0s4FVnAuedZCFiAagVxAKmM2IUB2CNBO2tRM09AYX8H
X-Gm-Message-State: AOJu0Yx6pJVa9uJ6ZCgfkznzNWNnkS9J/Yugm2c/rrVxrc0XewNH0i6R
	d1yJZsLFeCXaPRMbVqZsdGuP//Ry5VtyOAen9EhmdlatNeL9kyfj9eu1Bu8h5hOu8y3VvviLsR3
	HVBz8xtaMX8W7jON71KwdBT78c2lEdS2MReAd4EH76SJls5yRsf+iXQc=
X-Google-Smtp-Source: AGHT+IFLyLRvi8MSBjbC+l3Q/Sl2K10d4CedF5VXYqvuwhWDLBwotlUSz0WboYAZCxnMcrVtJyE4JIEfo8Bk7/4yQZ3dMWbXaTQ9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9825:b0:4b9:965:10b8 with SMTP id
 8926c6da1cb9f-4bbb70dad1amr802334173.6.1719929584918; Tue, 02 Jul 2024
 07:13:04 -0700 (PDT)
Date: Tue, 02 Jul 2024 07:13:04 -0700
In-Reply-To: <tencent_1625C3BA12BB3633E59EF81B504BC11B6808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2b3c5061c444f79@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __nft_release_table

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5870 at net/netfilter/nf_tables_api.c:1667 nf_tables_table_destroy net/netfilter/nf_tables_api.c:1667 [inline]
WARNING: CPU: 1 PID: 5870 at net/netfilter/nf_tables_api.c:1667 __nft_release_table+0xed3/0xf40 net/netfilter/nf_tables_api.c:11518
Modules linked in:
CPU: 1 PID: 5870 Comm: syz.3.18 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:nf_tables_table_destroy net/netfilter/nf_tables_api.c:1667 [inline]
RIP: 0010:__nft_release_table+0xed3/0xf40 net/netfilter/nf_tables_api.c:11518
Code: 8b 04 25 28 00 00 00 48 3b 84 24 e0 00 00 00 75 72 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 6e f3 e0 f7 90 <0f> 0b 90 eb a8 89 d9 80 e1 07 fe c1 38 c1 0f 8c fd f1 ff ff 48 89
RSP: 0018:ffffc900045e78a0 EFLAGS: 00010293
RAX: ffffffff89b53392 RBX: 0000000000000001 RCX: ffff88802a273c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900045e79d0 R08: ffffffff89b532c3 R09: 1ffffffff25f78ca
R10: dffffc0000000000 R11: fffffbfff25f78cb R12: dffffc0000000000
R13: ffff88801ee19100 R14: ffff88801181e970 R15: ffff88801181e9c0
FS:  00005555817aa500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 000000001c2b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nft_rcv_nl_event+0x55f/0x6d0 net/netfilter/nf_tables_api.c:11577
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:388
 netlink_release+0x11a6/0x1b10 net/netlink/af_netlink.c:787
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91b1775b99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8ddfaf58 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000019328 RCX: 00007f91b1775b99
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: ffffffffffffffff R08: 0000000000000001 R09: 000000048ddfb26f
R10: 00007f91b1600000 R11: 0000000000000246 R12: 00007f91b1903fac
R13: 0000000000000032 R14: 00007f91b1905aa0 R15: 00007f91b1903fa0
 </TASK>


Tested on:

commit:         1c5fc27b Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107e8ec6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137e0f1e980000


