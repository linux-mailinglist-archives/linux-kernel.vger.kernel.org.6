Return-Path: <linux-kernel+bounces-176341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC108C2E35
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB751C2132D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27772446AE;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnHBiKIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF0125C0
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=d15L5Q5VJNao4f+lLJpSABuGsrYZz87gtHZ4jRzvqk9yjE8fxt2MdlMlCbAyo1ZbCf0pxhUFpp9S0fM1H6Nn/w8yZfWkztIQHAxQsROc+t0H4hZLpuN/0M6p86ukLVCn+xz9R8wvAYAlrpX/ajMDJy95pXoRlXSLKGk1VritKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=BAOZth3SU5C4Yq4fzloslWpuCb5bnkV+Xuow5ptNvfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HENGn2Ckod33yay6DBjrdMANqZgWkS1yHt9XVpccpfXfzLWon40IlhrTWIklbj6AH8PaejXMkV+1S+7NbEhsJQfQ/wqvWzU16NP0PEdMAxwwQKGb78vzEK6sC4VQlFdywk4A84XuDLVzxV1vZZ85YGeIaJ82Hkzi5C8+ccZ0ANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnHBiKIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE1AC4AF0A;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=BAOZth3SU5C4Yq4fzloslWpuCb5bnkV+Xuow5ptNvfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UnHBiKIcNQrduUaq4FqQqop2hd+dUmvJD98PB/VHAf1LIe4GOKLfZ9w0WIM1No08B
	 gntPOwQo761cVRQOGX2uUaaa2X63QXnJqh/1Oog6Z3DDb2+qqY8t7gJLsatdlzK3Bv
	 IIk/hgXZQ1FvbG7LEUX1I95fepYUzJDiPP4HBxiJ+cD6UIn5BTB+ygQrJ/NWCBbA7F
	 VsqiUPqeeMtRBBe39YFKpZ5XAS+jjFvnX+cYrmndWzaFgJS7p/n5MazieUsn4+2LsL
	 I9TV53CXaV0RWpafig3C5tRgIf9DuzEJ7nl9AR52HhYH6WaR5hwWJLOEjPwExZdiKo
	 nT1FYUKY0WH5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE94CC54BA4;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863390.11229.16051294251093639392.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240510034333.358653-1-chao@kernel.org>
In-Reply-To: <20240510034333.358653-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 May 2024 11:43:33 +0800 you wrote:
> During gc_data_segment(), if inode state is abnormal, it missed to call
> iput(), fix it.
> 
> Fixes: b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid inode")
> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,2/3] f2fs: fix to add missing iput() in gc_data_segment()
    https://git.kernel.org/jaegeuk/f2fs/c/a798ff17cd2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



