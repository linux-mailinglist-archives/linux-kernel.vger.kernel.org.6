Return-Path: <linux-kernel+bounces-300828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9D95E8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85F71C217CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2183CA3;
	Mon, 26 Aug 2024 06:29:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40582490
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653769; cv=none; b=TY0bYyJeEwTHaLId2zkbWWh2oc+hEUfrTHACQxVMmDkb4ApxU39Ds0252Y34yfFZCCKH3MzUN2ZOSiPzb972VCQ1qvaTorKHKDHZ0A77g4Slw79jPRCzfW7dX4sX8jFIqI1g/Pwt7MVYG24T6Taok0YUTxGpkmbnZVhidcKCV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653769; c=relaxed/simple;
	bh=KtigigNOfTM6RaZcQT/zTu+5JZ0lfoD8OoVq1Q82Mgs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gp/ZgldTNntvq9r20BzwPxavzkIXKK5IauhknNkZlt75vu1VtfQin5R5B7UqjHV2UUV42afcPPFW7r47St1IXCqyudnZX18D2MjygBFuljCtjbMimc/uGNNUFH/Pods/M4BDpqEofdQO4g/ILEicpYuPItz+hhjR7FtJWstd1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d3061c2b5so45024675ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653767; x=1725258567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ocl1IxQuAx+4fHj2Qz/7zw20URid546YgXpegfAhpy8=;
        b=YMqMbIKjoZxRhuti+/QOWvMpgPrazAWa2XqDJaKjh7lJbqT8Q6b+/XQfqQvueKe1eM
         6Tl34IHoe6ORBBJdLtfMOW0Q5dkf9oyRbr1Ag9+3qo5/3Q41o5nxJM9DlLvcHDxzB3gk
         bGJ+0CcQO7AzwtNTvDTfWnWhUdjNUA/ISzi/VDvY2Y4g30v3tv2TDjCqUNIiSBJ1lpKY
         gzRjHpkhZxu2oBeFU/NMu1VI3Ss7OMl9MBVlYiOVpbzpHGLt76bEDbE8i1iOef15hsId
         EPq+mDM8NcsW7LUb1c9nbm4C4Sz5gqZo8o6VyQgDN1qtVKuJlGENwJSlXsWmXdOOJpDt
         ibSw==
X-Gm-Message-State: AOJu0YxXgWqyJoBTJkl5kmHmAjB5U4roUf7A2eqLyI7hclkR9PuVDEBu
	7voec45r8KchkqPKPgpC0kKdNUBVfmt+Cz4lHjPi3Bbah7icf/PFJ5A6nGBJ4sCReGHq21hMLl7
	Vym52WYp2FG0Xm5z9y9m1lwwBihOrM5a67uumkohRBq7v4z/gwUqjo60=
X-Google-Smtp-Source: AGHT+IEPKntTjRkoi0JD3F86nRk4wCWmIvQecSjCBBpP3IfgIQ4i70JDWqq7DZmPd4PVXBbjwffRgrw3vM6RexRGPSkT9uozETgm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:39d:300f:e915 with SMTP id
 e9e14a558f8ab-39e3ca15b3dmr5828895ab.6.1724653766787; Sun, 25 Aug 2024
 23:29:26 -0700 (PDT)
Date: Sun, 25 Aug 2024 23:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021531e0620903f47@google.com>
Subject: [syzbot] [squashfs?] KASAN: slab-use-after-free Read in squashfs_readahead
From: syzbot <syzbot+2868f8dd7c40437778d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c79c85875f1a Add linux-next specific files for 20240823
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15694043980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23bc95d9a9b56fa4
dashboard link: https://syzkaller.appspot.com/bug?extid=2868f8dd7c40437778d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8bbbc2af33d9/disk-c79c8587.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e25f34cd29db/vmlinux-c79c8587.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c0f92a7043e/bzImage-c79c8587.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2868f8dd7c40437778d9@syzkaller.appspotmail.com

SQUASHFS error: Unable to read metadata cache entry [1ea]
SQUASHFS error: Unable to read metadata cache entry [1ea]
==================================================================
BUG: KASAN: slab-use-after-free in squashfs_page_actor_free fs/squashfs/page_actor.h:41 [inline]
BUG: KASAN: slab-use-after-free in squashfs_readahead+0x210c/0x2680 fs/squashfs/file.c:626
Read of size 4 at addr ffff88807ef981c0 by task syz.4.190/6836

CPU: 1 UID: 0 PID: 6836 Comm: syz.4.190 Not tainted 6.11.0-rc4-next-20240823-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 squashfs_page_actor_free fs/squashfs/page_actor.h:41 [inline]
 squashfs_readahead+0x210c/0x2680 fs/squashfs/file.c:626
 read_pages+0x17e/0x840 mm/readahead.c:160
 page_cache_ra_unbounded+0x6ce/0x7f0 mm/readahead.c:273
 page_cache_sync_readahead include/linux/pagemap.h:1296 [inline]
 filemap_get_pages+0x543/0x2330 mm/filemap.c:2529
 filemap_read+0x457/0xfa0 mm/filemap.c:2628
 __kernel_read+0x519/0x9d0 fs/read_write.c:434
 integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0xaef/0x1b30 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x526/0xb20 security/integrity/ima/ima_api.c:293
 process_measurement+0x1357/0x1fb0 security/integrity/ima/ima_main.c:372
 ima_file_check+0xf2/0x170 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3154
 do_open fs/namei.c:3776 [inline]
 path_openat+0x2cd0/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f39c9d79e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39c9bf8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f39c9f15f80 RCX: 00007f39c9d79e79
RDX: 0000000000000000 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 00007f39c9de793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f39c9f15f80 R15: 00007fff29e06a88
 </TASK>

Allocated by task 6836:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4237
 kmalloc_noprof include/linux/slab.h:681 [inline]
 squashfs_page_actor_init_special+0x64/0x440 fs/squashfs/page_actor.c:113
 squashfs_readahead+0x188f/0x2680 fs/squashfs/file.c:619
 read_pages+0x17e/0x840 mm/readahead.c:160
 page_cache_ra_unbounded+0x6ce/0x7f0 mm/readahead.c:273
 page_cache_sync_readahead include/linux/pagemap.h:1296 [inline]
 filemap_get_pages+0x543/0x2330 mm/filemap.c:2529
 filemap_read+0x457/0xfa0 mm/filemap.c:2628
 __kernel_read+0x519/0x9d0 fs/read_write.c:434
 integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0xaef/0x1b30 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x526/0xb20 security/integrity/ima/ima_api.c:293
 process_measurement+0x1357/0x1fb0 security/integrity/ima/ima_main.c:372
 ima_file_check+0xf2/0x170 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3154
 do_open fs/namei.c:3776 [inline]
 path_openat+0x2cd0/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6836:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2299 [inline]
 slab_free mm/slub.c:4521 [inline]
 kfree+0x195/0x3e0 mm/slub.c:4669
 squashfs_page_actor_free fs/squashfs/page_actor.h:39 [inline]
 squashfs_readahead+0x195b/0x2680 fs/squashfs/file.c:626
 read_pages+0x17e/0x840 mm/readahead.c:160
 page_cache_ra_unbounded+0x6ce/0x7f0 mm/readahead.c:273
 page_cache_sync_readahead include/linux/pagemap.h:1296 [inline]
 filemap_get_pages+0x543/0x2330 mm/filemap.c:2529
 filemap_read+0x457/0xfa0 mm/filemap.c:2628
 __kernel_read+0x519/0x9d0 fs/read_write.c:434
 integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0xaef/0x1b30 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x526/0xb20 security/integrity/ima/ima_api.c:293
 process_measurement+0x1357/0x1fb0 security/integrity/ima/ima_main.c:372
 ima_file_check+0xf2/0x170 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3154
 do_open fs/namei.c:3776 [inline]
 path_openat+0x2cd0/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807ef98180
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 64 bytes inside of
 freed 96-byte region [ffff88807ef98180, ffff88807ef981e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ef98
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff888015841280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5381, tgid 5377 (syz.3.14), ts 67449689923, free_ts 67434124179
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1517
 prep_new_page mm/page_alloc.c:1525 [inline]
 get_page_from_freelist+0x312a/0x3270 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x29e/0x780 mm/page_alloc.c:4748
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2368
 allocate_slab+0x5a/0x2f0 mm/slub.c:2531
 new_slab mm/slub.c:2584 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3771
 __slab_alloc+0x58/0xa0 mm/slub.c:3861
 __slab_alloc_node mm/slub.c:3914 [inline]
 slab_alloc_node mm/slub.c:4073 [inline]
 __do_kmalloc_node mm/slub.c:4205 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4218
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:817 [inline]
 cfg80211_inform_single_bss_data+0xaff/0x2030 net/wireless/scan.c:2307
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3254
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
page last free pid 5382 tgid 5377 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1098 [inline]
 free_unref_page+0xc07/0xd90 mm/page_alloc.c:2651
 __folio_put+0x2c7/0x440 mm/swap.c:126
 skb_page_unref include/linux/skbuff_ref.h:44 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:57 [inline]
 skb_release_data+0x467/0x880 net/core/skbuff.c:1120
 skb_release_all net/core/skbuff.c:1191 [inline]
 __kfree_skb net/core/skbuff.c:1205 [inline]
 sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1243
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 __udp6_lib_mcast_deliver+0xdf4/0xea0 net/ipv6/udp.c:904
 __udp6_lib_rcv+0x6c8/0x1820 net/ipv6/udp.c:1009
 ip6_protocol_deliver_rcu+0xccf/0x1580 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x187/0x2d0 net/ipv6/ip6_input.c:483
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 ip6_input net/ipv6/ip6_input.c:492 [inline]
 ip6_mc_input+0x9c5/0xc30 net/ipv6/ip6_input.c:586
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5776
 process_backlog+0x662/0x15b0 net/core/dev.c:6109
 __napi_poll+0xcb/0x490 net/core/dev.c:6773
 napi_poll net/core/dev.c:6842 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6964
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554

Memory state around the buggy address:
 ffff88807ef98080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807ef98100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88807ef98180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff88807ef98200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807ef98280: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
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

