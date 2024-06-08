Return-Path: <linux-kernel+bounces-207190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6597690137B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F5B215C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4444421345;
	Sat,  8 Jun 2024 21:09:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D2FC19
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717880969; cv=none; b=us/bWz8E6rvUAGsC8hmbsk4mRRioM8dhvP5W9Pc64jpU/xG6DTbp9SUrIXkIm8NUQvPekgR4pR939vBNRs1qzrF9kMM/uE/+EmUz1i7dASJPhXXcgpPVbg5dyKpoz7z5sPK0OAmwfe+uPoRfkQ+ruFPtyiywV77vJqIbGGtKEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717880969; c=relaxed/simple;
	bh=fx2cUn1aGGTl72TzVzQp1Te/OpJg4rXmMYSOls+0/BE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ofmOvg44G7n9JFniPbxW3seuegSoO9gl3MbQQJcJgmxDak6Z7VrbNZScYxSYXRw8s2XO1S6jQvRFaUxnqltdIkm2q3PWdJ1uKcSyrUHAMKtHmY6nmEEx3Z1wycSKOJZvT5HdfFT3ICP93+VGyYpzlppfd49/S336S9VErkiRhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb4e561314so370540039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 14:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717880967; x=1718485767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/a1GMGacPVXDdBIoJvowPyN1smkbn3A/XJO66RgH2g=;
        b=AQiRfVWKrSnVdBFEW2bzCDRaf7dU0HqDT2a73gDfxdNk8DmTapPP4RoKn3S/oV/SKz
         NAzIRs0WSPaX0ENXogW3CMIDYeqx2T3xSvZg9cgkxb+MiXHAbuRJ1NZIJWwINdTkKVLN
         +USFNb0beu5IZxmWjTipFJa2SxCy5kbedEoShLIKhcwv2sYk7JGIQlglKZlauAUPkOc9
         jyr3f3bbv+i6QWuVQ1epSuCItZBc77pjsIZxaBnzN+9cpUqZv9fK0s/WZcBtS19irfNq
         hBjIC6i9vRV86sNRkcOd0Yxc3F7wwLB78jabGMBceBjF7tYyC4lCjKuaOHwSmM586PCn
         yVcg==
X-Forwarded-Encrypted: i=1; AJvYcCXJyAxD6bh9tVJoXkKydWO/hSJ/osO67jSUXSiOL9R9vGyXJWOp83RM9IjCBZyS7y6d9N9EtN7vYqrRIWeDWFS73eKKIHyRMfmOYcIH
X-Gm-Message-State: AOJu0YzuhE1ht6X6/B5tvuPLjhLrH7L5XaFu1g87D3glPPbdDfkQ//YA
	ZDW6Iq5RoMcfIkjj7lrkJ9QuqwH8gBUatABz2c9/sxAaUru6ZPCsmV4Upu6SMII54eWfMSH461n
	siLbuMr4QsTGog+yHn+8rsGxNb+Hxt4eUNUDBJL8CocK3eeDFRBIpMtY=
X-Google-Smtp-Source: AGHT+IHkVLOC4GAFi09SRk6jmIudmyxj7G9za864sinCt8GMUPwNOVAjWB+Tjr9irnQFcOMwb1LGznGPPW1MLVqhjXOca30gJ0mb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-375803a726cmr5106655ab.4.1717880967192; Sat, 08 Jun 2024
 14:09:27 -0700 (PDT)
Date: Sat, 08 Jun 2024 14:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0f165061a6754c3@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in zswap_store
From: syzbot <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113f3fd6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1fe13fcb51574b249b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in zswap_is_page_same_filled mm/zswap.c:1481 [inline]
BUG: KMSAN: uninit-value in zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
 zswap_is_page_same_filled mm/zswap.c:1481 [inline]
 zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
 swap_writepage+0x126/0x4c0 mm/page_io.c:198
 shmem_writepage+0x1826/0x1f70 mm/shmem.c:1518
 pageout mm/vmscan.c:660 [inline]
 shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
 evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
 try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
 shrink_one+0x66f/0xd40 mm/vmscan.c:4772
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat mm/vmscan.c:6895 [inline]
 kswapd+0x1eba/0x4460 mm/vmscan.c:7164
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
 generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
 shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:2920
 do_iter_readv_writev+0x7e6/0x960
 vfs_iter_write+0x459/0xd00 fs/read_write.c:895
 lo_write_bvec drivers/block/loop.c:246 [inline]
 lo_write_simple drivers/block/loop.c:267 [inline]
 do_req_filebacked drivers/block/loop.c:491 [inline]
 loop_handle_cmd drivers/block/loop.c:1907 [inline]
 loop_process_work+0x1502/0x3440 drivers/block/loop.c:1942
 loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1973
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages mm/mempolicy.c:2335 [inline]
 folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
 filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
 __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
 grow_dev_folio fs/buffer.c:1042 [inline]
 grow_buffers fs/buffer.c:1108 [inline]
 __getblk_slow fs/buffer.c:1134 [inline]
 bdev_getblk+0x39b/0xc80 fs/buffer.c:1429
 __getblk include/linux/buffer_head.h:355 [inline]
 sb_getblk include/linux/buffer_head.h:361 [inline]
 ext4_getblk+0x3da/0xe00 fs/ext4/inode.c:843
 ext4_xattr_inode_write fs/ext4/xattr.c:1421 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1596 [inline]
 ext4_xattr_set_entry+0x574d/0x6880 fs/ext4/xattr.c:1718
 ext4_xattr_block_set+0xb94/0x4fb0 fs/ext4/xattr.c:2037
 ext4_xattr_move_to_block fs/ext4/xattr.c:2654 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2729 [inline]
 ext4_expand_extra_isize_ea+0x20bd/0x3560 fs/ext4/xattr.c:2821
 __ext4_expand_extra_isize+0x5dc/0x680 fs/ext4/inode.c:5789
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
 __ext4_mark_inode_dirty+0x70d/0xa10 fs/ext4/inode.c:5910
 ext4_delete_inline_entry+0x650/0x7d0 fs/ext4/inline.c:1753
 ext4_delete_entry+0x13f/0x7d0 fs/ext4/namei.c:2719
 __ext4_unlink+0x9b8/0x11b0 fs/ext4/namei.c:3273
 ext4_unlink+0x226/0x630 fs/ext4/namei.c:3321
 vfs_unlink+0x676/0xa30 fs/namei.c:4343
 do_unlinkat+0x823/0xe10 fs/namei.c:4407
 __do_sys_unlinkat fs/namei.c:4450 [inline]
 __se_sys_unlinkat fs/namei.c:4443 [inline]
 __x64_sys_unlinkat+0x17c/0x230 fs/namei.c:4443
 x64_sys_call+0x846/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 88 Comm: kswapd1 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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

