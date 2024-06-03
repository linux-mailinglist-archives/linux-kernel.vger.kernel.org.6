Return-Path: <linux-kernel+bounces-199424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E78D8709
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3353E283039
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1E136663;
	Mon,  3 Jun 2024 16:20:25 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DB12F596
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431625; cv=none; b=EfsFAmn5z6HLXv9qfsJpm8URS/SDPo/4jzGRaHO1kEp0CzKvyppa+T4U0nq/DcTTp8YvrlWdMLHQBv79sO5cd45IWBuGvkBom3N4TSX/xxFZpcrPSl5TO+fSSsqCv+vBmIBId9Y3XySt0gXNXVZSHONw6jj+KcfHLNm4gqUE0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431625; c=relaxed/simple;
	bh=CUPKMB33bY6eRk75NQ/rabT0ot42iS9Gng0vkoX9ifs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O6EiAqyV23xbl0vAEqLk1dEYJQ5/0bBCVTGPfChN7+XlE8j4R3kKzgRAP0CzBDpwlVKIYu6jrP28e3J51gvBz6mFAZ9VtRBouUAPOjEC8kdlZnYYH6YmltVfztw0z6e/JTe2r1kf3mpAyQHKzSmDDznQofNvIGGdKBuqT6VUMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37491f6776dso23620285ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431623; x=1718036423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpUQfzX083+hbWQ2z1+AmBqSU8rDIaZW86oBva7LwFw=;
        b=aQ0UiiEA8MrSGfMe8G75xMBN7g/ix4kVOG5l4Y868jwvqLeVlh61tNzLpnVcdUkhSV
         vevJe0G9Ur85pUCePFXHBwHbCb/0wVWOOPjvJ7llz5r/M4X71rrThKsNJeWxdI/2D6qG
         J58/DzCGKX3Bkd9F2KpESYMNNFAxB2Hd8e4DsLNFIUPUsglTYJtcl0DjP7X2McyhfxiK
         RAZ5JOuCg79wab7wFAtj3SGZyGwxqavHtmDFdOO0Esmldvemebmx12GI5JxXVzo/JzJn
         O0P92jchoUhtOLaH7U8ki94sMbJc2AyBfV3Tom1KQicrxdQ5BR7fHvu0PQA9cAGhAT60
         fyaA==
X-Forwarded-Encrypted: i=1; AJvYcCVRvKrj0ZviYFgofsTcJAopdmM1GIdqCOq63oBpOrUlx+aYmCYepujrmXXQB35Y28INaIy53OXI5qik+a0Cqsc3cc0luFLNQNu7+qAk
X-Gm-Message-State: AOJu0Yz28udIwvtWw5haIbKV/3CDlIFScxoqCFHCptfxlsPBlMpktjlS
	v9XTj8Vg26qyjjuk2QPKUxjuKiCtvGSU/MeJhUWWS0XX1pFCHYBfSet+YGW+p6JNf5/Rn9GN51A
	fQTZrfQ9ILKO5G9o41ve8MejtbYe2nPUR+tw8P3itKwhOFIsMw5jxnRc=
X-Google-Smtp-Source: AGHT+IGjUkWSBmZoDo/th8Lfwa3N+qVUtM/hMh6K49GT41GwjsvIwrjUFUKyds2F3MHcRjSxmiB8+YN8y46nCEMpL76GfM4uy6aV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b29:b0:374:70ae:e86e with SMTP id
 e9e14a558f8ab-3748ba39e17mr6583945ab.6.1717431622815; Mon, 03 Jun 2024
 09:20:22 -0700 (PDT)
Date: Mon, 03 Jun 2024 09:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cde3320619feb515@google.com>
Subject: [syzbot] [net?] KASAN: use-after-free Read in rhashtable_lookup_fast (2)
From: syzbot <syzbot+128aaac913636290e5a9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e9bc0472b91 Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_S..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1209e85c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=128aaac913636290e5a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4d98ec9bb7b/disk-3e9bc047.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df7961b4e331/vmlinux-3e9bc047.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be4e509c6f1b/bzImage-3e9bc047.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+128aaac913636290e5a9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in rht_key_hashfn include/linux/rhashtable.h:159 [inline]
BUG: KASAN: use-after-free in __rhashtable_lookup include/linux/rhashtable.h:604 [inline]
BUG: KASAN: use-after-free in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
BUG: KASAN: use-after-free in rhashtable_lookup_fast+0x77a/0x9b0 include/linux/rhashtable.h:672
Read of size 4 at addr ffff888058fe8008 by task kworker/1:9/5947

CPU: 1 PID: 5947 Comm: kworker/1:9 Not tainted 6.9.0-rc5-syzkaller-00185-g3e9bc0472b91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: wg-crypt-wg1 wg_packet_encrypt_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 rht_key_hashfn include/linux/rhashtable.h:159 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:604 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast+0x77a/0x9b0 include/linux/rhashtable.h:672
 ila_lookup_wildcards net/ipv6/ila/ila_xlat.c:132 [inline]
 ila_xlat_addr net/ipv6/ila/ila_xlat.c:652 [inline]
 ila_nf_input+0x1fe/0x3c0 net/ipv6/ila/ila_xlat.c:190
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 __netif_receive_skb_one_core net/core/dev.c:5544 [inline]
 __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5658
 process_backlog+0x39d/0x7a0 net/core/dev.c:5987
 __napi_poll+0xcb/0x490 net/core/dev.c:6638
 napi_poll net/core/dev.c:6707 [inline]
 net_rx_action+0x7bb/0x1090 net/core/dev.c:6822
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_encrypt_worker+0x2e8/0x1610 drivers/net/wireguard/send.c:293
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58fe8
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152dc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 11308, tgid -1154580940 (syz-executor.4), ts 11308, free_ts 301906279236
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0x33e/0x4e0 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0x72/0x190 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 kvzalloc include/linux/slab.h:774 [inline]
 bucket_table_alloc lib/rhashtable.c:184 [inline]
 rhashtable_init+0x558/0xa90 lib/rhashtable.c:1065
 ila_xlat_init_net+0xa0/0x110 net/ipv6/ila/ila_xlat.c:613
 ops_init+0x352/0x610 net/core/net_namespace.c:136
 setup_net+0x515/0xca0 net/core/net_namespace.c:340
 copy_net_ns+0x4e4/0x7b0 net/core/net_namespace.c:505
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
page last free pid 1100 tgid 1100 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_large+0x13f/0x190 mm/swap.c:132
 __folio_put+0x299/0x390 mm/swap.c:140
 folio_put include/linux/mm.h:1506 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4361
 kfree+0x1ca/0x3a0 mm/slub.c:4384
 rhashtable_free_and_destroy+0x7c6/0x920 lib/rhashtable.c:1163
 ila_xlat_exit_net+0x55/0x110 net/ipv6/ila/ila_xlat.c:626
 ops_exit_list net/core/net_namespace.c:170 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:637
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888058fe7f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888058fe7f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888058fe8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff888058fe8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888058fe8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

