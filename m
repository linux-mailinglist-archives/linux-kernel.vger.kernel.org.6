Return-Path: <linux-kernel+bounces-309458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251F966ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF4283878
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654E1C0DC3;
	Fri, 30 Aug 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6KkzIwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01A1BE259
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051099; cv=none; b=OTRLShnwLdzT6jZyJn3XPUci8D65AyPw3Z1JNznOnsIJjLVzhiLfBn8X/sS7/Sz2roxM+RJx2WlDFn9e/e5R4DhjBevgbEC9jddip+50YxO8jMpBNR0rOBgJiGj1bEndBYxT/CRtXcpuQOlCo9X1QOW0Z0y97oWagLgg9g0+S/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051099; c=relaxed/simple;
	bh=vPxzIksKckelCZPO/lJH6gBkLGJDcZWljmfpGuIjjHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awoKOZ88mYWjj0qYgD2sbVAnACaIU+x2NPnms2va5RotJb6PNccHhK1TWNjJigR2J2EXERQ5hUJDcKUj1KXFY/woavA1RsHCu34X7gXbQpX9+AdmSDuv5xTushiN6+JmOrCLK0r0qz48rLr5FOwkNMKsS4oNYVmXdJtq905EC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6KkzIwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA35C4CEC2;
	Fri, 30 Aug 2024 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051099;
	bh=vPxzIksKckelCZPO/lJH6gBkLGJDcZWljmfpGuIjjHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K6KkzIwL6Ctr+iwW67Ua7xntF7iTQbEe8PUNj4KRZoHr79dfDNW8PNblFz9gx9mRa
	 A1YP0uECJJ6qXSxkQi1/HWOckUxl31lQdat8psmtTqGoIOV0zmhHDk5oOTgePXPOGb
	 X7Ey2AyltmA3LbauPooP+YqhNCHBe8k0CksFrLQJL/Qu3dhejSui4eTCdszan00Bs2
	 4aplR37mv17nzeta88KjVyggrD6TbUL+C3vlLgVftYe5ShT8fw8kZUizB1ZY9lB7zk
	 kXPSmcCbMgQjcW4VGBQYNEcYxtP52Hb+qYybBgNJkhSYiVXVmhPq5f3MSnU4qNlu5J
	 uNEgjpAzE0MZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED13809A80;
	Fri, 30 Aug 2024 20:51:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/9] f2fs: convert f2fs_compress_ctx_add_page()
 to use folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505109977.2712133.16285332779262349295.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:39 +0000
References: <20240813141331.417067-1-chao@kernel.org>
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Aug 2024 22:13:23 +0800 you wrote:
> onvert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/9] f2fs: convert f2fs_compress_ctx_add_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/2cbbc4f94317
  - [f2fs-dev,2/9] f2fs: convert f2fs_vm_page_mkwrite() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/8ed263450530
  - [f2fs-dev,3/9] f2fs: convert f2fs_clear_page_cache_dirty_tag() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/71aa6bbfc247
  - [f2fs-dev,4/9] f2fs: convert f2fs_write_inline_data() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/333ad04822f5
  - [f2fs-dev,5/9] f2fs: convert f2fs_write_single_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/65826f2732fa
  - [f2fs-dev,6/9] f2fs: convert f2fs_do_write_meta_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/9f9bbd634792
  - [f2fs-dev,7/9] f2fs: convert __f2fs_write_meta_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/1b9eb6539810
  - [f2fs-dev,8/9] f2fs: convert f2fs_read_multi_pages() to use folio
    (no matching commit)
  - [f2fs-dev,9/9] f2fs: convert f2fs_handle_page_eio() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/6d899d7e3999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



