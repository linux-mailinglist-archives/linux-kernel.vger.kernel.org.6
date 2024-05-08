Return-Path: <linux-kernel+bounces-172633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD08BF4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906E6B2216F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627AA11C85;
	Wed,  8 May 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC9nO7qw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12031118E;
	Wed,  8 May 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135939; cv=none; b=MUi8PBYO+9um2pOLEzTgAJ5HO24s9QtoaYoRoYcXBTErYANu7nLAP43pZjZouI8Vn/KgHIcZJdVKKO/bwP8lWLGMo2S+wZfxEv0OJHhJpcXvEgIPlqVSzZo0imBXQtkBWkJZOLTuWLhyIyUOVVpAkw7CnSMUMSdKea9aX8p+XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135939; c=relaxed/simple;
	bh=/3khDWZQ/GtML+FhSHCXGuNu/t+fIBx0N0zULUWpjWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rPfxpLK4ztzKYnRouCkRxrZch2A/G8gK+XfgussQGssxPLYOo7hoUpKHc6ryjfrctsUnaSY/SLb5RNfyQPgES+3DvyFzOcOa8jSE7inzui5kFQNcgXo9yKnCQLz1b9ZpTw1l5eUd6u5CO4SricksPOCEDLTWa993sTXgvIe5AA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC9nO7qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02724C2BBFC;
	Wed,  8 May 2024 02:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135939;
	bh=/3khDWZQ/GtML+FhSHCXGuNu/t+fIBx0N0zULUWpjWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uC9nO7qwz/RZe+qVeAYA5qg8DRX2OHooEZGkUg+YOiFYZbymhIt5OYrroDkvwZHx+
	 rloiSSzfzkpfR3JH7MYR+nwgB19ILcw3crrUVKTntXNt13ThipsAWyeevB2r2yv6e4
	 5UcJx3pXdyw//cVj268GeKVZeeXlC8CscMEFYHrvrAsHMAGXLZQj4qiDjiJa6/msly
	 chVJr5LgPieHOEt1Z6CDmFMIZNYKLXUkYS08rHdms6UNqleqnU+9MAV5ZdML0t7FUe
	 4rh/5pt8ZbvdIsh9pgfWDTw1ynQIxfxgYcl1bu+Kl0Fem7Stn0h55Di594V579dsht
	 8SgBQFV9z+Mbg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
References: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
Subject: Re: [PATCH 0/4] ASoC: Constify static snd_pcm_hardware
Message-Id: <171513593429.1997870.7721601606737894887.b4-ty@kernel.org>
Date: Wed, 08 May 2024 11:38:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 29 Apr 2024 13:48:45 +0200, Krzysztof Kozlowski wrote:
> No dependencies.
> 
> Static 'struct snd_pcm_hardware' is not modified by few drivers and its
> copy is passed to the core, so it can be made const for increased code
> safety.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: qcom: Constify static snd_pcm_hardware
      commit: e6fa3509cb32df373b15212a99f69a6595efd1c3
[2/4] ASoC: fsl: Constify static snd_pcm_hardware
      commit: ed90156037659473ee95eafe3f72d8498e5384ff
[3/4] ASoC: meson: Constify static snd_pcm_hardware
      commit: 7b5ce9f0c52a5885d34d46bba62e9eaedc3dd459
[4/4] ASoC: uniphier: Constify static snd_pcm_hardware
      commit: 74a15fabd271d0fd82ceecbbfa1b98ea0a4709dd

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


