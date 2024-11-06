Return-Path: <linux-kernel+bounces-398429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48E9BF12A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D11C21C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C7185B58;
	Wed,  6 Nov 2024 15:06:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E02537FF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905566; cv=none; b=Mi+ZPPn4qW3DOobq/28jIln/lL9d8rQJGLAqDSkxBV5E+gjGw1u1fm/6t+BPG4+BGA6mKVaz8BPnUa+jf2347cJkFz+aaE2/PbOKJRww0smtzDdoqE61MszM5NT/ZeLJqaRqMXp8t/pquHumdynW2RthdV616rQ75aFlDpTCjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905566; c=relaxed/simple;
	bh=quYL6+FlHA0cheZYOYCnPncpwtAp1HntMbJZgEAXU80=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mRTgyj0HnA5V4xy05Y+2M7SO99H3TUXfJX0+mwt0r+bNHgPmd1a9gn0GTUrFdsTF+aOIffrgf/zPJSkBazF52P4jbomIeMwKw9/HLXnoQnZ3A5JOntXU6PYpz6ZXhG619HWaCoyHwy9FVdBE/qV/d0C3/0JynFJwsgDvVTL4ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aae46538bso710651039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905564; x=1731510364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk9umGkAfRTN0+Uj5VR8v3xY0+9Z/Y+2qBBIBw83Ayg=;
        b=wU/bM6em28eWGZQe8DBoo2rvnXg5+kASjoOckYSyd+meHBYRb626Npe4D3e32c7yG+
         6L59c34TogqMFhfJr8JT4nh5mJDwmkzitIQT/dwTn53haxgBiEhdwAd6ZtqDODh21LKS
         z1bn9IoXf8HKD81HaS2yy64GJ/3O8wvC7+BJCxgLQ+CyrTaRhMsk/46svONYAqyizYL2
         M1/2Bl4XOeiA+dJRjpB5T6CUd+1tRtIptzN6OrkLa4Sl5A/pH/N5RrmeymKhDpB1j/5z
         XAU8MaZyN9Q3VX54YUDfLHOh12KNL0Oiigbck5vtk8SN/tKHW6ku+veu68ogampX+gYV
         64GA==
X-Forwarded-Encrypted: i=1; AJvYcCXalV7qDz6npJoXpo1cEvG/8G7NUFGYJrSSvCCuRyT69YA5uFzUo1SaRds6QIINO500bVZVU/NjHPlMHis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwilkrExtI+0g2Dkh4p1nGKI6Bl1pjQZUnwqL0a8ZI5SgQ1+K
	aJeHew8Cdx9DczRkEfpV6L3eP380V1n7xylarNWZxW54oqUkj5s1sshY4F/pBHHvOrzgkO3d2a6
	Kv6d17HIS5MN+PGBr9QcXMgcVxfoDMcJpAjuVuZbzcGQEVsfFVSdEciI=
X-Google-Smtp-Source: AGHT+IHLMMBk0ub4WPZFmvIVVgAlxZRIv2z19Tr9OHGTrj6Q/TkT9U+F639yaGiStgXA4u8ZoN1bg3hxLFpEVRDluTDS1nAu2r7K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a6:c43d:12ff with SMTP id
 e9e14a558f8ab-3a6c43d15bcmr123226705ab.8.1730905564286; Wed, 06 Nov 2024
 07:06:04 -0800 (PST)
Date: Wed, 06 Nov 2024 07:06:04 -0800
In-Reply-To: <20241106145044.90199-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b85dc.050a0220.350062.0262.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl

9
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/core.c:417 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x2061/0x2440 drivers/acpi/nfit/core.c:460
Read of size 4 at addr ffffc9000166e038 by task syz.0.15/5815

CPU: 0 UID: 0 PID: 5815 Comm: syz.0.15 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 cmd_to_func drivers/acpi/nfit/core.c:417 [inline]
 acpi_nfit_ctl+0x2061/0x2440 drivers/acpi/nfit/core.c:460
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f768a37e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f768b263038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f768a535f80 RCX: 00007f768a37e719
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
RBP: 00007f768a3f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f768a535f80 R15: 00007ffec5fc1248
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000166e000, ffffc90001670000) created by:
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888040f74360 pfn:0x40f74
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888040f74360 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2cc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5815, tgid 5814 (syz.0.15), ts 117205092748, free_ts 117198254028
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
 alloc_pages_bulk_array_mempolicy_noprof+0x8ea/0x1600 mm/mempolicy.c:2556
 vm_area_alloc_pages mm/vmalloc.c:3542 [inline]
 __vmalloc_area_node mm/vmalloc.c:3646 [inline]
 __vmalloc_node_range_noprof+0x752/0x13f0 mm/vmalloc.c:3828
 __vmalloc_node_noprof mm/vmalloc.c:3893 [inline]
 vmalloc_noprof+0x79/0x90 mm/vmalloc.c:3926
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5612 tgid 5612 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000166df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000166df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000166e000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc9000166e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000166e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16808d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1109b6a7980000


