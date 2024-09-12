Return-Path: <linux-kernel+bounces-326949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C1976EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CCB21F17
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCE1AE87F;
	Thu, 12 Sep 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foLVDVI9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE913D531;
	Thu, 12 Sep 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159380; cv=none; b=deQqAhVNI9Eobg0iI25mivO6q6i5dJbMcdvz1z1VLLt3abSAA2qa5RjJU0WQR2Pkpw31QngcL6OIPRBCKodFQRGk5faOxSFkZmSinUaKEx64H4foUOqXJKcmn5GI+RVAr4alwjEX20q0T9HKX8Unxlh9AjpCSOLQ9b2f5a/yAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159380; c=relaxed/simple;
	bh=Dy1qB/XUHzJb3yDZ0ZEhR9UA1RtJzn1qcAKojgpMbkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TGCQY7BplZ5BG0rdqlweTvkinYUqDwLFpVqDZ0kEAOo0xfpS9pH40J6jKFzXrcsAd589YIdCJ2o6TFPRTi0+ZxRl1DObFkhGOMy8vVN9L9OofbhnSQSL+qbrJ/Lhv3gO8L4O4z9Ib6puCrGZoAaX2JMoUoWmDHoQ85mUv7YOee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foLVDVI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D61C4CEC3;
	Thu, 12 Sep 2024 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159379;
	bh=Dy1qB/XUHzJb3yDZ0ZEhR9UA1RtJzn1qcAKojgpMbkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=foLVDVI9AfPDYA7d331pQScZys3QViy8YFispaPcU94eac/Sgv2vXRAHw1aa91TmF
	 WqmhP/DSK9gYpPMhCwzb24+r3ZEk0YWgFaxwHD+gwLtfcEuBLJwH2tCvzC6pmxGpSg
	 Fzbd4DFAE1jEALXiXBT9009s153vbvLb5qKnTLTKYS84ufgQ704/AGduQm58TD/Buc
	 9hqsFw1kI8SKNNBS8KyZSpldbBrIuauznVrnWSzOcloDRxmheGB7v3YqqbbqNPJ2b7
	 kXs2AFn32HeLqtabc1MkSrtqVxTFd4rtD2mqzHiFOtINLZcq5lXxwasLg+QAhlfnri
	 Po/AkqBgaKd2A==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240911122909.133399-1-andrei.simion@microchip.com>
References: <20240911122909.133399-1-andrei.simion@microchip.com>
Subject: Re: [PATCH 0/3] Improvements for mchp-pdmc
Message-Id: <172615937761.64859.1968686198308301512.b4-ty@kernel.org>
Date: Thu, 12 Sep 2024 17:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 15:29:06 +0300, Andrei Simion wrote:
> This patch set is intended to enhance the functionality and maintainability
> of the mchp-pdmc driver:
> - Enhances performance by refining maxburst logic.
> - Introduces a name for better identification and management.
> - Ensures controls remain intact when streams start/finish,
>   returning -EBUSY if the controller is busy.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: atmel: mchp-pdmc: Improve maxburst calculation for better performance
      commit: 8f0280c84607afe122788e508a171ba163d71be6
[2/3] ASoC: atmel: mchp-pdmc: Add snd_soc_dai_driver name
      commit: e6b95bdc1e333e14e4fdf71fd4e8962429d9b6cd
[3/3] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
      (no commit info)

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


