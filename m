Return-Path: <linux-kernel+bounces-203230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B668FD818
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8DC1C23828
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58615F3ED;
	Wed,  5 Jun 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5bLm2Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD374965B;
	Wed,  5 Jun 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621533; cv=none; b=FDAFHipy2G84MfanpzdVjOmOShpwjE6IhI3kmIFuyH2wlerloVzTh0CdLTi9fAE+wa1TE1Gx2RWYL4/mCUr/ec58wMLwbynFz1hUYi8QFAcaAxNDmoLyY0p7OYM3XUj33opHOAHOi054QcLXWhcgEjJkbwRjfWtrxcaQ4kbpMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621533; c=relaxed/simple;
	bh=vyVyWpamBkhCibWqrfOK0k2btOHC5xE3kXgbNGIntKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fMYHItDsau6Jkjm/mPvHRML3wtDCMGWruelZ44EHKBfDBzf5iONclypL8BGeV1BcgkY5gfWz/pvVW0snmHuhgfKqH7qBqzZP/dXRGGRtEdnpLLrv5J7NFdi7yUoMXIApYDRHWJZ70d/u4c0LGoKCdsmIL10bSfDGGaK2C2t3SXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5bLm2Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B75C2BD11;
	Wed,  5 Jun 2024 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717621532;
	bh=vyVyWpamBkhCibWqrfOK0k2btOHC5xE3kXgbNGIntKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P5bLm2Y1KeGSag+rNs+2DpD5bY/QXV89c223ilnqh9HJ6pHE8cViiSt0TNL2s7h8w
	 AwRGkgPlZVjdVx9XmmEjtFBkluoSfbeGJyXzcKiO3lqQjlLNbrtspmcmcMiBL+GbVM
	 aUXB8xi1S+d4MhpV6CsMA0fdR1ZIxCSVp8YUdYwyVsaaDxayadxE+1mfisHfizGitN
	 OUrUm6oilb76eEZBH4CGhtV95roADGOpMlkJElwwjCFVCeRUEE1YD+whkoZywyJsSv
	 CmMSM72YP2Eft8rh+hRYPp7loZaPIBVzOmaercAiUL6vmtzWjU1mfNf+Sad716mHzz
	 cTKsR3xQiIqjw==
From: Mark Brown <broonie@kernel.org>
To: luca.ceresoli@bootlin.com, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, 
 Alibek Omarov <a1ba.omarov@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240604184752.697313-1-a1ba.omarov@gmail.com>
References: <20240604184752.697313-1-a1ba.omarov@gmail.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s-tdm: Fix trcm mode by setting
 clock on right mclk
Message-Id: <171762152990.557520.1569792742795917762.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:05:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 04 Jun 2024 21:47:52 +0300, Alibek Omarov wrote:
> When TRCM mode is enabled, I2S RX and TX clocks are synchronized through
> selected clock source. Without this fix BCLK and LRCK might get parented
> to an uninitialized MCLK and the DAI will receive data at wrong pace.
> 
> However, unlike in original i2s-tdm driver, there is no need to manually
> synchronize mclk_rx and mclk_tx, as only one gets used anyway.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk
      commit: ccd8d753f0fe8f16745fa2b6be5946349731d901

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


