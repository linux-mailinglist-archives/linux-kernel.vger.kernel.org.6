Return-Path: <linux-kernel+bounces-369725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F029A21D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5161F2474D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC471DCB31;
	Thu, 17 Oct 2024 12:04:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E01D5153
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166650; cv=none; b=j2jrzoZ8PcbSulEQ1pT6hnROI2CVyfItOGVoGfDXL6BqqRBZWOEtN8tqG/6x6zK4wj2I1L+EZ5UffkSI3RwzkUzdVqymG7uH2FYuNn2NI4UhheDoX6SRkgXI48gBrXWF67q17ym6dj+K7CmzkqdWC2We3pVt+mtuErI71D3FnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166650; c=relaxed/simple;
	bh=bakgIPnGSt0zmwzGXHqruV/nGgL9llOjBfRDodkCIyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kLipCgNhpS9M/S3S5N0MaU8Jun3ow0uuGcgriF4X2B/ARtosKfC+UjLaf7bzkFlod8yFKedFHKSuN+v7xwN0AdZ5KOFNWuLTTpWfQgeNIKzpZYFnlcGCga6hLKKWkJqCxP21ZQ8FWHcwuDWdBB3SIUSC8FDSQvg6wSQV0X3VZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so4895605ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166647; x=1729771447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLx0XEr7QIW+dFoLAnWAGHywpe7yftQFdub9+rRTRSI=;
        b=SWF17teWv06YW/4mKPITTMkJYFRP/UlFNIAtY6HJetAVm9A7NsAj5Qt+GCWtBRix2L
         k+nnbY6bLm4o22785yydk3pLYOCRuL1Nec1mIYThAq8QWJSP4piv2Aklw7iovG5c8zBG
         lhaUVR6XrXGXC95DaGGwVPpBTJ+WGkU7Gz5FAtv3iXVKFRlUm+TydcY5x1Bybit9k4NS
         iWNDdeDhAYXXxUPK+KoBMGCRSWoaMnvRHMipIYfe/Qc+S+fUpeRElPWhOXE6erXUUHgo
         IdhyUeoYEkNkWV5WCaPWAKHij8KnFRxKH8VJ7rDpljEeTp96hGYwH5AtpjN6PDU57vmD
         FrAw==
X-Forwarded-Encrypted: i=1; AJvYcCU280zisnZYEFK6fi4meHsf11Tp6GpLaCHiUHeQex0NlaFFypYvikFdr3tfDbveZa3tjB/WN5kq7Ax2jlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GxfwB1/vNMATYLaX8ipHB436rVqk5TsdBD9tbsF5c3SEGefY
	EyligQU0kSSehVjuWT8gGfYeaPlb+QehqXECdjY9cNTctVmczuBv5VXPBbVej/S8uWNxRMEdrRF
	sadD36ePhbVdCY643qQk9VInl4Rf5UB6aOZumZ9ihEUQPhZ0/+cpaanM=
X-Google-Smtp-Source: AGHT+IEFFmAFVvVOxt9QPhnFVyYk1onWQEXrfxtZHaf+o0YiZSZJKL3xQudZGEbfq3FFcT8FqFXNjIWH44OmUpnJsENXqsoftLt6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:3a3:b254:ca2a with SMTP id
 e9e14a558f8ab-3a3bcdbdb6amr138597105ab.9.1729166646597; Thu, 17 Oct 2024
 05:04:06 -0700 (PDT)
Date: Thu, 17 Oct 2024 05:04:06 -0700
In-Reply-To: <20241017113915.2052-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710fd36.050a0220.d5849.0028.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in seq_read_iter (2)
From: syzbot <syzbot+c4cf28ed38d86d6b549d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=13101, q=1926589 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10500 (4294975059-4294964559), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10501 jiffies! g13101 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25296 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc3-syzkaller-gc964ced77262-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ip_output+0xcd/0x230 net/ipv4/ip_output.c:429
Code: 00 00 e8 46 44 7b f7 42 80 3c 33 00 74 08 4c 89 e7 e8 07 d4 e1 f7 49 8b 1c 24 48 83 e3 fe 48 89 d8 48 c1 e8 03 42 80 3c 30 00 <74> 08 48 89 df e8 e9 d3 e1 f7 4c 8b 23 4d 8d 7d 10 4c 89 fd 48 c1
RSP: 0018:ffffc90000156da8 EFLAGS: 00000246
RAX: 1ffff11030ec32e0 RBX: ffff888187619700 RCX: ffff88801beeda00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888187619700 R08: ffffffff8a19a267 R09: 1ffffffff2037a45
R10: dffffc0000000000 R11: fffffbfff2037a46 R12: ffff888187618b98
R13: ffff888187618b40 R14: dffffc0000000000 R15: ffff888187618b40
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa227d5f5b0 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 synproxy_send_client_synack+0x8b8/0xf30 net/netfilter/nf_synproxy_core.c:484
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e90240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=c4cf28ed38d86d6b549d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ccf887980000


