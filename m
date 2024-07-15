Return-Path: <linux-kernel+bounces-252700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A548E931706
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E01F1F21FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6418F2E8;
	Mon, 15 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrnhEkTN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5D18EFED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=grZ2bLin5ITLxa75OcRsX7eSPQzEdc2Lv9KUN8PMSTeueqfZE6GlCIlNylUoDfxWQNTWPsSDHv1jwuFDmoGxAQYeOmj/unT+NobqL70OpfKk2KzdtXC0IVJ+K2XtGZe0Czwn/NU9W1FbU0sjEkEcb0C0uhkopolJpw8FJGQoagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=D7KLOLWbUbbroj6+z4K7TzPFfauIf/C6xHVDOk3MrHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jf7pzVTHqQsoUTRmWqDhjiIlhPZFDNe6EjvacjdpEaCxKb+FqOcmTuYmFDKk1rcPsn3DFERZ4ULT5FFgiu3KySOQaNhoCnz7kmAnND4jIIxH6ojfig+d65hdfdHLitSbi8xOx63zk1xjMqNyst8LNdmIE3n1L+Ozs46JUkao6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrnhEkTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB04C4AF0A;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054432;
	bh=D7KLOLWbUbbroj6+z4K7TzPFfauIf/C6xHVDOk3MrHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NrnhEkTNXzaAnGctM4AI/f2A8k+GiZS+G6qg9V3ba77TgQXn21WmO88m1u2mQXukN
	 RQCrNajaCYYLa5JG1aNCwURSL/JE5bVKjXDl0xj9E8YSgULaoDbeXALclhru5QOICQ
	 BDitDC/f+9OLFnh+WH9U8H9+L025CI+W0wI415xH/xC/yelkDdVRTPSdHfdUyDf0Ye
	 PmgMzDLwFVeKa+qjtq9nclqFTIwt6kf8OetpKBeLz4+pLpRXykHG/SoM/uIzxnHDqN
	 j430u1VR0qpI07o1B57UsgCJc7RYSrYRy+3L8sobjq8d38+hXc6sUNqmr0EqCxh5Bb
	 BTuNudWH6d5gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD90C43443;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to update user block counts in
 block_operations()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443231.17443.11007255777614226894.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240625023239.3534605-1-chao@kernel.org>
In-Reply-To: <20240625023239.3534605-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 25 Jun 2024 10:32:39 +0800 you wrote:
> Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
> allows write() to write data to page cache during checkpoint, so block
> count fields like .total_valid_block_count, .alloc_valid_block_count
> and .rf_node_block_count may encounter race condition as below:
> 
> CP				Thread A
> - write_checkpoint
>  - block_operations
>   - f2fs_down_write(&sbi->node_change)
>   - __prepare_cp_block
>   : ckpt->valid_block_count = .total_valid_block_count
>   - f2fs_up_write(&sbi->node_change)
> 				- write
> 				 - f2fs_preallocate_blocks
> 				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
> 				   - f2fs_map_lock
> 				    - f2fs_down_read(&sbi->node_change)
> 				   - f2fs_reserve_new_blocks
> 				    - inc_valid_block_count
> 				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
> 				    : sbi->total_valid_block_count += count
> 				    - f2fs_up_read(&sbi->node_change)
>  - do_checkpoint
>  : sbi->last_valid_block_count = sbi->total_valid_block_count
>  : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
>  : percpu_counter_set(&sbi->rf_node_block_count, 0)
> 				- fsync
> 				 - need_do_checkpoint
> 				  - f2fs_space_for_roll_forward
> 				  : alloc_valid_block_count was reset to zero,
> 				    so, it may missed last data during checkpoint
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to update user block counts in block_operations()
    https://git.kernel.org/jaegeuk/f2fs/c/f06c0f82e38b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



