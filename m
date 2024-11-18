Return-Path: <linux-kernel+bounces-412900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CB9D10D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5211F22999
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED319ABC3;
	Mon, 18 Nov 2024 12:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2D19AA63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933905; cv=none; b=iMI/D+j8abuENXwmiuU+FnOsYR8Ju6tLF02fLvv2IGZZUUlIYZlASwXxhIG2/OT6HdYeW/ACl1kq0iyTMrB0bKruKArZK1pd5YWUDvjvaVou8/trm7bjo1KG8D2bKm2ngkoOCCgGFH6Wz6D4VycIWOtMGQiXruBdcBJyLiTitsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933905; c=relaxed/simple;
	bh=ho6ZUA1wruKouLPxCS5An2hpaWwFVlb2vPfoZv6YNUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pJRefdr/fGgfvh8P4e+b46nlNpIC5VluLXR4NWYjemBmrDXQ8ltKUBth2FG92M/ep+VB+hS3xcEVg9jvyL5xljsxIiO5LzCvOvaYjaB4tH1R4XD7oZT9u9V3ABk2zOcyonsAQMwek/QZKcBWxzm7mkd1tXXSjnsBiUtkCc35H+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a763be8191so11563445ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731933902; x=1732538702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+wkH0hHqbmsP3tIecxIaLQgLTNS2ky96wne1JslhK4=;
        b=MyTzUQSaohYUouqjkdX+sGMIj8RaBAIO7fDSza2ZaMgmb1C9XBDYMBnvqgQ+XDMH99
         vDKPblelYaYwG7V8Sghn1Eu5j3r6fEaaA0YgZudAWSPNn0OzHQu6mhfUvuIDE4ePgtWI
         qMf0zggVdY0wTd8vB5HPF6Bx9hnPIbY2N45fazrp8DHldJVWj9XeocofgoJwH/ulcmAA
         5KYtjI6Fy3heXx4T8CELOYQXYO+WMjZw+LpwMerrYwTqmP9TmbJ4/2a3VxjisItcHIig
         iXwpXP8cWGDR9onYYn83Kxho0CWY87RVjZ8R04zHf4prlfALqmBkHWNkGaI74BnLBHCK
         Lf9g==
X-Gm-Message-State: AOJu0Yy/xB9/WbPh9L02JLd9JB+oOL7/uet+HNp4ojHWOlC9o32yewb7
	pB58WYjJ8E0cZfGnloAybN+u+CH6NkeZQ+nroudE6RzsZYn3OevEadRKn4vsoNFMGll4d+0WFG2
	3iqLzupiLxaEj/stGc/vSp+UzAbM//JZMAx3m/BrIesc4ob2WcqR2mIU=
X-Google-Smtp-Source: AGHT+IFB0/PmiFyBu2cwErCsT0sBpn2Z6/5kEnAtE80mp7OZra4nY3lMzj0XnXkwTf9p3Qy+Rzwcl/j4V2X0Mjugx9Zfmx9o6+fs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a74808cc3emr117110515ab.24.1731933902716; Mon, 18 Nov 2024
 04:45:02 -0800 (PST)
Date: Mon, 18 Nov 2024 04:45:02 -0800
In-Reply-To: <CAHiZj8gNs-FFFQ0E1Zyxq7wa=CrHVfbaXeNE8yYi9eZVakGk8A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b36ce.050a0220.87769.003d.GAE@google.com>
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
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:465
Read of size 4 at addr ffffc90001106038 by task syz.0.15/5811

CPU: 0 UID: 0 PID: 5811 Comm: syz.0.15 Not tainted 6.12.0-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
 acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:465
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f51e537e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51e61fb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f51e5535f80 RCX: 00007f51e537e719
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
RBP: 00007f51e53f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f51e5535f80 R15: 00007ffe9dc12f58
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90001106000, ffffc90001108000) created by:
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88803f405500 pfn:0x3f405
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88803f405500 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2cc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5811, tgid 5810 (syz.0.15), ts 121385960669, free_ts 121037718009
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
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
page last free pid 5804 tgid 5804 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1936
 __mmput+0x115/0x390 kernel/fork.c:1348
 exec_mmap+0x680/0x710 fs/exec.c:1014
 begin_new_exec+0x12c0/0x2050 fs/exec.c:1280
 load_elf_binary+0x966/0x2710 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952
 do_execve fs/exec.c:2026 [inline]
 __do_sys_execve fs/exec.c:2102 [inline]
 __se_sys_execve fs/exec.c:2097 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2097
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90001105f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001105f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90001106000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc90001106080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001106100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         adc21867 Linux 6.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15488ac0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162ecbf7980000


