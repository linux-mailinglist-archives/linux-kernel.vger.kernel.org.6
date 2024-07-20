Return-Path: <linux-kernel+bounces-257884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D2938016
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0612823C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB33AC0C;
	Sat, 20 Jul 2024 09:05:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456603207
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466305; cv=none; b=XNzaIXOaQn1fphG0XVh56Fu/Qlj5AfE+KRqfzgvRXK/LdxCkmighufNStnm/e8LhZwNaiMyJA85Rwkq85tfXly9ir5egjmOl5flsjYr5Cs9+GRh968dPx1EmOb7zf6I4YX6pBx80gS+26b0iF9qpz/MfVIiz0Ac5Yd6q7ewDlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466305; c=relaxed/simple;
	bh=UHqTU3lVcPjoa+bA9j3/hLNTNTnx2m8dJzlwIMrzVEU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ieFpcg0LrZ+LLU3MTQBiDtn06gx1hvPATVb0yZNedo3IkuIMbYmhQyh2LLwIYdLBuBWKH4Q7O3BAyQvdCul75pEY7slC6cR6/dkV47J0rITYBKng0WPZX6AqGYZqY8mzo9CQfdx7YSCx5Zd95KaNiTXFwcIL23s4O4URxR9abzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so412067539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721466303; x=1722071103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4vj873Qhr2ONscAfDd93DuWsSLmMagkjDH7UJHKIn4=;
        b=FsFr5tldcA2o8gOEvWdTA5ZyfUs6Xi/CzA8gFYh6qFb5dE7XTxEEoYfEftq9dJ4RVz
         QG5LefvX+XWQFztpGGw6hVnN0FEpxQEIXRhamQ9asaESpM0JQrn1TM7eLeRPRY4VLb4/
         u2QOPdlzM/XrtQLjEdsVxPRrN6zutGrASMres+NzDd2PLAtjxN7oxHEOs9zv130cBpgH
         h+038DWki3FaEvD60di4MZIasGjiZPRc+t0lG/vbQzZfsa//NM18pkUv3qM7MlPm4Mgt
         wUfbEMCy6Hf/3dLQFt26MoWg7H7vOm9xkYBE/h2vGOw7dPLw0awh+eRSc9g2u4Q2iB8B
         OQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXrs7b8/Jc2Yh1bYivQWzS1WOshinh6qMAzamdfUsGTnl/v6APpov8YFFknRqfXcQmFJpVVVFR0oi4pDK0khUHcttXOyyiUGX2FM6Ug
X-Gm-Message-State: AOJu0YwwPqrS360Jba2vdyag6aJfSgOtOaHaDgrhV4QOto5RDSMGWbue
	+O4HIT+FflwDtczVZDxaegs6PoOAQs7Zy/r49hGeWAl4ryeZaXC0MW/ShfMmTkx6PKRrdVbruVp
	NNfWdYLizeM4kiY31RsE5Ic3gHlskjuDKm1cv4ECeggyTvFedrAQfrWA=
X-Google-Smtp-Source: AGHT+IEVDNknQfXAiYZZaFoosrtMPpPmQM+NHPDrb4qsKrwg+G5ErCjhy+gUAUrfSadSxsK+kId2cMMshQsuOWY2mxbiot1NbBjX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3706:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4c23fe461f0mr161700173.3.1721466303334; Sat, 20 Jul 2024
 02:05:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 02:05:03 -0700
In-Reply-To: <20240720083036.80392-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080dd7e061daa1b2a@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hsr_get_node

syz_tun: entered promiscuous mode
batadv_slave_0: entered promiscuous mode
=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xc3b/0xc50 net/hsr/hsr_framereg.c:278
 hsr_get_node+0xc3b/0xc50 net/hsr/hsr_framereg.c:278
 fill_frame_info net/hsr/hsr_forward.c:678 [inline]
 hsr_forward_skb+0xe9d/0x3b40 net/hsr/hsr_forward.c:715
 hsr_handle_frame+0x914/0xbb0 net/hsr/hsr_slave.c:70
 __netif_receive_skb_core+0x1f19/0x6c90 net/core/dev.c:5554
 __netif_receive_skb_one_core net/core/dev.c:5658 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5774
 netif_receive_skb_internal net/core/dev.c:5860 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5920
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5677/0x6b50 drivers/net/tun.c:2006
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3490/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4706
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2336
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2941
 tun_build_skb drivers/net/tun.c:1680 [inline]
 tun_get_user+0x1262/0x6b50 drivers/net/tun.c:1823
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3490/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5477 Comm: syz-executor.0 Not tainted 6.10.0-syzkaller-10729-g3c3ff7be9729-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         3c3ff7be Merge tag 'powerpc-6.11-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12aa2559980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf984d38d0f9fb49
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a8d749980000


