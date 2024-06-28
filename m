Return-Path: <linux-kernel+bounces-234267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BFA91C479
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1541A282E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619F1CCCBD;
	Fri, 28 Jun 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL08k6Gc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5611CD5CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594419; cv=none; b=lIHEx0B6TiRc9IpksOGzWT4V+TvtUnxnp0pMxaLcCJL2m5WOpxrnXMrNF9VuYVhLNWx3S50UNcR489fwu3TpsSJzu1+l5yi3bFFO2RS17v3/46hMPSF6oiL1yy+3nBbtxk+NsvJYbZ0/OYTzwv60OhxBLV23UiH0tkR7HxAhdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594419; c=relaxed/simple;
	bh=e27XHNkDKL+1iM5Es0V0iOZAvaQKSuK2qw+eY90lBwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RyfGGJlwj/KHo4kKWDC6XW5LYOEefhub8uOKZw7ZDUllSm780odIl2BgyIMUDGs7s6OLmYaVbftYfONSJmCumnChPHBfDfX76Q8TeJEqTIwPiHIplR1HTGwnI1YqOjE4HZgFzXo3MBSVwV/hqAlQQ/pM3ByqueR9KxM5zzU2/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL08k6Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A63EC2BD10;
	Fri, 28 Jun 2024 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594419;
	bh=e27XHNkDKL+1iM5Es0V0iOZAvaQKSuK2qw+eY90lBwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mL08k6GcCT+4je9d6lZuRBvtQ8Wz3szpKS6lcx8BrLMPCG8jVTC3H/ibrV5cMoasO
	 Xuevxmm3VBZRSBdwc4i0E6pd/HDUXUSBf2IQXxK983cGXRUsWP2flbuNon+hLk9in4
	 XBJYx3zTyfkn2gjqTRmoWI72W6DiRwGgA3iSe3mrYwO8LXPyeyU+JTqXzh43IH1vIa
	 DerwazdUZKt+fjxvp06Ul3pA4ev7QAEDf4mLHoImEvNj5Fruo48HTdTHe6fOxpUMGJ
	 99TvEMyysd51Mc1jlgADKaknkG/5Zm61VwM1k937zF5mUjTtNYsQ1JCnPRcyt5IzSC
	 ih70G8rwe0vew==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628120130.2015665-1-jbrunet@baylibre.com>
References: <20240628120130.2015665-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: soc-utils: allow sample rate up to 768kHz for
 the dummy dai
Message-Id: <171959441829.130075.12252644545432851916.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 28 Jun 2024 14:01:29 +0200, Jerome Brunet wrote:
> The dummy DAI should allow any (reasonable) rates possible.
> Make the rate continuous for dummy and set range from 5512Hz to 768kHz
> 
> The change is mostly cosmetic as dummy is skipped when setting
> the hwparams.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-utils: allow sample rate up to 768kHz for the dummy dai
      commit: 4adf454ff62883ee64b0b9818b951f34aa078d5a

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


