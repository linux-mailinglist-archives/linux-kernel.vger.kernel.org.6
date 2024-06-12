Return-Path: <linux-kernel+bounces-212387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D5905F71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD381C216D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A384A23;
	Wed, 12 Jun 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGyfSqC1"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA64084E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718236365; cv=none; b=eYW4Zjp4ZAu4loHmOdH8m3Gr2XOZnHWFpwtZqG0KUsLO6kTCTthxnKGUUFDKybnbCh21g/iiiE9jlAz4gtRR2KYnLF6ZmyRQEuTWkTlTkcfW4XpTnlNEFFm4wZQS0FWBc66pU6erlfxcp/XXN9b4dWOmXIVJIT0RZXxRI3f5Pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718236365; c=relaxed/simple;
	bh=H3fyuomyXg6FNR1PwVxBSjtKSzI3dLt5pNOYZIHg5dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qel4pdZUF0TogtfqG9k1C6g2yz9JUI65L8UyCk9JWJfSm1/lhqcv6PhyYyvfkSaxqY0Qkd56+mk9CP+MDMVw13Cx0n8ZkB0QeUu+GLRnvBqdhYINgCKeNwBFammmaiGEg/eK2y9U78v5jTq4B6fVvDEPNFptxEoaymX84nVRKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TGyfSqC1; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+51837cbb6ca165f5344e@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718236361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//foYkVPIad7avXaiinYfuHgA5SBIrgiY3hh3Kjh12I=;
	b=TGyfSqC1KhgeijC161TaIJPETZjdqwv5IQbCevjDYB5vx1ClziUzAiry+aS4+3GJ2XB4s0
	ZdPTEBDqiQRjl+P826yVfYpQt4f1hnWvFmqlfRbmW2IfrlQx83RpMxmBEdLu9MaagRcKcj
	/dXiZht5fUnDW430wl0oP0TpHO/fY90=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Wed, 12 Jun 2024 19:52:35 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+51837cbb6ca165f5344e@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] UBSAN: array-index-out-of-bounds in
 bch2_bkey_swab_key
Message-ID: <evajxourbgolc3nefulnx4omwsrwjquaab2jt6cwxjmumcgcxt@kuktptxqousz>
References: <000000000000b74056061a6840af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b74056061a6840af@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 08, 2024 at 03:15:24PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d30d0e49da71 Merge tag 'net-6.10-rc3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17cac096980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a6ac4277fffe3ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=51837cbb6ca165f5344e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6d0ced9b3d02/disk-d30d0e49.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cd5917307028/vmlinux-d30d0e49.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cda11b4554fe/bzImage-d30d0e49.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+51837cbb6ca165f5344e@syzkaller.appspotmail.com
> 
> bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=compression=lz4,nojournal_transaction_names
> bcachefs (loop0): recovering from clean shutdown, journal seq 7
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in fs/bcachefs/bkey.c:1067:27
> index 5 is out of range for type '__u64[0]' (aka 'unsigned long long[0]')
> CPU: 0 PID: 5185 Comm: syz-executor.0 Not tainted 6.10.0-rc2-syzkaller-00222-gd30d0e49da71 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
>  bch2_bkey_swab_key+0x224/0x240 fs/bcachefs/bkey.c:1067
>  __bch2_bkey_compat+0x2b3/0x1030 fs/bcachefs/bkey_methods.c:402
>  bch2_bkey_compat fs/bcachefs/bkey_methods.h:133 [inline]
>  validate_bset_keys+0x608/0x1a60 fs/bcachefs/btree_io.c:915
>  bch2_btree_node_read_done+0x250a/0x6750 fs/bcachefs/btree_io.c:1148
>  btree_node_read_work+0x68b/0x1260 fs/bcachefs/btree_io.c:1345
>  bch2_btree_node_read+0x2433/0x2a10
>  __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
>  bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1793
>  read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:475
>  bch2_fs_recovery+0x2346/0x3720 fs/bcachefs/recovery.c:803
>  bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1031
>  bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2123
>  bch2_mount+0x6c0/0x1320 fs/bcachefs/fs.c:1917
>  legacy_get_tree+0xee/0x190 fs/fs_context.c:662
>  vfs_get_tree+0x90/0x2a0 fs/super.c:1780
>  do_new_mount+0x2be/0xb40 fs/namespace.c:3352
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe09a07e66a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe09adffef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fe09adfff80 RCX: 00007fe09a07e66a
> RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007fe09adfff40
> RBP: 0000000020005d80 R08: 00007fe09adfff80 R09: 0000000000000018
> R10: 0000000000000018 R11: 0000000000000202 R12: 0000000020005dc0
> R13: 00007fe09adfff40 R14: 0000000000005dab R15: 0000000020005e00
>  </TASK>
> ---[ end trace ]---
> 
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
#syz fix: bcachefs: Fix array-index-out-of-bounds

