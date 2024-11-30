Return-Path: <linux-kernel+bounces-426235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E79DF0A1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64FB281904
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2819ABC2;
	Sat, 30 Nov 2024 13:53:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A479159596
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974810; cv=none; b=Pa7yxIFkfvroxx/dltpJteDlAAAlbU+Caf/b84/PnWWRqM5wYkVmYR4TEV5VH1kVH73c61cagQ2SHrygpYtmdpWR5dhINk1K+LLoVcXRFuykpJIVccr7bks/kcHS+f6Cjehvp3I4ERZ6WuOQI/EBkgh1YUXaLOYs8UIvWwLb9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974810; c=relaxed/simple;
	bh=q1WZHKbutW7nRr1zsBZWJD8iIhggYfnItH8WMiBjyPo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rCalq4flLQSNha69ymuvw2Z8NJfCpkUUXM96cB0rT1JgviEU9yLweIemB4Xk1dWawtSrv7I/LT0K/5r611exzIigfFzvA8SUFGCFgutIbJ6E6Uf7+e6epHioVgrcWloS6zN7m0si9sb7Wng56mvJdBoNt4wdKr7h72LUofBdmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7807feadfso24155295ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 05:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732974807; x=1733579607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=df20P3izm7SAs3dJHC0DnRTzRnt1LtogTQRaIdf1SPg=;
        b=W0p0I+OGycZY0iZukgkt+KhcYvF5uRe16sWzZTMnutdfU/2bPzhFboYjhr2aGe7Dn+
         2mVV73vYjSXZ43VIkwG5SifBParRTJsjoErGJuxQdEdCM6kFso39NjPLBwrdLkttM16k
         9qnx62Q7ES5HNmWNR70xGZetx2qNM/MvnKAcUiL+Ib+cmOtbckalZ7Z+7UaYrG3Hokwk
         2H1nCY2EO7mn2D/xs9F/LPFYPrNJSysjDAsrcp5LmV6l29ptddqMEuRXF22aE7OM7eEj
         k/QhI9+F/7sVIdqljXLF204y0VhYu96vzBDMXc0Ele7JFL+da4qeDGgB4QkwHazwVxl5
         eXlg==
X-Forwarded-Encrypted: i=1; AJvYcCXGXp1sTeKBzec5ie+3O7qK+wdbAj29RC25Vkcn+LJMchuA9RmIJdEJzdn3rq7irP33jo8+gFayFSH9qFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziX8HzG1FcQErz4N9ndaiofcaVEaVLhyY7oEhumw4yYG4bsn89
	ja9Qc2pedulzGGD/J+F0LhhFjTjoIHJAygcH0ZtB1mRsIpOoevu2JhwCxYGATZMZCXj3iqkIYFE
	wMpM35gONGlLGeJAzXr2XQq/ly9TQ0ZqOKAVSnRQKP/yZMDQjCFozYp0=
X-Google-Smtp-Source: AGHT+IFCEMNjsjl7ZXuwRDUqxBwqsVWLRkaXwmziJ2WBwn7ENmBKKYve2ojzNYjnG5h31gRUW5+iAe1SzNRp2IPTzpz4ZYZCj1jY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2401:b0:3a7:d5a6:1f9d with SMTP id
 e9e14a558f8ab-3a7d5a62424mr76820085ab.9.1732974807569; Sat, 30 Nov 2024
 05:53:27 -0800 (PST)
Date: Sat, 30 Nov 2024 05:53:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b18d7.050a0220.253251.00dc.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_inode_update_after_write
From: syzbot <syzbot+1142db83534a06f10d5b@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    65ae975e97d5 Merge tag 'net-6.13-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14512f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=1142db83534a06f10d5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-65ae975e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53fd215a7a86/vmlinux-65ae975e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/589c729ff0b2/bzImage-65ae975e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1142db83534a06f10d5b@syzkaller.appspotmail.com

  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq ebb8d5a9e3463bdb written 16 min_key POS_MIN durability: 1 ptr: 0:32:0 gen 0  
  node offset 8/16: btree node data missing: expected 16 sectors, found 8, fixing
bcachefs (loop0): btree_node_read_work: rewriting btree node at btree=snapshots level=0 SPOS_MAX due to error
bcachefs (loop0): scan_for_btree_nodes...
bch2_scan_for_btree_nodes: nodes found after overwrites:
  extents l=0 seq=1 journal_seq=5 cookie=c6c25c03258c59c5 POS_MIN-SPOS_MAX ptr: 0:27:0 gen 0
  inodes l=0 seq=1 journal_seq=5 cookie=7589ab5e0c11cc7a POS_MIN-18446462598732840960:14872293344460931071:U32_MAX ptr: 0:38:0 gen 0
  dirents l=0 seq=1 journal_seq=3458764513820540929 cookie=9aa2895aefce4bdf POS_MIN-SPOS_MAX ptr: 0:41:0 gen 0
  xattrs l=0 seq=1 journal_seq=4 cookie=2285c34bed0abe32 POS_MIN-SPOS_MAX ptr: 0:31:0 gen 0
  subvolumes l=0 seq=1 journal_seq=1 cookie=c0bef60d07ceb940 POS_MIN-SPOS_MAX ptr: 0:35:0 gen 0
  snapshots l=0 seq=1 journal_seq=0 cookie=ebb8d5a9e3463bdb POS_MIN-SPOS_MAX ptr: 0:32:0 gen 0
  lru l=0 seq=1 journal_seq=5 cookie=28f61e078e70b95c POS_MIN-SPOS_MAX ptr: 0:28:0 gen 0
  deleted_inodes l=0 seq=1 journal_seq=0 cookie=1db8f60c84bb244c POS_MIN-SPOS_MAX ptr: 0:42:0 gen 0
 done
bcachefs (loop0): check_topology...
bcachefs (loop0): btree root inodes unreadable, must recover from scan
bcachefs (loop0): bch2_get_scanned_nodes(): recovering inodes l=0 POS_MIN - SPOS_MAX
bcachefs (loop0): bch2_get_scanned_nodes(): recovering u64s 11 type btree_ptr_v2 18446462598732840960:14872293344460931071:U32_MAX len 0 ver 0: seq 7589ab5e0c11cc7a written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0
btree node with incorrect max_keyat btree inodes level 1:
  parent: u64s 5 type btree_ptr SPOS_MAX len 0 ver 0
  child: u64s 11 type btree_ptr_v2 18446462598732840960:14872293344460931071:U32_MAX len 0 ver 0: seq 7589ab5e0c11cc7a written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0, fixing
bcachefs (loop0): bch2_get_scanned_nodes(): recovering inodes l=0 18446462598732840960:14872293344460931072:0 - SPOS_MAX
btree node with incorrect max_keyat btree inodes level 1:
  parent: u64s 5 type btree_ptr SPOS_MAX len 0 ver 0
  child: u64s 11 type btree_ptr_v2 18446462598732840960:14872293344460931071:U32_MAX len 0 ver 0: seq 7589ab5e0c11cc7a written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0, fixing
bcachefs (loop0): set_node_max(): u64s 11 type btree_ptr_v2 18446462598732840960:14872293344460931071:U32_MAX len 0 ver 0: seq 7589ab5e0c11cc7a written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0 -> SPOS_MAX
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
bcachefs (loop0): dirent to missing inode:
  u64s 7 type dirent 4096:189491840996961599:U32_MAX len 0 ver 0: file0 -> 4098 type dir
UDC core: USB Raw Gadget: couldn't find an available UDC or it's busy
misc raw-gadget: fail, usb_gadget_register_driver returned -16
netlink: 157436 bytes leftover after parsing attributes in process `syz.0.0'.
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
------------[ cut here ]------------
kernel BUG at fs/bcachefs/fs.c:59!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10681-g65ae975e97d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_inode_update_after_write+0xbd6/0xbe0 fs/bcachefs/fs.c:59
Code: e1 07 80 c1 03 38 c1 0f 8c ea fb ff ff 48 89 f7 48 89 74 24 10 e8 4a a8 cd fd 48 8b 74 24 10 e9 d3 fb ff ff e8 5b c1 62 fd 90 <0f> 0b e8 33 f9 9f 07 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d38f8c0 EFLAGS: 00010287
RAX: ffffffff84332325 RBX: 0000000000001003 RCX: 0000000000100000
RDX: ffffc9000e472000 RSI: 0000000000007a41 RDI: 0000000000007a42
RBP: ffffc9000d38fa10 R08: ffffffff8433186e R09: 0000000000001000
R10: 0000000000000d0c R11: 00000000ffffffff R12: ffff888051b2c000
R13: ffff888044b1c000 R14: ffff888044b1de00 R15: 0000000000001002
FS:  00007f10501736c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020034000 CR3: 0000000043e86000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_unlink+0x469/0x530 fs/bcachefs/fs.c:763
 bch2_unlink+0xac/0xf0 fs/bcachefs/fs.c:786
 vfs_unlink+0x365/0x650 fs/namei.c:4523
 do_unlinkat+0x4ae/0x830 fs/namei.c:4587
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f104f380809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1050173058 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f104f545fa0 RCX: 00007f104f380809
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007f104f3f393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f104f545fa0 R15: 00007ffe1724f5b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_inode_update_after_write+0xbd6/0xbe0 fs/bcachefs/fs.c:59
Code: e1 07 80 c1 03 38 c1 0f 8c ea fb ff ff 48 89 f7 48 89 74 24 10 e8 4a a8 cd fd 48 8b 74 24 10 e9 d3 fb ff ff e8 5b c1 62 fd 90 <0f> 0b e8 33 f9 9f 07 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d38f8c0 EFLAGS: 00010287
RAX: ffffffff84332325 RBX: 0000000000001003 RCX: 0000000000100000
RDX: ffffc9000e472000 RSI: 0000000000007a41 RDI: 0000000000007a42
RBP: ffffc9000d38fa10 R08: ffffffff8433186e R09: 0000000000001000
R10: 0000000000000d0c R11: 00000000ffffffff R12: ffff888051b2c000
R13: ffff888044b1c000 R14: ffff888044b1de00 R15: 0000000000001002
FS:  00007f10501736c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020034000 CR3: 0000000043e86000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

