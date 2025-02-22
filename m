Return-Path: <linux-kernel+bounces-526941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BCA40567
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F1F19C5FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E701FF60F;
	Sat, 22 Feb 2025 04:08:28 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748EC7082A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740197308; cv=none; b=EhhDvIq4MBhEEK6QMm70NlKX/DJlMNsgmlBP1jK4Zyh3hJY0S6wLyhPRgpvm13V3pGQSsWjCG0TjQpEdrN7p2Ny7ehf7HZ3DqMEg8QGqTRlZY7h93O/BwvYG+jsiQNs/1S0ZQZbqgJ87W0A110OEcsLWMDxMDEcVqogQ8t++7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740197308; c=relaxed/simple;
	bh=GJhM2N7+R3N2fbaD6O3Dyi9sUgWCnlzrL3/fj+IRc+8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qA8VhcgmIuoF3oAhoL2cMnHnVUdO9wwVhE40fJ2SG+BM7omYJthpFu530BR59nVDMmjiqV1y5u0Byug8nyHWztauhcyV7KVW8fq5HvQaE5iJDNZlxNxDreHrwhEfrE0Q7/6TehPlvT5HXnfW+3kiTCqkvJwsj6csKnq7ZIcIMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b6d933a5so21682245ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740197305; x=1740802105;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D99NrVD47AWBZFuc3B/PLXfdMCaZWQsK8zWZH00Bwc=;
        b=GSHBtQKj+HZ41u5656yj079qlaUXD9GPFt20qnUsc2wso3p4sxKn7oKiHgyPadSJOV
         kYMcf0AvUhU+0gdelSWtbSxn/bG6N1EfC6NOoqnejYIEz3E9RCSEG4KqAW+kTlZRm94f
         ibFFqvH6IO8vQOESo4rSTR6bylyNXw+2M65FerAiplp+Ehj/KBDdKh/tr297rn1bCDXx
         M3mz9LfFvBXdaVNfOFcBJs5J12w+1BaxscpdXuDcl8DJRkDqb85xRdsafCaZ6lNDc9xS
         lERezrFNjPbQFoHXsRTRt6QnGpXWZHhWAFB4VUQHy8j4tole0UH0ErE+GG7POXReQucn
         9AVg==
X-Forwarded-Encrypted: i=1; AJvYcCWlmkz2H5fswHaC8oOgWR5jRPHPQGv5nfcYXLc6U1YKT+Bmw9v6QYj6RirGOthOL5yE/rDc11GamOKsD18=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJ8YgpQ29VtYdmWf1JKULAOlEaStDtB6A/9+WTHp6Mav1DpZf
	Hzg1mdTerQLBoX39NNsXsDQC2+hrR3aBBYDmDTdD14k1T4XGX7RVkDCUKhI8nXScytdzTwdflkt
	WCtYGEbzuRTD6BLmGsa/OW1X8m4VUin/kDRPO5VW0wYK03kZNtgEtGbs=
X-Google-Smtp-Source: AGHT+IGb1trX+rafT0n9MN3CQAgyT7icGkwYBvwBqpa+Blc5Yx26W9oOCWaFrQn5WFoydBtt7HEjjX0wqjzkbBKZ4jeQsVeu3XIh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f04:b0:3cf:b87b:8fde with SMTP id
 e9e14a558f8ab-3d2caefdc5cmr55499135ab.17.1740197305559; Fri, 21 Feb 2025
 20:08:25 -0800 (PST)
Date: Fri, 21 Feb 2025 20:08:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b94db9.050a0220.14d86d.059e.GAE@google.com>
Subject: [syzbot] [kernfs?] UBSAN: shift-out-of-bounds in idr_get_free
From: syzbot <syzbot+3bc3cf50b8473fe86880@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d737df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7bde34acd8f53b=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3bc3cf50b8473fe86=
880
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-2408a807.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f62d1e4db390/vmlinux-=
2408a807.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb24d3a710ff/bzI=
mage-2408a807.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+3bc3cf50b8473fe86880@syzkaller.appspotmail.com

bcachefs (loop0): empty btree root xattrs
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): done starting filesystem
bcachefs (loop0): missing subvolume 1
bcachefs (loop0): inconsistency detected - emergency read only at journal s=
eq 10
bcachefs (loop0): bch2_fs_get_tree(): error mounting: error getting root in=
ode ENOENT_bkey_type_mismatch
bcachefs (loop0): shutting down
bcachefs (loop0): shutdown complete
bcachefs: bch2_fs_get_tree() error: ENOENT_bkey_type_mismatch
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
Topology repair: unreadable btree node at
  btree=3Dxattrs level=3D0 u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: =
seq 2285c34bed0abe32 written 960 min_key POS_MIN durability: 1 ptr: 0:31:0 =
gen 0, fixing
empty interior btree node at btree=3Dxattrs level=3D1
u64s 5 type btree_ptr SPOS_MAX len 0 ver 0, fixing
bcachefs (loop0): empty btree root xattrs
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in lib/radix-tree.c:88:31
shift exponent 160 is too large for 64-bit type 'unsigned long'
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller-0001=
2-g2408a807bfc3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 radix_tree_descend lib/radix-tree.c:88 [inline]
 idr_get_free+0x68f/0xab0 lib/radix-tree.c:1518
 idr_alloc_u32+0x195/0x330 lib/idr.c:46
 idr_alloc_cyclic+0x106/0x300 lib/idr.c:125
 __kernfs_new_node+0x12d/0x870 fs/kernfs/dir.c:630
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 device_add+0x4e5/0xbf0 drivers/base/core.c:3603
 device_create_groups_vargs drivers/base/core.c:4347 [inline]
 device_create+0x257/0x2e0 drivers/base/core.c:4386
 bdi_register_va+0x8b/0x770 mm/backing-dev.c:1094
 super_setup_bdi_name+0xe4/0x200 fs/super.c:1873
 bch2_fs_get_tree+0xce4/0x17a0 fs/bcachefs/fs.c:2242
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f419b38e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f419c235e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f419c235ef0 RCX: 00007f419b38e58a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007f419c235eb0
RBP: 00004000000058c0 R08: 00007f419c235ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007f419c235eb0 R14: 0000000000005912 R15: 00004000000001c0
 </TASK>
---[ end trace ]---


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

