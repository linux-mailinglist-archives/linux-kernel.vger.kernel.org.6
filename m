Return-Path: <linux-kernel+bounces-360091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2480C99945B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C807A1F24439
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D61E2830;
	Thu, 10 Oct 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dVe3CECt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2379D2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595436; cv=none; b=t6EuP2CykfFVQeh9WZ7lCTrdQwoYH9Bmy8suCShE8v/KqvNBllU1jZEn+zPsh3G9bSBDTih8m84hC/25YHi3/ppDeo3iPcDwZ84zGWZwZb/qHi6R1WXM4PxyoJoSO+0amxGWVhlyIT+OWl9cMH9t2LJ42K/gb4o31XkyjXedmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595436; c=relaxed/simple;
	bh=l9tL2ZVcfqeduP5gfOeRiPTFjYuhBWTaGrja2zdDbWE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PLUVDuQqErc1IVhVsF71YBxTvylwWb0nTfxFivK9KponjNP9ovt5ydYfuZv4DZfdc7TcDtQ2SYEunXUl4+gcqg0qweC80yZvIIOH5x/EIRi5QiBrxVeQ/A4SK+yROel25asZeX3ZC1T5W2NccqXFk9R5gksj9oQvIbt4iOf4Q9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dVe3CECt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFC0C4CEC5;
	Thu, 10 Oct 2024 21:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728595436;
	bh=l9tL2ZVcfqeduP5gfOeRiPTFjYuhBWTaGrja2zdDbWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dVe3CECtBMCtgno1ZnXV4LCwMgXEd+vcNk/CkHl4xjK/0p08Sp2qtYM3IE2mJsCBX
	 Jv0qjX0MwCkFYFLoHLPl57RSQUrdr0McWDph565kfLNLSNuv/YAgoPYhnstyi7nlYP
	 Oc6/kfZCYyu+v0fFEDKccyFZTOWQlTuRFefa31K0=
Date: Thu, 10 Oct 2024 14:23:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in swap_writepage
Message-Id: <20241010142355.92225576a955836a67ef746a@linux-foundation.org>
In-Reply-To: <670793eb.050a0220.8109b.0003.GAE@google.com>
References: <670793eb.050a0220.8109b.0003.GAE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 01:44:27 -0700 syzbot <syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cdfd27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
> dashboard link: https://syzkaller.appspot.com/bug?extid=febb2473441bfb8fb380
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5b4b9aca7b75/disk-fc20a3e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b22e17636ec0/vmlinux-fc20a3e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5266e625be99/bzImage-fc20a3e5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com

Thanks.  I'm guessing that shmem symlinks aren't initializing the whole
page (folio) and that has tripped up Usama's "store zero pages to be
swapped out in a bitmap" feature - it's checking the uninitialized part
of the page for zeroness.


> =====================================================
> BUG: KMSAN: uninit-value in is_folio_zero_filled mm/page_io.c:189 [inline]
> BUG: KMSAN: uninit-value in swap_writepage+0x536/0x12b0 mm/page_io.c:259
>  is_folio_zero_filled mm/page_io.c:189 [inline]
>  swap_writepage+0x536/0x12b0 mm/page_io.c:259
>  shmem_writepage+0x2117/0x2450 mm/shmem.c:1567
>  pageout mm/vmscan.c:688 [inline]
>  shrink_folio_list+0x5e78/0x7dd0 mm/vmscan.c:1366
>  evict_folios+0x9813/0xbaf0 mm/vmscan.c:4583
>  try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4778
>  shrink_one+0x646/0xd20 mm/vmscan.c:4816
>  shrink_many mm/vmscan.c:4879 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4957 [inline] 
>  shrink_node+0x451a/0x50f0 mm/vmscan.c:5937
>  kswapd_shrink_node mm/vmscan.c:6765 [inline]
>  balance_pgdat mm/vmscan.c:6957 [inline]
>  kswapd+0x25e2/0x42f0 mm/vmscan.c:7226
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Uninit was created at:
>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
>  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
>  folio_alloc_mpol_noprof+0x55/0x180 mm/mempolicy.c:2283
>  shmem_alloc_folio mm/shmem.c:1774 [inline]
>  shmem_alloc_and_add_folio+0xc33/0x1c30 mm/shmem.c:1813
>  shmem_get_folio_gfp+0xacd/0x1f30 mm/shmem.c:2335
>  shmem_get_folio mm/shmem.c:2441 [inline]
>  shmem_symlink+0x528/0xa20 mm/shmem.c:3834
>  vfs_symlink+0x1ed/0x460 fs/namei.c:4615
>  do_symlinkat+0x257/0x8a0 fs/namei.c:4641
>  __do_sys_symlink fs/namei.c:4662 [inline]
>  __se_sys_symlink fs/namei.c:4660 [inline]
>  __x64_sys_symlink+0xe0/0x140 fs/namei.c:4660
>  x64_sys_call+0x30e8/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:89
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 UID: 0 PID: 80 Comm: kswapd0 Tainted: G        W          6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> =====================================================
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

