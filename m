Return-Path: <linux-kernel+bounces-331123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E197A8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706561F26B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DA15E5DC;
	Mon, 16 Sep 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5REh09/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA91494AC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522230; cv=none; b=iHJoufZ/rBokvASsPgcEoWLv5XMN19BVKAbeY2q+mzvWqYRV01IYYU+Wss1YwNA3pZSI6ECvumVbCAjxCdcRQ0AO44yC+7XWyJYRCz4qc/WYa+rElMMxM3uxqAd/wk8D9hYS4d0OhdzCvnF0isUG1mnBKcGd4CLfB+M3eAJlDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522230; c=relaxed/simple;
	bh=anl4DpoqqD9fIJF2b3yEUbmX6bTmHXeEKVEwgC0wq3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CPgiiydteJ60d6P9IK/Q03a81t5NC4pTO3aXowy5HTpTnsyX4ZZbjQge3L/U2B7sW794m11b3Iyv09pbpXnxVgPxVbpc4JhCQ6sRPFaFFHrTx12x95dvt0m4vlkgmPufRnEsxFtk4LJqk97QUNCi+/G1Db3xX0qSZ2CBaTZWV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5REh09/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E51C4CEC4;
	Mon, 16 Sep 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522230;
	bh=anl4DpoqqD9fIJF2b3yEUbmX6bTmHXeEKVEwgC0wq3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z5REh09/c6QIhhYABIZhNRBLxGuekL9ILzwCRKqqWabrx/lYD4CDG9gpZKnecCFoV
	 K0CvBQidTUAj2VD1jtxECKNPEPTzMbMP2vM2tE2XWqHveB2rdBwhwiWKrH0xLTCVjZ
	 YnXA87pAgDmyaIrgPPqmXS/3pGgpZwpbY7uSX8iXWJn2inUtQ2Yl+HsvKZ4i/2Fk4l
	 AhSqUaX2GGpbTxNn4OVxfYzsuEDOJ4KQT3j5tz9we+utXc5GmhFNV3LGPgE/QanIjf
	 oe4Oi/M9aR/Wi9oC0rJA1Mq8TG8b4eXs4v/yVGUqLKqttupj9kzmH3mAgUACnvpj9o
	 CmE64cki7pWEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0D3806644;
	Mon, 16 Sep 2024 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: forcibly migrate to secure space for
 zoned device file pinning
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223176.3820990.6988007191062882745.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:31 +0000
References: <20240912165958.386947-1-daeho43@gmail.com>
In-Reply-To: <20240912165958.386947-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 12 Sep 2024 09:59:58 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to migrate data blocks even though it is full to secure space
> for zoned device file pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: forcibly migrate to secure space for zoned device file pinning
    https://git.kernel.org/jaegeuk/f2fs/c/5cc69a27abfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



