Return-Path: <linux-kernel+bounces-257931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE19380F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E582820B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509685C5E;
	Sat, 20 Jul 2024 11:22:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A335374F5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721474525; cv=none; b=S8ZZnI9NpFUuTVXITieWRS2SEluIPL5AgmaxwMiG5wGQkxHH1X829XVIVD/t3SRSGvulE+RhK7EI5OjpO6LpQGAOYbha0xbhOuAJ7dJIjl5wOYKQEKCMYzXhkhkI+mfmwBFLGdWIddCk1PN9jbSjXYup2ZwOXQ5Ys9h65wyVvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721474525; c=relaxed/simple;
	bh=CkqAdFqjPZRymKPHHls0nIYWF054qNfRzWdIalMjMJA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oPUxtHgsWPOLcSV/L4sIVEBf3MKKGP4RaG2GrPAeE7f5f1ePScor1CAPT6q2G4eQLWboxDeU3BtERxWwr18kbJnJ4+M9tAj5v8JhjtEuPK801HerUBnqDnDFaayi7T7XNSYWfBLRR2oP9Xk8KwDGA+f5h4SIsIb4yF9S0N1Z5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397a99d76baso26683795ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721474523; x=1722079323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moOwreaGeFaUNhSyZbmgvOvyjE4NceXZyKg5BYVGGTc=;
        b=tsuxZwrqhCT/G7ekWB9yCWBg/UZqwlhp4BW3gwqESYa8scX7OdGGwRJVMuuEWDDde5
         IOvjHpju6QciQ7iLMUv4Da675J4kreO1xpH6uusQi81joExZkHbD7WHAMxWyd26UF4cr
         5+tLvwrzXkMu213ZuYMuMNwAg2b15RCVFW0ocEjb7rYZRiVM3GVY3w8Dtj5IFi5qs0g2
         2GkrzLFjLHwlKGYrDffFROEh23g2UdVVc+vLT2qugGwL6bgk2scHWvmriHRyfH+3SuYm
         IB8rYEmzrmvhvee9JJauBF8zT5zACyLqz+89L5HiJN7QaTf8LZxIf3C6sTdXJMmJAZlN
         /tvA==
X-Forwarded-Encrypted: i=1; AJvYcCUeXVFhCMntdOYhByERaoTA4GndABMH2U58nEOU1XD+kOZoXwJg/exNUaZXiXGB4GwAp30FsOBixmle50K5fahcyXVpDZYwr0O2e6P8
X-Gm-Message-State: AOJu0YxoyiLygslMP9/fMQKRrzPePY7P36UDFCm2R+qBfaQnB46uqF43
	w8ns8UN+C+erc4JiWuIbVikMalUW9p+WEq4LJt/NDbQVoknQ3Mey/JNOuhO3y7tutAshfiQcvj2
	syrEsxXlzpH2dA9cqOQzVC8zZMBnSApgZlOWxwGX7wtdzhJKMjrH9w5M=
X-Google-Smtp-Source: AGHT+IHqOF1tXLpu16CJLHzgScyu3juSWdtSFN+idekGCpi4c0nOy8NHbjxsdGsUfrvByTcP1QVJPNOhOPiOFUAxfNEq83ivjmWA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8629:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4c23fe8a057mr110849173.4.1721474523571; Sat, 20 Jul 2024
 04:22:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 04:22:03 -0700
In-Reply-To: <20240720105318.114879-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077b745061dac059c@google.com>
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
BUG: KMSAN: uninit-value in hsr_get_node+0xd1e/0xd40 net/hsr/hsr_framereg.c:275
 hsr_get_node+0xd1e/0xd40 net/hsr/hsr_framereg.c:275
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

CPU: 1 PID: 5476 Comm: syz-executor.0 Not tainted 6.10.0-syzkaller-10729-g3c3ff7be9729-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         3c3ff7be Merge tag 'powerpc-6.11-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13549349980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf984d38d0f9fb49
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150cd8ce980000


