Return-Path: <linux-kernel+bounces-428646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3449E11BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736532834FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655216DEA9;
	Tue,  3 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYty1Hip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848F381B1;
	Tue,  3 Dec 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196619; cv=none; b=rVavPUJBW8OgpyIZH0wV2DNWiX33ZNxE7pqDf0l2VvezZL2ewF4nELLLXStL4XSnTC9NlXjs/imLhX2VUp+9Br56DgRGTEBuZPUHeeT4Hcu8H3xQo5c9ilaJBK/vMss9wCGBUicWkIfUliy2gj0JQ4r6D1UvzPYPZZ93XZU2+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196619; c=relaxed/simple;
	bh=JW22FuElbaOOlzX9B0W54QnBsobFrQ6eyTb48QLL1Aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tC/ZKVjpVrQyyR60oGBrUIzRUgRaw/21EfreJG8TnsggOc1i0q+u2wYW89ZLjaZQ5eaSNwW3txP3hmkMNSFiKsyuRE1awAYmmMdEFaBcqU9jWJUJ7ZV3XXtZLeMK9I1VnrmuIwvf5EwE3QiRUJKQVVXeXRN+8Wdht0ml4XeJU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYty1Hip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A35C4CECF;
	Tue,  3 Dec 2024 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733196617;
	bh=JW22FuElbaOOlzX9B0W54QnBsobFrQ6eyTb48QLL1Aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YYty1HipZkIzDAi7tOsYnt5Vg/ZALHW0t82sKXfvwTYtHssqnz0iSZ0xRzYTyD8Ss
	 G5ynarRkjtk+mG9WT/SD+aPI91UVDT/CBALYJZknrRdmJZRbnY/CC+XhTx6Fb/NS9Y
	 eHiPaPqN6i2+jZNaTmzxtDEnlrKEUltjLygMJMEgOD3Ev4tmBh9WOEvKVLe6i9jd4W
	 9mm4oJpv1noMmeyyVaCe0QrpXci5UhaKYlUX2jX39uZaCCtyMHtph6dwlIROzOEkAT
	 xJDt3gu06KgOv0Ezx5YKxD9Uqhv/yfBHjs3bqIAj7gpx+94eHf7GxeyT0XWnmdDZxx
	 fqhPJwdz9blQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2B43806656;
	Tue,  3 Dec 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: phy: microchip: Reset LAN88xx PHY to ensure
 clean link state on LAN7800/7850
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173319663152.4008208.4968769521828302061.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 03:30:31 +0000
References: <20241125084050.414352-1-o.rempel@pengutronix.de>
In-Reply-To: <20241125084050.414352-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, yuiko.oshino@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Nov 2024 09:40:50 +0100 you wrote:
> Fix outdated MII_LPA data in the LAN88xx PHY, which is used in LAN7800
> and LAN7850 USB Ethernet controllers. Due to a hardware limitation, the
> PHY cannot reliably update link status after parallel detection when the
> link partner does not support auto-negotiation. To mitigate this, add a
> PHY reset in `lan88xx_link_change_notify()` when `phydev->state` is
> `PHY_NOLINK`, ensuring the PHY starts in a clean state and reports
> accurate fixed link parallel detection results.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850
    https://git.kernel.org/netdev/net/c/ccb989e4d1ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



