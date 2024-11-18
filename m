Return-Path: <linux-kernel+bounces-413265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C04A9D16A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B07B21AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245921C1F19;
	Mon, 18 Nov 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSZ5uyug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB51C1F08
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949230; cv=none; b=sanQzmHCq2O6ZPoVJvrudAwLacvLmhtyAVEOtOV24noqg6tw2sQEV7+k8/KK4kY5sOWUeLWE60l50KwtKpXMzCeeJmmuOKNZaY07uyFkWcpLCt0WZf6xE8JNJCL0fEDx3jNkPsSJRA2TgpqAdmDQEPcpzCFK5VLa8zpKAIVng60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949230; c=relaxed/simple;
	bh=qLWBUrU30pw/zPIYWpjpJqcg5yzpEUiM4v1tVieKRcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ktT/I9RFG6UuyTe8GFlNV/ARrG5lq4AZoRUxKt5xUzbn4YzGZYVH295L6PkvMy8rC3n4YTqcGiEwQxjiMe6sH2WeoyElg+6v5bwopeEabIpbQap0IyUdwCCdInwFsgfZeAUnbQwrqAhopidQNbwiLgrqA0nr0ClCUWe4VckPaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSZ5uyug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64930C4CECC;
	Mon, 18 Nov 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949230;
	bh=qLWBUrU30pw/zPIYWpjpJqcg5yzpEUiM4v1tVieKRcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tSZ5uyugusioRTS05iGs6lYpGWJ7be8GhhfPuvCNe1PQJyKl991NyGnoUQLwsQ56Q
	 83oE+qob73r7zD/qGstBLDv0gdUClDYfv4/PkMT8T6LLJ9fjY5dHeGQFInzTYRbmOr
	 7bt6+qFoiiiwxJRz7TU0zKMLpDDiTvo2NEy+4MyHQsSfJwUJwL+FE9gdFn0lMoMFLg
	 Gd0QplpCtE9UfPSbhZvBgSykdEjXahaJSYUrvbxvlY6lNL0nbV1OXzIFbW4K99tPa1
	 BKmR79nbcAx8jc7AVO/Weqhk2juc6hP+QMV8r+cvGL9vh6foji/kTgQ+z5j3U6BSk1
	 TaSoms0smI5Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2C3809A80;
	Mon, 18 Nov 2024 17:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid forcing direct write to use
 buffered IO on inline_data inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173194924173.4109060.6198520262725543063.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 17:00:41 +0000
References: <20241104015016.228963-1-chao@kernel.org>
In-Reply-To: <20241104015016.228963-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Nov 2024 09:50:16 +0800 you wrote:
> Jinsu Lee reported a performance regression issue, after commit
> 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
> inode"), we forced direct write to use buffered IO on inline_data
> inode, it will cause performace regression due to memory copy
> and data flush.
> 
> It's fine to not force direct write to use buffered IO, as it
> can convert inline inode before committing direct write IO.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode
    https://git.kernel.org/jaegeuk/f2fs/c/26e6f59d0bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



