Return-Path: <linux-kernel+bounces-241411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C1927B2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33D2B223D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E21B374F;
	Thu,  4 Jul 2024 16:33:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295721B1424
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110803; cv=none; b=thXIrwlpTb621gG+Tfywr6gmNdXhWVU8lB2fJp4bwcc4TfVOm3+SyaD6vrkOmQpa7c9/AVrta8yeLX2wiwTEqSeVChC4KCdE/RiCnMz567QJpF/kLPjOxL45kCS4/WyY8NHNstXyKfTSK+wF4giuyF24JBgHwz6AXk0baaV4dEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110803; c=relaxed/simple;
	bh=5ITx1Qun66+GeWVbD/FYi+IU72IBJ5jSnCo7fyr73LI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WOo9d5wMTcbc+iPbOQ+KxZF20rMF32+RiNOLB9PGheJvE+NXz3ThObliK6jjoZ/mtXJ5X9dERNQwGwANzQAOwduEQ9dHmbsvPJo5fW3DqD4L33O25y6PO5t23y3QrbOPJjL7ZN20C9HNBOa8+nmvHTOdKS5YK5tsCBVORw4WUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so92765139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110801; x=1720715601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tG35q1StV/2z7cK6mhk2/Wuuk7vbrJGi0KGHNAimHPA=;
        b=lcKsnL4AXBat8f81CAxdAOHu0qbxIAuV5wN8VVxDNosFGL6f7dacQQE+6+Sdwgs+N0
         KMaffSsjnuu+gOPYWJLnZX8wFlhFr6+pmMf734L7NcnOY5vf3nyerOC/Mqg17zIggSwJ
         vkuvcy0V6VcKYO5jRG4Xw0+pCCPlow7yyJ5MTQBDNqJ+lcs8hmQ0D+s6L9JQzgGajjuK
         /UJl9sEtXIOLdGpVxOZVocLvKcXBZGY+IzsNQxvmENZvNZCewDO8ZKVdXOjuld/y9gmm
         mfm7C3j11xh/uZYlCdiPTsz1LRAcCFZS5vUpxqLYxC48ftwi3epvj4MrUJi2RwknlJJd
         4A2w==
X-Forwarded-Encrypted: i=1; AJvYcCW6J0M2Pg5QBG/1S1RczP95zUtcTGwOTTE9PLFGA06GOkkvcszsYrc4FC8YWnkVJpb1AJLQ9EuvbH4vs1nbpazxy4mGT3hXQneWir1k
X-Gm-Message-State: AOJu0Yzv/DChvygc4IuPIe+GioN2pjTKnmErf4gK685zGfsNJ0I/mxC5
	dWykZJZd9wbMoW5Vvlg1bwUY3GbZBlx0hi/nkUmsaLk3iWO9rsDwDEt0b4a3DtDH4jGKRd4cL0b
	z8vYoGZzKQbxCYqf2gpI2iJpmsxL+XvNV7Mw9CdzlHzWxvtsbX5JESVY=
X-Google-Smtp-Source: AGHT+IGSvKTeR4Ftvy1VSZCCfNPptop45KTh2jm8edQ3/bXDMb60Xma0Hv5Zvta3bZoSo08lS7A2VoxJseIgu1kmLWrHdEMYJWDv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cf:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4bf60321c8amr163624173.1.1720110801300; Thu, 04 Jul 2024
 09:33:21 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:33:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000494468061c6e81ea@google.com>
Subject: [syzbot] [ppp?] KMSAN: uninit-value in ppp_async_push (3)
From: syzbot <syzbot+ec0723ba9605678b14bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1315203c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=ec0723ba9605678b14bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b284e8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1653d768980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec0723ba9605678b14bf@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:548 [inline]
BUG: KMSAN: uninit-value in ppp_async_push+0xc05/0x2660 drivers/net/ppp/ppp_async.c:675
 ppp_async_encode drivers/net/ppp/ppp_async.c:548 [inline]
 ppp_async_push+0xc05/0x2660 drivers/net/ppp/ppp_async.c:675
 ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
 ppp_push+0x220/0x22b0 drivers/net/ppp/ppp_generic.c:1883
 ppp_send_frame drivers/net/ppp/ppp_generic.c:1846 [inline]
 __ppp_xmit_process+0x123a/0x2780 drivers/net/ppp/ppp_generic.c:1646
 ppp_xmit_process+0x100/0x2b0 drivers/net/ppp/ppp_generic.c:1667
 ppp_write+0x63a/0x7d0 drivers/net/ppp/ppp_generic.c:521
 do_loop_readv_writev fs/read_write.c:764 [inline]
 vfs_writev+0xb0e/0x1450 fs/read_write.c:973
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev fs/read_write.c:1119 [inline]
 __se_sys_pwritev fs/read_write.c:1114 [inline]
 __x64_sys_pwritev+0x2e5/0x500 fs/read_write.c:1114
 x64_sys_call+0x3539/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:297
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3961
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1319 [inline]
 ppp_write+0xe5/0x7d0 drivers/net/ppp/ppp_generic.c:509
 do_loop_readv_writev fs/read_write.c:764 [inline]
 vfs_writev+0xb0e/0x1450 fs/read_write.c:973
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev fs/read_write.c:1119 [inline]
 __se_sys_pwritev fs/read_write.c:1114 [inline]
 __x64_sys_pwritev+0x2e5/0x500 fs/read_write.c:1114
 x64_sys_call+0x3539/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:297
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5049 Comm: syz-executor420 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

