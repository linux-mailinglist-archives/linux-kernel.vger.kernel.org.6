Return-Path: <linux-kernel+bounces-313546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D296A6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984401F21E18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74A192583;
	Tue,  3 Sep 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyfTuXvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021DBA53;
	Tue,  3 Sep 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389430; cv=none; b=Yi4q6odbMccJ6Ph9S1OifWoDj0j6+ovT6lZ/7+0GDdtBpgc2bYzCrHW2iu9P3W7wCR3Fb41+myFnFAfPaUABWWK+LPxlUY+hu1sKW4je1vD5yJweuAosvEHZjBExXEFgNirvG/1XTGvIMona572ozFwGpBdk4L6Qoqs2FFbKstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389430; c=relaxed/simple;
	bh=SNpY72thgBs1zRLMoTRa0FG6EbQhuX1HeYdZwy33ptk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJ8A8QHm8jig/+pd/W9YMLsr+DOcIi0JThZ/wghb6U5sKKV/Plajm5+Zp0pm04naL0oxpetubDoYzTNJxTEZg7YUlfNQDovwcSW9zssuy48rq1ISL3+QX45ZDfrMuXCKuUk3hW+ZcVkRcLHzdPhtP0Xp1sURgjEpmRIBODBy2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyfTuXvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A4C4CEC4;
	Tue,  3 Sep 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389429;
	bh=SNpY72thgBs1zRLMoTRa0FG6EbQhuX1HeYdZwy33ptk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kyfTuXvJTbxwR4lTw30gPBCEAegxYLE7OubdZaIZ+ZkMxMS/56q1KvP7JCXF1zOa1
	 1xuOPlVcbEw5vYuwz4FAMeAx+ZMfTKxqxf0137ZOwVVwNHHbXB/Tm0j1u56Xj5wSLM
	 lrriL0EJmHqmsUWhWjOcC5hZevGL5zsZEN+grrTdvmMoH4Rv+ho5om15yb1YiXzoa7
	 TaixYN36JPoXMMzZJoVKsaR7gI7hnKisgFyPgkeDBopIgR1Z1nE5GxDigo3BiPbwpo
	 wrRgxKhUoPux+IVKm7SG5fVOCOrYV6IdWAB/RShm6nl5DtloGbJgIzEvzkyWZQQ/cA
	 qIFpNTiu1Mmww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1B3822D69;
	Tue,  3 Sep 2024 18:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172538943051.403883.13946561515764029455.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 18:50:30 +0000
References: <20240829175201.670718-1-oneukum@suse.com>
In-Reply-To: <20240829175201.670718-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 19:50:55 +0200 you wrote:
> The driver generates a random MAC once on load
> and uses it over and over, including on two devices
> needing a random MAC at the same time.
> 
> Jakub suggested revamping the driver to the modern
> API for setting a random MAC rather than fixing
> the old stuff.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] usbnet: modern method to get random MAC
    https://git.kernel.org/netdev/net/c/bab8eb0dd4cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



