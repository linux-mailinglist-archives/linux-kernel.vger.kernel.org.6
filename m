Return-Path: <linux-kernel+bounces-189943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90D8CF783
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE4C1F2167E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4AC132;
	Mon, 27 May 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM7unr70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DC1FBA;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778511; cv=none; b=TZ1VY2Wl4ylLO5oVbrzwpZAURhck5/OZdal4rSC7LinP7pL1ncf9zxUaXYS3Ia6tYwL5ZP48rstl4Eh8yvK/Li4q6I+OgIg0QkvDFaviBzNsaK7L6+/V3WYqcp+fpSmlewPFnk4cZ4lzLdqBGEHYcdYnbP8RZSDMgL+eQEAgHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778511; c=relaxed/simple;
	bh=+J2jhZqmD9tVbcp0PsnZ6RwP7Cc7iWFPNZskazlOzV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eG1ejN500QO6R7qK6EGo6OD3w/usGS9aLFRAy+MI8GAHQ/DOpAV6EG8AGyawyxx47rHFrcl7ep0wWLtccRoZijwavPIpdBhEozCnnFIkg7/HCFXHKDnkCgSn9sPFonJJrlEN1P1T7LrFnqh55FSbD4yuCUPFeIHS0Q/HriKgW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM7unr70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E49C4AF08;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778511;
	bh=+J2jhZqmD9tVbcp0PsnZ6RwP7Cc7iWFPNZskazlOzV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VM7unr70e21Judv5lw1k/mRk0S9DkbtwCvyx31g2BXUz5Lsik/7OY04aRdquZ29Ak
	 cNQGU1e/NNbH4oRKsfu0RSJ6YoYsWu5nGXH70EfM2f34rQ04fGryl5aVUdbo5IieuF
	 aW6z83kHwPh6yI57tPDfBHS+1vtqVTeUJuehnw+hC0wjPxhqCFcT2bnNk2VFNzrspd
	 ttjdfOKf107n6HlxryzwI7bnc598Lr2dEC8eDYry37MYUHkM6tZ1bEdQJ3EkWSHKLd
	 kxgQeGjIvvrmdLaM/71oWHIgcRABsm3zsHVNKo1Dm9EFpZXuv00F2x11yCk4FtTqXo
	 UAEWentLzxIqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05781CF21F7;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] firmware: coreboot: store owner from modules with
 coreboot_driver_register()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677851101.1901.12388109509867955776.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 02:55:11 +0000
References: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
In-Reply-To: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: tzungbi@kernel.org, briannorris@chromium.org, jwerner@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 30 Mar 2024 20:49:46 +0100 you wrote:
> Moving the .owner setting code to the core this effectively fixes
> missing .owner in framebuffer-coreboot, memconsole-coreboot and vpd
> drivers.
> 
> Best regards,
> Krzysztof
> 
> [...]

Here is the summary with links:
  - [1/2] firmware: coreboot: store owner from modules with coreboot_driver_register()
    https://git.kernel.org/chrome-platform/c/46c6685e7e88
  - [2/2] firmware: google: cbmem: drop driver owner initialization
    https://git.kernel.org/chrome-platform/c/7f20f21c22aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



