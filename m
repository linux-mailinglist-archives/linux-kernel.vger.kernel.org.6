Return-Path: <linux-kernel+bounces-176337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945818C2E34
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B761C214B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A244366;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyXhe8Q8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6111CAB
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=adTktrXkzcQOEOiMJRAaD4BGaQmPFoUyf4iKYtJUZ2n9WLtAninmA2rGrXv9N+9HR+E4a14W2KFyHDPKlpHUDmxWayPwzl42sQ0bwRMARp1hT46NFo4UgCvqMNpDUCYXJmRLxj5TWAEXzPXbuVpkUa22CkLJv33rfsUT3EKIsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=x6JU8P/5APIQD+V7RPpFEEmBjkv6DyMsYkZv1QVVlhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UgnXbxk+K4MI0o1MAlSCPV3dc8dnXfSid0LsWddpc2cuhTLdeYir+26QND5/vOnSvRs2zPUVmPJCtmfJm3c7B2wnOqdIuzztRZ+xjtywInoI/gNQqx3FUe6e9HGoD6yLUPm5uh4jW5oH8SPVYTdeXfd60FcjHhRu29k0H9UIukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyXhe8Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10032C4AF12;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=x6JU8P/5APIQD+V7RPpFEEmBjkv6DyMsYkZv1QVVlhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kyXhe8Q8wiUv+KzYnnxHiOES1CAI+3tgweb7creUuJGzzRp9aMgvh2amrUae8r/4C
	 Nw0REH5GBstRAuNg7pyoV3rKEb2PumlcEG6RLpx/yXZ9C7lp0BRUYgHc3HwN9pifgK
	 h6qM1mwAwI/xU0zRT+AEdEbeDYJeqAk1kI/NEfQLUgB1zV1+wrn/cm+OZXchgwPfi+
	 LJGehwS748xl56lCovkOGdH72jWrGqZMj0Qi9DL3bdt4Nc3+UyEWplSv72DXI8RT4a
	 /dEzGzPj7zd/KZQlM3/6VfQMJ1mOewToBcJ0e5Zvs7raQOK9Z3YpoUluO5JYmzPWDo
	 AHOpjmcS07Ucg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04AEAE7C114;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: zone: fix to don't trigger OPU on
 pinfile for direct IO
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863401.11229.5177002465976586784.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240428011236.1008917-1-chao@kernel.org>
In-Reply-To: <20240428011236.1008917-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 Apr 2024 09:12:36 +0800 you wrote:
> Otherwise, it breaks pinfile's sematics.
> 
> Cc: Daeho Jeong <daeho43@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix to disallow OPU on pinfile no matter what device type f2fs uses.
>  fs/f2fs/data.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: zone: fix to don't trigger OPU on pinfile for direct IO
    https://git.kernel.org/jaegeuk/f2fs/c/48d180e2bf5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



