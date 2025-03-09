Return-Path: <linux-kernel+bounces-552883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09973A5806F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 04:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695DE188E4F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462D70814;
	Sun,  9 Mar 2025 03:03:24 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1735964
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489404; cv=none; b=qFEGWLpHBFfFjT/u27L4ANf0V5p2t0XzwMFcg2gfJLd1mVwFs4QVdPr+PZMxhWmdTmkxdzOm1u5lvfHnB7WSmdJCZAuXJBKGZQurQX/poAEhZVjHG1p9By1M3KT0i6V/ATRdm3iT2dydn98Q98WQe33816WTHhIhq2M2d7WiV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489404; c=relaxed/simple;
	bh=n0y9uXzRp4nd2UEuB/QpG5DfKUfIZlVoT2ko8vRMXtQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IO99Ki2cHVVU9DFVbySWMPh1x3KkltxMaYMc5kn+oopU/vOrFr6cS5I2p0JnD/3SC2d6X7qwjr4pCv0GEk8PZTx0LrSpin3tynDXVOz6dPO2mj/z0mxZN7H2oJxfzRE07mEYhc+Xo84JzJK0Apt88sctiyfa+4lyygQc3Jd2Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so7365115ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 19:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741489401; x=1742094201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7lI9vq0dCiuVwqTWFXCoyyGJs3SP4CmmE1ZX50lz3Q=;
        b=ZNMqMh0fEn6kXpnEh9HGKr5jA+EzXf3ZK/nSf9YAstQiNEoFCZF6NJCOqf0RP+0+ss
         Cd71f2IYj9oSvVqOlQVudK351x2yiZTbeyZGntZrxA59Tje6nqZMaB9fsedyc0btLvOs
         C3FwxB0pTiBmDRBhEPnqU1iBU/VVfNwXIdMZlS6EU0Y/mVw9ibQRAGQr3+WlAqHXYL/Y
         GQQZDfKP8k7D2fWa/MkxC0A+ZJ36X2K6+FgF7kXIa+Z0YQcN1iPT44ZI5Ja50OxJvtIS
         S5emr5sMglp+S/nU77DF6WpbphfycWI1S6S0JOnKHRqSZdU9mYavwygWxLBshv+EoDi0
         W4fw==
X-Forwarded-Encrypted: i=1; AJvYcCW8d5kagkXyn+G0OkMQQ6SoxjfFa74ZRlLUwWEh4iTmkicDvQbNQ2rGr0cY53bRanR3Y9KGqjhMIZTZfwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMFi/30Adp511+2JyyIxxrzzxpMznmzj+QLV/9SxEvr8Zh+XO
	D6zdwYRBiF2Al3plJX/tNr00Mvkmjq/F2+D8k0G6QK5hXBKKLA8ohonvUMHK7soeTS62wiWNT4F
	LU/udrdKN4nfsNfBvjhLnuSM5wts19zPnHBalPAxuGXdnnHAxKNMYJIw=
X-Google-Smtp-Source: AGHT+IG867GCeldxqxyB1InYkZ1OBi1osD2Tik2lnZoVzU4Xgi45W3Oz0WkqfyHunVkvAFKAMJAxoOR3M3Fnhirt4SMnNljpgZNz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d441a00284mr120387625ab.15.1741489401571; Sat, 08 Mar 2025
 19:03:21 -0800 (PST)
Date: Sat, 08 Mar 2025 19:03:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd04f9.050a0220.14db68.006e.GAE@google.com>
Subject: [syzbot] [netfilter?] KMSAN: uninit-value in __nf_conncount_add
From: syzbot <syzbot+83fed965338b573115f7@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a5eed9ad58 Merge tag 'devicetree-fixes-for-6.14-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174d8078580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d47ea4b9912d894
dashboard link: https://syzkaller.appspot.com/bug?extid=83fed965338b573115f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e13258230ff9/disk-48a5eed9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b84f07fdcdb7/vmlinux-48a5eed9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9860005c79df/bzImage-48a5eed9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83fed965338b573115f7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in find_or_evict net/netfilter/nf_conncount.c:117 [inline]
BUG: KMSAN: uninit-value in __nf_conncount_add+0xd9c/0x2850 net/netfilter/nf_conncount.c:143
 find_or_evict net/netfilter/nf_conncount.c:117 [inline]
 __nf_conncount_add+0xd9c/0x2850 net/netfilter/nf_conncount.c:143
 count_tree net/netfilter/nf_conncount.c:438 [inline]
 nf_conncount_count+0x82f/0x1e80 net/netfilter/nf_conncount.c:521
 connlimit_mt+0x7f6/0xbd0 net/netfilter/xt_connlimit.c:72
 __nft_match_eval net/netfilter/nft_compat.c:403 [inline]
 nft_match_eval+0x1a5/0x300 net/netfilter/nft_compat.c:433
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x426/0x2290 net/netfilter/nf_tables_core.c:288
 nft_do_chain_ipv4+0x1a5/0x230 net/netfilter/nft_chain_filter.c:23
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
 nf_hook_slow_list+0x24d/0x860 net/netfilter/core.c:663
 NF_HOOK_LIST include/linux/netfilter.h:350 [inline]
 ip_sublist_rcv+0x17b7/0x17f0 net/ipv4/ip_input.c:633
 ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:669
 __netif_receive_skb_list_ptype net/core/dev.c:5936 [inline]
 __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5983
 __netif_receive_skb_list net/core/dev.c:6035 [inline]
 netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:6126
 netif_receive_skb_list+0x5a/0x460 net/core/dev.c:6178
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x2e86/0x3480 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0xf1d/0x1ae0 net/bpf/test_run.c:1316
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4407
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5813
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5900
 ia32_sys_call+0x394d/0x4180 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:387
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:412
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:450
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x915/0xe10 mm/slub.c:4171
 insert_tree net/netfilter/nf_conncount.c:372 [inline]
 count_tree net/netfilter/nf_conncount.c:450 [inline]
 nf_conncount_count+0x1415/0x1e80 net/netfilter/nf_conncount.c:521
 connlimit_mt+0x7f6/0xbd0 net/netfilter/xt_connlimit.c:72
 __nft_match_eval net/netfilter/nft_compat.c:403 [inline]
 nft_match_eval+0x1a5/0x300 net/netfilter/nft_compat.c:433
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x426/0x2290 net/netfilter/nf_tables_core.c:288
 nft_do_chain_ipv4+0x1a5/0x230 net/netfilter/nft_chain_filter.c:23
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
 nf_hook_slow_list+0x24d/0x860 net/netfilter/core.c:663
 NF_HOOK_LIST include/linux/netfilter.h:350 [inline]
 ip_sublist_rcv+0x17b7/0x17f0 net/ipv4/ip_input.c:633
 ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:669
 __netif_receive_skb_list_ptype net/core/dev.c:5936 [inline]
 __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5983
 __netif_receive_skb_list net/core/dev.c:6035 [inline]
 netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:6126
 netif_receive_skb_list+0x5a/0x460 net/core/dev.c:6178
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x2e86/0x3480 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0xf1d/0x1ae0 net/bpf/test_run.c:1316
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4407
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5813
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5900
 ia32_sys_call+0x394d/0x4180 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:387
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:412
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:450
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 15694 Comm: syz.1.15735 Tainted: G        W          6.14.0-rc5-syzkaller-00016-g48a5eed9ad58 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

