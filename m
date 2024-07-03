Return-Path: <linux-kernel+bounces-239935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5759266FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298DFB2256F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8887187547;
	Wed,  3 Jul 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNLaOhat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA118732E;
	Wed,  3 Jul 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027292; cv=none; b=aMLOdOqiYaxrX4PsuJvCbunl7RdBt+DAKmBtjHngf80F3ueDueJVKrWAd9xl/QOhb7OSezd3H7ZCDPERo9PES3jWlAiNhZNRNx5/lO7gUKMe7++brEr5wAy/sQSFsct5Y8QFn27eaDVBKPeF0UiwCs1ee7U13ffcjREeKZmVykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027292; c=relaxed/simple;
	bh=giXUCjE/bVF2J8IwN5KMHAKxDuYcdenGtsscvyNcoFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MOHip8JVG8x+4ju7DiEebAtmKQV1BFny/Kf0tm8ClIFplAVovOYJ91vjXR1L/j/zV5fE7vlIFjGTwPoKRfglIPDnK4slw6P/BsQc6xxUCJ4vlwUPSqjCOar5IcmvPuOWnT3PkN3WOnFYlcqN8UnhFI4otZDxf3REYmOGxX+5EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNLaOhat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83588C4AF07;
	Wed,  3 Jul 2024 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720027291;
	bh=giXUCjE/bVF2J8IwN5KMHAKxDuYcdenGtsscvyNcoFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DNLaOhatSyBmheBUCTXVoWP9pBSwvdkQCzPKio/jnWsJ28MZn/w9C/jXgxgYIHGA4
	 +d3qWvFjFE9pDjd7FUTzpHs964S2+gFb9ZLZAlEMy9wMMH+DC/xzZqUB4RwXocLw5m
	 ypk1gtUICiffHOFiLu0VoeAVcuwictBtFbE7QaAsujwbV5O+d1SnGMay3WZGJnRtVn
	 NfwnLIlcsrS5qvLUe+pZT9uCYrB3EoFJbACcl81XVlfykkQKE5lPnQK1F9dnXS98bn
	 ZEDGS6kQFD4phMsjoUvq0kla0oNEwjZQkDq1pVvUZ5rhTCts/SIYSP44GDCDqOZs6u
	 M+ZeMzL8WTMeQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240703095517.208077-1-rf@opensource.cirrus.com>
References: <20240703095517.208077-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l56: Set correct upper volume limit
Message-Id: <172002729026.88190.11217430564421888436.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 18:21:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 03 Jul 2024 10:55:15 +0100, Richard Fitzgerald wrote:
> These two commits set the upper limit of the Speaker Volume control
> to +12dB instead of +100dB.
> 
> This should have been a simple 1-line change to the #define in the
> header file, but only the HDA cs35l56 driver is using this define.
> The ASoC cs35l56 driver was using hardcoded numbers instead of the
> header defines.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l56: Use header defines for Speaker Volume control definition
      commit: c66995ae403073212f5ba60d2079003866c6e130
[2/2] ASoC: cs35l56: Limit Speaker Volume to +12dB maximum
      commit: 244389bd42870640c4b5ef672a360da329b579ed

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


