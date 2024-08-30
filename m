Return-Path: <linux-kernel+bounces-309462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61721966AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB617B219D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AA1C1ACB;
	Fri, 30 Aug 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF6V+2LU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082A1C1AB3;
	Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051105; cv=none; b=L2g0/GhQ0ESn8/zG3ViPZxfDejqUlowCaRQEjejcubKgH6HQrh9k12aIx5ruae9YMH5T5/T726uvWa2QUR0rM/+1LNhk2Vil/pydZ/ZnCF0dugFveneatVPg/M0g78KYyGtt/6/ZgLFQue1d7LVaxdKKDRIid9UbREslP2WCEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051105; c=relaxed/simple;
	bh=tQRa7q0D+LkWLy/OI2DyVMxkZHU1QU8d28Z3XzOwl90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cGj0/8SHIuZfPGYncluE5XWsTeT3RYCplJ1WNVMEjx+kcW0VTNh/iKJBrHMi26dWFAStFp8i/90zKQ83ZoJh4MsrUk30os7QChqW/VZNCx25DGDVywJDx2S6LbNyU3HZzkm/9VFb/J93cA6h/YXoeP8zgl3FwHhMh1hHoU7l6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF6V+2LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF52C4CEC2;
	Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051105;
	bh=tQRa7q0D+LkWLy/OI2DyVMxkZHU1QU8d28Z3XzOwl90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KF6V+2LUggpoxduIVgSjPBj9ABhgGMXDEoPRaogn0sAWI+CGGYjfuuZhHGf1r5hW2
	 TfgaB+e1PFbZROMBvLetywx1IXyGfwBMtA1NBM0BOkJySLwUu9mmhGA53/lHeUD/Ae
	 xiT3yxk/uIicALyS4A/udF9W7fOCpS3wfkI6SGxz1wQ1Q8y8uX/kNLewAqkkPYjH6z
	 rRmjmwf2Jo9rVPn5Sanbf54gRIOkCObjU8QTeK+G3u1z9Cpxynx4PpX5bfWcAdhOeO
	 XgazP+c4L2iJNsmSURTTpb+adhPkLsTuOzSPH7hw7dxQchFHZ+Pz8VtLghPcOSJXV1
	 P2czZgwDsal2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE223809A80;
	Fri, 30 Aug 2024 20:51:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Use sysfs_emit_at() to simplify code
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110550.2712133.8948730888225333311.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:45 +0000
References: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jaegeuk@kernel.org, chao@kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  8 Aug 2024 13:50:46 +0200 you wrote:
> This file already uses sysfs_emit(). So be consistent and also use
> sysfs_emit_at().
> 
> This slightly simplifies the code and makes it more readable.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Use sysfs_emit_at() to simplify code
    https://git.kernel.org/jaegeuk/f2fs/c/f7a678bbe5a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



