Return-Path: <linux-kernel+bounces-200542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DE8FB171
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED56D282ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A444145A17;
	Tue,  4 Jun 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMb/3XWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56DC145A11;
	Tue,  4 Jun 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502068; cv=none; b=iEqPjEbONUjeGQ1UeRiUGFYXtOa9PALGs9KEN3smLbZFysr3Rft1S0LpTeOJ2O6GWigcQcxrSRAwS0/lWLJ1e3ZtHoQmwkErgJNyTyV4zrqN2LR2vOTbc3QDPhO7lk/XmmWuRxsnmaSTXSBp+yYDMbJmFMVm2aBvzMC1OO2Tasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502068; c=relaxed/simple;
	bh=5xynS5Cwt54RsRZeRgz/DpPruiYlzjttr/9pT7oZPno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtY2Nv1E3/JcknVmiuJoPLIL9qx5Mem1YGOLC83Z5yyUkpvWzqrxPD/lZgVGCEwiKOyf/JXV22Svrq5tnIg/9xkFMdPKQFyRuT7V8/n8sF9NLZrsNQ4nctagtgyS8ifDT2XWrWf66RWxRyEGPy7kz+nY4m9lqDUMKDej3roHx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMb/3XWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2239FC4AF08;
	Tue,  4 Jun 2024 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502068;
	bh=5xynS5Cwt54RsRZeRgz/DpPruiYlzjttr/9pT7oZPno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DMb/3XWaUQb2OqrloX95cD48ThhwqczuEgmSk2o7Qqs32NJSz1IfNix1wNRaxtFu9
	 F14B0kufDCtZoMyiI+Yzdi3oKvUonPRresoiNSrTjN5RaJ2yLAES3kuoN/PBf5Bls4
	 JkF4JfcQu6KX+AqAVTtCvh/+yRznuLHJKaXFhLlrZQ+8Y3JnmMZBDF29qTGXZZ9k/O
	 EdVsMWrz1VtUumhnXsCsz3quAYZTjgMVVm/UIjIak0hO6lrIjffr+Mf0VI4NL1nHcJ
	 IV4HjS4OPj3IZpikLvlGgZjZZ0FZCzf1uTVeLy9kNuYlA8KXf/T4g+EAFGEFynfAZZ
	 JYhTUH8cKz2/w==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-snd-fsl-imx-pcm-dma-v1-1-e7efc33c6bf3@quicinc.com>
References: <20240602-md-snd-fsl-imx-pcm-dma-v1-1-e7efc33c6bf3@quicinc.com>
Subject: Re: [PATCH] ASoC: fsl: add missing MODULE_DESCRIPTION() macro
Message-Id: <171750206485.24919.11440040605308557644.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 12:54:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 02 Jun 2024 10:00:27 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-dma.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: add missing MODULE_DESCRIPTION() macro
      commit: 7478e15bcc16cbc0fa1b8c431163bf651033c088

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


