Return-Path: <linux-kernel+bounces-211827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDE90578B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AE1C2218A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EB18132F;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYZaTL2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2516D4F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=Ra9+iF7/t5NNRh0EC/ZqdkVTXXW55RU2T85X849xYJkiaGwILb/w0oK0SPRTcqXoakMhcupNTg7Va1n/CMsP9Eu66ZLzttHIVzp3dGFk3QRRaJtBa7luor5S7hFn/CR54AX+m6PffvLlCSo/NU8JNkm1p6H/Ph/YIw7oLwrnj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=DZPyxFdKirmwiOX/njEKegbJptxiHo8sI/vLKAKdO74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iESM8XhmeQi74qOd4sodz8l9Lp2sZGUzLP9le7XbBdJ8rYzOV9FiaL7RcmmKr8Gr6Oz3V4oGLSQzu3P3IVpMtXOy2CSJJwgVytl00WRs1G6SilDhbm/g9a9uAFDnGKNnwXRfYkuj5wMlWzNTcxpcQLoKheDi/OEc4ZdqwQCF6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYZaTL2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21371C4AF1C;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=DZPyxFdKirmwiOX/njEKegbJptxiHo8sI/vLKAKdO74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYZaTL2vORBb8W8g+jzjLsH7pHyggMjmQkJ0pMhqZQNDXhzHhVufNzzvGCcSBYgnr
	 z1QNVhCzNDuS7Fnar67O57lDD4XrGEb/KHM7yVTbkxC0KdmPNAc+jTgvDklTBapU/A
	 7N7k/t2oqI7j2tNCakIwUjvQPKoNHYJk+jtienv1hvQOVBjAOeG0q7CncW/wjF75XS
	 YseMAzlGeBHtvjCCNmziSlmh+v+LVATJWxpyxF+2Yc2mad/ihOx+l9nl6OeTZRsxbE
	 OVocZUMxDrJFHS6+AYnaaTs2+GE2bbhMPMWrvUFmSUbJ6bJnDyhQFmVCP4oYJgYT5V
	 docIxYS/r+NRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C887C4361A;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: alloc new section if curseg is not the
 first seg in its zone
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775704.32393.17458759004168978642.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240530100158.762954-1-shengyong@oppo.com>
In-Reply-To: <20240530100158.762954-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 30 May 2024 18:01:58 +0800 you wrote:
> If curseg is not the first segment in its zone, the zone is not empty.
> A new section should be allocated and avoid resetting the old zone.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
> v2: remove and update inaccurate commit msg
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: alloc new section if curseg is not the first seg in its zone
    https://git.kernel.org/jaegeuk/f2fs/c/76da333f4b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



