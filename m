Return-Path: <linux-kernel+bounces-205797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B300D900065
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA68428DD6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27215DBC0;
	Fri,  7 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjMsvr/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DB15D5B2;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755030; cv=none; b=MvhiOjLE2Tjs/vUJaY5SRVGevA0+wDT22yhGhBSBVFAcZQtLTlje0IMcUveWwVrAfpGuYDiZsHZrcSG6H6wIHpmsHSRnjehsDUb40VK7/MnOZ4jBRkHXTFpf8m+WBQA4jtOEiorsnMW3/vUmAUK7UWQ4Y90o9UMzPTauWunGVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755030; c=relaxed/simple;
	bh=FVslamAwlV2F+uLh9RV1KrTV/WJ8HEMSH4ggltQtDF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DOxLiDlQTdhd/UmKFYZqasYBXrXEpUYHvHboklUrxKqVqeRE8jJUgx9p9O7RSpkO62W9URQpwL5nf2QZrH5OSEWlPgokBtybw6yS5Q/mnlwH27JUTQdmGKKH+NQndpljqBHpBmsJOsXfEn5y9FAVyBvaZydo0YlU3n4J9mbSCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjMsvr/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4126C4AF0B;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755029;
	bh=FVslamAwlV2F+uLh9RV1KrTV/WJ8HEMSH4ggltQtDF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjMsvr/KI3OrHtqHA9fuIg3quZUtV9dwo2zNUeoHNhwVBGjSltGO6G0wyQDM3we+t
	 dLfAa+EfEr9iIFpL0i6SzP0jMZmk05XPy/3CYkca2xMCI9Sxd4I4irn9oojCdhhMTC
	 y1RKywDpqtub/BQ+M7J2T437vS7CNfev+4jW6p1EpQJ8NEAPHbZ+op6Spnaj1vyOfz
	 HMqF72yKLg+wapRxEmLNfFTVUiABh/qjeJ3c6bozobr25tLLD94TzBCAnDx5boS0RI
	 RJYTFi2lhgyyEYhC2eEf3qAFIKBHbu5gFvJJjR9phe/MOj0BRPoOnU4YZAXrivfPJv
	 jsnIix0/6vdDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADE5BCF3BA3;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171775502970.9691.11396054272859229908.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 10:10:29 +0000
References: <20240606180507.3332237-1-linux@roeck-us.net>
In-Reply-To: <20240606180507.3332237-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 bleung@chromium.org, linux@weissschuh.net

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu,  6 Jun 2024 11:05:07 -0700 you wrote:
> 0-day complains:
> 
> drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
> 
> Fix by using a __le16 typed variable as parameter to le16_to_cpu().
> 
> Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> [...]

Here is the summary with links:
  - hwmon: (cros-ec_hwmon) Fix access to restricted __le16
    https://git.kernel.org/chrome-platform/c/c8a4bdca928d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



