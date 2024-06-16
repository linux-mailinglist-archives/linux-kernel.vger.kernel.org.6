Return-Path: <linux-kernel+bounces-216411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5503909EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BDA1C22819
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051FC44377;
	Sun, 16 Jun 2024 18:10:23 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2737165
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561422; cv=none; b=CYvtQtxasYIMRU/7ZCNcB3E+wMclt0mOqg5Q2Tq7uywSkBhXmKPxZG1YhizTQWph47VDAHBYqejnmx+lYUCXfvHFh5suh924gs7L7rNgGbdkKfRhpc1Ce3Xeuue/x2s2hd1I+nSLr1OENF78jPew+ygi7lB7Lz+zXXJ1J+xZ0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561422; c=relaxed/simple;
	bh=7+7MFyHk11vi9eBTLmKp+v9VUFipyCwofVlIvborQBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h1k2QEkzP/HbopukECZLQrEkKW6kJon9deMn7X68owxjQ6oLcmuHQcUYPlAyOb0RO2Peu17j8OL/OA4jM7S9eaM2v/Bv7PykclLAtriAaRh+4alJMGZYoSZ6NR5S6JKAGx0JQGDaLecZMBgkmUFRgPOa0JEKS+hCs9rtpPoDobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3745fb76682so40471875ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 11:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718561420; x=1719166220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrYU6JDIwS80CxOKwrt5b61jti47MKIp+Id+1DaGeOU=;
        b=NFKRuM93KYKAUCCnyiMbM4N6GH6QVBbsLurnG5neQH9RlVnXbEOt8c6Pf+q56jYsJQ
         oIwlSx6I4K+gGUQJf+wHhw1Es5mA1JW/1pwMPF5SfDYxlcFT80qSbU5/79123oGD0Bds
         AzyJDKF+jCXPRCcj/LPwIm0asNyxuO5hH+ahCu+cJnMszI2QH7crapl/TAjY6kstXLjm
         OFhI1sD/J68KYNla5S1JO1kaKxppa0USomRWBoF5EafwNafvB7ixaij9/cWfiRcwq24U
         kbp9DQljLARCJW2qqF9LwXItEUCTR3eo8uL6qfGzSmqTO3V6Pzqho5JIK/4qKj2fsjQr
         iCjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBo2vS06tAa5s00t8moLtGbLr11Hht86sQe16Y/g3GINB5mUGiHxkV4beUiQKEWYOo01Rion25RUErOXRQD3GswbJrdTef1E4npArQ
X-Gm-Message-State: AOJu0YxDGPVB5gKd+uyq4IXmhLoygHWFAmpdOmTsDnRQdZqW+OIfpNKS
	QdJvD+9gn9Zq2T6TSMGQN3uzqClga94TPhKVwBWonwYJ364ctWZMqOQ9DsIvd64/Zlk/8k6fz/s
	Rm04s1zbiOapixzDRcqucpFDGitKZIaa4OLj2Tso4vPhMfzyPOVoIPZs=
X-Google-Smtp-Source: AGHT+IFXjfNVGVhps53tiw/UPSTIudku3JjQrZDRHQK9ATBhtEZuCdMDQrXUsWhZifzibJ/loToODVsUICXE5d90wuB1BkMZ8OXv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a5:b0:4b9:80a8:3cf3 with SMTP id
 8926c6da1cb9f-4b980a84230mr152116173.6.1718561420086; Sun, 16 Jun 2024
 11:10:20 -0700 (PDT)
Date: Sun, 16 Jun 2024 11:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f82ce5061b05c2b4@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in hsr_forward_skb
From: syzbot <syzbot+b78a03b570e0033aba81@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b61eee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=b78a03b570e0033aba81
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b78a03b570e0033aba81@syzkaller.appspotmail.com

ip6gretap0: entered promiscuous mode
syz_tun: entered promiscuous mode
=====================================================
BUG: KMSAN: uninit-value in hsr_forward_skb+0x268c/0x30e0 net/hsr/hsr_forward.c:618
 hsr_forward_skb+0x268c/0x30e0 net/hsr/hsr_forward.c:618
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5438
 __netif_receive_skb_one_core net/core/dev.c:5542 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5658
 netif_receive_skb_internal net/core/dev.c:5744 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5804
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5587/0x6a00 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 hsr_fill_frame_info+0x538/0x540 net/hsr/hsr_forward.c:533
 fill_frame_info net/hsr/hsr_forward.c:600 [inline]
 hsr_forward_skb+0x6f6/0x30e0 net/hsr/hsr_forward.c:615
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5438
 __netif_receive_skb_one_core net/core/dev.c:5542 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5658
 netif_receive_skb_internal net/core/dev.c:5744 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5804
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5587/0x6a00 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x6a00 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5890 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


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

