Return-Path: <linux-kernel+bounces-205795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE5900062
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C57B28DE03
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81B15DBAD;
	Fri,  7 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP4ynT23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDF15B0E7;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755029; cv=none; b=sQVtcleG1xJkF+SWuUs29yOtndtED1bCf7xNUJ8ztG+XF9vbAhOZ2m8RJ3dKJDsL40FVzOzZsKczvZ9NCYcO5ulUJBLGEAZ5oMZOOjjcmRF/alX1mog8NK4Izp9FAGUM5gPdg8uSChPQ/tC+1yXgxlprhVJglurFe2Y9jJa4lP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755029; c=relaxed/simple;
	bh=fJJpTcmE67gybMtkto49XtqnJGcpAyK+OZybc/rYHxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+GQ+XlrnmnW7Reobju1atBIczmP8OrrBZGQb9/pc67/GayJKdZkPsjBKY8MWg+J1QcsEsoCuilxHbT2+Rk/3vjODHtbmoSLbvxqwDrxvcj98vr+PyXsFTxj4bwDTI06QUCmkDjELyG89DAwv7tpsHbVx3IDhl9PhWgfmJ3q55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP4ynT23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 614EAC4AF07;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755029;
	bh=fJJpTcmE67gybMtkto49XtqnJGcpAyK+OZybc/rYHxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kP4ynT23Jn0AUXgJxbNNHno1mo6JyEaJhVEwa1jluovymJqBoF4QBL2fOg8Cn81Mq
	 W6dh3U2xgtcR694oBeoss6800HbUiIo1VaZUY+Q53uIFAaET+ru8gradUQNKhTpxht
	 qUNVu/9stxLf05Q26YV3IOLhKYHYULS5Xh9pnQ4KzS9+hL3QzZvoBXw8zs4cyIVaSN
	 TfdsWhjVB7lt74h2CdRx5qJYhetWKDz4wYfgqL32WdNysv3C1Q9NbzpLCnv1XAWclL
	 sNRbPpZbO39xdPWf4Wm24exslLbniddJkz79AFcRBZHqurD5zd7wXJZ1hOuO4C6WHO
	 GFpuFTsIHtY7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A25CF3BA3;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hwmon: (cros_ec) Prevent read overflow in probe()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171775502934.9691.12638692648620767166.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 10:10:29 +0000
References: <42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain>
In-Reply-To: <42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux@weissschuh.net, thomas@weissschuh.net, jdelvare@suse.com,
 linux@roeck-us.net, bleung@chromium.org, tzungbi@kernel.org,
 chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 6 Jun 2024 16:12:11 +0300 you wrote:
> The "resp.sensor_name" comes from cros_ec_cmd() and it hasn't necessarily
> been NUL terminated.  We had not intended to read past "sensor_name_size"
> bytes, however, there is a width vs precision bug in the format string.
> The format needs to be precision '%.*s' instead of width '%*s'.
> Precision prevents an out of bounds read, but width is a no-op.
> 
> Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - hwmon: (cros_ec) Prevent read overflow in probe()
    https://git.kernel.org/chrome-platform/c/1f72dd046270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



