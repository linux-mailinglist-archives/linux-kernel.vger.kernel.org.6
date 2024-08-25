Return-Path: <linux-kernel+bounces-300211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354F695E075
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7651F21D03
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2912119;
	Sun, 25 Aug 2024 00:13:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B2817
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724544805; cv=none; b=bDHVp2ToJIIoKxQXy67z4XJRtM3GyG2lp4S8fEWUuL/8Qnet2B7hFWxS1VCSPGlR1/RWyBVBfr8NZRxl0AT6ON6LhvwMB3C0ErVfkog1SAo5BkQvLvmB7SvssBcgNM8WDCbOzJbOHWMOpaOC74aBDyBiOlnTDGHjzHWeqKuFDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724544805; c=relaxed/simple;
	bh=UFV9hBpUSpf16CB4Z2k2o2ToUZipCUs4fZyzTa6PPnE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bn811DgnSmyzP0fsLf7fQL8OEixHs5/pW24oLxrFmfN/bkF/9lROBJQSK58zmk2EQCCIMSD1BbAvmZ+/0WWIWMYopQ1D59HbUwQ0qHC1a9nSJ1FdhHsKPQLxx7u6kQ9oXuElDlmIVXKZEnx9SuVTtKUDtP0BeadVIVO2fK3Tfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d49576404so33008845ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724544803; x=1725149603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwTiW/VJC3EVIU91mUst+X3Xt+nwR64slOGsXzz+GgA=;
        b=A9i52RcE2G0McE2d2bN12xDXNCODnuWscqyZDWvTGdd2H5GFpiSbp0x2LC2JcsASU+
         ZcEWDcMktADFrHqca3Nj3tb7ouaKGNJckgaLQkpW4sQbBKpkngT9lXzyQO0m+qWFK0mu
         ZN/pvdlToLzr5VYFgMuBxGfAUWvOsh/D3pc5E9mWBzTAhjC0ypNYKTIWNskRh1j/DC0e
         Z/YQm75rhD/YKyvYRs7PMPs0f/L89Zq8Xr+wLFC66EF/5fomKol0KH5/q4EHYlFwI6rX
         MZW9afgOBzjyNNMw6efMbT2F6Dmp+1G/Rqmr5EccQdpA52K6DvRJHES71Wa5yj3qi5UX
         wPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpSYyMBjkJnPm3mkQ2qR7wddRlN6kMKXUmGqYCDMc+tuTtbE94NBzXFGGWuwEZGQLjWWjxhEzs1wKy8Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW99bkP/Iie03uj+G++sJRXwQL3GyPtkRjw4C+I81F6D8j3rn
	3RWy54WiL3wne/h/nmXFvzCyfaUYvfsXjE+JqpwU3mMK/8HGoWfXx3ojFsQe52+/C5m1xyxN8ml
	G8uHPhQmLjrjR+69Pffks36jdPWhqBKXdseLOXWikOOk6ImHZBtxRgWM=
X-Google-Smtp-Source: AGHT+IHYXbnw310hcjbXgo+X6VZXrB35d1FxZCySmDt5tpiaoBtpe2InpxPooO0odrc1ou/808E+m+/wW62H2+4xrgVHgjqebnQq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0d:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-39e3c9e6694mr4930955ab.3.1724544803101; Sat, 24 Aug 2024
 17:13:23 -0700 (PDT)
Date: Sat, 24 Aug 2024 17:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000636a27062076e046@google.com>
Subject: [syzbot] [usb?] KASAN: invalid-free in raw_ioctl
From: syzbot <syzbot+c17537a52fdd1e1bf35a@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ca7df2c7bb5f Merge 6.11-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1317d5f3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31bb2857b4a82509
dashboard link: https://syzkaller.appspot.com/bug?extid=c17537a52fdd1e1bf35a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9cc03ea70257/disk-ca7df2c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2474799a1fb1/vmlinux-ca7df2c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/defdfb2c65cd/bzImage-ca7df2c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c17537a52fdd1e1bf35a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:964 [inline]
BUG: KASAN: double-free in raw_ioctl+0x4e7/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1321
Free of addr ffff888111c532c0 by task syz.1.5060/27826

CPU: 1 UID: 0 PID: 27826 Comm: syz.1.5060 Not tainted 6.11.0-rc4-syzkaller-00047-gca7df2c7bb5f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x135/0x160 mm/kasan/common.c:232
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x10b/0x380 mm/slub.c:4594
 raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:964 [inline]
 raw_ioctl+0x4e7/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1321
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc90ec49a7b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007fc90d8c4f00 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc90ef10320 RCX: 00007fc90ec49a7b
RDX: 000000000000000b RSI: 0000000040045506 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000868 R14: 00007fc90ef10b88 R15: 0000000000000868
 </TASK>

Allocated by task 27832:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4177
 memdup_user+0x2a/0xd0 mm/util.c:226
 raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
 raw_ioctl+0xbca/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1318
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 27826:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x10b/0x380 mm/slub.c:4594
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888111c532c0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffff888111c532c0, ffff888111c532d0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888111c53300 pfn:0x111c53
anon flags: 0x200000000000000(node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000000 ffff888100041640 0000000000000000 dead000000000001
raw: ffff888111c53300 0000000000800077 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 12232, tgid 12232 (kworker/1:7), ts 1485408509711, free_ts 1461255308030
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_track_caller_noprof+0x14e/0x3e0 mm/slub.c:4177
 kvasprintf+0xbd/0x160 lib/kasprintf.c:25
 kasprintf+0xc8/0x100 lib/kasprintf.c:59
 dvb_create_tsout_entity+0x26d/0x430 drivers/media/dvb-core/dvbdev.c:266
 dvb_create_media_entity drivers/media/dvb-core/dvbdev.c:298 [inline]
 dvb_register_media_device drivers/media/dvb-core/dvbdev.c:397 [inline]
 dvb_register_device+0xd99/0x2000 drivers/media/dvb-core/dvbdev.c:547
 dvb_dmxdev_init+0x33e/0x4e0 drivers/media/dvb-core/dmxdev.c:1435
 dvb_usb_adapter_dvb_init+0x636/0x9f0 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:192
 dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:86 [inline]
 dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:186 [inline]
 dvb_usb_device_init+0x15c7/0x20a0 drivers/media/usb/dvb-usb/dvb-usb-init.c:310
 gp8psk_usb_probe+0x51/0xe0 drivers/media/usb/dvb-usb/gp8psk.c:304
page last free pid 803 tgid 803 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2612
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2797 [inline]
 apply_to_pmd_range mm/memory.c:2841 [inline]
 apply_to_pud_range mm/memory.c:2877 [inline]
 apply_to_p4d_range mm/memory.c:2913 [inline]
 __apply_to_page_range+0x795/0xdd0 mm/memory.c:2947
 kasan_release_vmalloc+0xac/0xc0 mm/kasan/shadow.c:525
 purge_vmap_node+0x3fc/0x920 mm/vmalloc.c:2208
 __purge_vmap_area_lazy+0x9ca/0xc10 mm/vmalloc.c:2290
 drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2324
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888111c53180: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff888111c53200: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>ffff888111c53280: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
                                           ^
 ffff888111c53300: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff888111c53380: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
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

