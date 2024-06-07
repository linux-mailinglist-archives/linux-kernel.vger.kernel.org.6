Return-Path: <linux-kernel+bounces-205796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C585D900063
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6879328DE27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071B15DBB5;
	Fri,  7 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFGFUZI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271D15B0FB;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755030; cv=none; b=gjEdtqgUBY4G1Y6LRABSAfbQnL7MKkb2FLF/hrtM0qKG9dEwPRvwuWjqlKZjGI1EcxKesx7wyxQUBZFcS4XmUolWm53BibxrdHnhi+9pwOih5OkjjRhqnOEDuRp4LGwdkCYRzLmEqY/r6jBKmFYRCaU46uG5PfYRFUsIkWtZ+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755030; c=relaxed/simple;
	bh=3q+16WX6b8x4qD8IG0VF1CV7m3QLtG8soxVfGdyTrsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mO1FvWYCh3KBzp+U1xap2jSNjjEbQToMFfU3D6lLUQ6Zc10KukIfps8WfXmSUq830OyGBI2VZSarP2TPv6+lw8mbcd1Q/QnMnG2nd+8T08cwlMDY7/MfTjZRnmLJMsqfDR3J0SxMVSLYRzWA5PPn8E82wTAZS8Qnd0pbYWuIr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFGFUZI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2472C2BBFC;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755029;
	bh=3q+16WX6b8x4qD8IG0VF1CV7m3QLtG8soxVfGdyTrsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFGFUZI7zlKn8NPLtzDlgL+0PX8p2y976S9t6o8wXqN898f9E7J4xMSTsSohZQ79C
	 Z8s/1aqbIiWKWiQw6gYeyIm/fq7bqJcJwpWxtBbNy3HaawmPONk9uDy8l9bEr0/nW3
	 Zc1FYCSqYzjFjFRddYQVFlWbJLACVWVYFGYQVAlRL0EqfT2V+G2LJrFnVRDib8w7z6
	 CY/zWXs7e7y77YqIBbHaAegzIDo1JV1Rn/JL/xRtofIuAG4fE1NCSuXfUnlBEjTyu7
	 c0WpgBGaAYhgqVhrctacD0FsFKUR4kOgoeAXsTQXqE89EXCuzOfRtDrE0Wf48uO4of
	 y3TXW1trcLNAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B70B5CF3BA6;
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
 <171775502974.9691.860373891404266889.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 10:10:29 +0000
References: <42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain>
In-Reply-To: <42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux@weissschuh.net, thomas@weissschuh.net, jdelvare@suse.com,
 linux@roeck-us.net, bleung@chromium.org, tzungbi@kernel.org,
 chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



