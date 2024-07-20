Return-Path: <linux-kernel+bounces-257760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F3937E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D3E28251C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3A2F43;
	Sat, 20 Jul 2024 00:38:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F681F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435885; cv=none; b=pjoA2zEMXDzD2ocXXsQfhUUj4s1s0M+Z+HoQZkSe346jjhTjABEtk9BF6CYeNi0iJ4mn7bY3MF+4xitJXqPNAVO2m8W/n8pC86xVzhdfUdNrvzF44pbLZdu1HfUNKWmHZMuoeePqP0dxNmEQjcm4tIyZb6gW5KqJaqlfl5Ivwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435885; c=relaxed/simple;
	bh=82ykkuubhxItZldKkMIw7jis3fsZAdfwotvJElmAUtw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQrNoBlJZsUmH1AlXecgsG/Nk2ba0GNzBnidvotObZD07Xed8s4QCElzXV61IJnFIzVJy0uX1Lv0dUvm+W03xzPkk8MFCtf6FvMb3jFEI4pqHumEgClqpsKUxmtLR53yUjZn5bGqsMF5vUZ9Rwec1HeLfmLuzW+f2w73dA4ozyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-803aad60527so346579539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721435883; x=1722040683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNEDSxG5myYLmoPvfA+g915b7zd8mfcokFwvOJNhDSs=;
        b=ayrmQPsRSWznfr/qfy40aumqa4uPFT01Ysau6SmjChdAIHqoHOy3OopsnXX8SgskN9
         19LAchzAnLsiPKp5kGRgJP9U02Fi9z4mXaS91iDcvEa0fDTOE7BYuI/sxC0CtnMDA9sT
         PHSRb1E8SJcJ1PmA8TMj2FzdyTwZAkmgh8YnEEhKYjhO+b5P+Mxrd6H2bZsJN4hz+twI
         jHIs0UjsxUrTJVHOaARewg/YO0IroDrFA5BXA/0YcmeGB2ERZtqA+Z+5kBAt9MFIt5TD
         TmvArwA6aOkI8/obU/ijTi82cPyMJ9yloXQdTsh65fwWVv9aXXlG60oB2KJt8rFNOV2t
         ZClA==
X-Forwarded-Encrypted: i=1; AJvYcCWLYenhGpnWTcScCcxBinOElmk1Vgoi+qxubgOFKz9uYnIdsJYUKQPen4pVkpyQ79/W8smlZXEnZJrRIG3ZcV44Mcf0Zk7XBiI3zqU7
X-Gm-Message-State: AOJu0YygohA1Vbgb+o32ClizilQv3xZz/qE5NWKxVnOLDavnMgd8DMNo
	BmmzuwYg5g59QrTFWW8LV0xgMyD9j++la+9fRGUY7GVXy9D8zKZxD/0A5OM4Dt8YK5pw5gVzrrG
	J0HSPJiuSDl1pVVp5JVPJaW68v/COBrlzswFm1ARbNhySYZojS1j7O0w=
X-Google-Smtp-Source: AGHT+IGf9ONwwUT2zK0i54SCwUEuXhGAgHIPypP4pfIiZ8SYC1ocOzKDeyOABe/A4SZsqNmrgfcwsaZIOo1i4cBUisY8NOiZyqWG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:258a:b0:4c0:bcff:656b with SMTP id
 8926c6da1cb9f-4c23fd0cf47mr62735173.2.1721435882932; Fri, 19 Jul 2024
 17:38:02 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:38:02 -0700
In-Reply-To: <20240719162238.71387-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e613b061da30600@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hsr_get_node

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xd05/0xd30 net/hsr/hsr_framereg.c:275
 hsr_get_node+0xd05/0xd30 net/hsr/hsr_framereg.c:275
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

CPU: 0 PID: 5480 Comm: syz-executor.0 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         d7e78951 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116a2349980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be93d3b0d4dc66d7
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106b443d980000


