Return-Path: <linux-kernel+bounces-275457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4428948601
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A436D2835D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D916F91D;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4YTc9sW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47815383D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=HE4bxkei3obtlliakLfv2cA7UQ1MbrFYf0fDrC3IXBAZ/v2fIBfrXHFxQ1JwA5xIiaxyJS1Oj6u9cZfdlwNe96aI5fkBlkChH958hzAslFKfLeleTaW1M13YtfNdxL79dcDkWk6pBLGcZwRrjeBkE93gGdWY9mLefbOiRy4XOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=X7ausYPDDFnL539kbYS2qwmsnC8TcaLxcrV/4ugzBLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GcGrXsxe/oxUy267qwS2d5Ah4Pw51jAgi7zGY2+RWW62HJr3Ab/yG72SA1HY42L95sN9kT2oIXlGELwRLY3mETxHjz5tDjSwkJE4kNagt4R+IGHfIWhE5qi/GZ0kgeHU6RCcGUABco/VKVZm7u+ecnskX+G5YzTa4Zw9BjCv4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4YTc9sW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE35C4AF0F;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900651;
	bh=X7ausYPDDFnL539kbYS2qwmsnC8TcaLxcrV/4ugzBLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O4YTc9sWjimtkICsL+mDWcgVSigSYVDD1C5Pn0COjmh7EraFGynstCs8goqdosuop
	 AJ8xLiCvrZTEanpO/C4oen2UDpGR/b8TqbXS3SdzIKqBo+iQ4+I/5RbGoZEZs9W0/5
	 oUkLntNV3CEUMzrUpw9IUe9X1WajbQD6TeDzEac2JoQrjg4u0wOT9NQ8X8qS8GjiRg
	 OYS7HZK0TGzDmzhPZjP8NjxDjyDNAEw8cTLo/3yckqSQwzHCbX3NGECfBcVyC/oUuN
	 PkWpd4eAV+2+9rZnK/2mb9bzsYLjB7mRi9BY7FMF5plRZKbszLFuhmBSqeDkOCVhhV
	 drXi3ojhRmfeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF486D20AA6;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: atomic: fix to avoid racing w/ GC
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065184.2803.16077457643424916047.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240625031351.3586955-1-chao@kernel.org>
In-Reply-To: <20240625031351.3586955-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 25 Jun 2024 11:13:48 +0800 you wrote:
> Case #1:
> SQLite App		GC Thread		Kworker		Shrinker
> - f2fs_ioc_start_atomic_write
> 
> - f2fs_ioc_commit_atomic_write
>  - f2fs_commit_atomic_write
>   - filemap_write_and_wait_range
>   : write atomic_file's data to cow_inode
> 								echo 3 > drop_caches
> 								to drop atomic_file's
> 								cache.
> 			- f2fs_gc
> 			 - gc_data_segment
> 			  - move_data_page
> 			   - set_page_dirty
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: atomic: fix to avoid racing w/ GC
    https://git.kernel.org/jaegeuk/f2fs/c/1a0bd289a5db
  - [f2fs-dev,2/4] f2fs: atomic: fix to not allow GC to pollute atomic_file
    https://git.kernel.org/jaegeuk/f2fs/c/7566a155c666
  - [f2fs-dev,3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
    (no matching commit)
  - [f2fs-dev,4/4] f2fs: atomic: fix to forbid dio in atomic_file
    https://git.kernel.org/jaegeuk/f2fs/c/374a8881ce4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



