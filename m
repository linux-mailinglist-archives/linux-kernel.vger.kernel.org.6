Return-Path: <linux-kernel+bounces-238025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09D924254
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F408E1C23354
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5801BBBD5;
	Tue,  2 Jul 2024 15:28:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D441BA89E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934085; cv=none; b=n95g5UVvH/kOX63RqbMvjt3+dpPSAtotuXUDFfOfRW5mnjSTMLbOS7JjYHS3SOP3hmC9wpGWR83N4E3SNohDUzyFMYX9H3YJ/AmnOqYs/XwNaz+hETRdgHVuAuTWqR1TQRknvWWCBVpzA667J6E9m5GTRzplfqWSH6lvoCYQhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934085; c=relaxed/simple;
	bh=9BcbW3R58Xt26qorPVQMjxexUsj4CEO4CJkf0dkDK+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jRd6zUuFha+eqWUCwQrnC0xWujGuRWpvRyEj6j1u0gpHn056j27SitIrqMmCRZjXa4Olt0iltZFLaQFPbEWigicxbzf2JRfCqBDWkZhwOTN6T97Sk8kCzljoJvWY46tHEWTLnNIr2X+n/kB+AeZj/LLNmsFJmXNSUnGcjQeen20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37714b7f378so48444505ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934082; x=1720538882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm/SFW10p9CDhz9e0IrzOEC4hQ8O7cLnB9cnxNvIrpQ=;
        b=ZDsKLidPBCsEx5/QFvEMmgnuieaQMkSZv5WfbGg8si8hsHs4L2FyRC5wgw+lMcil4l
         NJ/aj+gOvAj8tTX2LVTZAJ5ejlnwLLOvTplVkethoVubf7MNUkvJaOQepRSJDxfuJ5kf
         ddpeAqoVxspEAHQBFaJS9lesouOPd0Bs37wj2lpcS/f9rC5MC5CMLVvnujuUUwAe7m29
         HpeWDFmteoRZiip2ly+t3XPmk+lrQw0bz5C7w4AGTVuURJzqgPNc5G6j8YANpgKCNzc7
         bkayL1tLNbTxAXshzDm9bYY5vXn/TKIOqJgCtF/qb2JJu3KxKO6nM9B6BQhmqJV56eZt
         Esgg==
X-Forwarded-Encrypted: i=1; AJvYcCUY9LOr/wHsq7QzM4QL+upNcaV7wlv9CVJNkIiazz1BJvGZ6j9urD6BGI7BWBP/NTtJELKuCapdc55z9gADtHdcv01QNU+mIBauY67i
X-Gm-Message-State: AOJu0YzAxLdsuY5SOmrUfJNfdM/JXzi3/OGT7fqMBZtbKMOiedKilfAW
	0wuEG5UljXIy9C4gIat0vM3ja8E9s0hick8MMe0FP8L62Yy/aCPhBZ/NQF7tRNWrqk661jOnHXI
	IIc7Ff5CYNhY0p5HgHKIQ+TnM37OtkkLPDyh/4IVg7jtX4K2BVX1ykJQ=
X-Google-Smtp-Source: AGHT+IFkn4D/b1TKuOyqfcYM7t2On3XNHJyTqE6eAqfp55yJTMdTulbmCjlmT+DwwiHUupZnD5jtVhcBOdddYzvbAJt7aRk5z8RY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:271e:b0:4b9:80a8:3cf3 with SMTP id
 8926c6da1cb9f-4bbb6f21bb4mr446557173.6.1719934082580; Tue, 02 Jul 2024
 08:28:02 -0700 (PDT)
Date: Tue, 02 Jul 2024 08:28:02 -0700
In-Reply-To: <tencent_922C096E68955CEA7AED66CC3079766DA40A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007935c061c455c9d@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __nft_release_table

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5991 at net/netfilter/nf_tables_api.c:1667 nf_tables_table_destroy net/netfilter/nf_tables_api.c:1667 [inline]
WARNING: CPU: 1 PID: 5991 at net/netfilter/nf_tables_api.c:1667 __nft_release_table+0xed3/0xf40 net/netfilter/nf_tables_api.c:11521
Modules linked in:
CPU: 1 PID: 5991 Comm: syz.1.21 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:nf_tables_table_destroy net/netfilter/nf_tables_api.c:1667 [inline]
RIP: 0010:__nft_release_table+0xed3/0xf40 net/netfilter/nf_tables_api.c:11521
Code: 8b 04 25 28 00 00 00 48 3b 84 24 e0 00 00 00 75 72 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 9e f2 e0 f7 90 <0f> 0b 90 eb a8 89 d9 80 e1 07 fe c1 38 c1 0f 8c fd f1 ff ff 48 89
RSP: 0018:ffffc9000465f8a0 EFLAGS: 00010293
RAX: ffffffff89b53462 RBX: 0000000000000001 RCX: ffff8880258d8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000465f9d0 R08: ffffffff89b53393 R09: 1ffffffff25f78ca
R10: dffffc0000000000 R11: fffffbfff25f78cb R12: dffffc0000000000
R13: ffff88802be8fb00 R14: ffff8880644edd70 R15: ffff8880644eddc0
FS:  000055556d3a6500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6829251378 CR3: 000000002a83e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nft_rcv_nl_event+0x55f/0x6d0 net/netfilter/nf_tables_api.c:11580
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
RIP: 0033:0x7f052bf75b99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd273700b8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000018813 RCX: 00007f052bf75b99
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: ffffffffffffffff R08: 0000000000000001 R09: 00000004273703cf
R10: 00007f052be00000 R11: 0000000000000246 R12: 00007f052c103fac
R13: 0000000000000032 R14: 00007f052c105aa0 R15: 00007f052c103fa0
 </TASK>


Tested on:

commit:         1c5fc27b Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=120dd466980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b97f05980000


