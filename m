Return-Path: <linux-kernel+bounces-241620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344B927D32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D15A1F2475E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890F135A69;
	Thu,  4 Jul 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkC4aqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141945979;
	Thu,  4 Jul 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118147; cv=none; b=uE80qbm7GuSyETiXp0Mkt2XKlCPs+qHkmEv7zoxFeyOOcWIxse8iOMHy2wuilG18t1TgtZhQnfosAucZ6tGsIZa976gBgyQV/HZiDu53pXmXiyh3j7None9Eb/vNU490Bsxm1IujiggvUQ4hRcJ9NCsD5oIEBBiK5X90p+jptMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118147; c=relaxed/simple;
	bh=rCWEKZiJpFDMpQmRBe2oHF+Q4L1xuCzmJqFKI9sBbBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H70Bqu1PirnJYdsx0vGna+hr0qUq2XD9y6q0kuexQYsNvFibmhgZopONGzT1vx4mYF4LSV9MQpvpthJAe3WvbWdPND37C9ibVF//dc/yhtTIyqEftxIBRZUIbIh4uE8KLCq7W7MzYSql310vWGQuOefmG6nK0eWyeNoKuJRXVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwkC4aqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE4C32781;
	Thu,  4 Jul 2024 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720118145;
	bh=rCWEKZiJpFDMpQmRBe2oHF+Q4L1xuCzmJqFKI9sBbBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XwkC4aqRrEk7dbyVe7FPkDuvLWRj1jidNP+euuAbzP9JjJzLszTewqZzPa+o+jBjC
	 FfFm5HKXGJqAADRL6npfN59JBc96M4knjbEw55jvee+lnAx4pced+gtLG/Id8VWOlX
	 UQaKQ5if+3ZNZlp6hHhpWOkCK8IUesi7Y+7OLE0lk5WaxQg3EGu/fmJaNrpwGR5QFa
	 TiIMvvL5uQCyFdh6L8HSwLkmE8hrqsRtVIJiouy9JLLCww5LkHFuXxaL0ZNkP965RM
	 mu/JfdeUKlnfOmLtHEJjNcf0T0eHBjGtDD9EamZCPEDDyP3EtBv9EaBAWPirYx85z0
	 kOEspMLmVOnEA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Herve Codina <herve.codina@bootlin.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240701113038.55144-1-herve.codina@bootlin.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
Subject: Re: [PATCH v2 00/10] Add support for non-interleaved mode in
 qmc_audio
Message-Id: <172011814156.108577.6835000954041673379.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 19:35:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 01 Jul 2024 13:30:27 +0200, Herve Codina wrote:
> The qmc_audio driver supports only audio in interleaved mode.
> Non-interleaved mode can be easily supported using several QMC channel
> per DAI. In that case, data related to ch0 are sent to (received from)
> the first QMC channel, data related to ch1 use the next QMC channel and
> so on up to the last channel.
> 
> In terms of constraints and settings, the interleaved and
> non-interleaved modes are slightly different.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
        commit: e62599902327d27687693f6e5253a5d56583db58
[02/10] ASoC: fsl: fsl_qmc_audio: Fix issues detected by checkpatch
        commit: 86dd725b57a88869acfe15b0405937450d0aef30
[03/10] ASoC: fsl: fsl_qmc_audio: Split channel buffer and PCM pointer handling
        commit: 42212b2ce8b1182d536452eee2880d2de7cce059
[04/10] ASoC: fsl: fsl_qmc_audio: Identify the QMC channel involved in completion routines
        commit: 5e51a1f9dfd90de6e44cfb5340d48263f9e8f8d8
[05/10] ASoC: fsl: fsl_qmc_audio: Introduce qmc_audio_pcm_{read,write}_submit()
        commit: 33a6969fbc653f25d5204b17fb67d5a21e6295e6
[06/10] ASoC: fsl: fsl_qmc_audio: Introduce qmc_dai_constraints_interleaved()
        commit: b81cfa66435bdab896b4c24e11d24ec33bdb0601
[07/10] soc: fsl: cpm1: qmc: Introduce functions to get a channel from a phandle list
        commit: 37797c605da33445adc112561695f70bfaa11133
[08/10] soc: fsl: cpm1: qmc: Introduce qmc_chan_count_phandles()
        commit: af8432b2e41abc0a20bdc01a3b144ea7b2f1ee09
[09/10] dt-bindings: sound: fsl,qmc-audio: Add support for multiple QMC channels per DAI
        commit: fb6013168fa94d5863ed6085b24eaeb89102ad74
[10/10] ASoC: fsl: fsl_qmc_audio: Add support for non-interleaved mode.
        commit: 188d9cae54388171d28bd632a2561863db4b9f8b

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


