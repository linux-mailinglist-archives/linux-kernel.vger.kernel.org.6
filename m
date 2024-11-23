Return-Path: <linux-kernel+bounces-419125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957A9D69BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511671617D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612E44384;
	Sat, 23 Nov 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFn77zh3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843E22EED
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377028; cv=none; b=MqaFCQ57lY4yyIzAbsM9UXtJ9p7SjJO/UWWKznFxhZTMTvnLjTR1zTBH7CFkvEcTuVrzbewRFJKE22AcetXkJEQBHGSSCqoc0baVswYAp5Si6GlptcOarVfzt75EzHX2CIbyhv1rd+RJfdkQJE/mNrx4p4NqeDvP7cw/XEw+M/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377028; c=relaxed/simple;
	bh=dtotHtOLZEq4lFv92Zs9oG8yEKOiZLjVNbIt8QDq6S4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RGNHuUkhm97N0t1kTjT3TK6WuAaPQDffX8I4LhIK/L5dCMctyeViXwsRiG2PtFboWXzh1LV5Ago7SM3kxSs6llitOg+DGV74r08LgObxvVrSGhnKxE6GsDrP3yJvfH+sCincy0v0P0+XDm4VxZISj0IFzFLnrT+7F183n/PuGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFn77zh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A3C4CECF;
	Sat, 23 Nov 2024 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377027;
	bh=dtotHtOLZEq4lFv92Zs9oG8yEKOiZLjVNbIt8QDq6S4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XFn77zh3+fKJRnqfBMpa8VOwmAIdyJTcc55zi6Ym8eVzq7ssSHin6oYHya/4+Vg38
	 pv/YlZ4JcUDMAI2VWSX+hEyMSjw7s1NjEiCriTcuwmbS/SRw/VRJ+iXGQwFdcQQg/B
	 OFSHikjPoNxGkIFNEBduB0AnnAXjJ08KF1isbncjYqtCCZV2sP3mvE9sxrG6Wc6PFe
	 PHJncKY7URC0aZUv4RRch0OWnDa5/d5ZySz4Na1vsfIVzFbTkd8Fssp59P0PvGSQKV
	 CkEQhzfiuK8boka32L2Gy9jC//o+HEPIuOvc9Ak5Uohp/RUWUBnzqqAE4N6EOlrHRn
	 ePJBBe6/cXkYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBA13809A06;
	Sat, 23 Nov 2024 15:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix to shrink read extent node in
 batches
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173237703949.3018181.7264272337903464166.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 15:50:39 +0000
References: <20241122065005.3772987-1-chao@kernel.org>
In-Reply-To: <20241122065005.3772987-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, xiuhong.wang@unisoc.com, zhiguo.niu@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 Nov 2024 14:50:04 +0800 you wrote:
> We use rwlock to protect core structure data of extent tree during
> its shrink, however, if there is a huge number of extent nodes in
> extent tree, during shrink of extent tree, it may hold rwlock for
> a very long time, which may trigger kernel hang issue.
> 
> This patch fixes to shrink read extent node in batches, so that,
> critical region of the rwlock can be shrunk to avoid its extreme
> long time hold.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: fix to shrink read extent node in batches
    https://git.kernel.org/jaegeuk/f2fs/c/3fc5d5a182f6
  - [f2fs-dev,v2,2/2] f2fs: add a sysfs node to limit max read extent count per-inode
    https://git.kernel.org/jaegeuk/f2fs/c/009a8241a8e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



