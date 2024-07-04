Return-Path: <linux-kernel+bounces-240985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75627927556
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200501F24D36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8971AC447;
	Thu,  4 Jul 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVTplohB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BF17B410;
	Thu,  4 Jul 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093336; cv=none; b=YkumqC6YAx/qKRn3aPVTf+RZ56rgHL/ChHlMb8dHp0+vjD7qF5vulb1g2o1V+NlsYy2GyucKCO0f3CL9eKXZFmW1vSUh7n2gGYYPdJl2/0pB1D+9VA7iuvX/5xk44QP/gqpiQHsvPB3pa/rIqGQ7yRmx9riZZFzVNqzs0d6USsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093336; c=relaxed/simple;
	bh=stZBtm/0v1LSoKFqjt/ikzo4FA1KZbF+BMeuF8x9aVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qC+RWaWlvKm8Wukr+k4alNhcdR3I4ctqRZDrD6VCrA16+BXQI/r7w86oZXho9yhJXlqpVwUfmavCzDS82TFjV9xlw/ZioDXyYrltHCqQw8O8FxxEvE11ZKlhYgSfudWscMq78hMvKPfakiVqKBq29WXN2lf2lzwGG+F0FRD07Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVTplohB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E444AC3277B;
	Thu,  4 Jul 2024 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720093335;
	bh=stZBtm/0v1LSoKFqjt/ikzo4FA1KZbF+BMeuF8x9aVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cVTplohBA6oAWsg490qFGevGJ3yrfvrdaMSIrUYeQjH+DD5JxJpvkdTPwkpYv1apF
	 qIzCi6xoJIrcQKRsgoM5eysik12FeRTiMjYY2zSNyHAqHSmfsxAFtk+0ycnTEbajb4
	 zG2/pDGIyvgbmhyyaLRarLJU7iAoak9u3lo1YFYpOAqFYMBclPFQHnM3wsADlWLzJU
	 HYmpvTKqoE2xZ7f1+aBgoqrY+Dly/xF7c+SfYUeoDol4Nuh0y/F7Gvy2/b/jiCaINQ
	 +E0YmTbhiLUOSIt8oMR6X/AQIwKZg1ddtCGAGMq06xnSHewRjelGLQBqR0eyroYMwx
	 Xkca4Fv0xLhOQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shenghao Ding <13916275206@139.com>, alsa-devel@alsa-project.org
In-Reply-To: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
References: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
Subject: Re: (subset) [PATCH 0/4] ASoC: tas*: Fix up GPIO usage
Message-Id: <172009333244.28053.17496645260509712348.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 12:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 01 Jul 2024 09:02:11 +0200, Linus Walleij wrote:
> The TI TAS drivers use some legacy GPIO code and headers,
> this series fixes it up.
> 
> The TAS2781 is a special case since it adds a handful of
> lines of deviating code to reconfigure a GPIO line for
> IRQ mode and then never actually use the IRQ obtained in
> the code. Is the line used by autonomous hardware? I'm
> puzzled by this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: tas5086: Convert to GPIO descriptors
      commit: 3b628e617b21144579bbca806a26737e8485d93a

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


