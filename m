Return-Path: <linux-kernel+bounces-330011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A730F97986A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A121F21C42
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E241C9EC3;
	Sun, 15 Sep 2024 19:21:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32E1F943
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726428082; cv=none; b=F5X/AZfrlWl+K1gVSimbHW9u2jXztpHZUXZCTezvr/3PaZUsGvaMjKZpNcHbpQF2PDA600ry1lAsfkSupc+IZDtT33H3o91iNP0KhWc/Gp8T9ZReObuG6olFAm/dVIV6wndK9qm2IckliolQj5aBLWC1cc26ZvGgbndEkpQcLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726428082; c=relaxed/simple;
	bh=oC4GPx8HfAP1M6GguJXNAUrEKggzXFRJOnkuEcBom+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XGP4xUuhslgTcsfYj3sQv2ewmpojjGyGZJTEGDzmlNPIx9/JLnaiOmjsQEBzE0vd0VkZXjT5lgxmZHYCfTv/4KRjpZNx2tpbcXz4iTbWF1LJriIhA4FDD14r6AXcF+z3z6QRU0DsGIzff7bjIM8K5h4J096Hf/BzR/uM/W2keLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so78288725ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726428080; x=1727032880;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQJVhROZf4larSYxvTqQu+IgUPdd+YVsrfrx2cXDFvU=;
        b=Je74pnIoaY1S2T6ogP4AEgBw5EMyP5ZDuVX7WKfBwQjj5ZF7O2a1XOohhYtpLZEIdg
         eAb2zkxEvJV9CiM3UwpElt5S0Jq+/YZcfbx/nV9FJp2cjPRNu6f3bAprPDs0R/9w/D31
         Mr+3no9qikLLkjK01dH9m83C/ko7PsyXnoAOOVOC+g2NSUDNu2RMtp7Doc0Fjs8/4Ur/
         LdCZVEyRnpvI5NLH4Nsy0w39NrdgxE9bGb5VJgzoPpvCzfaeQEW7VPzGCdwoQWv0eKSI
         bzU0zHy18usY8cJyY2PTAOqcQAThU34D53jPyx5fHMZj/IuWDil2TmsuJoINKo4fPC+p
         C/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzCk3ptDCpgpRT7yk8htGlZOJBiXA4o2kBUNBFZip3ZS4zNe1qOvPrrSl02yoKIQGZV4VTeeln62A8C44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaTkXmVZNlMwiufjUrclmRBfhCjjOkglmfPp09Qatg2CXwNVL
	HuLTseQXWLh3DWZ30Ai+Oae4FjBZUc/KE6OSCb5TFU7Evi+BCf1nxwnBa2ORP3LjFu8YTWI3L/y
	MPrcMtdIOm0UCg7+5KVWCyDlRmHKVtK2yyigYl4geE0gBdcNOkAFDhQw=
X-Google-Smtp-Source: AGHT+IF4DSwUnDi69YO62vQXUCo1h9RpjtloWnw06NihQN3+EI9kDFNhZm3LZJqYpHz/bJ7XVekgPL3FfaJWTTqUfroHgvqb68jM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c568:0:b0:3a0:90c7:f0f with SMTP id
 e9e14a558f8ab-3a090c7122fmr67339645ab.15.1726428080101; Sun, 15 Sep 2024
 12:21:20 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:21:20 -0700
In-Reply-To: <0000000000003e572006202cb2ce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071e9fb06222d5c17@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_update_tag
From: syzbot <syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12725407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11725407980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161797c7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27fdaed14a4f/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f65db4a0147a/bzImage-d42f7708.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/35d929f5e424/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5c402e34d952/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff88804575c000 by task syz-executor293/5222

CPU: 0 UID: 0 PID: 5222 Comm: syz-executor293 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
 udf_update_tag+0x70/0x6a0 fs/udf/misc.c:261
 udf_write_aext+0x4d8/0x7b0 fs/udf/inode.c:2146
 extent_trunc+0x2f7/0x4a0 fs/udf/truncate.c:46
 udf_truncate_extents+0x627/0x12d0 fs/udf/truncate.c:251
 udf_setsize+0xe85/0x1280 fs/udf/inode.c:1289
 udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3381 [inline]
 do_open fs/namei.c:3731 [inline]
 path_openat+0x2ced/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_creat fs/open.c:1507 [inline]
 __se_sys_creat fs/open.c:1501 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1501
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f27b96eed79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27b965d218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f27b9777728 RCX: 00007f27b96eed79
RDX: 00007f27b96c7596 RSI: 0000000000000004 RDI: 0000000020000240
RBP: 00007f27b9777720 R08: 00007ffdf39855a7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f27b9743964
R13: 0031656c69662f2e R14: 00007f27b9742068 R15: 6f6f6c2f7665642f
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1a pfn:0x4575c
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea000115d748 ffffea00011567c8 0000000000000000
raw: 000000000000001a 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5220, tgid 5219 (syz-executor293), ts 100640669004, free_ts 100713641467
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 alloc_pages_noprof mm/mempolicy.c:2343 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2350
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1008
 __filemap_get_folio+0x44e/0xc10 mm/filemap.c:1950
 grow_dev_folio fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1113 [inline]
 __getblk_slow fs/buffer.c:1139 [inline]
 bdev_getblk+0x1d8/0x550 fs/buffer.c:1441
 __bread_gfp+0x86/0x400 fs/buffer.c:1495
 sb_bread include/linux/buffer_head.h:347 [inline]
 udf_read_tagged+0xa6/0xe00 fs/udf/misc.c:199
 udf_read_inode fs/udf/inode.c:1352 [inline]
 __udf_iget+0x408/0x3e60 fs/udf/inode.c:1939
 udf_iget fs/udf/udfdecl.h:152 [inline]
 udf_lookup+0x1e9/0x2b0 fs/udf/namei.c:127
 lookup_open fs/namei.c:3556 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x11cc/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_open fs/open.c:1439 [inline]
 __se_sys_open fs/open.c:1435 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1435
page last free pid 5221 tgid 5219 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2667
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 folio_batch_release include/linux/pagevec.h:101 [inline]
 mapping_try_invalidate+0x3b1/0x4f0 mm/truncate.c:515
 loop_set_status+0x1ab/0x900 drivers/block/loop.c:1264
 lo_ioctl+0xcc2/0x1f60
 blkdev_ioctl+0x580/0x6b0 block/ioctl.c:676
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804575bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88804575bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88804575c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88804575c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804575c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

