Return-Path: <linux-kernel+bounces-360000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B99999366
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7216D2834B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF61D04B9;
	Thu, 10 Oct 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amNPfYSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C91CEAD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591028; cv=none; b=chsvm49GyzxE9zJYbLZ8oACWrhYaEzAe0g92ALBDx8TD0x8ve8JLsnjnmsrCCtmBnSnMGSP243EwEnFQ2N6T/Roz5W8xohql4a/pCkZAs6VKFTSp5k0uhp/GTX+XjTqRxvoAYlfK+0vLCPuLd6BalaQ17tbEVD09Ykz+58ICe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591028; c=relaxed/simple;
	bh=BSsw+Y7OCGA/ex7b4VjgtD8Mj7ponFqGdm1B/6PluOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STAF7icoygnMbN7DMuZBXBz/8h3FWDvtAM98WgEbmwkoOVa9rNCyeguAWfof5R8rPRo4/DBjqzeHY6lni+RYtbruxh4TIbX4mZXMb7PsI58dGvhk/cXZ9Eo72DkIqOJoxoLvxnoy5whQaWZEg/KfaA8qWkrFZSrXrdH6A0MWyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amNPfYSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E2C4CECC;
	Thu, 10 Oct 2024 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591027;
	bh=BSsw+Y7OCGA/ex7b4VjgtD8Mj7ponFqGdm1B/6PluOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=amNPfYSHH/H53KPD3Uewa6He4jRlEirCJxFEDoJLPcVOcDL8lt8PZyP2ZiG4aE6C8
	 5slTYrC3pXTca8AykH0lVGYjB+YpN7DkuTibj+wGrA30BaDvgl0q23+p2sbvR64DSP
	 1mR3RHmTlRIgzbsRlEfwjAkvYEvpsvI88rkf8gXanYMGdpWBM2DEfbjXEt/W9mRxh6
	 uAbSl8AGgE9lTMo30/wqdv96nKIZIXIS7twmx+6rD7aZ5rmqvXmwioVkLLfcIZ4KRx
	 wNBIPjk7JLTSiCS7MSJiLWEWsKwjoMHeii/KCJvNaGFU+kmfQ8QaMCnX2xFZSgiETV
	 IA0g3Q/U8gI3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6F3803263;
	Thu, 10 Oct 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow parallel DIO reads
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172859103175.2156650.13652147260460527526.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 20:10:31 +0000
References: <20241010000923.1278817-1-jaegeuk@kernel.org>
In-Reply-To: <20241010000923.1278817-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Oct 2024 00:09:23 +0000 you wrote:
> This fixes a regression which prevents parallel DIO reads.
> 
> Fixes: 0cac51185e65 ("f2fs: fix to avoid racing in between read and OPU dio write")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allow parallel DIO reads
    https://git.kernel.org/jaegeuk/f2fs/c/bdab38b79199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



