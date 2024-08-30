Return-Path: <linux-kernel+bounces-309465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0138966AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB37283F10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C21C233D;
	Fri, 30 Aug 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+F6Hfxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F331C2335
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051110; cv=none; b=hekrtAsJ0+Dv2Gm7Nm2o0oNIdx4b9rjrzFEm2xxPaIy1VdQ+HLx+cHxl/XzLSXuSktay56ymN7+HYxhcmdZJi1CVRSIJaap6s9HQ2d3LWR+omCRMTBTVSEZVFFzkGPqIIErWKwkUJquATuzFG3SIVcMYX5Z3doezuKfiVwTRSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051110; c=relaxed/simple;
	bh=4Vmdu72nUVTxQXYckq6IBwekLTpwl0AskvoZbUnNnSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F6Ftn4kGHGOTlfZ6KvNDsiSXfzjV22UFWxwF8aIVqtGYedal84jdN5bb8Vpae7JGMeZ94F+OsWKw5JRMhqu5pQvjOpfhA+keiWpR27/gpsCyWgp8/ZmAQMAuOylz5+FztEcyfBFJfC+J5aTZVXLz0ZRO1PBp78SiSbwqsnfCi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+F6Hfxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203DC4CEC6;
	Fri, 30 Aug 2024 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051109;
	bh=4Vmdu72nUVTxQXYckq6IBwekLTpwl0AskvoZbUnNnSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+F6HfxgLbI227YOSEmxQMOjwOpFCRPRInLD49dQSWL6hZ+K7XqZlOcaPj/Zikci4
	 KAu9I2ttKDZfb5PyX0v9O+E/JusyiZHjgvXPdeHwo3iZjvYZFFNA4OD+539WKYWti6
	 4sB0Dcyymf2//GWZnXqZD/aVu/Wr6ThkbzmvrYRixvqmY/afDE9WmYKTreW3nW9gi4
	 74HqcjK6hn627tObMjdL6wURtkymqggtbGkckSKAPI3yHHpKSTnclcb/31Qdz1Ch7Y
	 F7mcE7tU3qfNq4ZBdv/QE9pE61mkrxrqy2CyBn8KJr25LtT6WaDAnpmihNhGl1ObJm
	 dyZbpS04YWEpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9D3809A80;
	Fri, 30 Aug 2024 20:51:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to wait page writeback before setting
 gcing flag
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505111000.2712133.17949895219038625887.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:50 +0000
References: <20240812141242.4159033-1-chao@kernel.org>
In-Reply-To: <20240812141242.4159033-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Aug 2024 22:12:42 +0800 you wrote:
> Soft IRQ				Thread
> - f2fs_write_end_io
> 					- f2fs_defragment_range
> 					 - set_page_private_gcing
>  - type = WB_DATA_TYPE(page, false);
>  : assign type w/ F2FS_WB_CP_DATA
>  due to page_private_gcing() is true
>   - dec_page_count() w/ wrong type
>   - end_page_writeback()
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to wait page writeback before setting gcing flag
    https://git.kernel.org/jaegeuk/f2fs/c/a4d7f2b3238f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



