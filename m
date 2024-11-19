Return-Path: <linux-kernel+bounces-413845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1329D1F89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C107B20C92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3814A4E1;
	Tue, 19 Nov 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fmElQZKu";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="J6b/IQqL"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264B2563
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731993858; cv=none; b=QtiQOh8n3YfIq3WqsShqIR+msDSsmKMeiBz8pZHEqzqY3/yprxuImEVfhPeUjIn3XBcm8SPSM1oU76UQqJBeZPOmUnTCopH/QgGwUCE+Ja3Wp3kFF6L02f09R6Ov++Ed6DLKXguXvJ0kNS2ce13nHOucrLs/5GJ11nTxMSZbwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731993858; c=relaxed/simple;
	bh=RSIWF9dWhK5bG+0/7bgkNz1VCaANPiyJxvYDBREv8/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tkjipS4aQ2kXxiYUPkSbgH9ftS3dvuUu+eAEezYEVc/oWrjR5aPEONxahXG5H4fa5EuMO9W3M7wAeytIU411avNkq8gZ5aJwayWEcUcS59cxww+xHq6mnDorEun7o3YAPdNXWOCzsV89NimUCIQqZg47890X3NdcrgW7vJqFkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fmElQZKu; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=J6b/IQqL; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1731993855; x=1763529855;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=RSIWF9dWhK5bG+0/7bgkNz1VCaANPiyJxvYDBREv8/w=;
  b=fmElQZKuugesHelL0TLUETfrBRhMd507XG/sk9jD+7NnHRQksNuWSl7L
   xKio9FMOQ8Y5CDNyo9LVWJnhUBD6xZQpB7pVCerEEF3I4/wGPpjCNXh7k
   Q7waA+s/pSD0oXxtYL8gSLt6di5OtOWmiDPxccO8GPQ5W67owLiT4VE+3
   GqnDrlaJDqJHEjZzReQt42yc97R4Nnk8MySkFeNmyaikfJN968CKEwIX1
   +8bcN+aUFG5EsjpuG9QG0HmiObb6Ipj5maQHeX0bYd7Lf9bUOqThsM1FL
   Q+MAWPCWSlcumQaR8aRMm2HMHC2ZnHPVz0AfkwPgkm9d5cJhBRam25mCz
   A==;
X-CSE-ConnectionGUID: ujvuPdZDSFKQyRuVWWCc4Q==
X-CSE-MsgGUID: gl/v/8FGSXi2tS1TvrGNtQ==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 21:23:06 -0800
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abd63a132so430638339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1731993786; x=1732598586; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z7RSfGOcNLlRwLMd+5dBsRSHhdnFAckzvVBCNqgl1Iw=;
        b=J6b/IQqLRLI69xSV144+6lwxtW296PkD74R+5OUpbHDL+lmZB7rfc/2sUHBmtGGbwa
         DxansFT+CgfCzITixHUEPH0IHTA0/jYeVW5teVBMlyy0broNgyNvsF3aL9BNLxIYNG1I
         KhtnPMTZydG61c3BoHJuOW0esP8Cb7cZyBI0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731993786; x=1732598586;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7RSfGOcNLlRwLMd+5dBsRSHhdnFAckzvVBCNqgl1Iw=;
        b=ITYlaZWY2XTJb13d/K4VoW3MRWVEK7TeattStKOFbxtytF429qij2A74nDH7lnBcn3
         apK1Dl9yMQzh2YV0zqVNgZURVdJQNv2Vh8fMPb4aSQj77aGCiOHECYIx33fRW6slOPzD
         1D2w9zfnvZfSjj4iwIt0kh1A/eQGDoe3re2eS3OytzT3fMqjOEXQuP7yFKiTQekLQWjt
         vTJultPnuu2e1BjIoihU33uxj0XTrEv+r1OmwP4kroGTF9AxCHlh65W3xRL6SiAz7rnx
         T7TgIXtTSLSiS5VaPA1kgPeIpfD90l87e7Pn4MN6999pAq0DJXgolmVq+MnlGpWztH7d
         5AIg==
X-Forwarded-Encrypted: i=1; AJvYcCVlbc6R8hahYC1Nl2PUZxyDU4RdTZ7O4O9LPsXZPcl9ArvxL0SKijlnCIy6cubwCkkcbMsH7kD9bkRrXFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rhxbzof00fIU22/G8+chhROoTBwXowAOsQ1z5CKk6SQ33+w8
	gycLIdl9NgllhUGrkerWYOdTvLCMvhpAbYRub9aDOc4aKfq1FEZRm30VAUhpkd9X6Fj+Sv547PX
	f6y6NBfhsvAGXGlU6AqVs1Ca4fAE3VO14wowp4Tjd5Sp4BF06dh+CMlqAdXPIK/Rl0iekz3Tbev
	iAup/g4isl/N6Wh4xdThbRjE24+aIocrLC4iwA6A==
X-Received: by 2002:a05:6602:611a:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-83ea8abcdbemr206901339f.4.1731993786344;
        Mon, 18 Nov 2024 21:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr7JIuo+Q8xum+7MTkOOdjvwMuhzU3MUjpVITuW3scWIk+NPW/z5/EqehSYHebQuGWYDaVDYWhsNEwCsr03w8=
X-Received: by 2002:a05:6602:611a:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-83ea8abcdbemr206899939f.4.1731993786028; Mon, 18 Nov 2024
 21:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 18 Nov 2024 21:22:54 -0800
Message-ID: <CANikGpf8mkdZ+MVjLWoBEg0XZOBmwHVGaZVKX6eBSst+a2-Y8w@mail.gmail.com>
Subject: BUG: KASAN: slab-use-after-free Read in gsm_dlci_config
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.11.
In function `gsm_dlci_config`, a use-after-free on object `dlci` has
been detected.
Since the reproducer takes around 10 seconds to trigger the bug, it
might be a race condition one.
The C reproducer is available
at:https://gist.github.com/TomAPU/2ef61db5e741daa2b4b040fd874b9e92#file-gsmvuln-c

==================================================================
BUG: KASAN: slab-use-after-free in gsm_dlci_config+0x7b7/0x1020
drivers/tty/n_gsm.c:2588
Read of size 4 at addr ffff88803dab000c by task syz.0.361/12086

CPU: 0 PID: 12086 Comm: syz.0.361 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 print_address_description+0x77/0x360 mm/kasan/report.c:377
 print_report+0xfd/0x210 mm/kasan/report.c:488
 kasan_report+0x13f/0x170 mm/kasan/report.c:601
 gsm_dlci_config+0x7b7/0x1020 drivers/tty/n_gsm.c:2588
 gsmld_ioctl+0xbbc/0x2540 drivers/tty/n_gsm.c:3880
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f86c25809b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f86c3429038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f86c2745f80 RCX: 00007f86c25809b9
RDX: 0000000020000200 RSI: 0000000040384708 RDI: 0000000000000003
RBP: 00007f86c25f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f86c2745f80 R15: 00007ffd81f1d488
 </TASK>

Allocated by task 12086:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3b/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x94/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19e/0x2b0 mm/slub.c:4154
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 gsm_dlci_alloc+0x53/0x6c0 drivers/tty/n_gsm.c:2643
 gsmld_ioctl+0xb99/0x2540 drivers/tty/n_gsm.c:3876
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

Freed by task 12087:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3b/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x3c/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x140 mm/kasan/common.c:240
 __kasan_slab_free+0x33/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x118/0x2a0 mm/slub.c:4559
 dlci_put drivers/tty/n_gsm.c:2706 [inline]
 gsm_dlci_release drivers/tty/n_gsm.c:2739 [inline]
 gsm_cleanup_mux+0x5a2/0x930 drivers/tty/n_gsm.c:3156
 gsm_config drivers/tty/n_gsm.c:3408 [inline]
 gsmld_ioctl+0x13c4/0x2540 drivers/tty/n_gsm.c:3839
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

The buggy address belongs to the object at ffff88803dab0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 12 bytes inside of
 freed 2048-byte region [ffff88803dab0000, ffff88803dab0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3dab0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888013042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888013042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000f6ac01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 8050, tgid 8050 (syz-executor), ts 139463488880, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1db/0x220 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x7e5/0x860 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x25a/0x580 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x67/0x130 mm/slub.c:2265
 allocate_slab+0x5c/0x240 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xc6b/0x10c0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 kmalloc_node_track_caller_noprof+0x268/0x410 mm/slub.c:4143
 kmalloc_reserve+0x10e/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1e8/0x430 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_ifinfo_notify+0x6e/0x110 net/ipv6/addrconf.c:6161
 addrconf_notify+0xca7/0x1000 net/ipv6/addrconf.c:3762
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 __dev_notify_flags+0x201/0x400
 dev_change_flags+0xe8/0x190 net/core/dev.c:8858
 do_setlink+0xcc7/0x41e0 net/core/rtnetlink.c:2900
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803daaff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803daaff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803dab0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88803dab0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803dab0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

