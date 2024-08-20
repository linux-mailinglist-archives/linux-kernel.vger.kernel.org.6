Return-Path: <linux-kernel+bounces-294094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E39588E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9891F21EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F11917E2;
	Tue, 20 Aug 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLvfqDMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF9190486;
	Tue, 20 Aug 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163568; cv=none; b=T1TcVmyI4wi98p8W1Sz1GJc/7pOVbO5XMhd6brI9fD3iAdo8tTinU7j0cuyGqcEXkO8O5hFRwyrJ0e2Zig8EEenFKpa2nLqGGehDBa+6M0YhdXALakkOWC2xfIaESOIFPffPM37ER7uQWIIk9DTzU0WXP55M9sKcWqKLJcN4uJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163568; c=relaxed/simple;
	bh=j0JDv1N4HNRsMbjk+DNy4CqAhbFiGVYkfQVCqlomYFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cWwRHkdYseHNfOoJeuSAAjyb5ffTLcMHNhKi6SpMe8/OmcLJf5TU1eCOIHLH+jrnRnoXBXslZ0OiIxJkFfisSlxVyB9maAY4TfaIbYwNfYA6J/2fokFmRxkRtExexJ4ZKWFouM6V2NWOwqBpZvM3zgq099VSG1G8NtHvzzsk+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLvfqDMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B9C4AF10;
	Tue, 20 Aug 2024 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724163567;
	bh=j0JDv1N4HNRsMbjk+DNy4CqAhbFiGVYkfQVCqlomYFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KLvfqDMXBT5ucXRxaB/4+wLQlHBvrK2MGmV1Bbw74EMcEAvpVemGf/6POMA+ShvFI
	 QXARICJ8lr6PPnb5xcNPYJHSB+KhZFJaAvpUQnVjyOJNSuQ560aucjKpdpPwTE+dSD
	 kVfsRy9E2Tubo1TEu4JCiNVOj98ytOthYOPw+Rvpe2Og9fipCXTCNJnqenrW+MtwVA
	 n2z8UDx/bgwVpO3hsYqJOszatIwql/qGw88nSthynXZjuiH5s/VIHrxlVkOWS3gVs8
	 lH0Yp2gumTOHUZ5s6TwJGPbIhNV62J58oPzYhI8DWk5FnzhmF5PxwlvdV0h0KI59e4
	 LBs+3aATSGngA==
From: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZsPty8oNMQk4YTl1@google.com>
References: <ZsPty8oNMQk4YTl1@google.com>
Subject: Re: [PATCH] ASoC: tas5086: use sleeping variants of gpiod API
Message-Id: <172416356610.261879.3153828567035739715.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 15:19:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 18:13:47 -0700, Dmitry Torokhov wrote:
> The driver does not access reset GPIO in atomic contexts so it is usable
> with GPIOs that may sleep during access. Switch to using
> gpiod_set_value_cansleep().
> 
> Also the reset GPIO is configured as output at the time it is acquired,
> there is no need to use gpiod_direction_output() when executing reset
> sequence.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas5086: use sleeping variants of gpiod API
      commit: 5f83ee4b1f0c04a8b4125daab8918606df3dc035

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


