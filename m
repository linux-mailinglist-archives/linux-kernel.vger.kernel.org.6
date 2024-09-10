Return-Path: <linux-kernel+bounces-322707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3733972C97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6471F25821
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAD186294;
	Tue, 10 Sep 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPE/xcd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46517183091
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958485; cv=none; b=oeR1WXKbzhFdEk8xmfgge8y8/yv/vPrrj6Di2Luu0ZAGi4MAQX+DmzHq8gpM8mM+I7+0EarzSr/n2EQupxqfMLIjh/8f6xoTCMxVletJrDtVGsC99GdwcOdKat0T7mc/YkALNbXJcr3eMzQzGrmXjHLNkfe1V5lHkobhpWXea9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958485; c=relaxed/simple;
	bh=6Y1ViSleBUCDmdGKI23JhY0or54xyLwoDFqx1mz5S+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1yOpcC3hayDcWo6XTn4nweE3zz8vWIK66fBOwh9CYn04DyC5f5krWZbIWn02OU1M4xMXo8b301yQhbtJwLXc9G3LavVAUUyuG7oHRljOB0ZiTRF7KdBu4fm1uDSTut2rAU7ArNIT8cOxpD8KNmcbFJPqWslVuZbZiKTE3OqxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPE/xcd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A11C4CEC3;
	Tue, 10 Sep 2024 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958485;
	bh=6Y1ViSleBUCDmdGKI23JhY0or54xyLwoDFqx1mz5S+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPE/xcd52nZflCF2jO4lmSx99c0hLRO9PG/dCIRa0M0hPqM4D7SAm7s/DNbef+kDZ
	 p/M1r/eq1TpryWfWaqYvZ9ie5pZjOLSd5Aip5PJem/pHM7oTnd75csisAPVbGJEQ+D
	 YX2bTzKtH2yb17YfXnf15O7RyJZignkGCDcRXUGooRAjt3ou2WIUlxzEDVV46awUAc
	 cLIYBY5cSc00053ZYwWyqOvCywPZE6e9j/ltnVXs11O9Aty3DNTk2OrxC11TlAvw5S
	 e9X8XtBGKSAyLAF4/1BaYlWq0rfeeikag3kyjWtvcNh8mny4prqwRcW+vnVTSQuJb8
	 PgsN+qmZCvUyw==
Date: Tue, 10 Sep 2024 10:54:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] f2fs: fix to don't set SB_RDONLY in
 f2fs_handle_critical_error()
Message-ID: <20240910-lesesaal-missfallen-adb9485d67e7@brauner>
References: <20240910030713.3716318-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910030713.3716318-1-chao@kernel.org>

On Tue, Sep 10, 2024 at 11:07:13AM GMT, Chao Yu wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
> Workqueue: events destroy_super_work
> RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> Call Trace:
>  percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
>  destroy_super_work+0xec/0x130 fs/super.c:282
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> As Christian Brauner pointed out [1]: the root cause is f2fs sets
> SB_RDONLY flag in internal function, rather than setting the flag
> covered w/ sb->s_umount semaphore via remount procedure, then below
> race condition causes this bug:
> 
> - freeze_super()
>  - sb_wait_write(sb, SB_FREEZE_WRITE)
>  - sb_wait_write(sb, SB_FREEZE_PAGEFAULT)
>  - sb_wait_write(sb, SB_FREEZE_FS)
> 					- f2fs_handle_critical_error
> 					 - sb->s_flags |= SB_RDONLY
> - thaw_super
>  - thaw_super_locked
>   - sb_rdonly() is true, so it skips
>     sb_freeze_unlock(sb, SB_FREEZE_FS)
>   - deactivate_locked_super
> 
> Since f2fs has almost the same logic as ext4 [2] when handling critical
> error in filesystem if it mounts w/ errors=remount-ro option:
> - set CP_ERROR_FLAG flag which indicates filesystem is stopped
> - record errors to superblock
> - set SB_RDONLY falg
> Once we set CP_ERROR_FLAG flag, all writable interfaces can detect the
> flag and stop any further updates on filesystem. So, it is safe to not
> set SB_RDONLY flag, let's remove the logic and keep in line w/ ext4 [3].
> 
> [1] https://lore.kernel.org/all/20240729-himbeeren-funknetz-96e62f9c7aee@brauner
> [2] https://lore.kernel.org/all/20240729132721.hxih6ehigadqf7wx@quack3
> [3] https://lore.kernel.org/linux-ext4/20240805201241.27286-1-jack@suse.cz
> 
> Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
> Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com/
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

