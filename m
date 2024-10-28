Return-Path: <linux-kernel+bounces-385495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A19B37ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665A51F22762
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD041E00B1;
	Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOCmnBVf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C51DFE34
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137228; cv=none; b=e4pu45O6vaM45Me/03dhsl7OgpAps1eY7RkND/KC9ZTvXjP6O8vGFqIG1vcxzEuaLnY/LxCfnJUhMVmH6eNNEUfV+CBa0seSRW3FktF7So6h5M63l9jAbvuEHBSURPyEZkKs1nkQAFd0c6Z0SbnwKmp2PuK9DXzU4RyEfLFXKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137228; c=relaxed/simple;
	bh=t790CU2G2j/NEXrCiMu4H/h7Ti3SE9Z+3VZODIkCWOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgUYJOAa3OqCX6O0EJPdmCtawfTzn2JlnIejkObRDmtJlPb5zouNixJAzfJ3PeypOqh45jGeA3N6v8Dm8/SAZeaQeIXBpewWKzTeFzezaW9+Hzg7Uo32tsMAlZ21neYSqfEWPxUc49Zy9mVsBx26CSIBnk7cOH8lk8gCPzD6jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOCmnBVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF4C4AF11;
	Mon, 28 Oct 2024 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137226;
	bh=t790CU2G2j/NEXrCiMu4H/h7Ti3SE9Z+3VZODIkCWOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MOCmnBVf4Ujd4vpMssLLwsgl1TtO/x0DV/NioiMQ7r9FtHFaGCIrR9nSewCLA/oNC
	 F0fNUj50pG6kDyv2mVdUihlKWaSP278AWT9wH+BDUUjTnBtE7DH8cHrdtrbEhw4lYm
	 fjj9E/gM7X52gDu2gWf3+lUV6eYlkxvOr9AfihUKz8qBw6S0wSl5mKG9UwvxuACRvd
	 6JlqUN4vLHfdBaSf4A0zBWtePWZkN9+W7qe+IS8SAzUtCvyjeCITFVO+/1dLuxrGtI
	 LPEUJtoRTMU69aVa1gzwFSIriF4xYMgWKKy40lBVrYpHAfxLZ3krrhlH9kBAKSf6Q/
	 hjzL5UpnjWhNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFC380AC1C;
	Mon, 28 Oct 2024 17:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Use struct_size() helper to improve
 f2fs_acl_clone()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013723403.126843.13404518317398636551.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:34 +0000
References: <20240924102800.240209-2-thorsten.blum@linux.dev>
In-Reply-To: <20240924102800.240209-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 24 Sep 2024 12:28:01 +0200 you wrote:
> Use struct_size() to calculate the number of bytes to allocate for a
> cloned acl.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/f2fs/acl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: Use struct_size() helper to improve f2fs_acl_clone()
    https://git.kernel.org/jaegeuk/f2fs/c/527a4ded09b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



