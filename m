Return-Path: <linux-kernel+bounces-275467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104DD94860F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416991C2206C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937D17623A;
	Mon,  5 Aug 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsXQ1usc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8816F0D2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=svnf6OZjOAj5YFOmKybT2Hjwc/XVDZpb5uvuGapd7r0mH79dNTx8H8nLAURZB8tCuDaj/9BSxKuEYcYowprjBZHfN8gdyb+gks9dE4X0Z570f3PajVJw9YNeFadsdLYvocyae4Dz5bzvw4n737j4X9pjiRweRAHtZPtKy0dCmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=DWXHm383eXgnYAXqu2T1KjAOSvVJYaQJUm9hcHncQCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLbaPYSG8KT0umdepSZt+UTSC+ZEkCa7LMrrF6mZH1hafb+XDljpiwjPrYXLLZ4EixKh3zSGob1rzDC9i6mwDxS9IMfaKxDNQeBdzPzXWyKqVeI1CPkMnBgt0JPVg5NPqnnSw+S2AfKmN+bNjPWW5nDHH9ZI4VPjohjQnMT+oMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsXQ1usc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23491C4AF54;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=DWXHm383eXgnYAXqu2T1KjAOSvVJYaQJUm9hcHncQCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsXQ1usc6kuEkKuHAqkuutjYQNQxjRTw3msC19C698qNhbCixqlQOuc7h5qd0Gq12
	 +Q4JwRDbDYirTVUZBDMp1RzkDB/Isp4op8vBlfTDW/ON1hnREUnKwePhWlvNTNnfca
	 Kae3VZX+yfNBCvcYIQqzK0J83aljuBgrQ4xFnfi0Ci01+Q6/LzVELNxOVcqKQpRj0s
	 2SG+kB7SB+8pblbmnUayC5VB0nyyIr86rtgvj8XqiqcghZ6PjNis8AOkKg//OoMe+6
	 MiarzJj9w5Cb0bnk5E8SRYym7IENj47r0EW8D8YLtT2POE0qA0p+uIEbPj08+t3QZ8
	 lTVGSOLcBsWSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 179ACC43337;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: reduce expensive checkpoint trigger
 frequency
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065207.2803.4270306685689335916.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240626014727.4095350-1-chao@kernel.org>
In-Reply-To: <20240626014727.4095350-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, zhiguo.niu@unisoc.com,
 wangzijie1@honor.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 26 Jun 2024 09:47:27 +0800 you wrote:
> We may trigger high frequent checkpoint for below case:
> 1. mkdir /mnt/dir1; set dir1 encrypted
> 2. touch /mnt/file1; fsync /mnt/file1
> 3. mkdir /mnt/dir2; set dir2 encrypted
> 4. touch /mnt/file2; fsync /mnt/file2
> ...
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5] f2fs: reduce expensive checkpoint trigger frequency
    https://git.kernel.org/jaegeuk/f2fs/c/f541093786a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



