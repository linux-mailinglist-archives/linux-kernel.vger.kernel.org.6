Return-Path: <linux-kernel+bounces-309466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B49966AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1206E2844F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D91C2DB7;
	Fri, 30 Aug 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTNhf9Ok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783C1C2DA9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051111; cv=none; b=Cy0r+YEIHPCf3x++jd9b3Mv76qGiulcOyK4qJXLiyepobEkX+/rrgK7KUktkC/4pzP/669L0zPfwgckzIidIWByGBfzWPP0QfsciiWOcHPEtkXFbBH+cexmK4Ff2osiIQIqANzSfhlp58PthtWARMxTDHTOLZCw6BJ4c+T+nDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051111; c=relaxed/simple;
	bh=5HvT4Ii3FEkKfU5sKRbDHNqFEXP1hCHQA4nUix0LiIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6BY2/C45DiLMcruhxAxV2AV7Y4hxv1vNNtEd1ol/Cc3YvowFxo0sDwDHpHN+NPqg2RDeR+e0PICezlaDP070GJSsNPU/LPqtxuOetWJtmT1GMe0aHQPmQnD99vrf9n4tG4ypM8mk928GOTypMarYI50MlWazfj8kRAcvv201LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTNhf9Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425F0C4CEC6;
	Fri, 30 Aug 2024 20:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051111;
	bh=5HvT4Ii3FEkKfU5sKRbDHNqFEXP1hCHQA4nUix0LiIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YTNhf9Okvd9+PzUwMBAW+GF8maOawHNjMyPHWCFkW2WK54qU/sYM81ZwjqGFZmmQi
	 dA8FnHW5fEqAWuA/Se3g+J2L1rX+y1oucOC2pzvpTk1LwfPVVG9n5q0QcUnUmtvrPj
	 TR4GI4h0CJYpZzDgCINUAi4n6s3iwchK+0+QB/o/9nvhAHui383Z5hMAmqZ/nQ3wr6
	 sjHuY8Xj6tFGHGA4vWvYTR7u+Nvk4pbvCGCZdz/2NWF0wIIpC0+kpVjzK6oMmmLGGC
	 h6hlw2k0Bx28JsZoFfr1jZ1xV8Xo5vxAlEiDcIRTSC4eOYr/LoJUQowimlRZKUTcFR
	 bz9iwJ74sseow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD033809A80;
	Fri, 30 Aug 2024 20:51:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 3/4] f2fs: atomic: fix to truncate pagecache
 before on-disk metadata truncation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505111150.2712133.9357937873277394097.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:51 +0000
References: <20240807102435.2198055-1-chao@kernel.org>
In-Reply-To: <20240807102435.2198055-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 Aug 2024 18:24:35 +0800 you wrote:
> We should always truncate pagecache while truncating on-disk data.
> 
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - don't reset i_size to zero.
>  fs/f2fs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [f2fs-dev,v4,3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
    https://git.kernel.org/jaegeuk/f2fs/c/ebd3309aec62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



