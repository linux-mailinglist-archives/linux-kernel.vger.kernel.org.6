Return-Path: <linux-kernel+bounces-312669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CD969992
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1142288A11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26981AB6E7;
	Tue,  3 Sep 2024 09:55:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202C1A4E88
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357325; cv=none; b=S5Ke8359v/+5S0XKg+p06zksqvh95UAEV1vgZsGyjbMzMV0DXcsAemIESaLUS1PzzzWv7hZF3wFnz65AZ0xrm1riBMskvYyl5hPW7b8qosc3BPkkd2JGDw8Twur/ThmcVNR8iNk+XRbLejaVq6P3/NSMwiwhS6q/VKNEyrAMXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357325; c=relaxed/simple;
	bh=JQG+8/hGtJUJC2q24WS3T2KLKfjM6bAKOrrJU5DigZ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M+9+Pi587STqogJmlCKW9GvPXGU2ggnwXr3YFDZU/wRj7jiFTJiRa3F1WggEUbCzF5BQlvlVlylwJ9Bb/vcGs0GcwXPrwHBZynOLMYoKPfP8J5m03FFFJ1taHOGr1v0RLZ8lSUN65K/jXfT3hI8Nezr/ega59TuukTJFcLvxcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a20e57f6aso594729139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725357322; x=1725962122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX/wt3ffsEWk8V7XCO0IbBFzT5CaoqrPS0y+MBMo5IY=;
        b=M+YF6LXtMuZXYTBevT2tLepWzJsgdCQu14oQk+g9JpdKSx8ObQHyQ8CcSv1rI+y5vn
         7rM91UA/ca48+/XVDNDzHLnUl9QJnrZsgp8RY371NWQKTwXrTnmB7GQdgLun6aYjx2k8
         7XFlq1FlQjHh1+DqGr2AzrO8dJR/z+Z63ogWziCeW3bqWIrk69eFMoCgd5g8cB67xJp6
         Q2P7OS4g2s1mvQsQzn6akDjW+IFkWZkdmRwM0ylxHhe28ItxPBB+tDrKVyDBCEhCWgas
         7rT13usY0Lg8ljN/2ZigzD1ohtYiuUpZC0ubooXnRRdC+KJyo++Nx9HmgpWHEQ051dEj
         D83g==
X-Forwarded-Encrypted: i=1; AJvYcCXx1BRDFISejVp/Xl8Y2uPZa75qkcz2UySd/qOFtR05YfqBbMw6+NAY0wG93M/ULD7JZV0lTKvWcDHoQdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeEExoRHdVRxGBVdyTTQwZGORx0kJ/bFPneign7bhRvJ7RRiZ
	CQQTTdIuI6k4Z//ii5HiGcTSrj+vD2vRFfMzRR0z6EsIClwJU/PMFWTE7TUeHNHV+QP7EIP1KS/
	9iO5pPPWKIN/VwTkyOQRAniyM0hm0k917S3mkjx4lowHUUzPp6bsTnx8=
X-Google-Smtp-Source: AGHT+IG8cly+a4u8s3sQKgZVpy2z0NNMhMfAmp+EEEshJkpZmB0detQuUMy3wFUNxgH0Cl0lB1RPnpwP0pfl7sfMSvDNoaiYrx/7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a9:b0:4c2:2ad5:bfd0 with SMTP id
 8926c6da1cb9f-4d017c5c774mr468265173.0.1725357322437; Tue, 03 Sep 2024
 02:55:22 -0700 (PDT)
Date: Tue, 03 Sep 2024 02:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005093590621340ecf@google.com>
Subject: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb2b0b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f2ea63980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13608f33980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-67784a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2583cf0b1/vmlinux-67784a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fedd864addd/bzImage-67784a74.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0604f67569f1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com

loop0: rw=0, sector=117, nr_sectors = 1 limit=0
syz-executor135: attempt to access beyond end of device
loop0: rw=0, sector=117, nr_sectors = 1 limit=0
==================================================================
BUG: KASAN: slab-out-of-bounds in udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
Read of size 4 at addr ffff888012113f30 by task syz-executor135/5106

CPU: 0 UID: 0 PID: 5106 Comm: syz-executor135 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
 udf_current_aext+0x435/0x9e0 fs/udf/inode.c:2235
 udf_next_aext+0x8c/0x4a0 fs/udf/inode.c:2171
 udf_extend_file fs/udf/inode.c:677 [inline]
 udf_setsize+0xa8a/0x1280 fs/udf/inode.c:1265
 udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x46b/0x590 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13639ac249
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0302d508 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13639ac249
RDX: 00007f13639ac249 RSI: 0000008002007ffb RDI: 0000000000000005
RBP: 00000000000013f1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0302d550
R13: 00007fff0302d630 R14: 431bde82d7b634db R15: 00007f13639f501d
 </TASK>

Allocated by task 5061:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4177
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:605
 pskb_expand_head+0x202/0x1390 net/core/skbuff.c:2259
 __skb_pad+0x329/0x5c0 net/core/skbuff.c:2537
 __skb_put_padto include/linux/skbuff.h:3720 [inline]
 skb_put_padto include/linux/skbuff.h:3739 [inline]
 eth_skb_pad include/linux/etherdevice.h:656 [inline]
 e1000_xmit_frame+0x3938/0x5130 drivers/net/ethernet/intel/e1000/e1000_main.c:3123
 __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
 netdev_start_xmit include/linux/netdevice.h:4922 [inline]
 xmit_one net/core/dev.c:3580 [inline]
 dev_hard_start_xmit+0x27a/0x7e0 net/core/dev.c:3596
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0x1a7f/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_cleanup_rbuf net/ipv4/tcp.c:1513 [inline]
 tcp_recvmsg_locked+0x1d00/0x2640 net/ipv4/tcp.c:2563
 tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2593
 inet_recvmsg+0x150/0x2d0 net/ipv4/af_inet.c:885
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1ae/0x280 net/socket.c:1068
 sock_read_iter+0x2ca/0x3e0 net/socket.c:1138
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5061:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 skb_kfree_head net/core/skbuff.c:1084 [inline]
 skb_free_head net/core/skbuff.c:1096 [inline]
 skb_release_data+0x676/0x880 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1188 [inline]
 napi_consume_skb+0x146/0x1f0 net/core/skbuff.c:1508
 e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1967 [inline]
 e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3857 [inline]
 e1000_clean+0x518/0x3ec0 drivers/net/ethernet/intel/e1000/e1000_main.c:3798
 __napi_poll+0xcb/0x490 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6963
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
 __dev_queue_xmit+0x1763/0x3e90 net/core/dev.c:4450
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_cleanup_rbuf net/ipv4/tcp.c:1513 [inline]
 tcp_recvmsg_locked+0x1d00/0x2640 net/ipv4/tcp.c:2563
 tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2593
 inet_recvmsg+0x150/0x2d0 net/ipv4/af_inet.c:885
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1ae/0x280 net/socket.c:1068
 sock_read_iter+0x2ca/0x3e0 net/socket.c:1138
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888012113800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 816 bytes to the right of
 allocated 1024-byte region [ffff888012113800, ffff888012113c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12110
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000
head: 00fff00000000002 ffffea0000484401 ffffffffffffffff 0000000000000000
head: ffff888000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5061, tgid 5061 (sshd), ts 83597267288, free_ts 71025249904
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4177
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:605
 pskb_expand_head+0x202/0x1390 net/core/skbuff.c:2259
 __skb_pad+0x329/0x5c0 net/core/skbuff.c:2537
 __skb_put_padto include/linux/skbuff.h:3720 [inline]
 skb_put_padto include/linux/skbuff.h:3739 [inline]
 eth_skb_pad include/linux/etherdevice.h:656 [inline]
 e1000_xmit_frame+0x3938/0x5130 drivers/net/ethernet/intel/e1000/e1000_main.c:3123
 __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
 netdev_start_xmit include/linux/netdevice.h:4922 [inline]
 xmit_one net/core/dev.c:3580 [inline]
 dev_hard_start_xmit+0x27a/0x7e0 net/core/dev.c:3596
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0x1a7f/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 vfree+0x186/0x2e0 mm/vmalloc.c:3364
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3285
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888012113e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888012113e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888012113f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888012113f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888012114000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

