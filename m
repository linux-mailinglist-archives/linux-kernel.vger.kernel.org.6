Return-Path: <linux-kernel+bounces-275468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D105F94860E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE9283D35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F9D176237;
	Mon,  5 Aug 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJWr89W3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5316F274
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=MFE/8pKPHsik6cQilpgAJlxM6DeBiixxFkOmNtaE8hEOGdLPVxL2cvKDQ/IY+FAMFapwhfNGJW9RSOY55eFW9WhWmQz6+zdrvoW1w7WaJtrBgOA42j36upvvHGXzsLBrTSr4u+2g8MWQgvhfU/08dooloiODPdtBObQCRz9iByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=ICHRUR5jiG7pkCFf4zi9Dn+hNtalIy1AkC9PonW3yrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SW678rVtkuxvANH5icoEYl0dfR6iZoYum+sljvJrknv+u7S9zrcNfQq+kuRTHy3h32EX3I4dDigqislAxDIV5kG5Ca5qslLQW5WCkv2ouFGUNZoo/B5Zvc7/UmFEHWItSVWzBPLQfc1Ko4utyqhKHkQNi79sXN5I/LZFB+iYzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJWr89W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3979BC4AF63;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=ICHRUR5jiG7pkCFf4zi9Dn+hNtalIy1AkC9PonW3yrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJWr89W30EGdyju1Xw6btrY/GdBXaBVx2ADqkutNDxAc2LGGtqthqA4wuqDfyzDeq
	 9uH2cxwbkoSwTmFpDxK2TRYGt8j22cmoIkdyY8gpW6EquqOKHZ8P7m7FhIpqgLynyx
	 SYe1HzaJXBBOnHx14qtGC9X69S4Q9PEOi0ekEYeZHx1e1ymkQbwI7RPHQf+y4k5pgE
	 B1FyEimiJv1q+A5OIUZZWimEBQ4KR3R5Miuq19eeHBTfx9aB1BkpNL0LATuc/NRCbx
	 uFxXCan0wCkCQaFpTouzSP/yR67nbg+G5L/Pcmyoh4uenBz6yYyqtCIw5rCvyZYd0n
	 7HNt5pePKrLCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31262C43140;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: get rid of buffer_head use
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065219.2803.34268911020752099.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240618072620.720535-1-chao@kernel.org>
In-Reply-To: <20240618072620.720535-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Jun 2024 15:26:20 +0800 you wrote:
> Convert to use folio and related functionality.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> - support large folio
> - use bd_mapping instead of bd_inode->i_mapping
>  fs/f2fs/data.c  |  1 -
>  fs/f2fs/f2fs.h  | 11 +++++-
>  fs/f2fs/file.c  |  1 -
>  fs/f2fs/inode.c |  1 -
>  fs/f2fs/super.c | 93 +++++++++++++++++++++++++++++--------------------
>  5 files changed, 66 insertions(+), 41 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: get rid of buffer_head use
    https://git.kernel.org/jaegeuk/f2fs/c/8ce36b8b1150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



