Return-Path: <linux-kernel+bounces-385496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842579B37EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD631F22922
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CF1E048B;
	Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBui1R7Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9111DFE3A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137228; cv=none; b=AOHdAOdHCwIGwu9puZw6q04pM0Q9VGYFf/YXs7wl8NQ0/zSeyB7OVt/dfDGNfFKPfoUMXXJtt8MHkFp6ForSQ8FFSS8uBn9pliYX5PWXynv6nV9cE2RJQ4bVa89u1ocn3+fK87eoNPbJnrSzt6AMZOCBN/UM637Zj3dHB2W9PJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137228; c=relaxed/simple;
	bh=pzjuA7a0UBgxrDJfx4P5HZ7OtYa+qi3cJ01PrrZVlPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qv/txjxI/4YOnezMZzGXh49aS5feZqgeRL2ZDoIex//vzWeHDf2yS5dZtkRx0tAk4YMa9FMLoIU0L7HJgCvKj3RJWMrzPQOAgzensLRLlotx0Fnd69eURzYe7nmnBgJoFT9lYvul/ZpCb5UW+9WjjCNe0AZ+6ksZNyDIKSvDlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBui1R7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089AAC4CEC3;
	Mon, 28 Oct 2024 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137228;
	bh=pzjuA7a0UBgxrDJfx4P5HZ7OtYa+qi3cJ01PrrZVlPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WBui1R7ZabXIBWVC0PUz7rAOYiu3kiZtiXDzPJYbXNpXDnCivfLg8dD4NW8DcL7j8
	 wiUYkPklhWFjLvI6B9BPgMDkmfDyFy1q95KsI8Rzu8jNKkD+lxmAPk2Beyy1z1BFs9
	 ++q3xzPPOpzrK9vxgl8thsVIFNa/ml638EjgGw0WWUoyGN4Jc43djvliZwggdF3K6H
	 icNw7tDi9Co1xm9Zzc6XY2ids7qRmJbKgFAMdbGc9AYvTsfuN/q4sWJ1Lg2WXS6mGJ
	 GHEARKZ8Xpp5Hkv3zdt5A+Yx7Y1p6WS/CEXqYfy8MH5b6rKSb9uJfMWfTuQ8g+Kr6M
	 dFypaxERJW3wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EEB380AC1C;
	Mon, 28 Oct 2024 17:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RESEND PATCH] f2fs: Use struct_size() to improve
 f2fs_acl_clone()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013723523.126843.1225973042359349619.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:35 +0000
References: <20241028112058.3346-2-thorsten.blum@linux.dev>
In-Reply-To: <20241028112058.3346-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 28 Oct 2024 12:20:58 +0100 you wrote:
> Use struct_size() to calculate the number of bytes to allocate for a
> cloned acl.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/f2fs/acl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,RESEND] f2fs: Use struct_size() to improve f2fs_acl_clone()
    https://git.kernel.org/jaegeuk/f2fs/c/527a4ded09b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



