Return-Path: <linux-kernel+bounces-403916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E089C3C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6C2820F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6E158DD4;
	Mon, 11 Nov 2024 11:01:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BB1411DE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322867; cv=none; b=Rnvp2gRZYyTSzHP/s/xynUxaz5xlLqz6jIwqr3UodYBsmziTCzmBr6hy7TSbvKG9BxdqC+qFRgpmcxFLW/GHfRO/X2dvwvzOmFP8eLtXpSPdzcn0r6hiAbU8O32t7/e8RvXHaTZalJZmDr1+ol5OEssaLBoYx69ykgKaKsDCZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322867; c=relaxed/simple;
	bh=H6JOYtDAXFqn3QoPqhZ5DjtJcPuDyp07yeiiekeOIbo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gCWqPhmhU7YrgEvDIOwNtOn4UzVpvlmjyxBksuSEZMxw4IaUC2gF6Dze5tsIc0slrZy5+V20DJfj70NBmy5FPWd9+5JSLx3pOIzXvfF9cnvrd9+3QdlRMcG68YB/EW+S8b3+JdIuFoKWzTy+cJYNv/YsAhFGg3lGarSp8kqlXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac79525b8so480533039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322865; x=1731927665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4wZSiWc0LOwLNESMvIM4p/cqTxFb7+PjaB1O23q5pI=;
        b=vtZunpgQShjhiUctakMuui3e865RD787/ilJ9rjKgq9xsFHZD2V8dFgc9iShI2F80m
         QlBdmgQVjLwzhO67ws/1vpBPaxOV9ckSC6dtg9ewdlPppg5Y2X56o4HPLc6g+jVIFbON
         O+HB/SLMgrJBoyyo+Rh7IjzU30L3LQwD3eWR9NW/R6iZqe9cqO/oIJvaHT4Gg8WXBS31
         ldsVhHbLySY6Kefw+WDEh2GTZaNCV0rUeAtOFQ67aAJEixoqpyAXMIArLDNIPLCrtQZ3
         LbffC56yfAi7HSq0cC9VBkTyYakwQydJNVQ8KINJ56ivPIVUO3QquoDFC+fLTfdvTlYA
         +SXg==
X-Forwarded-Encrypted: i=1; AJvYcCXY7aDPVtT9kM8yVzBshHY1uUtWoakmjQ3a+OhBnnLI+Ky3EYpDfWmzKaAEuDyRf1wM5BQ+HDMUiJyU3wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9f95Vdhg0M1NicesoowWABLrz9twMMaQGntSqFnmGPH+D53zm
	1T5AXN9tK1Oz1MKQKnA1ae/EIwRW5ifMG1YCLxwh2DjrB45gOqN87Mou9biAyov3XaKD/+H2B28
	A19VAnp80M7JFmQGT9LRxqt7Iz4zEzhj4B5x1c4ymSgbo4hDJ+j/yg1g=
X-Google-Smtp-Source: AGHT+IF5qO9lnlFO0JiTc8+FAXeBC8c0KXtd+6SixRqRBU1Gvasf9c4+ABMgePIFfHT3M6wPKWyDHFNJrgg/1grr+taoYiJK9fRu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a6:bb36:ac1f with SMTP id
 e9e14a558f8ab-3a6f1a45467mr121452885ab.22.1731322865413; Mon, 11 Nov 2024
 03:01:05 -0800 (PST)
Date: Mon, 11 Nov 2024 03:01:05 -0800
In-Reply-To: <e7d2f6e7-4f3d-450e-85d2-cde33764fa6e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731e3f1.050a0220.138bd5.0066.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_check_topology
From: syzbot <syzbot+494bcd3631a9f6759f91@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __bch2_btree_node_hash_insert

  parent: u64s 5 type btree_ptr SPOS_MAX len 0 ver 0
  child: u64s 11 type btree_ptr_v2 U64_MAX:18374686479671623680:50331647 len 0 ver 0: seq 2285c34bed0abe32 written 16 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0, fixing
bcachefs (loop0): bch2_get_scanned_nodes(): recovering xattrs l=0 U64_MAX:18374686479671623680:50331648 - SPOS_MAX
bcachefs (loop0): set_node_max(): u64s 11 type btree_ptr_v2 U64_MAX:18374686479671623680:50331647 len 0 ver 0: seq 2285c34bed0abe32 written 16 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0 -> SPOS_MAX
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_cache.c:280!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 0 UID: 0 PID: 6643 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__bch2_btree_node_hash_insert+0x1b3c/0x1b40 fs/bcachefs/btree_cache.c:280
Code: 45 00 00 41 c6 45 08 00 bf 02 00 00 00 e8 2c 23 7c fc 84 db 0f 84 b1 fe ff ff e8 1f 20 7c fc e9 bc ea ff ff e8 15 20 7c fc 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffff88803ddceda8 EFLAGS: 00010293
RAX: ffffffff8538d21b RBX: ffff888042706400 RCX: ffff888118faa0c0
RDX: 0000000000000000 RSI: ffff88813fffab40 RDI: ffff8880427065c8
RBP: ffff88803ddceed0 R08: ffffea000000000f R09: 0000000000000058
R10: ffff888041f06520 R11: ffff88803d493180 R12: 0000000000000000
R13: ffff888118faabf8 R14: ffff888043f814f8 R15: ffff8880427065c8
FS:  00007f182314a6c0(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555567677e0 CR3: 000000004261c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_node_max+0xa7d/0xb00 fs/bcachefs/btree_gc.c:188
 btree_repair_node_end fs/bcachefs/btree_gc.c:299 [inline]
 bch2_btree_repair_topology_recurse+0x813d/0x8ac0 fs/bcachefs/btree_gc.c:425
 bch2_check_topology+0xa2f/0x1200 fs/bcachefs/btree_gc.c:550
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:185 [inline]
 bch2_run_recovery_passes+0xaf9/0xf80 fs/bcachefs/recovery_passes.c:238
 bch2_fs_recovery+0x447b/0x5b00 fs/bcachefs/recovery.c:861
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0x13ea/0x22d0 fs/bcachefs/fs.c:2170
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f182237feba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1823149e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1823149ef0 RCX: 00007f182237feba
RDX: 0000000020000180 RSI: 0000000020000000 RDI: 00007f1823149eb0
RBP: 0000000020000180 R08: 00007f1823149ef0 R09: 0000000000800008
R10: 0000000000800008 R11: 0000000000000246 R12: 0000000020000000
R13: 00007f1823149eb0 R14: 00000000000059bc R15: 0000000020000300
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_btree_node_hash_insert+0x1b3c/0x1b40 fs/bcachefs/btree_cache.c:280
Code: 45 00 00 41 c6 45 08 00 bf 02 00 00 00 e8 2c 23 7c fc 84 db 0f 84 b1 fe ff ff e8 1f 20 7c fc e9 bc ea ff ff e8 15 20 7c fc 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffff88803ddceda8 EFLAGS: 00010293
RAX: ffffffff8538d21b RBX: ffff888042706400 RCX: ffff888118faa0c0
RDX: 0000000000000000 RSI: ffff88813fffab40 RDI: ffff8880427065c8
RBP: ffff88803ddceed0 R08: ffffea000000000f R09: 0000000000000058
R10: ffff888041f06520 R11: ffff88803d493180 R12: 0000000000000000
R13: ffff888118faabf8 R14: ffff888043f814f8 R15: ffff8880427065c8
FS:  00007f182314a6c0(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555567677e0 CR3: 000000004261c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d63ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=494bcd3631a9f6759f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f368c0580000


