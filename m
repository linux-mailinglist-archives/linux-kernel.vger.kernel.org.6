Return-Path: <linux-kernel+bounces-252698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C852E931707
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E4FB21CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043418F2E4;
	Mon, 15 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLltqwFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2418EFE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=UyXT/xka3E3lWxfZ76BzG9XFTnTrBmRQLh8v8QiX/HCMNYFeKPWYmNZlRihOWg27MnjjCAGpus1NzJUa2KvWszdLA0MfMutAhSMxIH3uPZDEuxRlsmitFud4XRqPNvMc8RwVr4T49zjvEwweslaxmEC2weSA1BlqeI55W5piyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=7lQpNJeDAEX8VEuasSqugBf66qAmRs1PQ70h9A3wydE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=twAg4W2bJY0LQGhjvldItSQCq8E8AC3k3lwsBXcDOwh7D/hD+oG6D4Ora/Sr2iKWzK+ia0XufjgRLuXCxzF+UZdkIjeemNVt9QNQUsL2htWCYXXHE9VTesTD9umn6bBVYAKlWYzfnk+tXdD/1wp0mO9WCIuuusp5SxXRvvYmUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLltqwFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33039C4AF0D;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054432;
	bh=7lQpNJeDAEX8VEuasSqugBf66qAmRs1PQ70h9A3wydE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLltqwFwu6TH5P9yJnujFqZCdIEwe/tHUXpG6lD1fQyiCHtYNux/q1CKAmdTBImHY
	 MOj9lxZsCVy1safC1fq7E2HsBh6dqs9krY1frIFzCUqyVtw73NzO2gEEXSakBkGtY3
	 D2eWeDHsgna1l/BL+CvVLZReqpYI0oR1XsLq+vsWPumu2SVPtV/StkGIUVpZWrBz3Y
	 Q7Uivb7q74oQMNzdC1BKEy86NxOleYKjXkkxIsCRHCTtMnTHCJ7C7dbD9A3Z+GYbJb
	 M4xYxr1VamZE7oLDzYgO0dWnckQjnfGjQlT9Nr82DRGU89iwTbMeTcwd3LJ7p5fovn
	 sj9iVMBhbMJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27E2DC43443;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null reference error when checking end
 of zone
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443215.17443.11491545195159801035.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
In-Reply-To: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
To: Daejun Park <daejun7.park@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 nayeoni.kim@samsung.com, siu.jung@samsung.com, sukka.kim@samsung.com,
 dongjin_.kim@samsung.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 04 Jul 2024 10:01:21 +0900 you wrote:
> This patch fixes a potentially null pointer being accessed by
> is_end_zone_blkaddr() that checks the last block of a zone
> when f2fs is mounted as a single device.
> 
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix null reference error when checking end of zone
    https://git.kernel.org/jaegeuk/f2fs/c/c82bc1ab2a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



