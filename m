Return-Path: <linux-kernel+bounces-385504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A79B3804
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56C9B20F52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B01EF0B7;
	Mon, 28 Oct 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3OrC9sA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106B1EC014
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137233; cv=none; b=fydos2KRKzp9A0Qz7LaDO7UHd5yJyutul+MutCiPlHKhufeKwKK6JtifWkVGzbL7o1SYkU1YpTwp0B1v2MpwEkbgg+Z9Ey6XAn80zYV+yEOmxQLOLzykUh9qra4RxK45cQ7jkHNLrzSc1KbVpFX8c1CRyFRJTQ3FhqUD6WG7ZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137233; c=relaxed/simple;
	bh=OQuqvgPpJTyymPkKHwhPpdLnmwUPe1+ON5uz/XBDNM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MopdgFlPU81xAL9sXMJvuVtfW7HZIK2pSFBQOnQ5Y06QcOxwTkFKmTjV7HJBmgz8kWpOTEhEdeKHV9WirkjI0i7YdbFbLvi9JO52UllYkYyUIksdSByeG2zL4Ia3el8EXQLe6++fqD72e+5jEAV9RlxMzjhuvVLK/ICZ6eXPMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3OrC9sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F77C4CEF1;
	Mon, 28 Oct 2024 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137233;
	bh=OQuqvgPpJTyymPkKHwhPpdLnmwUPe1+ON5uz/XBDNM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e3OrC9sAIpc9iKL1nLAhryd8obqC7SoBysVT3+UVb85m7FRcr3aF1dvYheK6hmBpT
	 NyjxEwqb5lVTkVCqdMejqaU91Z05zAiVzUkZttRXc3Jey+gSXCG9EDrwgudFu3pxiX
	 k/AU7jzGrCPM8bz7AgGAN6nUgO5nSYIvrKsUFFNf433MQqmC6AMmL/I7jbHxvPXicE
	 tQwAFOXv2LQ5dCLUH494bcavUzYqJZQJ2kJftLvIQosjdLcQ3a8+Fx4nYfl1BnbTKe
	 +YSCV1G2D6L4yrkgjgsjyIzjWKmURXDcYa18IjyT9PenudAHbDJlVOAAx60JcgfaOQ
	 GTyTFZ0lUciZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F46380AC1C;
	Mon, 28 Oct 2024 17:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RFC PATCH 0/2] Speed up f2fs truncate
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724023.126843.9607726471702748636.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:40 +0000
References: <20241016052758.3400359-1-yi.sun@unisoc.com>
In-Reply-To: <20241016052758.3400359-1-yi.sun@unisoc.com>
To: Yi Sun <yi.sun@unisoc.com>
Cc: chao@kernel.org, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 sunyibuaa@gmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hao_hao.wang@unisoc.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 16 Oct 2024 13:27:56 +0800 you wrote:
> Deleting large files is time-consuming, and a large part
> of the time is spent in f2fs_invalidate_blocks()
> ->down_write(sit_info->sentry_lock) and up_write().
> 
> If some blocks are continuous and belong to the same segment,
> we can process these blocks at the same time. This can reduce
> the number of calls to the down_write() and the up_write(),
> thereby improving the overall speed of doing truncate.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RFC,1/2] f2fs: introduce update_sit_entry_for_release()
    https://git.kernel.org/jaegeuk/f2fs/c/af68d9b481ac
  - [f2fs-dev,RFC,2/2] f2fs: introduce f2fs_invalidate_consecutive_blocks()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



