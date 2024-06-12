Return-Path: <linux-kernel+bounces-211829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57F90578F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96D528C205
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB8181B87;
	Wed, 12 Jun 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFJWoRfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E3180A77
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=a8ecCOMLxFsaGVC8cEfjmCg79IkGagJUyGEuJWDFxqJqIJOp1P+X4L8GkV1ivkqomJVV8y0PJFlIUyHD6WPkhvOnMeD/CLK1Pk3klAynSXZ37eO0Ma47XJaaAU1SzDeeBevP/Ph7qmZNuo0viTRSMdKy2uR7cOw/9x18fSHB6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=InqFS4sAhFS4WS5r2v86I1PxxzLrtej/dKx5aTUSI7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tMhh/OhyLNnAo6RrVZ9/PTn2pOjoOyZ/8Xw/DtnhY11GxspS84BDY6h4tmjW63Sc4jyUCf6DemQKihC2kgcaJteFShcEEHNj3EfhJEa7wdPZqQXEQ4rAwphZ/LZiD4/FMwKbkM0G5DhCkopy2gw1tBMFYmUKK42SmMJGte+1UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFJWoRfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F693C4AF48;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=InqFS4sAhFS4WS5r2v86I1PxxzLrtej/dKx5aTUSI7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFJWoRfekMfMC6zwSUbqWD52MqaKb2xn1cp3YFaIcDLXIf3dfm79BsBvq2f78C2W7
	 5eIrd8bRlh7nC1ceKvNSt+m2R+Tx1zweMWfPvlSMcJO5T5Nyc7BmKzzOgRhT4IYhOP
	 FVir2jWKu6YikbRhghh6d4Wl3+V4LOtaeJ0W23e8fi3/glAfJlwwZW5uAHC2ChUqD9
	 ftc3PYUeZ2sH0Z1s5wECTqoUarvE2sjw+BH3E2ivq25GMSYP/0MBZCUxW3O0nFBDXB
	 0wGRIze9QWU0qQJr6mOXZ6gyC1J3BoQsJoMmLvKHX9EDHhUl/SyThEZTjfWyij4emm
	 sGf+TChXjLP3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15C6EC43619;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to do sanity check on
 F2FS_INLINE_DATA flag in inode during GC
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775708.32393.13954078092151830814.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240521062318.976239-1-chao@kernel.org>
In-Reply-To: <20240521062318.976239-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 May 2024 14:23:17 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inline.c:258!
> CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
> Call Trace:
>  f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
>  f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
>  f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
>  do_writepages+0x35b/0x870 mm/page-writeback.c:2612
>  __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
>  writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
>  wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
>  wb_do_writeback fs/fs-writeback.c:2264 [inline]
>  wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f2/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
    https://git.kernel.org/jaegeuk/f2fs/c/fc01008c92f4
  - [f2fs-dev,2/2] f2fs: fix to do sanity check on blocks for inline_data inode
    https://git.kernel.org/jaegeuk/f2fs/c/c240c87bcd44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



