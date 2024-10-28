Return-Path: <linux-kernel+bounces-385503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E359B3800
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ACA1C22109
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE271E32D3;
	Mon, 28 Oct 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfbfpzma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AE1E1327
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137232; cv=none; b=N4fy0j5MIL/exifelATaiwx+t9Ptll5pWgcQczvsVcxavDd3RnoSF1zy0I6PP17Kutp8AUrOWrCDU6EZiQ8Ihv98ucPMlTGQNEUu99es4hlKsz3SyfvEEa3g2eTpQn2GDYp4gt2K4IwAQqATRrQ/6UP51jqayPGlsmOvYe7O0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137232; c=relaxed/simple;
	bh=kCJ5JorSKHyA2UxhmbTseadz7Iu8NE9AytEHPbCv4n4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8UeeED/yldR3M5juv1XviMNPAVjzIcwMGdrDCufaOsvmSaJFN6bJFTOBosnjM8yBg/HCe5uh2+4bkk9ldlUXWrgzb2XgurGnrOSjUydJ6g77lgwGEO8NDC+rNLyt90SeCYxqHldHWKIzce2qewPULBcj3CPyGKPVlEdxhhNzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfbfpzma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135BC4CEEB;
	Mon, 28 Oct 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137231;
	bh=kCJ5JorSKHyA2UxhmbTseadz7Iu8NE9AytEHPbCv4n4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hfbfpzma3Ou8k/d2LW+ABdp2j7SEUfGS5C89tiRLERDYDNxRKw3UE33vsU1wqapz/
	 fHcYHfBW52bffNODpBqc8AJtnixYSCU2LLmjJ7Ws2DbqPvNoZDVLfUXzaW8DIkOYt9
	 etPdx7RANVUPlmkmRUEjwpfXNm7YCDkch4ZehSUdkLqICHeuBgopHZkOF9xHHPBIVs
	 isRRdTdNTJB89nMrAIsYM2olzidAmA0iVKV0RlDPP8PxWOyk4i1s001lt88cFMneS3
	 JoBKjgSdd6/ULznYLA+ov4ASJLq5/+XCLWcQQMsuZmHJh69NkoiDeX5FHaVutpO6Is
	 gtpvH/5fbjhUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34937380AC1C;
	Mon, 28 Oct 2024 17:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: decrease spare area for pinned files for
 zoned devices
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013723899.126843.17159941935914326247.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:38 +0000
References: <20241015165427.1158782-1-daeho43@gmail.com>
In-Reply-To: <20241015165427.1158782-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 15 Oct 2024 09:54:27 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now we reclaim too much space before allocating pinned space for zoned
> devices.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: decrease spare area for pinned files for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/b715716ee839

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



