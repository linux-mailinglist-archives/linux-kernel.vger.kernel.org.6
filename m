Return-Path: <linux-kernel+bounces-244795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3992A9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044BD1C212E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422C14D29C;
	Mon,  8 Jul 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMQ2xoJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED014BF87;
	Mon,  8 Jul 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466077; cv=none; b=d6iOqELDzLYwpx+yWYLHkE09/ALuw/p6Z2qAecfvU3ODEs6cwv7wbEV+3yAKUUvEXw5zbiNdE+l1YvUYcgpT5YOlGHcgTBtCw2JHRYNRzdRAK/vFcfP4nCCnI8WsHIj5La8WLklNot+C//IqQ73WKJYjMApwAq23Oy812lYN/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466077; c=relaxed/simple;
	bh=MMzPt1qLEIBFPhRV9nvK5Pdc6T5Fmql+DzmSgYeT42g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=muB5SYfr5eNwaPzLOQlhu0jCVFpnjo/JGoUA3N1hnatGjCBSPBKTEc4urMczhw8cV2CEUm36b30mddccZrlz8Z/HrLdUt49R7hl+N7sAD6EQzRDjzv47s9ihxGjAdKGq5RXeDCEerMg+Lw2RRtBXJIhfKHwHvwR2G/eN/UOcuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMQ2xoJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3CFC3277B;
	Mon,  8 Jul 2024 19:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466077;
	bh=MMzPt1qLEIBFPhRV9nvK5Pdc6T5Fmql+DzmSgYeT42g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CMQ2xoJsPqqdADYwCDYy/gW5cLanL24QDbLS5EDVLOGfvwXCKdGPXIpY74Z5nlbL9
	 uNWjXkhyj/oUe3IvkDZw1Z7BguBh6Wx0i8cS867uhVrKRAzm1xGY6phABCfmqPchUf
	 OkCAYz+uEkGxFMsNsny71RPucWbcrDT6RefehqhWxantYEAClNfcIdRGt7zLetbBmb
	 l94yo3iBAZVfC+Wl1Y9858WifMJ2jWVm3TVImvj/0PU2mDAiOQAcelClasA+/9ApNb
	 4TQ1YPE1kNh1dvQx1oxzguLW9yCfr0t8ZQrpNxK13+IOehjz0AuDlwVLb1BzAkHbwX
	 hsJWsq2ou8CZQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, 
 Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, 
 Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
In-Reply-To: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
References: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
Subject: Re: (subset) [PATCH v6 0/7] ASoC: fsl-asoc-card: add S/PDIF
 controller support
Message-Id: <172046607109.120366.13569145279464885226.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 20:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 27 Jun 2024 10:30:57 +0200, Elinor Montmasson wrote:
> This is the v6 of the series of patches aiming to make the machine
> driver `fsl-asoc-card` compatible with S/PDIF controllers on imx boards.
> The main goal is to allow the use of S/PDIF controllers with ASRC
> modules.
> 
> The `imx-spdif` machine driver already has specific support for S/PDIF
> controllers but doesn't support using an ASRC with it. However, the
> `fsl-asoc-card` machine driver has the necessary code to create a sound
> card which can use an ASRC module.
> It is then possible to extend the support for S/PDIF audio cards by
> merging the `imx-spdif` driver into `fsl-asoc-card`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: fsl-asoc-card: add support for dai links with multiple codecs
      commit: a613b63db233b6e7d46ec72f009c1cbb7db8be66
[2/7] ASoC: fsl-asoc-card: add second dai link component for codecs
      commit: c68fa0d9b0f8cc7c3ae7d29c02adbc97622a73f5
[3/7] ASoC: fsl-asoc-card: add compatibility to use 2 codecs in dai-links
      commit: fcc6ace84f1f6ce2211af25c3c8fb30a0fb2bb2c
[4/7] ASoC: fsl-asoc-card: merge spdif support from imx-spdif.c
      commit: 6d174cc4f22461ad3fe383570527e86bf1948a2e
[5/7] ASoC: dt-bindings: update fsl-asoc-card bindings after imx-spdif merge
      commit: 4359caadd17fbde64d656c10bd6f2dc91b675a11

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


