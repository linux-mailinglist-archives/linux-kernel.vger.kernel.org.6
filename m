Return-Path: <linux-kernel+bounces-309463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6567966AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A348C283964
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163F1C1ADF;
	Fri, 30 Aug 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuY3lw/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D301C0DC5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051107; cv=none; b=tpEz1KN3rFUTYl+iLYx9F9VirosvEHzijlhuaFU98gR92qt8jSPPps/0NFWH94nbNZ/naxh+4yKr1/4UEe7memB4TqVxbXJGzmVB9eSqUHGT/ZNrykOCbEivv7UMhblViBwD9SsXTSSfjJQH4VlPISIhauZBNAb9VhfPXK6cyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051107; c=relaxed/simple;
	bh=+uGLknkE6IoO7a90AR+5N+DJ4wXbk1knYsF6gQ4Z0iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JlIK1IMhoOX6DbEzPledO+tsO0P7syEcSr/VbOPwTDmqJnUy9zON5Agy80ZnQofpaOLKR7nw5D6xvBsSWkPNKqc1jk39z8FUHk7TDjat3l19s9J032l2auR8YEodqVba/OS/wYEmdMciZJnfWFnz6eZVqtDOmt/w2H4+mzbbJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuY3lw/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3921C4CEC6;
	Fri, 30 Aug 2024 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051106;
	bh=+uGLknkE6IoO7a90AR+5N+DJ4wXbk1knYsF6gQ4Z0iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LuY3lw/o8cVgpsG0zbxiatyxvXTQqqsXeepFteXMMYvxLJCC0o2bVYp081n77XiWI
	 VOHpM4dQUlKXlDyLPShI+nnB+JNP4895XkICs1aSsmfL4fZzx/Dgm4raGw3QAwD7Xv
	 buQKS79wFpF2mQBvTzh0vJYznWS+1/lngLkTxpz+JMpMlCPFd5i+5zTvNTF9DW51Dc
	 aXX0aPhDtuHfTpuZ6WsY7V9d15K2i9h3IbBhoE1hsWwx9+OVb9cWvPWpCSCiS2i0GY
	 kerj/6Ft2ze9AA83B9gKwUBPIQb1CLGVHY4y5snf+9lCuUnrxDf9asWEBEyqKDc0GP
	 W6RZcQplP69sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECC3809A80;
	Fri, 30 Aug 2024 20:51:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: Use sysfs_emit_at() to simplify code
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110700.2712133.2963157749047738751.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:47 +0000
References: <20240815004728.983290-1-chao@kernel.org>
In-Reply-To: <20240815004728.983290-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, christophe.jaillet@wanadoo.fr,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 15 Aug 2024 08:47:28 +0800 you wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> This file already uses sysfs_emit(). So be consistent and also use
> sysfs_emit_at().
> 
> This slightly simplifies the code and makes it more readable.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RESEND] f2fs: Use sysfs_emit_at() to simplify code
    https://git.kernel.org/jaegeuk/f2fs/c/f7a678bbe5a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



