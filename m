Return-Path: <linux-kernel+bounces-417205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D39D5091
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3B9282ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2115D5C3;
	Thu, 21 Nov 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUL5YxwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131E19A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206019; cv=none; b=qlg2ZUXWB/dZDH3ssSZVOHSbZxVW0ucweZlhMQkHvfIrSfY3G66zML8D/TMI8DQ3MVGNwvOqVgn8ipX5f37+NJLMwAmyM+YnzOTCsS0z8Dapvz1+PhiQicTEb8cCvT/EnfdGgO2zSHaMS1DJUVbMM2B0eycDLKHkNFES0mnozeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206019; c=relaxed/simple;
	bh=ZDtigLTDD88X3n5JZoGpSForIA9qoDETxrOoWIGrOVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oNvKSFjzQ/yzQORI5Y387udi60QkasMEZkry5IXqZ7dy4HMgN9IZuvMFogNeoCve0tHHr9BT5P3dQyr2k4c8eVnj8EOUFGxsdbkAC0f03wYpId8P7sFXq9dcXPRHQRdGs6iTr+0p+q7ojVMfmiEf0iRsXmmL4HQ6mwYHgGlSq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUL5YxwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD8C4CECC;
	Thu, 21 Nov 2024 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206019;
	bh=ZDtigLTDD88X3n5JZoGpSForIA9qoDETxrOoWIGrOVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QUL5YxwV5iRpmQvfcXy2B2xb0Z1bdyJLHjojcBFqLr7eMW6DXxy5VHfxfG8qhpu8R
	 CIRoOoTwU4N1vh+5ecyddDNItuGwN9kynPoOP27YwomjQ95Q1v+3Smydxyo1cSPg2o
	 Tbi1XDu/D7RAKEGya0yPJIYuTxOj4kB9N05kXQjCsP9PR331FIMSCYm/yhxoeb6mGY
	 L55VxIFt0bbDDxci4uBNNz4fizQ3DNqOVESAo3OJr5Z52MyQ5KJUwRHbW6HmM3DKD+
	 oX4gUp2vjVEsv2FTKZnZGgLghvK6udzglkPSuhtqRiSqTTZ/B4a6EuPvQD/KeS1/6e
	 CSswbYCqybjTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D023809A00;
	Thu, 21 Nov 2024 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK} to avoid overflow
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173220603104.1977996.13915931436818539295.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:31 +0000
References: <20241108012557.572782-1-chao@kernel.org>
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  8 Nov 2024 09:25:54 +0800 you wrote:
> It missed to cast variable to unsigned long long type before
> bit shift, which will cause overflow, fix it.
> 
> Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  include/linux/f2fs_fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
    (no matching commit)
  - [f2fs-dev,2/4] f2fs: clean up w/ F2FS_{BLK_TO_BYTES, BTYES_TO_BLK}
    https://git.kernel.org/jaegeuk/f2fs/c/7461f3709418
  - [f2fs-dev,3/4] f2fs: fix to adjust appropriate length for fiemap
    https://git.kernel.org/jaegeuk/f2fs/c/77569f785c86
  - [f2fs-dev,4/4] f2fs: fix to requery extent which cross boundary of inquiry
    https://git.kernel.org/jaegeuk/f2fs/c/6787a8224585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



