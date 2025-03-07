Return-Path: <linux-kernel+bounces-550662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC6A56290
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E39F1769F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D61C32EA;
	Fri,  7 Mar 2025 08:29:13 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E71A314C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336151; cv=none; b=K7FldnTfIIsuRwQz+zBjaDiUEze5fbelG5Cchm0sjskACwKWAeW2Jdg4XzWn+Od02GAP+lOwm/AY09LFtnvsPAzn8/fmSWdHONbLJ5S0nas0iLmCu235Bi5qHdDKIaoVJzVzzc8PBEeEMBxa9eNT3/nQY0ioDQagMPz7tgWQHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336151; c=relaxed/simple;
	bh=y8fDLVeF1yrcYpSXHim6kDVgsZ6iSyH1cdzlUfV1Zuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OK2cTRl3h6n+oWBnI7Z4KQkOLy/ziC4YVxVCBO14qxmTzg3Uhgx1D1nLWiAqejP7ehM6yoADe5WS1O2kjSnAYIlaEmCQu/Gihz14Vj1kZm8afXdJLRiBQKQjvI+LwKI+C27k554747ZtGWx7PQ9H06sQI/jgME0oHV/hI+EBoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43b460962so25851385ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336146; x=1741940946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXWv9yZ6HvRPxBIDeDLY/VNdiT0TlX7+syMLsxLYqnc=;
        b=BW98Mal6LIzYpncoUNClCN/shHbT0DesdVx86QG2V9GFKbua5e1hYc3QaBQrbatih4
         saAYZGaHDfrvNoJ86Kkm3FOnNFxKuQkIE9OwrGXzvK82a0qwWE1s/Q2zw1ZabacbzPu5
         P+ftYwx6c+QQ7pHYDeqlz9DWFUQgtx4iufcKs9I20j7FZAA9jLKsyu8485fom9ccxNQN
         BhAJLYUjnFjbWErQqrFDnneSY6m97GBojz+ztXozvESg1bJNqYsMWHP0Z3wj7CwoHvHA
         q+ckPARGogkOr+yInq7WcHaqUc7A/mWFKJBIwT+aWg/GccUQhMZX7/S02brGP4AAwyIL
         WI6A==
X-Gm-Message-State: AOJu0Yy1+GnH/rj0PtzEArnZCSaQZPx3AVR8qM/i7bHberbWKw5ztPri
	uJwacE4TVxoq+8Tf7ZVQp7Dn0aZfTxTHBeus+S+cSuz/VN+RKR6vLDTXQBr1jo8L+up5vNpxwC/
	l5FzozzP5xeSoVmm+oJ1xY37H65gcsB+s0VGKnVWtmE40MRSiIhepL/Gqkw==
X-Google-Smtp-Source: AGHT+IEWkvahjFn/MWVKE1jubbmPgwL9WBlgK32yfX8BxpkmyQdC9VKJhGtLzLbpV71rpNC1H0XPeKDwGLw3fmJzXs/NDGDygy8W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d44196ff85mr34300185ab.12.1741336145958; Fri, 07 Mar 2025
 00:29:05 -0800 (PST)
Date: Fri, 07 Mar 2025 00:29:05 -0800
In-Reply-To: <67c5c1f8.050a0220.55417.06f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67caae51.050a0220.15b4b9.0079.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read
 in validate_bset_keys
From: syzbot <syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in validate_bset_keys
Author: mmpgouride@gmail.com

On Mar 3, 2025, at 22:51, syzbot <syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com> wrote:
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-next/p..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=16fa9864580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
> dashboard link: https://syzkaller.appspot.com/bug?extid=3cb3d9e8c3f197754825
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1614e8b7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fa9864580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/54f57836a7d4/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com
> 
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2097 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __memcpy_u64s fs/bcachefs/util.h:434 [inline]
> BUG: KASAN: slab-out-of-bounds in __memmove_u64s_down fs/bcachefs/util.h:450 [inline]
> BUG: KASAN: slab-out-of-bounds in memmove_u64s_down fs/bcachefs/util.h:458 [inline]
> BUG: KASAN: slab-out-of-bounds in validate_bset_keys+0xa08/0x16e8 fs/bcachefs/btree_io.c:999
> Read of size 8 at addr ffff0000de6100a8 by task kworker/1:1H/57
> 
> CPU: 1 UID: 0 PID: 57 Comm: kworker/1:1H Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> Workqueue: bcachefs_btree_read_complete btree_node_read_work
> Call trace:
> show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
> print_address_description mm/kasan/report.c:408 [inline]
> print_report+0x198/0x550 mm/kasan/report.c:521
> kasan_report+0xd8/0x138 mm/kasan/report.c:634
> __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
> __memcpy_u64s fs/bcachefs/util.h:434 [inline]
> __memmove_u64s_down fs/bcachefs/util.h:450 [inline]
> memmove_u64s_down fs/bcachefs/util.h:458 [inline]
> validate_bset_keys+0xa08/0x16e8 fs/bcachefs/btree_io.c:999
> bch2_btree_node_read_done+0x19f4/0x4acc fs/bcachefs/btree_io.c:1164
> btree_node_read_work+0x534/0xf20 fs/bcachefs/btree_io.c:1358
> process_one_work+0x810/0x1638 kernel/workqueue.c:3236
> process_scheduled_works kernel/workqueue.c:3317 [inline]
> worker_thread+0x97c/0xeec kernel/workqueue.c:3398
> kthread+0x65c/0x7b0 kernel/kthread.c:464
> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> 
> Allocated by task 6439:
> kasan_save_stack mm/kasan/common.c:47 [inline]
> kasan_save_track+0x40/0x78 mm/kasan/common.c:68
> kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
> unpoison_slab_object mm/kasan/common.c:319 [inline]
> __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:345
> kasan_slab_alloc include/linux/kasan.h:250 [inline]
> slab_post_alloc_hook mm/slub.c:4115 [inline]
> slab_alloc_node mm/slub.c:4164 [inline]
> kmem_cache_alloc_noprof+0x254/0x410 mm/slub.c:4171
> alloc_buffer_head+0x38/0x320 fs/buffer.c:3015
> folio_alloc_buffers+0x40c/0x974 fs/buffer.c:924
> create_empty_buffers+0x4c/0x54c fs/buffer.c:1662
> ext4_block_write_begin+0x21c/0xf24 fs/ext4/inode.c:1046
> ext4_da_write_begin+0x4e8/0x98c fs/ext4/inode.c:2946
> generic_perform_write+0x29c/0x868 mm/filemap.c:4189
> ext4_buffered_write_iter+0x2c0/0x52c fs/ext4/file.c:299
> ext4_file_write_iter+0x1ac/0x197c fs/ext4/file.c:717
> new_sync_write fs/read_write.c:586 [inline]
> vfs_write+0x704/0xa9c fs/read_write.c:679
> ksys_write+0x15c/0x26c fs/read_write.c:731
> __do_sys_write fs/read_write.c:742 [inline]
> __se_sys_write fs/read_write.c:739 [inline]
> __arm64_sys_write+0x7c/0x90 fs/read_write.c:739
> __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
> el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
> el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
> el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> 
> The buggy address belongs to the object at ffff0000de610000
> which belongs to the cache buffer_head of size 168
> The buggy address is located 0 bytes to the right of
> allocated 168-byte region [ffff0000de610000, ffff0000de6100a8)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11e610
> flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 05ffc00000000000 ffff0000c18aadc0 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000110011 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff0000de60ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff0000de610000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff0000de610080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
>                                  ^
> ffff0000de610100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff0000de610180: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
> ==================================================================
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2095 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2093 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2091 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2089 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2087 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2085 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2083 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2081 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2079 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2077 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2075 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2073 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2071 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2069 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2067 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2065 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2063 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2061 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2059 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2057 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2055 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2053 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2051 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2049 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2047 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2045 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2043 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2041 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2039 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2037 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2035 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2033 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2031 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2029 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2027 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2025 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2023 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2021 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2019 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2017 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2015 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2013 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2011 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2009 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2007 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2005 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2003 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 2001 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1999 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1997 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1995 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1993 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1991 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1989 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1987 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1985 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1983 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1981 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1979 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1977 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1975 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1973 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1971 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1969 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1967 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1965 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1963 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1961 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1959 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1957 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1955 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1953 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1951 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1949 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1947 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1945 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1943 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1941 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1939 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1937 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1935 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1933 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1931 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1929 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1927 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1925 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1923 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1921 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1919 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1917 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1915 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1913 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1911 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1909 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1907 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1905 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1903 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1901 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1899 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1897 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1895 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1893 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1891 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1889 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1887 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1885 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1883 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1881 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1879 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1877 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1875 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1873 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1871 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1869 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1867 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1865 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1863 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1861 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1859 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1857 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1855 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1853 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1851 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1849 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1847 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1845 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1843 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1841 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1839 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1837 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1835 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1833 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1831 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1829 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1827 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1825 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1823 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1821 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1819 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1817 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1815 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1813 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1811 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1809 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1807 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1805 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1803 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1801 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1799 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1797 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1795 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1793 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1791 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1789 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1787 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1785 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1783 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1781 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1779 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1777 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1775 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1773 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1771 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1769 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1767 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1765 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1763 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1761 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1759 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1757 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1755 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1753 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1751 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1749 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1747 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1745 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1743 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1741 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1739 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1737 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1735 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1733 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1731 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1729 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1727 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1725 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1723 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1721 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1719 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1717 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1715 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1713 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1711 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1709 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents level 0/0
>  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 48 min_key 0:36028797018963968:0 durability: 1 ptr: 0:27:0 gen 0  
>  node offset 8/48 bset u64s 1707 bset byte offset 40: bad k->u64s 0 (min 3 max 253), fixing
> bcachefs (loop0): error validating btree node at btree extents leve
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

#syz test

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 80a0094be356..553cfd7ebc21 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -1187,7 +1187,7 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
                             le64_to_cpu(i->journal_seq),
                             b->written, b->written + sectors, ptr_written);
 
-               b->written += sectors;
+               b->written = min(b->written + sectors, btree_sectors(c));
 
                if (blacklisted && !first)
                        continue;
@@ -1195,8 +1195,8 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
                sort_iter_add(iter,
                              vstruct_idx(i, 0),
                              vstruct_last(i));
-
-               max_journal_seq = max(max_journal_seq, le64_to_cpu(i->journal_seq));
+               if (likely(i->u64s))
+                       max_journal_seq = max(max_journal_seq, le64_to_cpu(i->journal_seq));
        }
 
        if (ptr_written) {


