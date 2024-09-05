Return-Path: <linux-kernel+bounces-317312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED496DC2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725F9286747
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484617BA5;
	Thu,  5 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipggf7NM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A8168DC;
	Thu,  5 Sep 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547429; cv=none; b=o5/HpDF4OHghxFAPA0AUmeJyMVcDhmyUCDOi8DiwEh5fBOt8xCvZs2gP9YB9BBcQ2WCkFgjCCFGrSleQBkpmKEyQmRMAJH8HUDjSXkMS5UadcfJYe8cra8kX0UujYiNJqkCpASyc3Iq+rEaPiooQfEOJVZZ+vqXJZSeXIbF/38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547429; c=relaxed/simple;
	bh=kn8IWovie9Ztxca1VoLhrlCB8UCzsBhW/erL0/lsOR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyuXqYlDIhJV6E5UCoqymk9jW+rss5IU2L0RmOvnAF8EZD2HPNbqxJOtltjL3XeCRW8yjPOxKFSZ6I9RornBliyjJLuWpGYsHLAYdsQn6nqEg1jnL6NX4d1nu8+mRcwO8xjK0HcqsaYJjDF975GRZVYPOr4wdkj3X2TpwfzkqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipggf7NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1682C4CEC3;
	Thu,  5 Sep 2024 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547429;
	bh=kn8IWovie9Ztxca1VoLhrlCB8UCzsBhW/erL0/lsOR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ipggf7NMKyUa/gAxukpHjiOqsOBpLq7Jr6bB/MxdWWIbIOjvD9nncsI3w2WXZdm7n
	 pcHUoUCa8P2rsqn7WTUt4mXns1WL6SK6aj56QutJMsrWjLAbWocqUKHBXwDtNzesRJ
	 7OgGrJTvVOUSbWi1fSSX3KrT5w8y0Z5q2UdSIc02o/ULQk4vFG/6b5ZcK4CH1sHyyd
	 Lc14fSRbkCF8wD9jyfWnYasN7C+crdc/9r8z2xj/u6i6xvEwvMKofNAAcPOa6VmWqv
	 bYaq7tD0I7XOQXDltDwq2OL8rM6emZl+9z0sOlAdBgK4aFTeL4vS0D9rbl/RGq7p8L
	 swC3rjCUEhwzg==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
In-Reply-To: <20240905095633.113784-1-andrei.simion@microchip.com>
References: <20240905095633.113784-1-andrei.simion@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-i2s-mcc: Improve maxburst
 calculation for better performance
Message-Id: <172554742664.49204.15446673448032504147.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 15:43:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 12:56:33 +0300, Andrei Simion wrote:
> The period size represents the size of the DMA descriptor. To ensure all
> DMA descriptors start from a well-aligned address, the period size must
> be divided by (sample size * maxburst), not just by maxburst.
> This adjustment allows for computing a higher maxburst value, thereby
> increasing the performance of the DMA transfer.
> Previously, snd_pcm_lib_period_bytes() returned 0 because the runtime HW
> parameters are computed after the hw_params() callbacks are used.
> To address this, we now use params_*() functions to compute the period
> size accurately. This change optimizes the DMA transfer performance by
> ensuring proper alignment and efficient use of maxburst values.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-i2s-mcc: Improve maxburst calculation for better performance
      commit: 03667e3d4fbcaf6228fd642464467366f0b693de

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


