Return-Path: <linux-kernel+bounces-331128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69697A8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A461F268E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24115176FD3;
	Mon, 16 Sep 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tobJscG3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806561714C9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522237; cv=none; b=SzMCXCiK+rP1UKTQpmyvRbxPe9eFvGR+uJ5ua1sSZ06+ghDDt1CEF45j9mNzj0lKzfVTs7K8tlgS1TIQRmVrIFeIqSz+juUhoxYrRjijwiQeBRreMLx707kIYC1CJucY55dJgCxlxF0QFiUhRo+4+SLvNTuFBPBWPqe65IuxtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522237; c=relaxed/simple;
	bh=DA/pGYkMc6X5k091k31gZIzgOwklfjJsQjPwiEsd4/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZeprs3Ge7n3wa8LwofQuQIkEktkMFX8bkpbgeln4lMiAC87+dCo+wfaDx2we9er6kXYVjnX0f2ZiaKiIvki/Cp8lavVp188iKHjl2Xor+MaEHQQIIvxYUZ7jpigr5MGfH7Yz9j3o/B0MV90gOyKPYUEHhu+aUu2rBnALyIM+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tobJscG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E42DC4CEC4;
	Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522237;
	bh=DA/pGYkMc6X5k091k31gZIzgOwklfjJsQjPwiEsd4/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tobJscG3wXitGqhxu+Nj01wjVddRJRRXzwrOpjDO/iKKsVlu8nfAB5hMpVhtAvllN
	 n7fYQsRfO8crdbxxenB2RzTMWFDqjuoP/hJnZDbQ0EUmrONuF2Otad2R6nf/7REZp2
	 Yvd5WVE8ZyFByUDkB03ySDvevUZT8whGnvHEtgr8I7/28YWcmEWqvuenzCSqJioIae
	 32//jaDlbyJlJns2ARtjs70W5zCNYPSiW6kCpWj0szRi2szO3g38fVpob61+/2vpTM
	 a2BqpbCChiE/5olkjX26MxIM5zfBH/awJnpY9hiPG84wyz6D6yPP6xcHrOodGjTeBc
	 KXryEi/FtVqFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE73806644;
	Mon, 16 Sep 2024 21:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: get rid of online repaire on corrupted
 directory
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223875.3820990.5151598286635393871.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:38 +0000
References: <20240906062724.3569496-1-chao@kernel.org>
In-Reply-To: <20240906062724.3569496-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  6 Sep 2024 14:27:24 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> kernel BUG at fs/f2fs/inode.c:896!
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> Call Trace:
>  evict+0x532/0x950 fs/inode.c:704
>  dispose_list fs/inode.c:747 [inline]
>  evict_inodes+0x5f9/0x690 fs/inode.c:797
>  generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>  kill_block_super+0x44/0x90 fs/super.c:1696
>  kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>  ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>  syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>  syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: get rid of online repaire on corrupted directory
    https://git.kernel.org/jaegeuk/f2fs/c/884ee6dc85b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



