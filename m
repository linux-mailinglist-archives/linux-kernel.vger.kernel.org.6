Return-Path: <linux-kernel+bounces-316866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668196D65F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8584281241
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85481990C7;
	Thu,  5 Sep 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW9dw8xc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78F14F117;
	Thu,  5 Sep 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533433; cv=none; b=Mj2juqDUOULPVJ9BJastxVavVixGbllaQ44gddlCGWnuImA7mI6qQm//IeQvxiGlA/nHkL7wZqcViz2ASRMxaZXDTDVZ32rKKro45WbRvcuhKQKf6pe0r2IjXQd6M/31Fr+YZbBxFYcphdjZmw0GhK1WwN+UTdvyFm81+gDSCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533433; c=relaxed/simple;
	bh=x3o1pAqDc46l8W9Gjl5Ch+6aa1YgsGfkMdUN7eho/Mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mT2jxKaoynHQLLvIoHoEFOOUVghVZYp9fHnsobUWwoGLO5pi9ucX9ZBQhxrXTB6BUMsJEl6DYE/Ry+M1Eos71Rb5ny5JeMAn7iPS5nJ/vkAL2dMuvX0PEiAXrsTlbOO3zoJr30rL0Z/A/xqdcMSN0CwCgaMgpmEzSWVVP/QfQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW9dw8xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39FFC4CEC4;
	Thu,  5 Sep 2024 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725533432;
	bh=x3o1pAqDc46l8W9Gjl5Ch+6aa1YgsGfkMdUN7eho/Mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MW9dw8xchzN0Gh5Cl40T/IWegMJ0dashrZeyUPxu5Rsv+XWEBiXrKfFhgNo8amzTi
	 227WYFbkuBZHR7wob6GPn5n0pTe+V4+5C9+YpQJHLtDpMOA2gnrF1ky2g1zG/3mN//
	 RejokG3WiYzl4T/AXi4ESRAj3EpxRnSi6aXWb1po9ByxWtzESPIKmRmxGTI3n/1f9A
	 cBM2jbszVWBw/5Ay7g8+qaXJBZB1TgjYHvn+T0x4ItdaApdzloWRU2A3LAAPCPxBQQ
	 XgMUhdXZkdPKf7S/zByWGFG1xpqGmNj8k3e5OfiJrSPjFk1IqKedBaTdwFWadRIx3c
	 TNLcG7g5U4WQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE14F3806644;
	Thu,  5 Sep 2024 10:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: vsc73xx: fix possible subblocks range of CAPT
 block
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172553343324.1354535.17438094920273848172.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 10:50:33 +0000
References: <20240903203340.1518789-1-paweldembicki@gmail.com>
In-Reply-To: <20240903203340.1518789-1-paweldembicki@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Sep 2024 22:33:41 +0200 you wrote:
> CAPT block (CPU Capture Buffer) have 7 sublocks: 0-3, 4, 6, 7.
> Function 'vsc73xx_is_addr_valid' allows to use only block 0 at this
> moment.
> 
> This patch fix it.
> 
> Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: vsc73xx: fix possible subblocks range of CAPT block
    https://git.kernel.org/netdev/net/c/8e69c96df771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



