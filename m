Return-Path: <linux-kernel+bounces-351392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03C499105C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A672728282A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EFA1D9695;
	Fri,  4 Oct 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osHq7uVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A861C302D;
	Fri,  4 Oct 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072625; cv=none; b=cisaeLFbyznGNlguUI8LtLlUA+bV5AghQ1gm6dmo5lTKE19hGLeF+dzE5kCNCn8YS2g2JJebrRMEzINBFIagf1WiVme9Ug6Hkdckjx4Q9YRQqaNzZZ0r06pVvKQ5C1B8nYnlUy//MndHkmIti2bgtFii3OuVR7PSmkwSz4J20D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072625; c=relaxed/simple;
	bh=kiUO3gtzG7jRQjrU5YxnxYMNvX+42NCIsKG8z9Da7fA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZO4/MACPoMTibFXGkn6myckck7eiAiUHv5i2TSPU0KwAkC8uEaLNV8Ytc+KleS5lBc713oDZhI07O/qevACHy5uyltGXghjSeaPT6/qfh4ZX4jTDIdffbGAkxAGqE0zeshwe/vncCXpct/tienKNg/Zh0d7GjHizaOfFf2Upprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osHq7uVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE395C4CEC6;
	Fri,  4 Oct 2024 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072624;
	bh=kiUO3gtzG7jRQjrU5YxnxYMNvX+42NCIsKG8z9Da7fA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osHq7uVnIZzvRLDd4nJlyE+lqfVmXgRJ1TqQ5XieRLKzygBGFYzIGVJtph+Hed16L
	 a1f/7CoBmIVRLQQoI7EDuNE2i1Y/OKN/LwgwVQwi+3Ki0VkZLp0dMPVgI/eq8qO2Br
	 Qy4VC+KWZ+WNLpDUidAKZLKsHBsEKjXGHmAJ4x6xIYnL8MGigtBV3R7OdGb9IC6mek
	 c5vKZBgMcHcZtilPCOqRyqLLkdPTdRKIIECqBFA3XxKNdiDd2DSJPPWiIyiXvADrX7
	 a5WEYX99LzM/ih2YmGM584EL8Xsm4eaeqRFGWfZM1KV06Q4jTuIwQUrtq19qRChTuw
	 +azx4kMeqGeVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A060239F76FF;
	Fri,  4 Oct 2024 20:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] ethtool: rss: fix rss key initialization warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172807262853.2727057.11525933903751583873.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 20:10:28 +0000
References: <20241003162310.1310576-1-daniel.zahka@gmail.com>
In-Reply-To: <20241003162310.1310576-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 09:23:10 -0700 you wrote:
> This warning is emitted when a driver does not default populate an rss
> key when one is not provided from userspace. Some devices do not
> support individual rss keys per context. For these devices, it is ok
> to leave the key zeroed out in ethtool_rxfh_context. Do not warn on
> zeroed key when ethtool_ops.rxfh_per_ctx_key == 0.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] ethtool: rss: fix rss key initialization warning
    https://git.kernel.org/netdev/net-next/c/5c2ab978f9c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



