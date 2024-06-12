Return-Path: <linux-kernel+bounces-211831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10115905797
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFEA1C227E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDFC181B98;
	Wed, 12 Jun 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT9Uooot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7A181306
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=dy2EsxunfIPJ50no16GgJdU3GqHGTUMCdt7b49FVPv1+njcKYUAMi0t905Kyao/k2xvnU054s9F6MTVsRkUV+8g/uAHt1R9PrnbeoNmZUsJPPUk+fOJAaa4cCIRAMs3/2WVtqnM0vOtKgNKtCevkom89k35L5+BpH6WzxKA8tK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=CJm6NsCv8wXRYnJiLn7aO9iQv2WZJ5cD8PjUW3TwzJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JnETlsEKxOm+RVVI3w50HsaIUgyiIu7E3kvEKkgHEgrcaHh8IJlbFA90S6+9Zd3rl2ibRWAQgCQInQ3Deoz8qhKmn9qx80g3WDgzyMz/QoLTHedArIr2DQHjGPaDoBG2InAhrrkonBo9pffMCiNFjzHxsUoTCVapv9XyYTwuB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT9Uooot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C6AFC4AF67;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=CJm6NsCv8wXRYnJiLn7aO9iQv2WZJ5cD8PjUW3TwzJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sT9Uooot1oDKn00smIXy8LRV1QS09qTK9sb548rjXfIVxrtC9Xc4TlKfuOl25piOV
	 8Vi+zatSxvp69yGyYHUcDu9HFWtCBTqrZnMvIK2i1Wouz94zsoh3UEsZsIJ4hchckC
	 fMLXL7Y9IJ9Io9G0xHaLof9kSNQo/Bd1AAKV92L3pkjSDIzZIGmiWKPOunBHmkG6rW
	 fK1744xxdMXOOAOtUbrZglOqGRZJSZCDrNUJfYjJLvCNRxMgrpJICRehr2FaOtK7ir
	 nZ3gUMW85CWeqSavOKbN+W6Q98+Wh9laL1uLfHtMztaFsofROvgdq4jnFqD1UHwany
	 zEFHC2OU2Zvqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52646C43619;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: use new ioprio Macro to get ckpt thread
 ioprio level
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775733.32393.12174093758559793586.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <1717414526-19658-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1717414526-19658-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 3 Jun 2024 19:35:26 +0800 you wrote:
> IOPRIO_PRIO_DATA in the new kernel version includes level and hint,
> So Macro IOPRIO_PRIO_LEVEL is more accurate to get ckpt thread
> ioprio data/level, and it is also consisten with the way setting
> ckpt thread ioprio by IOPRIO_PRIO_VALUE(class, data/level).
> 
> Besides, change variable name from "data" to "level" for more readable.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: use new ioprio Macro to get ckpt thread ioprio level
    https://git.kernel.org/jaegeuk/f2fs/c/270b09313b4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



