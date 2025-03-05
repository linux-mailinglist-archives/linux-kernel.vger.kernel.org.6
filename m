Return-Path: <linux-kernel+bounces-546115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8574A4F692
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662297A3311
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244C1A4F09;
	Wed,  5 Mar 2025 05:33:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2B2E336D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152816; cv=none; b=NNfH+vATLLGBfoQn1aSB3BG+oDDft/3fB09caMYR5t5lmrmA93kJ7u5w7xGpjPAiJkojailOx2WR2QLzzHMMEU9oDC4Hu860skuyZ6aGM5zigplTycDiNP/J8W6nJHsM6sUvxJgdcL9jKGTLDmXB1Bd0Oti3Q1d8Yi+c2b0NPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152816; c=relaxed/simple;
	bh=qPXLju+ES20fv8QEyKOXOQHUHZXaEG1WktBbUwbcwBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZzVo/EF3eeAh9P3SEfrkYcN/4Nl0sVHiYZsao3kjFKMl7yZ7nVs3tRWI0SVkcCHSVtXgCfdvwaRjFJGEzyjvfY3/2twfylXImtahsxHkkzAGiHD880Gl2lHH3SRBmjtejSAdd4d96JDUOTbt4aZ9W7+dC4ADmNshf2xCM6nzF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso4748965ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 21:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741152814; x=1741757614;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwEEWkbSEviAgP2e5fjHcYSK43txVLqIFwFg1VJiSz0=;
        b=KKhJ7+prRzhE73Pl1kWKD4IZpfo7PYIns54m2+z0rROHRn51KeOjZ3ToUoViRHUz0Z
         0zjNJMswpnZDZRwBAGNrgSN3PHWA//JlXsWn8pNwO+xxWBHutJaFy5jr9EGpV++EQUfE
         xC/haHFRIEFQ0Ri7xhXEYuhLNbx85xNOlfs6SZUOKneA4DKIeUla5AGcxnr2NfAQhhpy
         2EZBQkGRjdtcW3xqJiMt9tcxFbszwLiU8iYwP/nfaso0sn0dAG3uSKWjYjg+MRoyEVFb
         whLX6/xhSMK5UlTeLFABZqilKQ6NOhe9gI8XleOX4eASX6XdX3PJ84ELH6LLo/FOqkY3
         ri3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1zBG8QtKKJH+y9ShaqcDvinAWBLYPQs2eBgxn8ZgNLmxB/hzGWLyrc4QzMmLZpmTzI7V0yG1uVgnMdAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2t2s2XPmjaPDezN6ubWI5g3iXwpUErup+AAv0qkWtRPjMSFW
	McBAJggD8pWc1a3yigg/DpnG5w6iD2MQBvXyBNoOWG3BU26UvR9W2M/HHB6kSfYmO+7AazoFsP/
	5vnaFp0NWYlamRNB4FxIkTu1gpBwRnNHz63/y+1iCFTIbjXqR7oy/HOM=
X-Google-Smtp-Source: AGHT+IFlGRY6qc1eaIs1btuJpYp8SGDIzCRsKiKJRbSX7KnT1bdmQJinXV+BGTl0/45vta2dePIiMtjKFIZfEs3+BAF2DO9kDZHg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a09:b0:3d3:d344:2a1a with SMTP id
 e9e14a558f8ab-3d42b7cd85emr22833875ab.0.1741152813963; Tue, 04 Mar 2025
 21:33:33 -0800 (PST)
Date: Tue, 04 Mar 2025 21:33:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c7e22d.050a0220.38b91b.024e.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in depot_fetch_stack
From: syzbot <syzbot+20024c0fe2bf6dbc8c1e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    276f98efb64a Merge tag 'block-6.14-20250228' of git://git..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17a6c864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5b4c41bdaeea196=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D20024c0fe2bf6dbc8=
c1e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-276f98ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a036150d62e/vmlinux-=
276f98ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0b6c8e5972f/bzI=
mage-276f98ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+20024c0fe2bf6dbc8c1e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=3Dmetadata_che=
cksum=3Dnone,data_checksum=3Dnone,compression=3Dlz4,erasure_code,fsck,norec=
overy,nojournal_transaction_names,reconstruct_alloc,nocow,no_data_io
bcachefs (loop0): recovering from clean shutdown, journal seq 10
bcachefs (loop0): Version upgrade required:
Version upgrade from 0.24: unwritten_extents to 1.7: mi_btree_bitmap incomp=
lete
Doing incompatible version upgrade from 0.24: unwritten_extents to 1.20: di=
rectory_size
  running recovery passes: check_allocations,check_alloc_info,check_lrus,ch=
eck_btree_backpointers,check_backpointers_to_extents,check_extents_to_backp=
ointers,check_alloc_to_lru_refs,bucket_gens_init,check_snapshot_trees,check=
_snapshots,check_subvols,check_subvol_children,delete_dead_snapshots,check_=
inodes,check_extents,check_indirect_extents,check_dirents,check_xattrs,chec=
k_root,check_unreachable_inodes,check_subvolume_structure,check_directory_s=
tructure,check_nlinks,set_fs_needs_rebalance
bcachefs (loop0): dropping and reconstructing all alloc info
bcachefs (loop0): error validating btree node on loop0 at btree xattrs leve=
l 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 2285c34bed0abe32 writ=
ten 16 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0 =20
  node offset 0/16 bset u64s 60928: bset past end of btree node (offset 0 l=
en 960 but written 16), exiting
bcachefs (loop0): Unable to continue, halting
bcachefs (loop0): flagging btree xattrs lost data
bcachefs (loop0): running explicit recovery pass check_topology (2), curren=
tly at recovery_pass_empty (0)
bcachefs (loop0): running explicit recovery pass scan_for_btree_nodes (1), =
currently at recovery_pass_empty (0)
error reading btree root btree=3Dxattrs level=3D0: btree_node_read_error, f=
ixing
invalid bkey in btree_node btree=3Dsubvolumes level=3D0: u64s 7 type subvol=
ume 0:1:0 len 0 ver 0: root 4096 snapshot id 0
  invalid snapshot: delete?, fixing
bcachefs (loop0): scan_for_btree_nodes...
bcachefs (loop0): btree node scan found 7 nodes after overwrites
 done
bcachefs (loop0): check_topology...
bcachefs (loop0): btree root xattrs unreadable, must recover from scan
bcachefs (loop0): bch2_get_scanned_nodes(): recovery btree=3Dxattrs level=
=3D0 POS_MIN - SPOS_MAX
bcachefs (loop0): bch2_get_scanned_nodes(): recovering u64s 11 type btree_p=
tr_v2 SPOS_MAX len 0 ver 0: seq 2285c34bed0abe32 written 960 min_key POS_MI=
N durability: 1 ptr: 0:31:0 gen 0
empty interior btree node at btree=3Dxattrs level=3D1
u64s 5 type btree_ptr SPOS_MAX len 0 ver 0, fixing
bcachefs (loop0): empty btree root xattrs
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5318 at lib/stackdepot.c:461 depot_fetch_stack+0x9c/0x=
c0 lib/stackdepot.c:461
Modules linked in:
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.14.0-rc4-syzkaller-0021=
2-g276f98efb64a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
RIP: 0010:depot_fetch_stack+0x9c/0xc0 lib/stackdepot.c:461
Code: 48 c7 c7 de fa 3a 8e 89 ee 44 89 f2 89 d9 e8 ab eb 53 fc 90 0f 0b 90 =
90 31 c0 5b 41 5e 5d c3 cc cc cc cc 90 0f 0b 90 eb ef 90 <0f> 0b 90 eb e9 4=
8 c7 c7 30 af 2b 8f 4c 89 f6 e8 50 67 00 00 eb 94
RSP: 0018:ffffc900019a71e0 EFLAGS: 00010246
RAX: ffff888044008000 RBX: 00000000000036b0 RCX: 0000000000100000
RDX: ffffc9000e64a000 RSI: ffffffff8c2ab700 RDI: ffffffff8c80f060
RBP: 000000000000025f R08: ffffffff82329a83 R09: 1ffffffff2079dee
R10: dffffc0000000000 R11: fffffbfff2079def R12: 0000000000000001
R13: dffffc0000000000 R14: 000000000000025f R15: 0000000006d60260
FS:  00007f3e5c1916c0(0000) GS:ffff88801fc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555f8aa8e098 CR3: 000000003843c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dec_stack_record_count mm/page_owner.c:222 [inline]
 __reset_page_owner+0x320/0x430 mm/page_owner.c:310
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2684 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3153
 put_cpu_partial+0x17c/0x250 mm/slub.c:3228
 __slab_free+0x290/0x380 mm/slub.c:4479
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_node_noprof+0x23c/0x4d0 mm/slub.c:4300
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:662
 __bch2_darray_resize_noprof+0xd2/0x290 fs/bcachefs/darray.c:24
 bch2_write_super+0x48a/0x3cd0 fs/bcachefs/super-io.c:997
 __bch2_check_set_feature+0xe6/0x150 fs/bcachefs/super-io.c:1180
 bch2_check_set_feature fs/bcachefs/super-io.h:106 [inline]
 bch2_opt_check_may_set fs/bcachefs/opts.c:489 [inline]
 bch2_opts_check_may_set+0xf2/0x150 fs/bcachefs/opts.c:502
 bch2_fs_start+0x3be/0x610 fs/bcachefs/super.c:1048
 bch2_fs_get_tree+0xdb7/0x17a0 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e5b38e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e5c190e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f3e5c190ef0 RCX: 00007f3e5b38e90a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007f3e5c190eb0
RBP: 00004000000058c0 R08: 00007f3e5c190ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007f3e5c190eb0 R14: 0000000000005912 R15: 00004000000001c0
 </TASK>


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

