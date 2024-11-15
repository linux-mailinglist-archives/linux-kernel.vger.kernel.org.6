Return-Path: <linux-kernel+bounces-410184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B319CD5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADF8281027
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D817C22F;
	Fri, 15 Nov 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZo2+AeP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECD14F9D9;
	Fri, 15 Nov 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641428; cv=none; b=PwbzoxXkfiqVnMOE9K5lQ024m6WUunfj8CLLe0usuN1KkXIDTB1Ft+30eWKELuKgQlgL5Iv6CRpspOAQ1xfOkxxgnEYK5diQgwvg0jyxr+oVXVFG4u5p14TGxNt05Hl9ENXHXZ/HfOo6RtvQKfml76IhmRrmGgU9Cd8dWCbUzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641428; c=relaxed/simple;
	bh=tRte2cJ6WYjP7LNjMXvfr/fw720GHoAReQrPoN10vwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tIPToSdzsrkPsWKvT4yA44yq+rmaqzYlxtGiSnrua/LDLJWPupR/naeN/ozNDpOGZyrWe32Ytlpu27ju2ObNBPWwEUgwblmymgiXwJdPuxFitIggt//6S4doxAhkQKYehX6WP84zpv1afi7tKNg8PfyDfjiedOVj0gyMRlFid2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZo2+AeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E2C4CECD;
	Fri, 15 Nov 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641428;
	bh=tRte2cJ6WYjP7LNjMXvfr/fw720GHoAReQrPoN10vwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZo2+AeP5Q6VYbH7jUgw8KeRi7wuSwz/rnUCrv/ru5DWRrohIcm7OjR8BzcSJE8id
	 4vsEnrP4C71bm6ovypf4Y5qgBNNeWoaIXGGpDTtqLCq6szxaXMqBtZUktjSSYsFqwa
	 rTMdXuWuUaAKLFHcoO41aPRX1mt3lxhSaZ2XNidOqnqGV9v+++DCNI6MfRSmlW7iFB
	 EOZYtDBp/zg2w6QqH4hFLmXWmTLjk0aVOAny9vlYJnLpwQ+emiLxKvC/RHtU+64B1D
	 DyFgCS7dH0q3tUVwDVk6rm9R7USrwuoqSekcrR66rH52/OtQlJWMMu22jS4J342dQw
	 QcEWvq0sBSc5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E393809A80;
	Fri, 15 Nov 2024 03:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: clean up before returning in probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164143874.2139249.5208538994413325103.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:30:38 +0000
References: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
In-Reply-To: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: wei.fang@nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 10:31:25 +0300 you wrote:
> We recently added this error  path.  We need to call enetc_pci_remove()
> before returning.  It cleans up the resources from enetc_pci_probe().
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: enetc: clean up before returning in probe()
    https://git.kernel.org/netdev/net-next/c/f66af9616148

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



