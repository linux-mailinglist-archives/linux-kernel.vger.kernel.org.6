Return-Path: <linux-kernel+bounces-309459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556D966AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6B11F23608
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842A1C172C;
	Fri, 30 Aug 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lATOTwPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0941C0DF5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051101; cv=none; b=GGOMqF7v2sEGBQenrjqDC0fIkfTLwCmo5wpO+B8CMVJTdbNolnwxT3bGAQ7RsQ3o95zK667ug3BoE3twYlmRpuULRG78UkFvCzBmZtqVNediMJ2COVAmEXDey9jn+P0wABlrjBxCKITPtsVWm2b42AIN4+Zt4CzujtYDYeLZBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051101; c=relaxed/simple;
	bh=uTw2PivCAVhqwWwRcS6aU3xqvVMUcLj7zapdKiG/t8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OUv0Bw+GErMbZWXEDuYCjSc43siB/EN31q2XEeYXwYFgdFJkRDbDaTGUEgiWsJL91c3ABPe6I1Plouuw/npQwlwJB3yHBLSUBtCYqhMjneUDjgwCs/xaBW31qVXoJZHi0hXeXfUlbcFRH61G8//yFNdzYdKfSc+gsV/zJIeUlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lATOTwPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E70C4CEC6;
	Fri, 30 Aug 2024 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051100;
	bh=uTw2PivCAVhqwWwRcS6aU3xqvVMUcLj7zapdKiG/t8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lATOTwPar158c+Lu0wZzU7V0jxsiVr/Rd0EiBeiqT5hlTvt/LzMEr6K1sXZKitOLW
	 0a/2+4LYsuGRS9kRfY4g1Hw0SVxBlQ506ob3QEW86MBgwfrrmhcBBYfm5KugsX/Yez
	 3GKZTgVQ1IVZfSYtgkkQgQrvDK+HoN6S1z0sCmhrMnmR9wZI1AQTsyv71FkreaBUnb
	 SWBgdVjxZLAdHtj0L9kJcEfuj74nvDdVv5gPr3ShhdEi0X1I7w4M1KtFkCofQidrun
	 a8YJm2s2LlljShgnhGCLs1FMe67VBZLP55OuZGmh26imsCmkjbd2Aex8+Ws+EGjToE
	 exBO1ikz7ndzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712823809A80;
	Fri, 30 Aug 2024 20:51:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to use
 folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110100.2712133.9120573138658027084.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:41 +0000
References: <20240820034654.698236-1-chao@kernel.org>
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 20 Aug 2024 11:46:47 +0800 you wrote:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/8] f2fs: convert f2fs_write_begin() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/f13c7184e62e
  - [f2fs-dev,v2,2/8] f2fs: convert f2fs_write_end() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/357dd8479f8b
  - [f2fs-dev,v2,3/8] f2fs: convert f2fs_set_compressed_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/4713b14f107a
  - [f2fs-dev,v2,4/8] f2fs: convert f2fs_do_write_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/609c7375350a
  - [f2fs-dev,v2,5/8] f2fs: convert f2fs_write_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/75428dcd4d2e
  - [f2fs-dev,v2,6/8] f2fs: convert __write_node_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/62b691af1a66
  - [f2fs-dev,v2,7/8] f2fs: convert read_node_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/e381d92a035a
  - [f2fs-dev,v2,8/8] f2fs: get rid of page->index
    https://git.kernel.org/jaegeuk/f2fs/c/c6f1758f7a68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



