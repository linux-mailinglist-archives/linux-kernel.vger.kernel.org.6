Return-Path: <linux-kernel+bounces-516272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD07A36F02
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EF11891B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FEC1DD0D4;
	Sat, 15 Feb 2025 15:14:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98479151991
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632444; cv=none; b=WXHiCPp/xnIK/DJ1TWOvU1r+kUooUyzxwct5VBakYnZ9lLM3Q/AuIidfc0TaT31XWOcuJQwGfh8psZ5TORBqP+SMvYcWdT056ciNLsmG2gnKjspI84RLR4kBofiP8xHsDvZg1XlugCfEF20pYvy9xn6G8oVP+41nvhviKvaWvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632444; c=relaxed/simple;
	bh=OKCzKtnAlEd/Ti1HmoZ6dWbA21lphnQr7ghoE8Xw9qw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U3iam0q1Td3YwW2U0Q0CuI33M7vEp1ouubtT4rFpNScyZD5Zw12vr2VOEfLMP7PRMNpUFgvaPot8xkwNlt4jSy8cA0TXqq4kxsT/jQUMcRVARpAbNF4qJP9AwKh+eThG7St3VL4R/HAzbsgLgCvoSmi24jDLDx+FqhtmOGzIiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cf64584097so23875315ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632441; x=1740237241;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89WyuIP5yGF68xGJzIeWTkML77mCfVAZRoJH3MxCLAI=;
        b=e/jHXDyLESm7RASyjL/Rg1SV6U9Y3vDThFmfQV1+DXMB1/lL2pydLViNVwszV4oe6L
         Qzc3URVS9rJ3V5bXLu2mMBiiS/IS98ovkkdbv7Wnm4SQcBRdjIbG6Eb5It+DcL1PKUim
         of03Ps0/rWCsjUL8G5wVsSKDKvcS1ent1jLgaIGClrPrIMEVJYElM34UizH81GgyAo2s
         5mbKoYzh2CHVo2Hvdtchf816TdHUCpVKeq69E7XWEYLqRv6Edig/QIXaARsq/kIuvrRT
         WdR+QHPC+ZGBn4VE5sSldw+HpFfgCaVLdI0Vbr9JPl1tDu4MultD6yDE0UFDKcxe8VHg
         0Iew==
X-Gm-Message-State: AOJu0YysTcgr5qbIeXte6TaNfls7zXOLiLQt3/VJl5uJk8tROCyFnG+t
	vf79cPUy/2Hac+mB1OB6+RGNaMdzvju+/MohKAlwpgFC525P+cSng2VPeuiYvOTeuBLsvZ7bVuJ
	+v33dBbNdPE74lXa1VD+Bdr6hclR0IscAoJPRbNMKW/Yl7NXG8aJ/yhQ=
X-Google-Smtp-Source: AGHT+IH6q+bC0xLLA9EUEZBYJ1cvaf+x+ZafOSqhDOID9WO63/RBLLmy8S7GKlKNl19rIJ4Rz8nkZMri/vKcZLAVLdYEebIz1275
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d28090d830mr29975385ab.12.1739632441741; Sat, 15 Feb 2025
 07:14:01 -0800 (PST)
Date: Sat, 15 Feb 2025 07:14:01 -0800
In-Reply-To: <CAMp3bLUvAiaj_kKZ_+Wr3gFHRUC-j=isSxEb5_X7b+CqPpwgOg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0af39.050a0220.6f0b7.000d.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ppp_sync_send

=====================================================
BUG: KMSAN: uninit-value in ppp_sync_txmunge drivers/net/ppp/ppp_synctty.c:521 [inline]
BUG: KMSAN: uninit-value in ppp_sync_send+0x2dc/0xc60 drivers/net/ppp/ppp_synctty.c:573
 ppp_sync_txmunge drivers/net/ppp/ppp_synctty.c:521 [inline]
 ppp_sync_send+0x2dc/0xc60 drivers/net/ppp/ppp_synctty.c:573
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
 ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
 pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
 __release_sock+0x1da/0x330 net/core/sock.c:3106
 release_sock+0x6b/0x250 net/core/sock.c:3660
 pppoe_sendmsg+0xb35/0xc50 drivers/net/ppp/pppoe.c:903
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmmsg+0x2ff/0x880 net/socket.c:2716
 __do_sys_sendmmsg net/socket.c:2743 [inline]
 __se_sys_sendmmsg net/socket.c:2740 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2740
 x64_sys_call+0x33c2/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4762
 __alloc_pages_noprof+0x41/0xd0 mm/page_alloc.c:4773
 __page_frag_cache_refill+0x51/0x200 mm/page_frag_cache.c:59
 __page_frag_alloc_align+0xc9/0x630 mm/page_frag_cache.c:103
 page_frag_alloc include/linux/page_frag_cache.h:56 [inline]
 __netdev_alloc_skb+0x6ab/0x720 net/core/skbuff.c:762
 netdev_alloc_skb include/linux/skbuff.h:3410 [inline]
 dev_alloc_skb include/linux/skbuff.h:3423 [inline]
 ppp_sync_txmunge drivers/net/ppp/ppp_synctty.c:508 [inline]
 ppp_sync_send+0xf1/0xc60 drivers/net/ppp/ppp_synctty.c:573
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
 ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
 pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
 __release_sock+0x1da/0x330 net/core/sock.c:3106
 release_sock+0x6b/0x250 net/core/sock.c:3660
 pppoe_sendmsg+0xb35/0xc50 drivers/net/ppp/pppoe.c:903
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmmsg+0x2ff/0x880 net/socket.c:2716
 __do_sys_sendmmsg net/socket.c:2743 [inline]
 __se_sys_sendmmsg net/socket.c:2740 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2740
 x64_sys_call+0x33c2/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6764 Comm: syz.0.16 Not tainted 6.14.0-rc2-syzkaller-00259-g7ff71e6d9239-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167c59a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e8820bdc5f2bf2
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154ee7df980000


