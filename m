Return-Path: <linux-kernel+bounces-309467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1BB966AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE981C21B77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B81C32F3;
	Fri, 30 Aug 2024 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHpUApkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE51C2DC7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051112; cv=none; b=FYcZ6ZGU89FRQBk7naJTDN79DbS+RZ98StvBojvPiJJCrp8eRTG699RWZqiZfWxAZZyD0HC9LRdYponbNgOWLY053c9HoejX8k+w9LxOFoVepr7+I9XtCGRNoVyUNgFQ1UpmCcP4gV0+0o7TmAdordt9KYnNKLVOZ7x+2IdexKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051112; c=relaxed/simple;
	bh=BNWTmh8ILq4X1+YYGpjMMgsqivyDFQ8a56TQ7PCIOWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OPxvIkhe9dqdcIbw1KGBDGMIQpOjex8NO4zET1FHgM1w/OWpbq45J2CxzpxY6qEV6KmEumdEh3a3ZAVGcqIi/vTUyEVFMN0mHwBsLjNVPQdhmNmLUZM6lsQBp4VhCnvYfEz366/P8Ho6x3+BtFep5vmA4a/DVt8KGUoGgCT/YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHpUApkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D5C4CEC8;
	Fri, 30 Aug 2024 20:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051112;
	bh=BNWTmh8ILq4X1+YYGpjMMgsqivyDFQ8a56TQ7PCIOWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PHpUApkg3f5qVmWIKi4imN5/nzHh9AUpuTyTJWlQrJRqxyXS8htag6beGqyj/O8ga
	 m2JbZNL13IA20fgqRNx8YIudGPeLKQkXnLDLonrlv36bM8iQ9mab2/TDFINtKaSAc0
	 S1kvq95WgqZYMv8SPRbVT7rGcmhARRxSFCUVCgoLb33E8x5QhqtTUseydkWtyRm/zl
	 tyt7P2117bp+wx243RmjsNx0sD3P/aPbVFr1wWqoNXYLnFFWpOE+NggBjdv1T9Yq6p
	 eH9KyeEIVizTv9jq1WJC/P3o+/IdGk8vyuksq5er+m5BPWADYKlNnWDd8qw/NsKdLf
	 BjRYZY7tnUPtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100D3809A80;
	Fri, 30 Aug 2024 20:51:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505111299.2712133.3150061801664189477.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:52 +0000
References: <20240826202352.2150294-1-daeho43@gmail.com>
In-Reply-To: <20240826202352.2150294-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 26 Aug 2024 13:23:52 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Keep atomic file clean while updating and make it dirtied during commit
> in order to avoid unnecessary and excessive inode updates in the previous
> fix.
> 
> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: prevent atomic file from being dirtied before commit
    https://git.kernel.org/jaegeuk/f2fs/c/a433a8f0eb31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



