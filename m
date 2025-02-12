Return-Path: <linux-kernel+bounces-511177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA41A3274B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3998F3A7BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38220E719;
	Wed, 12 Feb 2025 13:41:34 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91920E6F3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367693; cv=none; b=jUkIH2c6hZPsUFs72xZZeaLmRe+/+nLrF3xf9jPewT92tN+eVrsS5EmOpOap6/K8r3HAMEKqmE3MF/0ifFeIiFAa/IODiUWka2ko1mOpzdGZuhxYUsiaNfXfegiaA2W6FeAj+/W8fOTxF58vhYbuhIEixMmcADKcloG+nP6O710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367693; c=relaxed/simple;
	bh=C4JDa3AZTszAFhsNnMRmmsyUBVeHeyukFwGTm4lt7qs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S7kmEkg/D4VRaMKEUnWukqFbxD2/N6+OWoKNNmZkxQttDJrLR5bTKNTTHZKTa5Jqul/kcbuS+pEzjNcShw+FYjsEOg7c+8VmDCxXdhoETNuYdEe0B6jl3iZ9Y7ngdFpH7PTUYnPTEw34HxxEmeoJO6PiaQZ4eW89yzurBbEWaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo47830215ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367691; x=1739972491;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qV2iVCe9A8aeE8PpOX+/swpsuolgCunvj4bgg81YYHY=;
        b=WJDu1+TNSBDU0jMBJvN4xWrLLMZKVc+qG8x48vQmaCHgCF4XlHdWgAo+tJ57vw+vhZ
         53NmET1vcIzoJFo1pd9mQdwpfQOTSvuKopP4f2h4Lsd2Ae0Qb5TNsEq0B3c2Qjasr1Uu
         GHVhX1Hb2PsbrzxWVcw+MZNXVxHqgAXedCsf3uEQKtB/vVJLGDEJusdAqf5CBgbsj6vF
         3vGgWboLk9kBY+EposQEWx/ni4GTG1KOsXgNuoWs6XVYXYmIfJpD/8EcVO1hZNT4sM+/
         xRo0MtC8eYpFnZvsAKXSdyMwIT8yqlPjiyoX1Jdkt/bgz3SHNxTripuArOpfZSxe+pKV
         N1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEu8OILP2nW5cHC9E2VDjQQHeqjg2fBbYwGvwujtBUfQ2U6KgkBD5EAUOU7MciEsjdIZsHLGNyrlyswsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtLvUBif02o2t0Eo3UAAuyMfB1FHOwpwiIDeoJhC2gZX/gomS
	tIcVlLRjOUII6Rbs5yWVMlKXBHWx/o5t4LCpv1vWLqVmKU49XfBoSL+KXFcDly/FLtQc8vlBULu
	llCbuP5icFuI2mcMLiBq2S/STTkYBfXi8spAdoiSK8cOC6x5Fcz1AsQQ=
X-Google-Smtp-Source: AGHT+IFw3OwkQX0l9K11/EE02bzq89ChU/ndRTGJbtmCcixzlNNvSJVmNCfHLvpjXYJ3PorwatpdzZmdR15fb4b635QsM7hVtVGQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138f:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d17c108f15mr28738875ab.19.1739367690996; Wed, 12 Feb 2025
 05:41:30 -0800 (PST)
Date: Wed, 12 Feb 2025 05:41:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aca50a.050a0220.110943.004e.GAE@google.com>
Subject: [syzbot] [modules?] KMSAN: uninit-value in __request_module (6)
From: syzbot <syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com>
To: da.gomez@samsung.com, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    febbc555cf0f Merge tag 'nfsd-6.14-1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137a78e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f90cac5eea091a
dashboard link: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a78e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16adc3f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f90f94285615/disk-febbc555.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a8bb66806c/vmlinux-febbc555.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8af6c511559/bzImage-febbc555.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
 string_nocheck lib/vsprintf.c:633 [inline]
 string+0x3ec/0x5f0 lib/vsprintf.c:714
 vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
 __request_module+0x252/0x9f0 kernel/module/kmod.c:149
 team_mode_get drivers/net/team/team_core.c:480 [inline]
 team_change_mode drivers/net/team/team_core.c:607 [inline]
 team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
 team_option_set drivers/net/team/team_core.c:375 [inline]
 team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2661
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmsg net/socket.c:2659 [inline]
 __do_sys_sendmsg net/socket.c:2664 [inline]
 __se_sys_sendmsg net/socket.c:2662 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1331 [inline]
 netlink_alloc_large_skb+0x1b4/0x280 net/netlink/af_netlink.c:1196
 netlink_sendmsg+0xa96/0x11e0 net/netlink/af_netlink.c:1867
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmsg net/socket.c:2659 [inline]
 __do_sys_sendmsg net/socket.c:2664 [inline]
 __se_sys_sendmsg net/socket.c:2662 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5814 Comm: syz-executor989 Not tainted 6.14.0-rc2-syzkaller-00034-gfebbc555cf0f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

