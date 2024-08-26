Return-Path: <linux-kernel+bounces-302257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4195FBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BBAB2217A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5819B3C3;
	Mon, 26 Aug 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuitari.net header.i=@nuitari.net header.b="HeJiJFw+"
Received: from anvil.nuitari.net (mail.nuitari.net [192.99.15.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56646199FA7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.99.15.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708147; cv=none; b=ajwY6xuShcDOpPQ9FbPHjqJEVcAqnuudA2OvNkz5BTv7mx7o+lQZ1cFp5zIMxvS5s5G6f5R08XuNlW0glXT7sG8DTTLtOVrnCADJsjo9WJmn7NM+fdbIRa4KVwPHxY7SDVOZyR06bFf5kCZewOseA5yTaFmzVHCv/TzPBYhf6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708147; c=relaxed/simple;
	bh=B3UN2oNjYD8+aM5pNMXEoFd7emTFM60SpNEpMigkSJQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=QpJCHSmuKJuv8VbcaE29YmCcV30qsNMpgqtJX6TEBULF6/XF83cyBeX/yjyaJNJvVJXRH7fAqyNqiPgxB4W4D+gHNBFVVzJMlxSVqqvyCfhgjX0FaL9p+2EfOJiXaAt2KwINrsYjRVxBWqkBkW/IsjnQQ+MWRR79QZ4cGEzCydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nuitari.net; spf=pass smtp.mailfrom=nuitari.net; dkim=pass (2048-bit key) header.d=nuitari.net header.i=@nuitari.net header.b=HeJiJFw+; arc=none smtp.client-ip=192.99.15.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nuitari.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuitari.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=nuitari.net; h=date:from
	:to:subject:message-id:mime-version:content-type; s=anvil; bh=B3
	UN2oNjYD8+aM5pNMXEoFd7emTFM60SpNEpMigkSJQ=; b=HeJiJFw+ZELf1AsAxc
	TfuBeQJkudlcLLkzDSmZcsh1DI2kmVCgJmnGZ4uxVld/TWTWqnU68OBOkqWvgdnd
	x5Apht56Zhk7wKeLfVeWv+d0cPTWVhu2A5XYTHoqAa+ebdck+oIRFM5o6uMf4gXN
	S7I1wITl5S4tzfnUD3rkpPoRG7o37g1A0f8ftZ4aAQeCL861i6i2Nw1ELE8Wndo5
	nCP5vWUApPzabK8LqeAQUq9WIULOuwHm/5ipsQ0kgd05sdwlztMJeDL1ctxByx64
	di7YCpgtNd2PBbbx7FKJcnsxYVjbiqWv05n21jOlZyQBfOOJ8IAULFjMTFjtPIHk
	N96A==
Received: (qmail 23714 invoked by uid 210); 26 Aug 2024 21:35:43 -0000
Received: from 127.0.0.1 by mail (envelope-from <nuitari-vger@nuitari.net>, uid 201) with qmail-scanner-2.08st 
 (clamdscan: 1.3.1/27378. spamassassin: 4.0.1. perlscan: 2.08st.  
 Clear:RC:1(127.0.0.1):. 
 Processed in 0.060714 secs); 26 Aug 2024 21:35:43 -0000
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with ESMTPS (TLS_AES_256_GCM_SHA384 encrypted); 26 Aug 2024 21:35:42 -0000
Date: Mon, 26 Aug 2024 21:35:42 +0000 ()
From: Stephane Bakhos <nuitari-vger@nuitari.net>
To: linux-kernel@vger.kernel.org
Subject: general protection fault, kernel 6.10.6, nbd in raid10
Message-ID: <f93268be-cd2d-10df-862c-50147e2b144d@nuitari.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

I was experimenting with nbd in a mdadm raid10 for a migration and somehow 
caused a general protection fault.

I was running a sha1sum while a raid10 recovery was running.

The kernel config is available at
https://nuitari.net/config-kernel

The dmesg is available at
https://nuitari.net/dmesg

This is on a self compiled kernel, 6.10.6 on Ubuntu 24.04

I included the relevant dmesg section below.

[278373.383576] Oops: general protection fault, probably for non-canonical 
address 0x9dbd6f51c091e114: 0000 [#1] PREEMPT SMP NOPTI
[278373.383590] CPU: 0 PID: 26830 Comm: sha1sum Not tainted 6.10.6 #1
[278373.383597] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-20220807_005459-localhost 04/01/2014
[278373.383604] RIP: 0010:tcp_rbtree_insert+0x25/0x60
[278373.383619] Code: 90 90 90 90 90 66 0f 1f 00 49 89 f8 48 89 f7 49 8b 
00 4c 89 c2 48 85 c0 74 1f 8b 76 28 eb 03 48 89 c8 48 8d 48 10 48 8d 50 08 
<3b> 70 28 48 0f 48 d1 48 8b 0a 48 85 c9 75 e6 48 89 07 4c 89 c6 48
[278373.383630] RSP: 0018:ffffac7c807cb2e8 EFLAGS: 00010282
[278373.383636] RAX: 9dbd6f51c091e0ec RBX: ffff948d0b125340 RCX: 
9dbd6f51c091e0fc
[278373.383645] RDX: 9dbd6f51c091e0f4 RSI: 0000000069334e04 RDI: 
ffff948d17010e00
[278373.383652] RBP: ffff948d17010e00 R08: ffff948d0b1254c8 R09: 
ffff948d17010ee0
[278373.383658] R10: ffffac7c807cb058 R11: ffff948d17010ee0 R12: 
000000000000001c
[278373.383663] R13: 00000000000005a8 R14: 000000000000001c R15: 
ffffac7c807cb501
[278373.383673] FS:  00007f2d2baa7740(0000) GS:ffff948d7bc00000(0000) 
knlGS:0000000000000000
[278373.383681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[278373.383686] CR2: 00005612124781f8 CR3: 000000010895e000 CR4: 
0000000000350ef0
[278373.383692] Call Trace:
[278373.383699]  <TASK>
[278373.383704]  ? die_addr+0x31/0x80
[278373.383710]  ? exc_general_protection+0x1bd/0x3c0
[278373.383719]  ? asm_exc_general_protection+0x26/0x30
[278373.383726]  ? tcp_rbtree_insert+0x25/0x60
[278373.383731]  tcp_event_new_data_sent+0x4c/0xb0
[278373.383737]  tcp_write_xmit+0x5f2/0x14d0
[278373.383743]  __tcp_push_pending_frames+0x31/0xc0
[278373.383749]  tcp_sendmsg_locked+0xafe/0xcf0
[278373.383756]  tcp_sendmsg+0x26/0x40
[278373.383761]  sock_sendmsg+0xf8/0x120
[278373.383770]  __sock_xmit+0x9b/0x180 [nbd]
[278373.383779]  nbd_send_cmd+0x266/0x730 [nbd]
[278373.383789]  nbd_queue_rq+0x1f0/0x400 [nbd]
[278373.383794]  ? srso_return_thunk+0x5/0x5f
[278373.383801]  ? srso_return_thunk+0x5/0x5f
[278373.383805]  ? pick_eevdf+0x62/0x1e0
[278373.383811]  blk_mq_dispatch_rq_list+0x124/0x6b0
[278373.383819]  __blk_mq_sched_dispatch_requests+0x3fa/0x5b0
[278373.383825]  ? srso_return_thunk+0x5/0x5f
[278373.383831]  blk_mq_sched_dispatch_requests+0x27/0x60
[278373.383837]  blk_mq_run_hw_queue+0xf2/0x1b0
[278373.383843]  blk_mq_flush_plug_list.part.0+0x160/0x590
[278373.383848]  ? srso_return_thunk+0x5/0x5f
[278373.383854]  blk_add_rq_to_plug+0x9f/0x140
[278373.383859]  blk_mq_submit_bio+0x42c/0x600
[278373.383865]  __submit_bio+0x92/0x1f0
[278373.383871]  submit_bio_noacct_nocheck+0x195/0x3c0
[278373.383877]  ? __cond_resched+0x30/0x50
[278373.383882]  ext4_mpage_readpages+0x333/0x5c0
[278373.383891]  read_pages+0x78/0x1f0
[278373.383898]  page_cache_ra_unbounded+0x100/0x170
[278373.383904]  filemap_get_pages+0x44c/0x5a0
[278373.383910]  ? srso_return_thunk+0x5/0x5f
[278373.383915]  ? wakeup_preempt+0x5c/0x70
[278373.383922]  filemap_read+0xed/0x360
[278373.383931]  vfs_read+0x294/0x370
[278373.383938]  ksys_read+0x6a/0xf0
[278373.383943]  do_syscall_64+0x9e/0x1a0
[278373.383949]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[278373.383954] RIP: 0033:0x7f2d2bbc5a61
[278373.383959] Code: 00 48 8b 15 b9 73 0e 00 f7 d8 64 89 02 b8 ff ff ff 
ff eb bd e8 40 c4 01 00 f3 0f 1e fa 80 3d e5 f5 0e 00 00 74 13 31 c0 0f 05 
<48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[278373.383970] RSP: 002b:00007fffc9ff5148 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[278373.383977] RAX: ffffffffffffffda RBX: 00005571dd892410 RCX: 
00007f2d2bbc5a61
[278373.383983] RDX: 0000000000008000 RSI: 00005571dd8925f0 RDI: 
0000000000000003
[278373.383989] RBP: 00007fffc9ff5190 R08: 00005571dd892410 R09: 
00000000078bffff
[278373.384004] R10: 00000000219c01ab R11: 0000000000000246 R12: 
00007f2d2bcac030
[278373.384010] R13: 00005571dd8925f0 R14: 0000000000008000 R15: 
00007f2d2bcabee0
[278373.384018]  </TASK>
[278373.384021] Modules linked in: raid456 libcrc32c async_raid6_recov 
async_memcpy async_pq async_xor xor async_tx raid6_pq nbd raid0 raid10 
[last unloaded: raid0]
[278373.384115] ---[ end trace 0000000000000000 ]---


[278373.384121] RIP: 0010:tcp_rbtree_insert+0x25/0x60
[278373.384127] Code: 90 90 90 90 90 66 0f 1f 00 49 89 f8 48 89 f7 49 8b 
00 4c 89 c2 48 85 c0 74 1f 8b 76 28 eb 03 48 89 c8 48 8d 48 10 48 8d 50 08 
<3b> 70 28 48 0f 48 d1 48 8b 0a 48 85 c9 75 e6 48 89 07 4c 89 c6 48
[278373.384137] RSP: 0018:ffffac7c807cb2e8 EFLAGS: 00010282
[278373.384143] RAX: 9dbd6f51c091e0ec RBX: ffff948d0b125340 RCX: 
9dbd6f51c091e0fc
[278373.384149] RDX: 9dbd6f51c091e0f4 RSI: 0000000069334e04 RDI: 
ffff948d17010e00
[278373.384154] RBP: ffff948d17010e00 R08: ffff948d0b1254c8 R09: 
ffff948d17010ee0
[278373.384160] R10: ffffac7c807cb058 R11: ffff948d17010ee0 R12: 
000000000000001c
[278373.384166] R13: 00000000000005a8 R14: 000000000000001c R15: 
ffffac7c807cb501
[278373.384174] FS:  00007f2d2baa7740(0000) GS:ffff948d7bc00000(0000) 
knlGS:0000000000000000
[278373.384182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[278373.384187] CR2: 00005612124781f8 CR3: 000000010895e000 CR4: 
0000000000350ef0
[278373.384199] ------------[ cut here ]------------
[278373.384205] WARNING: CPU: 0 PID: 26830 at kernel/exit.c:825 
do_exit+0x887/0xa80
[278373.384220] Modules linked in: raid456 libcrc32c async_raid6_recov 
async_memcpy async_pq async_xor xor async_tx raid6_pq nbd raid0 raid10 
[last unloaded: raid0]
[278373.384260] CPU: 0 PID: 26830 Comm: sha1sum Tainted: G      D 
6.10.6 #1
[278373.384267] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-20220807_005459-localhost 04/01/2014
[278373.384274] RIP: 0010:do_exit+0x887/0xa80
[278373.384280] Code: a3 a8 05 00 00 48 89 44 24 10 48 8b 83 80 07 00 00 
e9 e2 fd ff ff 48 8b bb 88 05 00 00 31 f6 e8 4f e5 ff ff e9 84 fd ff ff 90 
<0f> 0b 90 e9 e5 f7 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 07 01 00 e9
[278373.384291] RSP: 0018:ffffac7c807cbed8 EFLAGS: 00010282
[278373.384296] RAX: 0000000400000000 RBX: ffff948d0cae9f80 RCX: 
0000000000000000
[278373.384302] RDX: 0000000000000001 RSI: 0000000000002710 RDI: 
ffff948c017c5ac0
[278373.384309] RBP: ffff948d10c69f80 R08: 0000000000000000 R09: 
0000000000000001
[278373.384317] R10: 00000000ffffdfff R11: ffffffff93458860 R12: 
000000000000000b
[278373.384324] R13: ffff948c017c5ac0 R14: 0000000000000000 R15: 
0000000000000000
[278373.384337] FS:  00007f2d2baa7740(0000) GS:ffff948d7bc00000(0000) 
knlGS:0000000000000000
[278373.384346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[278373.384351] CR2: 00005612124781f8 CR3: 000000010895e000 CR4: 
0000000000350ef0
[278373.384356] Call Trace:
[278373.384360]  <TASK>
[278373.384363]  ? __warn+0x7b/0x120
[278373.384369]  ? do_exit+0x887/0xa80
[278373.384374]  ? report_bug+0x164/0x190
[278373.384380]  ? handle_bug+0x3b/0x70
[278373.384407]  ? exc_invalid_op+0x17/0x70
[278373.384413]  ? asm_exc_invalid_op+0x1a/0x20
[278373.384443]  ? do_exit+0x887/0xa80
[278373.384449]  ? do_exit+0x66/0xa80
[278373.384455]  make_task_dead+0x78/0x160
[278373.384460]  rewind_stack_and_make_dead+0x16/0x20
[278373.384466] RIP: 0033:0x7f2d2bbc5a61
[278373.384471] Code: 00 48 8b 15 b9 73 0e 00 f7 d8 64 89 02 b8 ff ff ff 
ff eb bd e8 40 c4 01 00 f3 0f 1e fa 80 3d e5 f5 0e 00 00 74 13 31 c0 0f 05 
<48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[278373.384482] RSP: 002b:00007fffc9ff5148 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[278373.384489] RAX: ffffffffffffffda RBX: 00005571dd892410 RCX: 
00007f2d2bbc5a61
[278373.384495] RDX: 0000000000008000 RSI: 00005571dd8925f0 RDI: 
0000000000000003
[278373.384500] RBP: 00007fffc9ff5190 R08: 00005571dd892410 R09: 
00000000078bffff
[278373.384506] R10: 00000000219c01ab R11: 0000000000000246 R12: 
00007f2d2bcac030
[278373.384512] R13: 00005571dd8925f0 R14: 0000000000008000 R15: 
00007f2d2bcabee0
[278373.384520]  </TASK>
[278373.384523] ---[ end trace 0000000000000000 ]---
[278373.384886] sha1sum (26830) used greatest stack depth: 10672 bytes 
left



