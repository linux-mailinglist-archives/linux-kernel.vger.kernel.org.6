Return-Path: <linux-kernel+bounces-232246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FE91A5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9C9B254DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1EA14EC75;
	Thu, 27 Jun 2024 11:53:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284714EC40
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489184; cv=none; b=nHo42cE4OiYqJFa7ygveLhxtCUqBxUJeXMByME/mu2PyAYCDhxnyVujDofFENeevhB08BGqYwj+B0zQ2/ytoTByqmx6L8SX9UTZpWJSYAiDcUt4tNu1rgg3nVFQdbG3CTDSXs0mAYw+R+eGFzwnduDtWOIk4wB1eYkLHd6tA2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489184; c=relaxed/simple;
	bh=27y6mu7bcleaZ3gMCj/TBbw5e8RxWIMmu/oX/tQFU8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pbl9Tv9VAJtrO7ma5Sa/uJPTgz61SEFbQ3L3Twd7Gul+ryNMFutUTsXJA/DJg1irJ5zf7jOKnnW/kMipPo0BjY6wHGfIbjpGr7GncSJeraDYyOJdX84hZo+DSI9lUk4yFrvVaSmOy+9Xdc0Hfskr+EtJBVJXu4tMr3uO+z/rbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebd2481a89so1137210539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489182; x=1720093982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5tW2ea+Z0+UnfkIW4kr9PMPDuhfmZ+iYSExnNW4vk=;
        b=Ao06eZdJmOanEpEES7hCxotTx5Gzw98vJkvMyFnbRfC3u68DNeRdt3dI/WY+eHT2mm
         KzgO4qHiwcqzu/2MttGBnfJybLzjbhIzpYNziGtJFPkhxP1cHxIQ8uO8CPaZP38q0y/m
         PoVVPzbfttnOejtA0FrWg//TosP835TLkdeLMr+kwzn3j3rw98JZ579+E14PIm6Bb7RN
         M8qfJeeQ1tgJdhPvS4zOoQQNBqG3qpnfIDs8qIeIbjoREylpmY+gakLTB8TdoNza13z2
         UwTMCJjJ1vKcmMTsemN6UR0vnGM7KJrS+R08iVjFXcXvd4tT3NWdUkkkJip4tmQdRDyp
         z77g==
X-Forwarded-Encrypted: i=1; AJvYcCVXV5f679yX/EV+DK07U9ZX2DY6sDIKNkSFulD4GpJyqL+EqpNRDnC87PIS0P7INIPek+pyKH8IjisLayFg8vgYIEnkrYBsfbDU2uJo
X-Gm-Message-State: AOJu0YyudLLWqogFdr1znnldE73X5YP2oqQL0qF8R6CXWcSiSZO9EnYH
	SiY/SJgWoRzK4XgHIYn0I/wM4iYl3y2DslITWXYtKOsnDU5M9Q6JX9NhepvrdmY9M6hLCHfXeV5
	/hRI2Y1YzVUhLLpjJn9e9+5yltDxWgdyDqpyLVzLacScmRvsSuAEXt9E=
X-Google-Smtp-Source: AGHT+IErEUZ0ERJ2rTuj/p+dbzwRwLUBukJ5xs9jWChbLbuv2y8fhHpy+iJNO1WNicXVAQdFVw8QNetkeheGw+u0c6ozxjf+rrgy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14d5:b0:4b9:5d51:ff99 with SMTP id
 8926c6da1cb9f-4b9efd8fb74mr359206173.5.1719489181921; Thu, 27 Jun 2024
 04:53:01 -0700 (PDT)
Date: Thu, 27 Jun 2024 04:53:01 -0700
In-Reply-To: <20240627113120.2142-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e246b9061bddc55d@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2tp_tunnel_del_work

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
==================================================================
BUG: KASAN: slab-use-after-free in l2tp_tunnel_del_work+0xea/0x3a0 net/l2tp/l2tp_core.c:1336
Read of size 8 at addr ffff8880684730b8 by task kworker/u8:0/11

CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc4-syzkaller-00869-g185d72112b95-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: l2tp l2tp_tunnel_del_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2tp_tunnel_del_work+0xea/0x3a0 net/l2tp/l2tp_core.c:1336
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6207:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2tp_session_create+0x3b/0xc20 net/l2tp/l2tp_core.c:1677
 pppol2tp_connect+0xca3/0x17a0 net/l2tp/l2tp_ppp.c:761
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 11:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 l2tp_tunnel_closeall net/l2tp/l2tp_core.c:1304 [inline]
 l2tp_tunnel_del_work+0x21d/0x3a0 net/l2tp/l2tp_core.c:1336
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888068473000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 184 bytes inside of
 freed 1024-byte region [ffff888068473000, ffff888068473400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x68470
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001a11c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 11, tgid 11 (kworker/u8:0), ts 100058781643, free_ts 99100548000
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x257/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xdb/0x2880 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2344 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2351 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1121/0x2360 net/wireless/scan.c:2293
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5459
page last free pid 4760 tgid 4760 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 __free_pages_ok+0xb4e/0xcc0 mm/page_alloc.c:1208
 __folio_put+0x3b9/0x620 mm/swap.c:129
 folio_put include/linux/mm.h:1508 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4529
 kfree+0x1c4/0x360 mm/slub.c:4552
 proc_sys_call_handler+0x593/0x8b0 fs/proc/proc_sysctl.c:604
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888068472f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888068473000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888068473080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888068473100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888068473180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1360bf01980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d4ba99980000


