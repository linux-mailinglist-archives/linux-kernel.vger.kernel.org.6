Return-Path: <linux-kernel+bounces-559072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A3A5EF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FD83B0D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E87265606;
	Thu, 13 Mar 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd22eAH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8846260366;
	Thu, 13 Mar 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856998; cv=none; b=Iei9u7nu64OeDYVZKWVGn0lGibGs8PpyCpSgXHwYCwqPAmS8L296QMs4EuvpGfRC/HaM71KBXhGmlQRwWFLuldVJufTMM2sItXNuTMXMgpWoYFGoStSiG4OgJ4FBYlHVsgHp8e2TB/gtPLlCt8kA0KwIEEVQBcVJa5kvgLzAaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856998; c=relaxed/simple;
	bh=KS2rOBtkxAgtVikn0bTfqcz+5ta18w4agh4O5SlnYcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ENUbyu8t/sSMrkv9lkVrW5ewZ3R+PF7kctF9LsV3hhbnppD7BZKaJJXZYSS0x9S9kuFnTiXQQmsXgEgzoPB8KkwOOXABwyzUpHTZ1gkHS0bLf+lKYv1zouq/nyUFkIFHC+00ul/GeXSMjYRwtr9M9rVMcEVtiOuTFjhIGH/IqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd22eAH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E850C4CEDD;
	Thu, 13 Mar 2025 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856997;
	bh=KS2rOBtkxAgtVikn0bTfqcz+5ta18w4agh4O5SlnYcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jd22eAH/rzKmUcy0P3aNtgWcNbVXNrJfzT82ziIeYK2jz8AAmg4iQsS+APS5cE7nl
	 xn8vEvDe63titi3FXsiwxicbgVyOHYF7AaOJhAvaimVHZTPcZaabxZ6VFuusuU9b2k
	 hYQMeRyxU0yy7Zn4wfFEuKO73qdag2DrXkVza4bWMuRKMziP8m71OLXrNiJDYqU5Zj
	 AamssTIGOFY8eqnUEJhpi0XjildB4Xgp2Baaw682RBH9Qg3TItjDY4fINqH7N1wcz9
	 FJ0m5OCvBOlZkPdwnNI1uj4tLTyv+ZiwdMSne30emX9k9qHaw7O8K4TlHRr8S+woxX
	 EI4l2kYvAQqhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3C63806651;
	Thu, 13 Mar 2025 09:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/2] net: hsr: Fix PRP duplicate detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185703151.1429089.2609915440433939062.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 09:10:31 +0000
References: <20250307161700.1045-1-jkarrenpalo@gmail.com>
In-Reply-To: <20250307161700.1045-1-jkarrenpalo@gmail.com>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, lukma@denx.de, danishanwar@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jaakko.karrenpalo@fi.abb.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Mar 2025 18:16:59 +0200 you wrote:
> Add PRP specific function for handling duplicate
> packets. This is needed because of potential
> L2 802.1p prioritization done by network switches.
> 
> The L2 prioritization can re-order the PRP packets
> from a node causing the existing implementation to
> discard the frame(s) that have been received 'late'
> because the sequence number is before the previous
> received packet. This can happen if the node is
> sending multiple frames back-to-back with different
> priority.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: hsr: Fix PRP duplicate detection
    https://git.kernel.org/netdev/net-next/c/05fd00e5e7b1
  - [net-next,v5,2/2] net: hsr: Add KUnit test for PRP
    https://git.kernel.org/netdev/net-next/c/814dbf4b6c95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



