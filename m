Return-Path: <linux-kernel+bounces-399476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEF9BFF6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E231C216C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E619AA63;
	Thu,  7 Nov 2024 07:56:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989117DE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966167; cv=none; b=IfEqUgAgyrJZMZlggFhYcak4gnO6DFAvBinMk1VojrHEjVAmHeid1zjQn0udC/F62thSo8b3Bng2cIuMzjmNrHXuZCe5NzbU2cw86gOt7l9HrSzQIxpC9zDD6wVLBo4q5OizEW9xQAjEPgAiUru6IlTQjSusQekTmW1j61NJSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966167; c=relaxed/simple;
	bh=SxgXoX+6jolcm9eaYTg73Aox34QDXZfHBjxZ0qIsO/g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lE7M3pIno+tmVLdEXEQP8KtBWeQz6joRLaKEdKLKIOeyS+jA50z6N3KWjDp7UgI6Agj6tR9FY9fgC1cwwX5T7mF0ZiXOqpNEqycNyhPKgvvMmxt1aKHTeRycGp+CL4SYJfH36wI1ljVrSHtV30qcKUYlWovpzCYYS4aUNeMK2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so7847855ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966164; x=1731570964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88W8ItruGS1Tw1Gqi1vj+XgIUBQW9aW6C/2RStBW4oM=;
        b=tKMIMIusECRXWaR+XQD5ApKYNqHuX2KQxZoH87P//OGEJc0FhU+jjnmj5ag6sWVAnV
         B8ieocO9wDZ+FpIya5ChdCCHo9POMVlwMgj261LaMAkE9sXaQi9B6Fl56l7pLRC5jfj6
         WEAvVa80Ioh9yDnWcl/9nBktbINcTz8Vdu38TYG8CTL1GUJSLnaD+Xnrfix0NPXh7P0Q
         W6RbjfwP3HAODtSiH0l6bDFvKcrfCjzXzjUlow/gxZO1GRCPTGyD9G3NwHcJIeo+kNmT
         +8kv9M0vr0ZqkARCKnvFTQGNZeDiGAwqJVXKIhGAnXAccgvkVJQ0Yk+ChxW6mG5AwEoN
         qFrw==
X-Gm-Message-State: AOJu0YzcNLpLXvjiLWawl9J1f+W1c2WE16vEjp2gIRG4nN3Ys6svxTzX
	tJRpBpJNP76Vvm6enpFJsoWNVG8udE9Ko8VrMQ5TZOJTPAFJ1E36xBD50/ubzkr2Zq9CadTXgyC
	li8nOjtyzRTxhy16BJ86mqLCxqzoajr9DFA38doT+CKR3cxHTEcqWon4=
X-Google-Smtp-Source: AGHT+IF8801g7yxVzP/lVKLA3JQn8nJckTw75MOFs7CSTSAYKn6tKPyBJ3fKeCC1g8o1dkinFLdpHFZk2GICbO3FkZMnsSa2eNRb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a6ed0d54f8mr4073365ab.14.1730966164685; Wed, 06 Nov 2024
 23:56:04 -0800 (PST)
Date: Wed, 06 Nov 2024 23:56:04 -0800
In-Reply-To: <CAHiZj8jdL5H9fBK5aA-VpNmEPkf7iatuBh5u2fby__t8nekTtg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c7294.050a0220.31356.0001.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459
Read of size 4 at addr ffffc9000169e038 by task syz.0.15/5821

CPU: 0 UID: 0 PID: 5821 Comm: syz.0.15 Not tainted 6.12.0-rc6-syzkaller-00110-gff7afaeca1a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
 acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7eff6877e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff6951b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007eff68935f80 RCX: 00007eff6877e719
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
RBP: 00007eff687f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007eff68935f80 R15: 00007ffc0d47a418
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000169e000, ffffc900016a0000) created by:
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888040b49700 pfn:0x40b49
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888040b49700 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2cc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5821, tgid 5820 (syz.0.15), ts 123316051472, free_ts 123283007135
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
page last free pid 5712 tgid 5712 stack trace:
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
 getname_kernel+0x59/0x2f0 fs/namei.c:234
 kern_path+0x1d/0x50 fs/namei.c:2716
 tomoyo_mount_acl security/tomoyo/mount.c:136 [inline]
 tomoyo_mount_permission+0x8db/0xb80 security/tomoyo/mount.c:237
 security_sb_mount+0xe0/0x2f0 security/security.c:1565
 path_mount+0xb9/0xfa0 fs/namespace.c:3776
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000169df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000169df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000169e000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc9000169e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000169e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1504ae30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d2df40580000


