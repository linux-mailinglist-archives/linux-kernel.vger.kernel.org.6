Return-Path: <linux-kernel+bounces-344859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624298AF04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983C41C21BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1111A3A9E;
	Mon, 30 Sep 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiURxv7s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AC1A257D;
	Mon, 30 Sep 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731597; cv=none; b=EenIV9sqBohsEd+oyzh4nz4j01xGV2yrRYdP6U0K+2NEihHERZGTYshyxw04/pAEG3H8WwxQjdkZu/n8/TE4xdcB9fnaG5m7kTTKsFKPmgZ2twFfgXOUIALZ7DxN08LdFpwjSHyvsPU/Sdnu3V4kwSbMdA3WmJI1sZmWX2accIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731597; c=relaxed/simple;
	bh=veuninIKx7QYinPBmCwwfQiyLb05lA5LCrphoSHqTqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bhVKPIvZIBXQ1PBRREW4nF/xBwgtp9Yv2Te/WuS8q/PjDHMfc1anQ1QfnISbFEISM7gbxbq8mWDII0Bi9HSwLMIWw3HhcaFMVUovXQ1N7wW/BNsSgCSeHOP0Wp2kt5nb7eUBT0jFx3o9X4fSotyfeUcy1LNOV6IeHto/bbYNKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiURxv7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9E2C4CEC7;
	Mon, 30 Sep 2024 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731596;
	bh=veuninIKx7QYinPBmCwwfQiyLb05lA5LCrphoSHqTqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GiURxv7sbbjhMHaH0tDr0g8pA8QZQOGxqmbeExzAcFohmWfqqAC9sK3+ZxrvuqUdh
	 BBLm0a/5EZnAzIyJALuSxxPRrxyzXPBZd4nLdhA+0oluSxdT47u7S6tl6FeMGrgOQl
	 AzZM8Ha8JYrgEQVX3rvSETBj8CZGDXN2eGr+iW+hnyRgqx1Rze0MY452pWSRKghgQu
	 7cjY9gdO1mwInCsE6xZjbMG8NQOBfowhWcBtEctqqHJhg+cYDRGAZoVYCgCyz8yHxC
	 0Dr4X/S5Wm3D1HhznhD4moZDv4BBKbLXKec5uZrZO6oyTtg7uJK4WVqMkTg3fipgYE
	 v7NloAuTt4AYg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240920-asoc-axg-iface-continuous-v1-1-6075d7db0e61@baylibre.com>
References: <20240920-asoc-axg-iface-continuous-v1-1-6075d7db0e61@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-iface: set continuous rates
Message-Id: <172773159468.2197048.15947948691093286494.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 20 Sep 2024 19:22:05 +0200, Jerome Brunet wrote:
> The axg TDM HW does not depend on a selected set of rates.
> The hardware itself, just takes an input clock and work with it, regardless
> of its rate. In this way, the rates TDM can take are continuous.
> 
> What might force the use of specific rate are the PLL available as clock
> and/or the codecs facing the TDM HW. Either way, this constraint does not
> belong in the TDM interface driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-iface: set continuous rates
      commit: 3a02cc576accdccb22ffd2d6ac1f9788c7b4c7ce

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


