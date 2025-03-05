Return-Path: <linux-kernel+bounces-547085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24EA502D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DCE3B44A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFF24EF75;
	Wed,  5 Mar 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+gzu8k1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B0250BE9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186198; cv=none; b=Lt1zqojtYajGFlV76GFQkBaHATY2CBQ/45BEB4qqtxWRA93kb2SalrGgq7a5XP4Cg7+trRHg82/CAivL4L19CseaQrWV7znjRCNBhoXPXzC7doboo2G4YXv24JRiJ+rYMEz4MwWfMySWHhffB6rz4GoCPGMczUbnDRqNdj6wtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186198; c=relaxed/simple;
	bh=9xEXhLrBR5atNK+lZw0zgbyBegFoX8kfwxdSVNfyf5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SX4Ke+rnxmbO6/xdaccQeQjsGwIyo/4ALQCjWzXpc7d8+61dz0aL4a34P/sMICUQp68h9q5ODOuCkEJOy9cnXKIhJ8Yn9JxMTVCTjEQKghzE8GN0LKMBat+FUlwoT+z2QojDfOIj0dGN0yuWFDZLqksLnmGO9KyVVKigUOb9Lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+gzu8k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC6C4AF09;
	Wed,  5 Mar 2025 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186197;
	bh=9xEXhLrBR5atNK+lZw0zgbyBegFoX8kfwxdSVNfyf5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P+gzu8k1f5u3myFSIBSNXqozxdXNAQN18iCv0XmC+hXV1yce05voilvCcXnfbMxEH
	 0VKWAWsOCvwgu7df3xt6HmOvnUd8A0CFGG95uSBS8vsOFm3CtA+1jdlzr9LmAXctGw
	 w4iObZIxSaIkF79dFQ/RQrTvJpa7CCdbe+xZ7REgfvvuX3dJCwYnv0Qoq8uUVZ0Fp5
	 FdLI0Jr3HWcGs65siLM3u+RxncHyK187oPNShalB9d9eVedbFVCsKJu0LZZG7OYS9X
	 yk+k9a4dDMAdxF9O8XPNH/r3CJ1qMTRiPV73duFHUEEI8sxFW0+5K281rPGZqtlTS/
	 EKgH1AvN6ciKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB232380CEDD;
	Wed,  5 Mar 2025 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: set highest IO priority for checkpoint
 thread
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174118623075.908551.2988977620651257899.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 14:50:30 +0000
References: <20250303221730.1284822-1-jaegeuk@kernel.org>
In-Reply-To: <20250303221730.1284822-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 22:17:30 +0000 you wrote:
> The checkpoint is the top priority thread which can stop all the filesystem
> operations. Let's make it RT priority.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: set highest IO priority for checkpoint thread
    https://git.kernel.org/jaegeuk/f2fs/c/8a2d9f00d502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



