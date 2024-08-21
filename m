Return-Path: <linux-kernel+bounces-295069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CD959648
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A605AB20C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018F188A3E;
	Wed, 21 Aug 2024 07:43:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AF1B81CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226204; cv=none; b=gZ8YwyPR8TRffBQoyEX55tfrYTDsCGYTqZlN1sCGZi67tqdxBY7VPkeG58ErFNBYN8mfszgKcsQs39NaDn8UgL9QIbde1sC+CXott82UGe7dAH8RwMJniI4EFtTU+db7T39cAXQb6zNyKDpRdhgLW9Xyn07CIM6f0ejDnCbJXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226204; c=relaxed/simple;
	bh=JzaePTA/tlvrizEitO5y/Idwr0RDdfR9f1qPkpQ/xrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S+cZryRktLVlT5ofEsFWc04UYFEQaT26wtZgdKcBAv5Bo/hHIshCGMsh4/KVaCaCwcc5t/hRAIWdr9cM7dOj1Im0tdh7IIn+R/dLUI6ZXjUe9+W7ebSrZbjs+ytevNoObyXBC/g3SHl4qjdFSrrkb91NiQieQzEeTUlhoTZS5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d470803edso42930455ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724226201; x=1724831001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cZiwRe09hRYFUZZAhx5xPyOEst5/A+5yWmvX/xi9TA=;
        b=T/crDjIfMiJMT+1MDz+avYOACkni33TMMZUqClmZC1X0PC9YirbfTKptSxk59nmI1k
         HsjKw2xk2YN/5FrgfPXqgp0VMD/ohlCKC0FLy19+qZGscDDF3sn2LvfyMw/EXSkqjwbc
         ai/8iE0HPsKU53rByBMQ8gbFalQLHm010738VjETHr3oN5r4O+6EWbshjo0W4Tkeal4w
         X1XKUw8JdKCOZCqXvVfufo7vL7eW6V9nzj6J3NU4QuR5XecyFigc76uZbNyJWBqzmB/6
         C2rXIOaX5dENoV4BsXW5itRK7FYq9ao6rS+idatR6PxYIenZ7TJjeEka1AmtjAPCZ5BM
         Ks2g==
X-Forwarded-Encrypted: i=1; AJvYcCWOQ0m/8izHxujVoSqmn+angqGkCIVoaWhIZn2oSBdEacV988uhjCatJ7n22I7kyYH+LlutbaY66rNmNmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUEygZkKJfL7xroxQVwDCHh3gvTSVrT3J9LOzJOiVInYe4Awo
	5CfhOt3UlY0VOqqOa51lLC1B2sRo2v5zkiDjBxlZTHH4tH6JqqhFsCHyyRIyt4wtjSDNop0UkFE
	17P5E+r5WRl4SxnZGgT+URwau8E6yhQwLKiv2krsmOVEAhnsPeZgkGRY=
X-Google-Smtp-Source: AGHT+IHv++quIVVjc6zGOLENIdVbh2tusRP5N60PsE6LUjPXifHuUqgbdfCLzl8+Bqp2CY+JMcXEVMIzG2aQt8TKT+R+KHy3UDUJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26f:0:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39d6c2bd24emr1190665ab.0.1724226201338; Wed, 21 Aug 2024
 00:43:21 -0700 (PDT)
Date: Wed, 21 Aug 2024 00:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e572006202cb2ce@google.com>
Subject: [syzbot] [udf?] KASAN: use-after-free Read in udf_update_tag
From: syzbot <syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c43d43bad35 Merge branches 'for-next/acpi', 'for-next/mis..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12558bf3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c91f83ae59feaa1f
dashboard link: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc2dd4be620e/disk-5c43d43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81d40d99ddbf/vmlinux-5c43d43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc6aed0f2bc5/Image-5c43d43b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crc_itu_t+0xc4/0x108 lib/crc-itu-t.c:60
Read of size 1 at addr ffff0000fbdb0000 by task syz.0.397/8678

CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Not tainted 6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 crc_itu_t+0xc4/0x108 lib/crc-itu-t.c:60
 udf_update_tag+0x74/0x54c fs/udf/misc.c:261
 udf_write_aext+0x37c/0x668 fs/udf/inode.c:2146
 udf_update_extents fs/udf/inode.c:1200 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x30ec/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x4d9 pfn:0x13bdb0
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xbfffffff(buddy)
raw: 05ffc00000000000 fffffdffc3e9b008 fffffdffc37da408 0000000000000000
raw: 00000000000004d9 0000000000000004 00000000bfffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000fbdaff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000fbdaff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000fbdb0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff0000fbdb0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000fbdb0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B              6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000010 x25: 0000000000000200 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff8000809c68b0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000200 x0 : 0000000000000010
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000020 x25: 0000000000000210 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff8000809c68b0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000210 x0 : 0000000000000020
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000030 x25: 0000000000000220 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000220 x0 : 0000000000000030
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000040 x25: 0000000000000230 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000230 x0 : 0000000000000040
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000050 x25: 0000000000000240 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000240 x0 : 0000000000000050
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000060 x25: 0000000000000250 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000250 x0 : 0000000000000060
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000070 x25: 0000000000000260 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002
 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000
 x7 : 0000000000000000
 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000260 x0 : 0000000000000070
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000080 x25: 0000000000000270 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000270 x0 : 0000000000000080
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8678 at fs/udf/inode.c:2047 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
Modules linked in:
CPU: 0 UID: 0 PID: 8678 Comm: syz.0.397 Tainted: G    B   W          6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
lr : __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
sp : ffff800098c56d80
x29: ffff800098c56da0 x28: 1ffff0001318ae16 x27: dfff800000000000
x26: 0000000000000090 x25: 0000000000000280 x24: ffff800098c570b8
x23: ffff800098c56ff0 x22: 0000000000000040 x21: 1ffff0001318ae17
x20: ffff800098c570b0 x19: ffff0000db608e18 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800083014574 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000001 x12: ffff0000daa50000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff800099be8000
x8 : 0000000000040000 x7 : 0000000000000000 x6 : ffff0000dd053488
x5 : ffff800098c570c8 x4 : 0000000000000001 x3 : 0000000000000040
x2 : ffff800098c56ff0 x1 : 0000000000000280 x0 : 0000000000000090
Call trace:
 __udf_add_aext+0x488/0x614 fs/udf/inode.c:2046
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_insert_aext fs/udf/inode.c:2266 [inline]
 udf_update_extents fs/udf/inode.c:1182 [inline]
 inode_getblk fs/udf/inode.c:897 [inline]
 udf_map_block+0x2e4c/0x3efc fs/udf/inode.c:443
 __udf_get_block+0xf8/0x39c fs/udf/inode.c:457
 udf_get_block+0x84/0xb8 fs/udf/inode.c:481
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2235
 udf_write_begin+0xf8/0x218 fs/udf/inode.c:256
 generic_perform_write+0x2e8/0x8e0 mm/filemap.c:4019
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4121
 udf_file_write_iter+0x25c/0x568 fs/udf/file.c:111
 do_iter_readv_writev+0x4a4/0x6ec
 vfs_writev+0x410/0xb80 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 42591
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (42591): [<ffff8000802b5d48>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (42590): [<ffff80008b3cafa4>] __schedule+0x2b4/0x2418 kernel/sched/core.c:6416
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (40096): [<ffff8000801f6dfc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (40063): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2048, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2048, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2048, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2048, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2048, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2048, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2048, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2048, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2048, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2048, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2049, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2049, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2049, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2049, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2049, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2049, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2049, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2049, lost async page write
syz.0.397: attempt to access beyond end of device
loop0: rw=2049, sector=2049, nr_sectors = 1 limit=2048
Buffer I/O error on dev loop0, logical block 2049, lost async page write


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

