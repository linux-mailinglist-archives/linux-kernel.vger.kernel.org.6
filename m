Return-Path: <linux-kernel+bounces-309469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7C966AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9943C1F21096
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5FA1C3F22;
	Fri, 30 Aug 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL9Ib4Bx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC11C3F0F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051116; cv=none; b=uGQJ6lBS2wk5fv3lvfludzv9jeoq1R8kbboac0CYT6Ag6d8bI9kTPmfC6cXQR47oGjhGmK0horZuqQK895vRcjECGNSdm5W34xdq2S8fMt6KtbSsoBOFI9hyCb4hc7chIxsraKeQr10O9E6EfUgUaYu6ZOZPwSokLSpfTulewGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051116; c=relaxed/simple;
	bh=seyHgsgjSd2j/gVtth38oABy1nAbTglTqEUNZWZsVL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OaO+4d4QpUBBTqhlzPlo9HAxL9B0uN7zc3vEIDALhfDVML/J6jEI8fdLiNGEer5yMalY19KCiPKxg+vNsaNZqxGTulSRPXtWwim42XzBamQPjLgGMdcqzkciUI2DDClUWxp53vxFWqyNHA3XaHmXlV85/6YEELdFB2WQlNYGz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL9Ib4Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F36C4CEC2;
	Fri, 30 Aug 2024 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051115;
	bh=seyHgsgjSd2j/gVtth38oABy1nAbTglTqEUNZWZsVL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tL9Ib4BxiAq8ybgzttePFesimvwxSl6hh1bs65fyTVOOiPSGnSd8Q7hmVbGX+FRVi
	 PzjAIsJFbJwQ3A6QxoU/LeKO0sO/ZxYwG/ObgvpOKg6YA2TB89g+/XQYmB3mGvpNo0
	 SlEqw8C2+bbNjpgCfYk+6rZFbB0w3zmiX8Kko40rkrFgIretrgsyHv1RHCllXMuAm+
	 sFc9rwVH6QqRbJBs7I3CvEOi89ITiH0XB/kNB94GdJWI6TzQutHP/DnRaetuSxMj+G
	 Zq+Lmz/XfJDiFvov1QHi/KJAfeXMYUo5grSzEM9IavrQKQuRBsFI1u+WFX+FpfktYn
	 a+t0bvPpxk9dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2D3809A80;
	Fri, 30 Aug 2024 20:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Create COW inode from parent dentry for
 atomic write
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505111601.2712133.11182331571148597127.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:56 +0000
References: <20240813073244.9052-1-youngjin.gil@samsung.com>
In-Reply-To: <20240813073244.9052-1-youngjin.gil@samsung.com>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 sj1557.seo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Aug 2024 16:32:44 +0900 you wrote:
> The i_pino in f2fs_inode_info has the previous parent's i_ino when inode
> was renamed, which may cause f2fs_ioc_start_atomic_write to fail.
> If file_wrong_pino is true and i_nlink is 1, then to find a valid pino,
> we should refer to the dentry from inode.
> 
> To resolve this issue, let's get parent inode using parent dentry
> directly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Create COW inode from parent dentry for atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/8c1b787938fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



