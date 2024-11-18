Return-Path: <linux-kernel+bounces-412803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1309D0F97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69251B2DBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A360219644B;
	Mon, 18 Nov 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vAkuQX38";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6cnkTgw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vAkuQX38";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6cnkTgw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199B14F102
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927856; cv=none; b=StLSlHlC0v310Bte5W6bYD3daJnPl6DzW4gCSD155LAMPpQkWgczL7PCxJVmSx7nz++xw9coyQDViofsxJ9LOGVZiqzxjp3jqxk5XgSgpy2TLZdjKe+jARfTikBZAG3ONMZNEwqIS3UuHlp7jkxRhVrMKUtzgf4e4F8l/DnWsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927856; c=relaxed/simple;
	bh=kJX4JKyXAHptOn5Lf1bVJ9Lkx6/ywgEdImQjJlhWq28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBagIEaI+QJShUGQQoSXTKl8wmhp2ULY2n2nBnJtfoeS5WC1W8OByTDz5yf60b9dD+KUpj1INVB8A7q2UDalyJMLlropcvkybsgw3wv+95r3pEwpciPgKgDdnv505cArP3FYsvR0FyNSypn/+1UVpRJJYjTUpe/8Mq6jdNL16lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vAkuQX38; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6cnkTgw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vAkuQX38; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6cnkTgw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 624271F365;
	Mon, 18 Nov 2024 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731927852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vCH4fT25UAM+LK3vGgiSrmNPx5b+seiHu6tJYQO25c=;
	b=vAkuQX38+MlQdorYrWrdn2UXx0IFRo06D9A78Pgp8OaFevLxHGeEynz8UlFJ/ZsFpCio6D
	P5UfTFWCHPooAWvOvlqrdzCHNjPgLpeG/WXaXtInvlRdOyTGRFCAIcaQO6u9sfjL/GiA1C
	AzEUZEkXKVfFhWNBqGozcwtu03eZ0Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731927852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vCH4fT25UAM+LK3vGgiSrmNPx5b+seiHu6tJYQO25c=;
	b=x6cnkTgw6kd6/Wst4wRNijvIG9lVF11kndfq7U1w2977VjXnkyWaSyZJhv2giOS9oj2/u8
	YNxpaSW5KF6JO2BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731927852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vCH4fT25UAM+LK3vGgiSrmNPx5b+seiHu6tJYQO25c=;
	b=vAkuQX38+MlQdorYrWrdn2UXx0IFRo06D9A78Pgp8OaFevLxHGeEynz8UlFJ/ZsFpCio6D
	P5UfTFWCHPooAWvOvlqrdzCHNjPgLpeG/WXaXtInvlRdOyTGRFCAIcaQO6u9sfjL/GiA1C
	AzEUZEkXKVfFhWNBqGozcwtu03eZ0Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731927852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vCH4fT25UAM+LK3vGgiSrmNPx5b+seiHu6tJYQO25c=;
	b=x6cnkTgw6kd6/Wst4wRNijvIG9lVF11kndfq7U1w2977VjXnkyWaSyZJhv2giOS9oj2/u8
	YNxpaSW5KF6JO2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4517B1376E;
	Mon, 18 Nov 2024 11:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAmWECwfO2dpOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 11:04:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEAC9A0984; Mon, 18 Nov 2024 12:04:11 +0100 (CET)
Date: Mon, 18 Nov 2024 12:04:11 +0100
From: Jan Kara <jack@suse.cz>
To: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
Cc: "jack@suse.com" <jack@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net
Subject: Re: KASAN: wild-memory-access in dqput.part.0
Message-ID: <20241118110411.adggbvad6ncocbhr@quack3>
References: <3A6D2300-7787-4C96-8509-B8D5907B9135@psu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A6D2300-7787-4C96-8509-B8D5907B9135@psu.edu>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello!

On Mon 18-11-24 04:32:38, Bai, Shuangpeng wrote:
> Our tool found a new kernel bug KASAN: wild-memory-access in
> dqput.part.0. Please see the details below.
> 
> Kernel commit: v6.12 (upstream)
> Kernel config: attachment
> C/Syz reproducer: attachment
> 
> [  341.442215][T17431] ==================================================================
> [341.444194][T17431] BUG: KASAN: wild-memory-access in dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [  341.448056][T17431] Read of size 4 at addr 006d03ff00000150 by task a.out/17431

This is a call to atomic_read(&dquot->dq_count) inside dqput(). And the
address 006d03ff00000150 shows that dqput() has just been called with bogus
pointer. Which means that jfs2_evict_inode() calls dquot_drop() likely with
uninitialized i_dquot array. Shaggy, can you have a look?

								Honza

> [  341.449702][T17431]
> [  341.450245][T17431] CPU: 1 UID: 0 PID: 17431 Comm: a.out Not tainted 6.12.0 #8
> [  341.451865][T17431] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  341.453827][T17431] Call Trace:
> [  341.454559][T17431]  <TASK>
> [341.455199][T17431] dump_stack_lvl (lib/dump_stack.c:123)
> [341.457411][T17431] ? dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.458459][T17431] kasan_report (mm/kasan/report.c:603)
> [341.459399][T17431] ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:737)
> [341.460465][T17431] ? dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.461472][T17431] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> [341.462560][T17431] dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.463548][T17431] __dquot_drop (fs/quota/dquot.c:422 fs/quota/dquot.c:1607)
> [341.464548][T17431] ? __pfx___dquot_drop (fs/quota/dquot.c:1595)
> [341.465592][T17431] ? mark_held_locks (kernel/locking/lockdep.c:4321)
> [341.466683][T17431] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [341.467852][T17431] dquot_drop (fs/quota/dquot.c:1633)
> [341.468844][T17431] jfs_evict_inode (./include/linux/list.h:373 fs/jfs/inode.c:169)
> [341.469841][T17431] ? __pfx_jfs_evict_inode (fs/jfs/inode.c:140)
> [341.471018][T17431] evict (fs/inode.c:730)
> [341.471878][T17431] ? __pfx_evict (fs/inode.c:701)
> [341.472844][T17431] ? evict_inodes (fs/inode.c:828)
> [341.473850][T17431] ? __pfx_lock_release (kernel/locking/lockdep.c:5833)
> [341.474965][T17431] dispose_list (fs/inode.c:775)
> [341.475931][T17431] evict_inodes (fs/inode.c:789)
> [341.476929][T17431] ? __pfx_evict_inodes (fs/inode.c:789)
> [341.478083][T17431] ? sync_blockdev (block/bdev.c:220)
> [341.480239][T17431] generic_shutdown_super (fs/super.c:633)
> [341.481352][T17431] kill_block_super (fs/super.c:1711)
> [341.482294][T17431] deactivate_locked_super (fs/super.c:475)
> [341.483433][T17431] deactivate_super (fs/super.c:508)
> [341.484415][T17431] cleanup_mnt (fs/namespace.c:250 fs/namespace.c:1374)
> [341.485400][T17431] task_work_run (kernel/task_work.c:241 (discriminator 1))
> [341.486378][T17431] ? __pfx_task_work_run (kernel/task_work.c:207)
> [341.487470][T17431] ? __put_net (net/core/net_namespace.c:675)
> [341.488455][T17431] do_exit (kernel/exit.c:940)
> [341.489372][T17431] ? __pfx_lock_release (kernel/locking/lockdep.c:5833)
> [341.490389][T17431] ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:107 ./include/linux/atomic/atomic-arch-fallback.h:2170 ./include/linux/atomic/atomic-instrumented.h:1302 ./include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
> [341.491477][T17431] ? __pfx_do_exit (kernel/exit.c:878)
> [341.492477][T17431] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [341.493553][T17431] do_group_exit (kernel/exit.c:1069)
> [341.494577][T17431] __x64_sys_exit_group (kernel/exit.c:1097)
> [341.495730][T17431] x64_sys_call (./arch/x86/include/generated/asm/syscalls_64.h:61)
> [341.496761][T17431] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [341.497753][T17431] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  341.499093][T17431] RIP: 0033:0x7fb31b2de146
> [ 341.500054][T17431] Code: Unable to access opcode bytes at 0x7fb31b2de11c.
> 
> Code starting with the faulting instruction
> ===========================================
> [  341.501546][T17431] RSP: 002b:00007ffc5afbf7b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> [  341.503383][T17431] RAX: ffffffffffffffda RBX: 00007fb31b3e38a0 RCX: 00007fb31b2de146
> [  341.505155][T17431] RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
> [  341.506907][T17431] RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffff80
> [  341.508600][T17431] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fb31b3e38a0
> [  341.510320][T17431] R13: 0000000000000001 R14: 00007fb31b3ec2e8 R15: 0000000000000000
> [  341.512053][T17431]  </TASK>
> [  341.512753][T17431] ==================================================================
> [  341.514883][T17431] Kernel panic - not syncing: KASAN: panic_on_warn set ...
> [  341.516508][T17431] CPU: 1 UID: 0 PID: 17431 Comm: a.out Not tainted 6.12.0 #8
> [  341.518075][T17431] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  341.520110][T17431] Call Trace:
> [  341.520841][T17431]  <TASK>
> [341.521478][T17431] dump_stack_lvl (lib/dump_stack.c:124 (discriminator 7))
> [341.522380][T17431] panic (kernel/panic.c:354)
> [341.523136][T17431] ? mark_held_locks (kernel/locking/lockdep.c:4321)
> [341.524057][T17431] ? __pfx_panic (kernel/panic.c:288)
> [341.525001][T17431] ? irqentry_exit (kernel/entry/common.c:358)
> [341.526063][T17431] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4468)
> [341.527213][T17431] ? check_panic_on_warn (kernel/panic.c:242)
> [341.528379][T17431] check_panic_on_warn (kernel/panic.c:243)
> [341.529413][T17431] end_report (mm/kasan/report.c:226)
> [341.530412][T17431] ? dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.531436][T17431] kasan_report (./arch/x86/include/asm/smap.h:56 mm/kasan/report.c:606)
> [341.532391][T17431] ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:737)
> [341.533429][T17431] ? dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.534496][T17431] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> [341.535592][T17431] dqput.part.0 (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 fs/quota/dquot.c:867)
> [341.536598][T17431] __dquot_drop (fs/quota/dquot.c:422 fs/quota/dquot.c:1607)
> [341.537612][T17431] ? __pfx___dquot_drop (fs/quota/dquot.c:1595)
> [341.538756][T17431] ? mark_held_locks (kernel/locking/lockdep.c:4321)
> [341.539798][T17431] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [341.540960][T17431] dquot_drop (fs/quota/dquot.c:1633)
> [341.541927][T17431] jfs_evict_inode (./include/linux/list.h:373 fs/jfs/inode.c:169)
> [341.542976][T17431] ? __pfx_jfs_evict_inode (fs/jfs/inode.c:140)
> [341.544121][T17431] evict (fs/inode.c:730)
> [341.544961][T17431] ? __pfx_evict (fs/inode.c:701)
> [341.545974][T17431] ? evict_inodes (fs/inode.c:828)
> [341.547059][T17431] ? __pfx_lock_release (kernel/locking/lockdep.c:5833)
> [341.548146][T17431] dispose_list (fs/inode.c:775)
> [341.549081][T17431] evict_inodes (fs/inode.c:789)
> [341.550043][T17431] ? __pfx_evict_inodes (fs/inode.c:789)
> [341.551081][T17431] ? sync_blockdev (block/bdev.c:220)
> [341.552101][T17431] generic_shutdown_super (fs/super.c:633)
> [341.553173][T17431] kill_block_super (fs/super.c:1711)
> [341.554216][T17431] deactivate_locked_super (fs/super.c:475)
> [341.555353][T17431] deactivate_super (fs/super.c:508)
> [341.556360][T17431] cleanup_mnt (fs/namespace.c:250 fs/namespace.c:1374)
> [341.557394][T17431] task_work_run (kernel/task_work.c:241 (discriminator 1))
> [341.558438][T17431] ? __pfx_task_work_run (kernel/task_work.c:207)
> [341.559595][T17431] ? __put_net (net/core/net_namespace.c:675)
> [341.560526][T17431] do_exit (kernel/exit.c:940)
> [341.561426][T17431] ? __pfx_lock_release (kernel/locking/lockdep.c:5833)
> [341.562555][T17431] ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:107 ./include/linux/atomic/atomic-arch-fallback.h:2170 ./include/linux/atomic/atomic-instrumented.h:1302 ./include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
> [341.563642][T17431] ? __pfx_do_exit (kernel/exit.c:878)
> [341.564688][T17431] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [341.565796][T17431] do_group_exit (kernel/exit.c:1069)
> [341.566798][T17431] __x64_sys_exit_group (kernel/exit.c:1097)
> [341.567988][T17431] x64_sys_call (./arch/x86/include/generated/asm/syscalls_64.h:61)
> [341.569005][T17431] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [341.569991][T17431] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  341.571281][T17431] RIP: 0033:0x7fb31b2de146
> [ 341.572302][T17431] Code: Unable to access opcode bytes at 0x7fb31b2de11c.
> 
> Code starting with the faulting instruction
> ===========================================
> [  341.573763][T17431] RSP: 002b:00007ffc5afbf7b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> [  341.575510][T17431] RAX: ffffffffffffffda RBX: 00007fb31b3e38a0 RCX: 00007fb31b2de146
> [  341.577279][T17431] RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
> [  341.578979][T17431] RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffff80
> [  341.580726][T17431] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fb31b3e38a0
> [  341.582427][T17431] R13: 0000000000000001 R14: 00007fb31b3ec2e8 R15: 0000000000000000
> [  341.584109][T17431]  </TASK>
> [  341.584889][T17431] Kernel Offset: disabled
> [  341.585801][T17431] Rebooting in 86400 seconds..
> 
> 
> Best,
> Shuangpeng
> 
> 



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

