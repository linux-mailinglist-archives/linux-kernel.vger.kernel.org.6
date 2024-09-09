Return-Path: <linux-kernel+bounces-322146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637A9724B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43EA1F243BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB418C925;
	Mon,  9 Sep 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZGFmF7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746858F5A;
	Mon,  9 Sep 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919040; cv=none; b=CKhdnksWhH0aTj4qD4mee/8Q1mgirssCoJkr7GdUCBd4ob7kVjs0VL5DMBLFEzBL49xKxw+f8xib96YH3WkTEUfnUC74fEzMpK3UzEn/ElPykJigYmxYn30A2R937vcRwVS4tang0SUSJ4JFZ1nBQ/piuyt3jCRclH6vKboTTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919040; c=relaxed/simple;
	bh=2UqAJVFWBnjGJoioHdA1uFRvBlpi1A+ZG7kkU7DYCGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g9UPJWZo8AkiAEjCCrOvFSlzstI27TKbo4OHkOXop8EaE9XwP4W0K6uF1uZmhuN2TrqvG8aprU3KeaOSgpeR7494TGPN6pRh19ZiU1/PFwSspBHIqeU0rXfMgbDJRB3PWTjnXTlI6jjTg3ktAegnH1Pr7pdPvxsGx3oKALshpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZGFmF7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F98C4CECB;
	Mon,  9 Sep 2024 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725919040;
	bh=2UqAJVFWBnjGJoioHdA1uFRvBlpi1A+ZG7kkU7DYCGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XZGFmF7KMgt+DbN5wp9RuN4VheJL/oWNBdMiHvhi/FbVbckqAELzDes8OYxH6gLRy
	 MqiHsUBvwabRIWxx9tPABWEgeEu7nk7mYHRrlSfG0xHKlVKhAQ2HXvd9BXW3DfOzAk
	 fQRgWmwzXdJiIia3E+JFl7s0VMAn4cBJPwLfmKiRJW2DFOGyusWO1KMRm7JyndHGEV
	 FaUzpxAQ2PaCzbJAtrAvZbYsApvr6CDYP3QRRLIWWX18JiSrf0cL2bRSZJ/b1CmwWX
	 qlOLX1/RDJ8Qsy8x/tPlxcnwFksXC5mylNS2GkAA3fh2+lKWJYhLqr5zz0D+X3jB7z
	 TLNozMClrByZQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: mt8365: Fix -Werror builds
Message-Id: <172591903776.148496.17884899696654432666.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 22:57:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sat, 07 Sep 2024 01:53:25 +0100, Mark Brown wrote:
> Nathan reported that the newly added mt8365 drivers were causing a
> number of warnings which break -Werror builds, these were only visible
> on arm64 since the drivers did not have COMPILE_TEST enabled.  Fix this
> and some other minor stuff I noticed while doing so.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: mt8365: Open code BIT() to avoid spurious warnings
      commit: d01c6a398750aae265c17859b57d7409a6d9181d
[2/7] ASoC: mt8365: Remove spurious unsigned long casts
      commit: 1b084d8e3b98ca460b815cff14617719ebe605ad
[3/7] ASoC: mt8365: Remove unused prototype for mt8365_afe_clk_group_48k()
      commit: 3e61df7d2ff67875c770a7f548038054d05a0f15
[4/7] ASoC: mt8365: Make non-exported functions static
      commit: 63157d994025639075b3faa372976a96186322c1
[5/7] ASoC: mt8365: Remove unused variables
      commit: 067d832806225cfaabeec8f5f683b7e2bc508a6d
[6/7] ASoC: mt8365: Remove unused DMIC IIR coefficient configuration
      commit: d70ce6d3105a6bd02b1708c399105631643a550a
[7/7] ASoC: mt8365: Allow build coverage
      commit: 36fa259b214c37bbae3e0b7a47e7fb49cb0ab462

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


