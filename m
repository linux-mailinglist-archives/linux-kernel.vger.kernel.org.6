Return-Path: <linux-kernel+bounces-275465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A4948611
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF2B22384
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E75176233;
	Mon,  5 Aug 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPCDXwNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4316F0CE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=jPOYrF07uZ9GT1SS6A4nHeo1xYtMYf4yc3qExhGBFFAwuslCjPjPxh0T0zhtlpspL8QI0FLHFQMHiJMoNU0ISoRdgSThRUM3CXfAge2yIVvn9zUOjjwhaI1OGnw5eLiCiGBlug7t5HXf/nFahvjfkFIvduNQs58AIWsidgzdklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=7GzAc4yLKdaVMivmKdQlEXCBG8tMPkeo9h1szBEqHWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uS1uP5akxqGfJWT7AFS/bqMrxNKz11EXb9PgJmvMOruewpqE0fVvRO7FnrjORf/c4i91uRN+obew4oJA7bsShu8UVp6pFl8+xsRwMt25zUluks1k3TPq6Ogjsztuj/aIOYs49Imj8raN9j6fTCMqfofMLtsakLkPtm/bVzTu4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPCDXwNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 059C2C4AF1A;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=7GzAc4yLKdaVMivmKdQlEXCBG8tMPkeo9h1szBEqHWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BPCDXwNQxqFO1HhY3m5wos9DjHcQVnIzwUgAO1Vbx6Y5vqcSD/oYFVXAt4crYEHB3
	 0iSFEXebaF3KH4K/Wr5MSJnqsO3Jon9lXEqYJ+lqZ3qCdKvJ4Ux5UlQmbRR9NV5Zio
	 YJ9TjJMXhKlB1nlCI2tXGmMJsQUJ64ChmYoF47L32T/K6d6iwBT9Nue4OcKKhxGBm5
	 2LIrLENKyt8HxdjTYoDk8/uLBuZpEPGt+e8PkpLLOkPMuppuc6Rny0KS4a3n1X5MPT
	 HBAcg4LDvF41Gbg9VO/3+HVqfWsyscox+scLauJZ4mEuCSkIfIKD9ldb2FkI4xMUU9
	 GbYTKtdCGUxug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFA5DC433E9;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_get_node_page when write inline
 data
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065197.2803.6155410196213496459.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
In-Reply-To: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, bintian.wang@honor.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 1 Apr 2024 13:48:20 +0000 you wrote:
> From: Zijie Wang <wangzijie1@honor.com>
> Date: Mon, 1 Apr 2024 21:24:08 +0800
> Subject: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline data
> 
> We just need inode page when write inline data, use
> f2fs_get_node_page() to get it instead of using dnode_of_data,
> which can eliminate unnecessary struct use.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_get_node_page when write inline data
    https://git.kernel.org/jaegeuk/f2fs/c/aac0828ab000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



