Return-Path: <linux-kernel+bounces-334289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709B97D526
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48209286663
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73A14B083;
	Fri, 20 Sep 2024 12:00:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BB14A611
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833605; cv=none; b=Yxsj/sdt6nExgTf3a13gE7DJqraE1YmRF26rBfZeA7/MU8Z1dpzowu6l3G9kicPvGpyavL080SsKOo21wlDiTDw8iyhl7fIUCc031wbGfHYeGY/P9NiInbJEqDaxsguVdaKDqM85uQ93v/4cgde1V2q+29+ZbrxonHrqALLzryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833605; c=relaxed/simple;
	bh=Yg9dSRkf2wdfzlj/X/2IaRtZPDJuNei88ci7TDTPrxo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8D7QFyA3HDtX0g0PLtvcpbS106TpQpmQeqPOp6WU/Us1LFu1I120mU7QCA9WSGJR3v6Ijy/UGD8vCIrO4twQijH2XTaOZUZvccQZ2tY1Fx7v3zVwcKClSC9C+bcdVig4P7eSyAYpYW06p6CLAUVaoYroOzbuVINeSXPRvRS0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so6303895ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726833603; x=1727438403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CKr9UlyFP24HZ2suKQmVYmXK1fTo9wwcBNVTnpAwqc=;
        b=D4Zn/eBTNJRowNuNSpWHDWbxzrGRhh54d9rbwrdcVh+c5ayiSNeqaFP3Te2l0dBweC
         4S3uKKsNsI3FFr04gY/wpiuNGvFz5xj80x6Rc4mvXtuknnpzWYfEADSYgWyPSfy4nKph
         AvWJPDEBNoPj4f5l0NulShH/+qk8XMqZNTdGM/wZWbnBQ5MbTRH0CUDFav+gWcqYxJEP
         5EgE61zCrhS67JYl3RmeqgaVha7ydFrLgH18XrIjflRUIlRtw89X9xmjvRS4b47vLyna
         hjxcX5HPnAola/wviowlEELFqpFV0fXTnygKd9FV0VLvsehUUrUiIU8DIGO3xvQZENgz
         4oVg==
X-Forwarded-Encrypted: i=1; AJvYcCVC7/gdM+z9xSpm84o8e9QcJuTmgxOPceORs0qYQfsLA07Gp4pepaRcmxv9tAi+zfhFB5wq2L+8iTspklQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwJGkX+G69nJuT6yuaBg8sYcdD0hrPqFDtOa/15rbxSoWVgUe
	PCB93NsyzxJmlMqSenpGyVRx4slaULWNoNNXN7PQPx9dobhxsdovHlVHxAKLC2pJIVIOhHs6VEG
	cvLx87ZaWQcOag6t1xI0dkQ/OirTI5lgS96p+jTA5qpz6ne2+v/fFRgg=
X-Google-Smtp-Source: AGHT+IGNuLZMO1jLenLJRscLSrzxOUfjW0EhzBnHdfTlfa4JXyoG5HytINOyx+BuWyw59hVfh1J9d5F/vQOS17O5GQljO48CAS2z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:3a0:9238:d43 with SMTP id
 e9e14a558f8ab-3a0c8cd71e0mr31227645ab.12.1726833602974; Fri, 20 Sep 2024
 05:00:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 05:00:02 -0700
In-Reply-To: <20240920112809.627-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed63c2.050a0220.2abe4d.0011.GAE@google.com>
Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in
 em28xx_close_extension (2)
From: syzbot <syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in em28xx_init_extension

em28xx 1-1:0.0: No AC97 audio processor
==================================================================
BUG: KASAN: use-after-free in __list_add_valid_or_report+0xe4/0x100 lib/list_debug.c:32
Read of size 8 at addr ffff88811ec98250 by task kworker/0:2/42

CPU: 0 UID: 0 PID: 42 Comm: kworker/0:2 Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __list_add_valid_or_report+0xe4/0x100 lib/list_debug.c:32
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 em28xx_init_extension+0x48/0x200 drivers/media/usb/em28xx/em28xx-core.c:1114
 em28xx_init_dev.constprop.0+0x197b/0x3090 drivers/media/usb/em28xx/em28xx-cards.c:3679
 em28xx_usb_probe+0x1151/0x3770 drivers/media/usb/em28xx/em28xx-cards.c:4035
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811ec9aa00 pfn:0x11ec98
flags: 0x200000000000000(node=0|zone=2)
page_type: 0xbfffffff(buddy)
raw: 0200000000000000 ffffea000446c508 ffffea0004668f08 0000000000000000
raw: ffff88811ec9aa00 0000000000000002 00000000bfffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140cc0(GFP_USER|__GFP_COMP), pid 8, tgid 8 (kworker/0:0), ts 189962545246, free_ts 190359765080
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x7f/0x1a0 mm/slub.c:4107
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4134
 __do_kmalloc_node mm/slub.c:4150 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5e mm/slub.c:4181
 kmemdup_noprof+0x29/0x60 mm/util.c:133
 kmemdup_noprof include/linux/fortify-string.h:753 [inline]
 em28xx_duplicate_dev drivers/media/usb/em28xx/em28xx-cards.c:3732 [inline]
 em28xx_usb_probe+0x1f2e/0x3770 drivers/media/usb/em28xx/em28xx-cards.c:4083
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2619
 __folio_put+0x1dc/0x260 mm/swap.c:128
 em28xx_free_device drivers/media/usb/em28xx/em28xx-cards.c:3566 [inline]
 kref_put include/linux/kref.h:65 [inline]
 em28xx_usb_disconnect+0x4e0/0x610 drivers/media/usb/em28xx/em28xx-cards.c:4207
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88811ec98100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811ec98180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88811ec98200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff88811ec98280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811ec98300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         68d42091 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=130b2e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=a11c46f37ee083a73deb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15aa1607980000


