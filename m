Return-Path: <linux-kernel+bounces-356455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED899615B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F82817FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A3184523;
	Wed,  9 Oct 2024 07:47:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272217C7CA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460047; cv=none; b=G8nGzRZqvz2ymePonqIlVQebmdkUKW19JuyVqkMAp/gD0O+gcA+EFWSCiDj6EN6i83P421I7WpruQti+VL7+0etuOLQhI9sPJHIT+V3zH6qleuMhaLQnQTxYt1TU1VtNZCVGHuG4pODVFqbn96AtqFiE1IrrTfEj9TTOiOg5zVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460047; c=relaxed/simple;
	bh=UXHinkOY94ThFAFVLGUNMyAmpLG+i0kcbARjnwRivDc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qOCTks/b2djHTogQfzDYJee9SVqqgijsPHif40Ffmtzv93uuT56VXkxqVIfy6SqkSy3daDQd5HN4LCO8B6ECl2qw1uWkV/Mx3RrdTqCpAoy5dwe7qC0NECg3Mc6qNogyzmfzcrWGcapVgC2jqA7Wke1xkg4kdPZ4fzR1JdH1smU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so107952965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460045; x=1729064845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7MVKMrr7sE1cZHiHRDlGfSko2JGv+xv2UHq22/5JtA=;
        b=stNrDOOksfr+KD5TH6NkYKt6TYBnQdAhqNNcdJmmq8oG8QKG4u7I/OwfpiOZFvN5d9
         xOWv8uRWs68Tr4VR50Cukqmhx/sGfvBViGtXqRVYX7+nEo7UbmDoEtYbHzB/h8yg+ZZb
         DLL9GPyki4XKfj+A9MgCxcUTDRDK9LWdm0gtKTrXgOYHgLV6ZKJ3CGSE0Ewc95ApVNgb
         NaJmc00EhT2i8IcOBr0bHozcVBNN6RKOliK9A++Z55uev9B4YnnENXIydINNgOrITgNj
         08NKr7mOZPgBtUX1L4d/csQ1/+W9a60l+VByduckEvv6WXHfLXSM03WC3Z694Yrne8GE
         Gkxg==
X-Forwarded-Encrypted: i=1; AJvYcCUcBUG6P6XAZ3Sbb0hJJjIqeH2wO5MdiJVJIFpOkdHyJTf9hD0Vp475MGp5RonhKRem8I9NYpO9Nyx9rEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6jVK9IAQENNENJRTFm7ngv4zsH7XFgmbCzulD01Oo3f9Az93
	e+r1zkmPPIw7uCdcyLBrbg50jNvKCzcTchLyCRJGzHi1y4H126MJBrQwK93t4cue3uT7RSi+3GH
	mned3QAq6+3gD6w+LvTjf24esWlv4JhkUkwZ7nBeYt+gdATgNlB5yMrU=
X-Google-Smtp-Source: AGHT+IE/H9HfGa47dTrP4jZRVzNp4L4IUSOVG/DCmz0hKK3xVz99KXfKO0bePVHnvz6HATumgWauwPb6+9A/j6nVzdoHd8HpOBjw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154a:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a397d2c553mr15393175ab.22.1728460045344; Wed, 09 Oct 2024
 00:47:25 -0700 (PDT)
Date: Wed, 09 Oct 2024 00:47:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706350d.050a0220.840ef.000e.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (7)
From: syzbot <syzbot+90c2972f9dd6cdcf7b07@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9234a2549cb6 net: phy: bcm84881: Fix some error handling p..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10833bd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=90c2972f9dd6cdcf7b07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05a4f5ae2b6e/disk-9234a254.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/157bcf16a614/vmlinux-9234a254.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f5a2485a15e/bzImage-9234a254.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90c2972f9dd6cdcf7b07@syzkaller.appspotmail.com

------------[ cut here ]------------
hook not found, pf 2 num 0
WARNING: CPU: 0 PID: 11707 at net/netfilter/core.c:517 __nf_unregister_net_hook+0x482/0x800 net/netfilter/core.c:517
Modules linked in:
CPU: 0 UID: 0 PID: 11707 Comm: syz.4.1852 Not tainted 6.12.0-rc1-syzkaller-00147-g9234a2549cb6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__nf_unregister_net_hook+0x482/0x800 net/netfilter/core.c:517
Code: 01 90 48 8b 44 24 10 0f b6 04 28 84 c0 0f 85 6d 03 00 00 48 8b 04 24 8b 10 48 c7 c7 a0 3f 13 8d 8b 74 24 1c e8 5f ff 7b f7 90 <0f> 0b 90 90 e9 39 01 00 00 e8 f0 02 bb f7 e9 5e fc ff ff e8 e6 02
RSP: 0018:ffffc9000486ef00 EFLAGS: 00010246
RAX: 789495961ce19900 RBX: ffff888069756a00 RCX: 0000000000040000
RDX: ffffc9000c6f5000 RSI: 00000000000026ab RDI: 00000000000026ac
RBP: dffffc0000000000 R08: ffffffff8155daa2 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88802715d940
R13: ffff88802715ea50 R14: 0000000000000004 R15: ffff888067836800
FS:  00007f3bff1fb6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3bff1faf98 CR3: 000000007f7ca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0x98/0xe0 net/netfilter/core.c:535
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:384 [inline]
 nf_tables_unregister_hook net/netfilter/nf_tables_api.c:391 [inline]
 nft_table_disable+0x305/0x3c0 net/netfilter/nf_tables_api.c:1221
 nf_tables_table_disable net/netfilter/nf_tables_api.c:1253 [inline]
 nf_tables_commit+0x4e7e/0x91e0 net/netfilter/nf_tables_api.c:10415
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:574 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0xc77/0x2ab0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
 ___sys_sendmsg net/socket.c:2656 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2685
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bfe37dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bff1fb038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3bfe535f80 RCX: 00007f3bfe37dff9
RDX: 0000000000040010 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007f3bfe3f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3bfe535f80 R15: 00007fff127040d8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

