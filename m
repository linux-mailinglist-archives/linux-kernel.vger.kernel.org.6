Return-Path: <linux-kernel+bounces-174043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C78C0985
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDEFB2162B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211113CAAA;
	Thu,  9 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9dwTcno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183F13C683;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220029; cv=none; b=QdQmQZnwBj0T2tjlbYD3bRs8ycjojcxaPr1TUlO8dav2OoVtUc8yI26de+xXWbtrxfj4y8q5TzV68PU2f+XYxJ67gapC1m/xENORyMEYhjajresaMCj5GzEs5MncqFbs6e9yWdaZsrlOkemhlnIaqVllLj/9OlFNVvWupF0SgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220029; c=relaxed/simple;
	bh=4FAUsU5mVbqb7YAyLX76pu1HOYCKM/90jyHr1I3lBOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/upj7oeLhXRO81giEKnk8yuLz/t9DE2wjKG3Twd13QlzoOr8ebOA1HRdyMzv8D/zsdsUvMW8zspabbJG+BU0fHpELUjRRzDfak4LZiPtUn+Z7lavvNe+iCsotpiub1NnYuzaI9xkAPMsW9VmiSU+OKEX4/6gft0Yy8QXFTSccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9dwTcno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38E40C32783;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220029;
	bh=4FAUsU5mVbqb7YAyLX76pu1HOYCKM/90jyHr1I3lBOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9dwTcnoBoWs1VjrsjgnLBl+iq8wZFwWptcmNAbutBxpV/+KMNwJHr4AV/AhFpISn
	 fbkA9l4GhK3fcdSzXQ3I6ahkmJcbRhCgflbj4pXlHx9+JHNNqPC8qa8EQ/g7Sq1lrh
	 uD/znpGGv6GCPMHNvBAWUdNdLYdjtutztfTtZ8Czm9hO6WxXHwlq7qLvaTWMxMMHmV
	 Ct2Vq3KsH0aeLil75MRX5tmwhX4cqQM33R0JF8irSUAVXTnNfLi0dxl6IEYCGj1Ieh
	 aUYhUbKXC89nNvjwtkfpsZ9aLxlvKqNug7CLTyohZCVr4nK9ckzOAsH8gUxYirLbHO
	 oA9YelZJZRkQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21C16C43614;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] hsr: Simplify code for announcing HSR nodes timer
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522002913.32544.11720704507207514169.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:29 +0000
References: <20240507111214.3519800-1-lukma@denx.de>
In-Reply-To: <20240507111214.3519800-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, olteanv@gmail.com, davem@davemloft.net,
 o.rempel@pengutronix.de, Tristram.Ha@microchip.com, bigeasy@linutronix.de,
 r-gunasekaran@ti.com, horms@kernel.org, n.zhandarovich@fintech.ru,
 m-karicheri2@ti.com, Arvid.Brodin@xdin.com, dan.carpenter@linaro.org,
 ricardo@marliere.net, casper.casan@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 13:12:14 +0200 you wrote:
> Up till now the code to start HSR announce timer, which triggers sending
> supervisory frames, was assuming that hsr_netdev_notify() would be called
> at least twice for hsrX interface. This was required to have different
> values for old and current values of network device's operstate.
> 
> This is problematic for a case where hsrX interface is already in the
> operational state when hsr_netdev_notify() is called, so timer is not
> configured to trigger and as a result the hsrX is not sending supervisory
> frames to HSR ring.
> 
> [...]

Here is the summary with links:
  - [net,v2] hsr: Simplify code for announcing HSR nodes timer setup
    https://git.kernel.org/netdev/net/c/4893b8b3ef8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



