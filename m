Return-Path: <linux-kernel+bounces-176339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C88C2E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A149B2451C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830F44384;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwBXNb7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9F11CBD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=BeSSgkk2G9NRFcXcHg1S6BXNr+RIhAEspPGUFvRRXzlBHsdO3TYmod4r+/wNixXQNqdkDrtXRqe1WQqXiagj+o/SZX0k38ZCDR+XwpEEcVVrd0RwO1U9fm/EQixbmtQKb2/ayGXUDF5qAQPN7WOkDkCUHzfnog5kZVmtAvmuPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=Pz+ow3JxEINc2wts5BR00ZQMF+TsSbf1YGi3BBPfPxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hTWlHfy77ASMEXgRnxGemzbmF1q4QNxq0JKK3wmNEYY1iQhlmEuxJdaqROOWLYHP5nMXX8QDylzlKfaNPBCr/DtNM1z/R32k7oqIlIoaX0wCnxrBjX8z+UsakonydAOddDJbZTKmN7q3Q9eekUMvAKN2kafCks2WfJypjJw7gVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwBXNb7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BFA6C4DDE3;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=Pz+ow3JxEINc2wts5BR00ZQMF+TsSbf1YGi3BBPfPxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lwBXNb7xi/6jTNONWTORQWCM0OTldyOVw9RcQyzfhL6TUPOhyyKR+vnyKp8PbO0mi
	 Ie9T2GmFCklKqn5gYCC78I+69DZcSf9jNvIpXKcvkjaf/yj8czyeUcpME7fn0KPf6/
	 EfRX/4sc5lnVCWQPcLxNfwgkMzgK87IP67hFr+O+elgezAE9vgW+8wmUrg+VMpXCqh
	 KVYwn1R8fqGhs1pwIpZs4KCEvoaPRI3ISyfW87gMWnzNxONl/oYfJz40W2TtRGYtmb
	 vDnXmB4M+TtlAtQJhDGAcLqAu6cznDqNRKebH70ptxjChOeOx1xn8U5TQ5UVaI0XoM
	 ksCqbF4XXeMeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20D5CE7C112;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix block migration when section is not
 aligned to pow2
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863413.11229.14009197979317413967.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240429035142.706356-1-bo.wu@vivo.com>
In-Reply-To: <20240429035142.706356-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
 liaoyuanhong@vivo.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 Apr 2024 21:51:42 -0600 you wrote:
> As for zoned-UFS, f2fs section size is forced to zone size. And zone
> size may not aligned to pow2.
> 
> Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix block migration when section is not aligned to pow2
    https://git.kernel.org/jaegeuk/f2fs/c/aa4074e8fec4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



