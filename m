Return-Path: <linux-kernel+bounces-212022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537C905A28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78A5B22CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221C1822CA;
	Wed, 12 Jun 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cpQKbVBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3C1CD38
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214457; cv=none; b=BJhAmyHCETDwU4pENZXjWY+nDvq/g9FHO9xiV98rbwgZ3G/etT4kmAuRoLzAcqscKCujDTIWXRGad2c5LxmD67Ljjo5YhJ25EjZ6waAFhZDdSuTPVw2a4giFt5GkBxINI5hUJuMK9PKTvbygha+2JXxaT3wDfJjNILJguQCLQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214457; c=relaxed/simple;
	bh=TAmpk28DOHQlh76vj68wZqyZ2em5S70V/tuKcrqTIJ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=huxmnHpwfPglDbjEXGOKmI8wE++hN8kZewZp7+nJF5Jp90CQnpetL3E9t+2Bt25E4gqy1KnvsT1ADHCBveidu2/lHl3obWbGYz+NZZ1JSDM2dVuMkWc4qMw5e1aLEfsdAAFm/aXy3rDWb2QpVf04BSK2exnaZdpDomwCp+3wrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cpQKbVBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138FC32786;
	Wed, 12 Jun 2024 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718214456;
	bh=TAmpk28DOHQlh76vj68wZqyZ2em5S70V/tuKcrqTIJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cpQKbVBnd+SeSjoJk5LlbpDqCHPsBMITWW4owW+EqGYHPdxGfpvvSM1h4RtTcQShV
	 P+9436E1EDMEEuv9RN+Kudi/mMB7DF/bRjiHB3fgfgfKIWhCWD1WK0q/23gZrGFj5v
	 VwfMLBHzuKuoOflv7AULxkhjALUqRD78xJKv3Qkg=
Date: Wed, 12 Jun 2024 10:47:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com, Peter Xu
 <peterx@redhat.com>
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
Message-Id: <20240612104735.ee6405d2096236bf18c51a41@linux-foundation.org>
In-Reply-To: <000000000000b7b11a061ab49122@google.com>
References: <000000000000b7b11a061ab49122@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 10:18:21 -0700 syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=146b3d96980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
>
> ...
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 page_table_check_pte_flags mm/page_table_check.c:198 [inline]
> WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211

	if (pte_present(pte) && pte_uffd_wp(pte))
		WARN_ON_ONCE(pte_write(pte));

Let me optimistically cc Peter ;)

> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc2-syzkaller-g8867bbd4a056 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : page_table_check_pte_flags mm/page_table_check.c:198 [inline]
> pc : __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
> lr : page_table_check_pte_flags mm/page_table_check.c:198 [inline]
> lr : __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
> sp : ffff800093d57520
> x29: ffff800093d575a0 x28: ffff7000127aaec8 x27: dfff800000000000
> x26: 0000000000000001 x25: bfeffffffffffff3 x24: 1ffff000127aaea8
> x23: 0408000000000000 x22: 0000000000000001 x21: ffff0000d38131b8
> x20: ffff800093d57540 x19: 0408000000000000 x18: ffff800093d57300
> x17: 00000000000074be x16: ffff800080b0d2d4 x15: ffff7000127aaeb0
> x14: 1ffff000127aaeb0 x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff80008eb6e78c x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000c1968000 x7 : ffff80008096b550 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000001
> x2 : bfeffffffffffff3 x1 : 0408000000000000 x0 : 0408000000000000
> Call trace:
>  page_table_check_pte_flags mm/page_table_check.c:198 [inline]
>  __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
>  page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
>  __set_ptes arch/arm64/include/asm/pgtable.h:404 [inline]
>  set_ptes arch/arm64/include/asm/pgtable.h:1586 [inline]
>  pte_clear_tests+0x510/0x538 mm/debug_vm_pgtable.c:640
>  debug_vm_pgtable+0x268/0x590 mm/debug_vm_pgtable.c:1392
>  do_one_initcall+0x254/0x9e4 init/main.c:1267
>  do_initcall_level+0x154/0x214 init/main.c:1329
>  do_initcalls+0x58/0xac init/main.c:1345
>  do_basic_setup+0x8c/0xa0 init/main.c:1364
>  kernel_init_freeable+0x324/0x478 init/main.c:1578
>  kernel_init+0x24/0x2a0 init/main.c:1467
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> irq event stamp: 1342246
> hardirqs last  enabled at (1342245): [<ffff8000809ba500>] seqcount_lockdep_reader_access+0x6c/0xd4 include/linux/seqlock.h:74
> hardirqs last disabled at (1342246): [<ffff80008af10a10>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
> softirqs last  enabled at (1342178): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
> softirqs last  enabled at (1342178): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
> softirqs last disabled at (1341257): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> page_owner is disabled
> Key type .fscrypt registered
> Key type fscrypt-provisioning registered
> kAFS: Red Hat AFS client v0.1 registering.
> Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
> Key type big_key registered
> Key type encrypted registered
> ima: No TPM chip found, activating TPM-bypass!
> Loading compiled-in module X.509 certificates
> Loaded X.509 cert 'Build time autogenerated kernel key: 79e1c0a63a233d95d926db3e542dc8d9e342ab6b'
> ima: Allocated hash algorithm: sha256
> ima: No architecture policies found
> evm: Initialising EVM extended attributes:
> evm: security.selinux (disabled)
> evm: security.SMACK64
> evm: security.SMACK64EXEC
> evm: security.SMACK64TRANSMUTE
> evm: security.SMACK64MMAP
> evm: security.apparmor (disabled)
> evm: security.ima
> evm: security.capability
> evm: HMAC attrs: 0x1
> printk: legacy console [netcon0] enabled
> netconsole: network logging started
> gtp: GTP module loaded (pdp ctx size 128 bytes)
> rdma_rxe: loaded
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> clk: Disabling unused clocks
> PM: genpd: Disabling unused power domains
> ALSA device list:
>   #0: Dummy 1
>   #1: Loopback 1
>   #2: Virtual MIDI Card 1
> md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
> EXT4-fs (nvme0n1p2): mounted filesystem 126e38a5-b482-40da-8f06-bd78886e02c1 ro with ordered data mode. Quota mode: none.
> VFS: Mounted root (ext4 filesystem) readonly on device 259:2.
> devtmpfs: mounted
> Freeing unused kernel memory: 4416K
> Run /sbin/init as init process
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
> #syz fix: exact-commit-title
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

