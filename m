Return-Path: <linux-kernel+bounces-245135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F254792AED8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83611F22DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50112C475;
	Tue,  9 Jul 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx7Kf2K/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87852F9B;
	Tue,  9 Jul 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496431; cv=none; b=g83Gy4soM6AKQ5BIk9CH1AU0PHsWHjFUcEKXU7ocOnkHlciHzEtkcCGyz/myJlIdpBC++c8crsNcjZmfB4BxNtZL3n6YQ8//aF1LY7jiFXJspSLXp2gjPBUNZuzgmbi+5Dg3hfGlGncebKjefYn7DAQ6pO9jgf1dOCxuq9iwZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496431; c=relaxed/simple;
	bh=qX2Ur8zMgU19dqHYE3m2Zrg/wI78MXLvDPJtwcQPP80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pKJHDOafWHMurOstfOEanEIkbcLBNLsmrDytRnmzESWFmUjnoJLA+7GAjZmtJHNSKJ4N47DvZlXNaE2tFLSDERd4l35Q1MEn33StLc8RGqYrAqKPApmkl+levofD++dlG/JnznhIEarK81mthfV2W7noSuCDJNlJBk/EuNY5hDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx7Kf2K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED2FDC4AF07;
	Tue,  9 Jul 2024 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720496430;
	bh=qX2Ur8zMgU19dqHYE3m2Zrg/wI78MXLvDPJtwcQPP80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jx7Kf2K/NwwjIkrrd9w3emc4/d8QRREC9oZAc0ZWtda2YUwue3YkcUEa+G2m9Cv9D
	 p+SFgESsEq1LPKEl5oXD4jeXFH/0UYIMWLcpm+XUvUr+qHBrtdtFkqVwF48elSG4j3
	 qK8i8MLjgy0//elTwRJCDizKQD9Sx+BORJOB8PMz3ONo3gCcM59jYI/D7smQoZwcH2
	 yLoaxL6ahUggyvSm8TeAmDyaNVmh8Yyqrswq6SjOSe23n77nUvsIoWRd/rKynpni50
	 AXTuqpvj9eTkPj4cC+l6BBQIqogrbfBbRUnjCy8cBmFFLGb0c1ZGZETjE1oBa/hU7l
	 ksyYE0c5aUygw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9CB3DF3714;
	Tue,  9 Jul 2024 03:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] net: phy: microchip: lan87xx: reinit PHY after
 cable test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172049642988.15240.2721815780092526824.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 03:40:29 +0000
References: <20240705084954.83048-1-o.rempel@pengutronix.de>
In-Reply-To: <20240705084954.83048-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, yuiko.oshino@microchip.com, michal.kubiak@intel.com,
 florian.fainelli@broadcom.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jul 2024 10:49:54 +0200 you wrote:
> Reinit PHY after cable test, otherwise link can't be established on
> tested port. This issue is reproducible on LAN9372 switches with
> integrated 100BaseT1 PHYs.
> 
> Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: phy: microchip: lan87xx: reinit PHY after cable test
    https://git.kernel.org/netdev/net/c/30f747b8d53b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



