Return-Path: <linux-kernel+bounces-236282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129A91DFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF48281DAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D115A863;
	Mon,  1 Jul 2024 12:53:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D4158DAC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838385; cv=none; b=RG84gWZomfSnN+v6i4yLcwuICRoAXAVVbIzpU26ZdCjqsGcza/48wni9xc5PugNHNJltOMCOhbyR2D1KrV4wv8647S5AO2ZDt55D31v0tspVefXRIc0z3n3uo2RySup9yeFXnis9MUOW4MPWtSZU7f4qJI7+uITXhZujqv2lVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838385; c=relaxed/simple;
	bh=i3hv2NInAMxcg2oVHX9rCREi0WqNN1RBXHf6Nfsf+3c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K8yq9ujelWOl11UwnVcfsnSj4Jbl78d3iBul5VTVogfuPpj31oIFLcHz6tun7VhyDc5VpxdmvgV9P+M1IMwlSbUP6JRGrVgZLcR8ByeLLXvZDGLJhWg0N0K3OglZcuGrt3LBdDWBmzcu1whvX65xiHxz6MFMnWdS0U1vH3tRauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6307d584aso189674139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838383; x=1720443183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B42h+VdiRbUUcC6Sg3ReWJIOZz89LnI8kXsZiHOUCqc=;
        b=V3jY/p8ZOQsWNdlJV0D/yMU8EGCIWYym6n60Em3VMdFDInRlsjkPj/6sRaIwEMWquo
         c4hDSyUwHQv84ndD57XwfuQvqCcHToPN9iDsDXspqSffmx6t7sR6o4orYi++3EfNPP9L
         pSG08s29IW4Hf8hZ3V3yZAwnEDvdam5PGHeXWd2nEPI8rpSgaKOdi0QHGvozYlMd24Az
         aSxjEYogsWnkBg8UQmLzgOj5Oh6fqGmAl4s2W5qfsZ7cL85OP4WtMVS4bdtcnGHsi/ue
         tier22jHPO6rz2FO/1S4gWBNAYox8RTzwcoXSs0NEP1DDevl4EfFvFZ1bA/YBTnvpM5D
         vHjA==
X-Gm-Message-State: AOJu0YzGQBZaBIyTnJSwouGETsIulu41YJJstwsBP7mnjD6b3LJ2NeSS
	y7z20dKVRCx0y1IMpOxHqAuvkxNU7XQJ3g/1huw3eV+e8nHjiv9b+LKaJ+LKz5WosUJn7jBbbkA
	G5YBIRk3BnYF9MJr+DrWdt2tbBQP9XueOmgSv2NxFSFKrobyc3OSLStw=
X-Google-Smtp-Source: AGHT+IHp66Yi+iVuE94Rld0P2USoXHcCPl7TVUj3AZievgbfX14VG/pNB6xPbjG8mQy6YTE8cCxQGAfrUo6sZrocBi95idj08OeX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d5:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4bbb6ec40afmr364765173.6.1719838383700; Mon, 01 Jul 2024
 05:53:03 -0700 (PDT)
Date: Mon, 01 Jul 2024 05:53:03 -0700
In-Reply-To: <20240701101940.16092-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee8def061c2f1338@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in bpf_prog_run_generic_xdp
From: syzbot <syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in bpf_prog_run_generic_xdp

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_run_generic_xdp+0x13a0/0x1ee0 net/core/dev.c:4923
 bpf_prog_run_generic_xdp+0x13a0/0x1ee0 net/core/dev.c:4923
 netif_receive_generic_xdp net/core/dev.c:5005 [inline]
 do_xdp_generic+0xb68/0x1440 net/core/dev.c:5064
 __netif_receive_skb_core+0x2533/0x6190 net/core/dev.c:5405
 __netif_receive_skb_one_core net/core/dev.c:5583 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5699
 process_backlog+0x49d/0x920 net/core/dev.c:6028
 __napi_poll+0xe7/0x980 net/core/dev.c:6679
 napi_poll net/core/dev.c:6748 [inline]
 net_rx_action+0x82a/0x1850 net/core/dev.c:6864
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 do_softirq+0x9a/0x100 kernel/softirq.c:455
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x2d/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 release_sock+0x219/0x250 net/core/sock.c:3559
 j1939_sk_sendmsg+0x23d8/0x2730 net/can/j1939/socket.c:1280
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 pskb_expand_head+0x30f/0x19d0 net/core/skbuff.c:2253
 netif_skb_check_for_xdp net/core/dev.c:4968 [inline]
 netif_receive_generic_xdp net/core/dev.c:4999 [inline]
 do_xdp_generic+0x931/0x1440 net/core/dev.c:5064
 __netif_receive_skb_core+0x2533/0x6190 net/core/dev.c:5405
 __netif_receive_skb_one_core net/core/dev.c:5583 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5699
 process_backlog+0x49d/0x920 net/core/dev.c:6028
 __napi_poll+0xe7/0x980 net/core/dev.c:6679
 napi_poll net/core/dev.c:6748 [inline]
 net_rx_action+0x82a/0x1850 net/core/dev.c:6864
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1842 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5441 Comm: syz-executor.0 Not tainted 6.9.0-rc1-syzkaller-00257-ge478cf26c556-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1648f869980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c3ffa6980000


