Return-Path: <linux-kernel+bounces-370715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1E9A312C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8521C21BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D2219CAF;
	Thu, 17 Oct 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjNlAGkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F521F4286;
	Thu, 17 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206625; cv=none; b=Nr3XQmbSuRmOB72LONHTdh7Kd6zQDR3QT+Zh+cwM//YHTtzJcbyc4l4bR1zcT49TzYWQs0Lhy25u3+dMCcoMkNCRyM93rxydDfEoE6kbhTpsdhSyikwenO+YwN8EwN6sl/mg7T8PRn5ILwPioPpboL3tozTwYKZlneShPKzhGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206625; c=relaxed/simple;
	bh=PUxUM+FNivZk+R5BUJR/P4OqjaInUKGEl74q8jkD/FU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sT7v9zM6up35K8TJE5oMckcRY8oQBDBCry9AT0QFG/msm+oU7NNNmZrNGCqVmxbJSiBuNCMda1oq6cuw7Oi1S07SznIieWcC1WZWLPZEE+4K1KhEMjFxQuJGkeUekwu5kwl6edlEeqhPZ2xs7xkKLnKLBxyihuYCHwOuHx7bGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjNlAGkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A3C4CECE;
	Thu, 17 Oct 2024 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729206625;
	bh=PUxUM+FNivZk+R5BUJR/P4OqjaInUKGEl74q8jkD/FU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FjNlAGkQ6qyu4D2Yb8HlTm6JezuYdWSoLaDmS7t2bL6Y4dwSq6aknIffpgQjUURiK
	 RBmfUVBkALfn1DAOjJg6id0wNpUO6y3UWuSMFGwgLUsrfJuTvdOR63l3WMC1Ehlebo
	 yndhDWFUCrFPm+6z7/tuPm4tYUOgEyyQpxmrAYa1KtRyX6yQQ0XgMHIjKDk//FG87x
	 42xDlqP+Nq6lBGyedVDHH3bYr5MTq1RYKf9Zio9lvhTWaTLRKN2f/bY5QLTPfJ5Rnv
	 I4WVk5PijLJ/rMuZp7W7zuMZKzpL8sDBSZL9S0JApGWC4hPDGi1VX+1F0O3BMCcxK9
	 togMS6pbZu6lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1BD3809A8B;
	Thu, 17 Oct 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Fix uninitialized
 variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172920662978.2631458.11785441270567785071.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 23:10:29 +0000
References: <b168d5c7-704b-4452-84f9-1c1762b1f4ce@stanley.mountain>
In-Reply-To: <b168d5c7-704b-4452-84f9-1c1762b1f4ce@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dpenkler@gmail.com,
 gregkh@linuxfoundation.org, rogerq@kernel.org, jpanis@baylibre.com,
 c-vankar@ti.com, npitre@baylibre.com, grygorii.strashko@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 17:41:44 +0300 you wrote:
> The *ndev pointer needs to be set or it leads to an uninitialized variable
> bug in the caller.
> 
> Fixes: 4a7b2ba94a59 ("net: ethernet: ti: am65-cpsw: Use tstats instead of open coded version")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
>  1 files changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: ethernet: ti: am65-cpsw: Fix uninitialized variable
    https://git.kernel.org/netdev/net-next/c/ff1d3484d6d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



