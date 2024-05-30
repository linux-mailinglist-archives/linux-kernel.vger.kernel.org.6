Return-Path: <linux-kernel+bounces-196049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9AA8D567C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CD92874E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E25186292;
	Thu, 30 May 2024 23:49:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F678186281
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112974; cv=none; b=biTpDwdvM0qDa+W0X5sTByU87I+5/glrIJU6o+1fKdFKJGW2e0Lbs4ojlxP4QX5mV3gMYg2HIAwFk/AnB4DS1+6nSp+JLhmGSk2NvjgBa85Cwg5XEioNCTW+2JCAkahZjCqximti7JMK19KeRSefSzh7EEvamKYVZxHbTev+Txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112974; c=relaxed/simple;
	bh=YN31BmyESqzMtESVOlP6LRIkiK0bbeXZbLPn0+AYntk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bVgzJbELAGKIDsWQA7YJphAN8vWIi0WpWLKhhaf86E0md+0P42EixL7UEumW1uMh81R3+8ibDDC7kfl3+sDwjSoXx+7zkN26zFCRknyiy0Mh3NuYK9avZqyX9lfG40YetYImqxTmqvB2EjHECvsGyh6TFlqPbhFPH/UFfWl4M3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-374820a077cso7799465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112970; x=1717717770;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QdWYIVuVJR5II4L9NJyCTO0lpr3jPFNqdPpqFXZ3nU=;
        b=bbcYjrL4Mo3nLp/qxiKJBM0OQuSVQJkc5haIIpQeoU7ekKO/MG1yyaYee6YpS1Bv8z
         w9JCE1iD2BEEAgjaJkB2RmVch9Tf6Xn3Dv05ZflY5PQzJ+VdZKleLxh0IstdVFpAg8/f
         UmnUgyDEmsYYRih59cOhSkQtHQ8U9bD5qWrc97BIR4afwZFGDv0fKfZKUVva+jAXXxnM
         R+Kn73IBZ2isj/v3CbUTJqX8A74sIAk0o8du4bjFF5Ybg65NzCYpTOsp1Ke3s2lo3K4z
         LmVmJ/AZoU339IZ+hygD8HaHJo13vAUo7X/teSpDZoGW3ubGE2SHaOMly4NlVTBm81u7
         fGWw==
X-Forwarded-Encrypted: i=1; AJvYcCWaTs0FyOM9zZBtqzX9YqEShv70WYY/FcceZj5yik0Pzp1H0dnMIKLy1cm4M3Nm9PmJ9xM3+O+64QMgFRms5lpBDpQ48mwTKdjYXV11
X-Gm-Message-State: AOJu0YydKltt48h5o61DoVRz6vzs1Hvvi4yTAnE0uBJMyvDq9wHHxCn7
	pyQ5Kd52P9YIO1JOPHfs1eO95bzaXhFEprrgbkpgo9H5/8uDWXXJ+g/zQAq6F8QiyRdcLatCehR
	OOOMZL8N/jfuWfTBs+iQLOnyl0YprBnRIDyKYm7edC377A0VWwNuEBeA=
X-Google-Smtp-Source: AGHT+IFcfAZDIy8C7KpLv8BWbtTZCt6FqFwWQ/qz9cZZp5PnMiO+HpjlOHDx5AjbNM7xtsP+jevLpJzOo4ZiW6v5KuzPV3MLNQjr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3748b9ea14emr78735ab.4.1717112970690; Thu, 30 May 2024 16:49:30
 -0700 (PDT)
Date: Thu, 30 May 2024 16:49:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a851b00619b484b8@google.com>
Subject: [syzbot] [arm?] KASAN: slab-out-of-bounds Read in contpte_clear_young_dirty_ptes
From: syzbot <syzbot+7eaa0d7b9fccf21052f1@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c9f9fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92af4362e7016e3e
dashboard link: https://syzkaller.appspot.com/bug?extid=7eaa0d7b9fccf21052f1
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b7af5f8e955/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b1adcfe75e6/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7eaa0d7b9fccf21052f1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __ptep_get arch/arm64/include/asm/pgtable.h:315 [inline]
BUG: KASAN: slab-out-of-bounds in __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1309 [inline]
BUG: KASAN: slab-out-of-bounds in contpte_clear_young_dirty_ptes+0x104/0x214 arch/arm64/mm/contpte.c:389
Read of size 8 at addr ffff00000bf420b0 by task syz-executor.0/4197

CPU: 0 PID: 4197 Comm: syz-executor.0 Tainted: G        W          6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xa4/0xf4 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xf4/0x5a4 mm/kasan/report.c:488
 kasan_report+0xc8/0x108 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __ptep_get arch/arm64/include/asm/pgtable.h:315 [inline]
 __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1309 [inline]
 contpte_clear_young_dirty_ptes+0x104/0x214 arch/arm64/mm/contpte.c:389
 clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1715 [inline]
 madvise_free_pte_range+0xce8/0x10e0 mm/madvise.c:767
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0x8e8/0x14a4 mm/pagewalk.c:293
 __walk_page_range+0x420/0x5e4 mm/pagewalk.c:395
 walk_page_range+0x370/0x6f8 mm/pagewalk.c:521
 madvise_free_single_vma+0x300/0x5a8 mm/madvise.c:815
 madvise_dontneed_free mm/madvise.c:929 [inline]
 madvise_vma_behavior+0x30c/0x1028 mm/madvise.c:1046
 madvise_walk_vmas+0x114/0x210 mm/madvise.c:1268
 do_madvise+0x20c/0x6c4 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __arm64_sys_madvise+0x88/0xdc mm/madvise.c:1479
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x6c/0x25c arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 1:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:47
 kasan_save_track+0x20/0x3c mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x54 mm/kasan/generic.c:565
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x8c/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_noprof+0x128/0x2e0 mm/slub.c:4007
 __kernfs_new_node+0xd0/0x704 fs/kernfs/dir.c:624
 kernfs_new_node+0x100/0x1f0 fs/kernfs/dir.c:700
 kernfs_create_dir_ns+0x34/0x118 fs/kernfs/dir.c:1061
 internal_create_group+0x2a0/0xb80 fs/sysfs/group.c:167
 sysfs_create_group+0x18/0x24 fs/sysfs/group.c:206
 dpm_sysfs_add+0x80/0x1c4 drivers/base/power/sysfs.c:702
 device_add+0x70c/0x12b8 drivers/base/core.c:3681
 platform_device_add+0x2d8/0x5f4 drivers/base/platform.c:716
 platform_device_register_full+0x390/0x4f8 drivers/base/platform.c:844
 einj_init+0x94/0x110 drivers/acpi/apei/einj-core.c:897
 do_one_initcall+0x140/0x7bc init/main.c:1267
 do_initcall_level init/main.c:1329 [inline]
 do_initcalls init/main.c:1345 [inline]
 do_basic_setup init/main.c:1364 [inline]
 kernel_init_freeable+0x56c/0xbf4 init/main.c:1578
 kernel_init+0x24/0x1e0 init/main.c:1467
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

The buggy address belongs to the object at ffff00000bf42000
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 0 bytes to the right of
 allocated 176-byte region [ffff00000bf42000, ffff00000bf420b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4bf42
flags: 0x1ffc00000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 01ffc00000000000 ffff00000a14d280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00000bf41f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff00000bf42000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff00000bf42080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
                                     ^
 ffff00000bf42100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff00000bf42180: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
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

