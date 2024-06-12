Return-Path: <linux-kernel+bounces-211834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50179057B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AEB1C22A01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2FB1836DC;
	Wed, 12 Jun 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5vQvJyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40718130D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=SP2DV2L981+dTbkF2anasNR71UaOxHtgNn1+d0cvKV5HsIDnXKEj0ukfWg1pT8zoPxlG1wAaEtAUnOsH+ZgjBqm6Qe+qMDngGh/un/i0/ZVMh5uXszJMj34N45wSLQr2YRuLHWXQmbCjS9e+3nLvVUSCEWydFT4M+N23XjeruAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=fg5ngAXBtHfUv26u+nwajvrTqbRSPs+zZsIgoe3iwR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cg9sLyD7Syy/aJ0SGkjd53SJF2EHG/a3p9wUPqRuxNHroHSnaKBVgwK6hx0GFGZS6YQzhmFaZqmOVYS/11YDkN67Ct2j5F2k52XZEtLeqnwbM6u7VWrker2IbAHBPg7TIV8GK3LR+6PA93D0cgAuRj7Si0uqQ8Fm1fmRqE1z3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5vQvJyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C10C4AF53;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=fg5ngAXBtHfUv26u+nwajvrTqbRSPs+zZsIgoe3iwR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5vQvJyBzqctuLwDDYj7pCJYgiBbRwzVJcRl1mJqImEXx8OrPBo9Qci53mSM+AGNc
	 VTOTT9pQgIpE6xq1DqkQJ7qNyOt80lWHsKpUiYQjWNiHjaOKBIFLPJe79nlzhS/eK/
	 oVElTBCjj2eopBOXvAjglDJY7w5VLhbBtpdWaNCH57UzNcvA5DLJXmg9vMxsm1Qqnt
	 RmXU4N/H00oygZ8VMl7Heo+zZBiY/VC/JS7X3IAhxbpEk91lfiIJpMTdiQsifvyJeY
	 R+05ZCk6JAKqDNYqcFmqiLfM0AN+2zdle0/sqyzSBsZCJa9MvmWdNUow2TYxC3rGjj
	 o6Jh+01D6JqoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35CA6C43638;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to cover read extent cache access
 with lock
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775721.32393.16229302976932686990.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240531020032.1019991-1-chao@kernel.org>
In-Reply-To: <20240531020032.1019991-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 31 May 2024 10:00:32 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> BUG: KASAN: slab-use-after-free in sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
> Read of size 4 at addr ffff8880739ab220 by task syz-executor200/5097
> 
> CPU: 0 PID: 5097 Comm: syz-executor200 Not tainted 6.9.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
>  do_read_inode fs/f2fs/inode.c:509 [inline]
>  f2fs_iget+0x33e1/0x46e0 fs/f2fs/inode.c:560
>  f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
>  generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
>  exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
>  exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
>  do_handle_to_path fs/fhandle.c:155 [inline]
>  handle_to_path fs/fhandle.c:210 [inline]
>  do_handle_open+0x495/0x650 fs/fhandle.c:226
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to cover read extent cache access with lock
    https://git.kernel.org/jaegeuk/f2fs/c/d7409b05a64f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



