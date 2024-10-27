Return-Path: <linux-kernel+bounces-383470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC499B1C34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 06:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571F01F21BBE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF352BB1B;
	Sun, 27 Oct 2024 05:08:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43E29A1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730005687; cv=none; b=hIA/ntQ5jBrzbc/QQWxZ7tFwbj5ajhZmdBKW9D4pqA5Itr8/mJehxJ6bhJXzdahgrfA2hakM84ecp7punaXrv1wE2WtMQI+RxDmGbtebeY5MQt8Uf1xk99xIUDz0TcXB2RQB2E7SvtmcpkjUsMUnLaOFj/UkSwMzM0NH8vgEVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730005687; c=relaxed/simple;
	bh=d31ifm//n/mWpPhJXB1u0f5W0g0w27hL8eEusfCktyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BdXaUZ3xtwcHh/j6DIJPFMsO96ijsg37UA3A6CCnf1nqAq4eQfEx/el5HUpU8OFnw5+JX71UAk8Orff3qbsfttO9BnoOz/CwaDkWC61BkuJnl3SfoYMDGO75bD5OLr5JZEBu2r3jH3dLc+d0t9uym8ZIMjRI8ft991WmpsboMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso33093545ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730005684; x=1730610484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rKtLXizkuvlqbkf+iG26BEHIsCnFZ28LoHen43kVIs=;
        b=GbM5Zuhn3N8OqJsIKNAICRcEUExBFxjgCi4h6ZmfLRAayKpl1uR0/0axryoxsFAvL5
         CUf5zppY8SndqW9IZ7cf/0dnYrgyXIsMthjuwFQ6lWE8F4Qo52j2qxwfgTW0g1ilufqf
         3IiH9sLO4zJXKbH0HAvEMeltnSQosuKil46RDCds5XQsifqAozwhONdJLA533Svp4maw
         yjx97Kfu84uzdxgY5UPm3pK3bi78DsZLBHmw9ddR1Ie7VD/TrUFiINIy7utpTufDL6YD
         VyCklE6qHKsJQe2r+ZCW78TBs9j30CEIcfLbZOSMfBsT+QBQW8EMMrzCaL2qnDO26Ska
         l88A==
X-Forwarded-Encrypted: i=1; AJvYcCV9+RP+A2MXsFZYx9/GOT6efOjhssAs/kdrUKBnoIXyt3h5EEepI4tTgVWhjpBGIbPk1XYzdN1gW/VCW8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2OO3m6Jh6Ji2MwANyekXLN/YDMGSn/At+GEAPRMSfXr55nH6
	p2PeeCgiSbgqbupYWLjOTkq+4zRGguIS+h9VHrmOuNSMGjsFVuWkSqpt8undwtwSUDNK7FbclWV
	YyBB8+vGAdAC8X0R2w7NyN2ruv07HNJ0UHoWPx52jTUy1LNSsvn4NbK4=
X-Google-Smtp-Source: AGHT+IEBlGweh7WU66bbXZhR4AnRneLml7TB1ZeHXrMuUKf6xg/NPnifTFjEBu/RujMBqzncfMDqmlAIBt/psyIgmLrOqqREwAc8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0f:0:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a4ed306645mr34174215ab.24.1730005683861; Sat, 26 Oct 2024
 22:08:03 -0700 (PDT)
Date: Sat, 26 Oct 2024 22:08:03 -0700
In-Reply-To: <tencent_6858E836EFAACEC478A26E8C2E216DE0950A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671dcab3.050a0220.2b8c0f.01c3.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Write in ext4_insert_dentry

rec length: 684, buf_size: 1024, name length:247, ext4_insert_dentry
rec length: 500, buf_size: 1024, name length:251, ext4_insert_dentry
==================================================================
BUG: KASAN: use-after-free in ext4_insert_dentry+0x3cb/0x790 fs/ext4/namei.c:2110
Write of size 251 at addr ffff888043963f14 by task syz.0.16/5618

CPU: 0 UID: 0 PID: 5618 Comm: syz.0.16 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_insert_dentry+0x3cb/0x790 fs/ext4/namei.c:2110
 add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2155
 make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2352
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2456
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2797
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3432
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
 do_symlinkat+0x222/0x3a0 fs/namei.c:4641
 __do_sys_symlink fs/namei.c:4662 [inline]
 __se_sys_symlink fs/namei.c:4660 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f055e17dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f055ef2c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00007f055e335f80 RCX: 00007f055e17dff9
RDX: 0000000000000000 RSI: 0000000020000cc0 RDI: 0000000020000dc0
RBP: 00007f055e1f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f055e335f80 R15: 00007ffc1e1967c8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:ffff888031d04d78 index:0x3f pfn:0x43963
memcg:ffff88803e45c000
aops:def_blk_aops ino:700000 dentry name(?):""
flags: 0x4fff08000004214(referenced|dirty|workingset|private|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff08000004214 0000000000000000 dead000000000122 ffff888031d04d78
raw: 000000000000003f ffff88804170d9f8 00000003ffffffff ffff88803e45c000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5618, tgid 5617 (syz.0.16), ts 118086176546, free_ts 118012117181
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 grow_dev_folio fs/buffer.c:1043 [inline]
 grow_buffers fs/buffer.c:1109 [inline]
 __getblk_slow fs/buffer.c:1135 [inline]
 bdev_getblk+0x1d8/0x550 fs/buffer.c:1437
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 ext4_getblk+0x303/0x800 fs/ext4/inode.c:859
 ext4_bread+0x2e/0x180 fs/ext4/inode.c:905
 ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
 make_indexed_dir+0x523/0x1600 fs/ext4/namei.c:2273
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2456
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2797
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3432
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
page last free pid 5618 tgid 5617 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 vms_clear_ptes+0x437/0x530 mm/vma.c:1096
 vms_complete_munmap_vmas+0x208/0x910 mm/vma.c:1140
 do_vmi_align_munmap+0x613/0x730 mm/vma.c:1349
 do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1397
 __vm_munmap+0x24c/0x480 mm/mmap.c:1610
 __do_sys_munmap mm/mmap.c:1627 [inline]
 __se_sys_munmap mm/mmap.c:1624 [inline]
 __x64_sys_munmap+0x68/0x80 mm/mmap.c:1624
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888043963f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888043963f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888043964000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888043964080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888043964100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c6c940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14569230580000


