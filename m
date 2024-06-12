Return-Path: <linux-kernel+bounces-211830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB8905792
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F828C2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2F181B91;
	Wed, 12 Jun 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpQi0DQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22C180A79
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=mli+PROHQgeYlSOVt88ePIL8FwPvFqzmB6oEkxq88zkSiGDEY54AdGsTSv8VImihOvctDLWBupjBX0bjk+HIboQ59knQKUEv9kz+tEUtNfV8VpqONbp/P2lj3StPyt0xV/TGJ0uFhq47MPEaS0YglolCgYWf325QJ4Y+tobSqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=9Z9Ru3yhVGdasewixq2jt9ojL4nDmltuDJb0o1FAZYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O41X4PodLGORVM6eTntzAMhmJhJCEwwYxcx9wArRRnS1yqBgFBtlPC8l/T+WOq+cHent24dPYXqTb4N6xeqCUc9LannsANj1wZNblMgU5ac6mo2xAIZs01wNfNYtEWwb6yBekQVIbwZimoZcOO2IGclXN3VQ9zdwBfMo3dwdT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpQi0DQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1925CC4AF1A;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=9Z9Ru3yhVGdasewixq2jt9ojL4nDmltuDJb0o1FAZYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TpQi0DQTGMB7xGuzygJ/k11AzpmaBgv1mUvwdVEao1lxlhZZUaUPNyszCN7YLCnzX
	 QHvdfhNNpMPAA5r6mU3ADgVW73V+YZEXdd9BpJcaBah7IeRAH2hSoAf7cgoRBaR6r5
	 m3iFuCWUjmwSCISRTsDV6T0OCqovQw8a7z0t/Gn8gZMbOguRkZ0bVVIz4w4uXpy9w9
	 0VaoNzQPE1h/y0RBdrTA6K1taykdXoZAz327Slmq+iZtGIbCVP15HcAOijDhK4j1HL
	 yDKH1HZPY3N4KRVY6J+DOgkgUIFGo0WbLQctL+uSTO9COLXqvEyA/wtY5sQjuw6DgX
	 whiuafk1JiyFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 019D9C43616;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid resetting non empty zone
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775700.32393.6615606891184295734.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240529112411.380453-1-shengyong@oppo.com>
In-Reply-To: <20240529112411.380453-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 29 May 2024 19:24:11 +0800 you wrote:
> If curseg is not the first segment in its zone, the zone is not empty,
> and it should not be reset. This issue could be reproduced by:
> 
> 	modprobe null_blk nr_devices=1 zoned=1 zone_max_open=6 zone_max_active=6 zone_size=1024 gb=30
> 	# /dev/vda is 4G
> 	mkfs.f2fs -m -c /dev/nullb0 /dev/vda -f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid resetting non empty zone
    https://git.kernel.org/jaegeuk/f2fs/c/76da333f4b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



