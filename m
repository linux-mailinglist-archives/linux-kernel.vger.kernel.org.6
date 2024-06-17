Return-Path: <linux-kernel+bounces-218017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCA90B807
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18C51F21FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02E176AB4;
	Mon, 17 Jun 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/lBgC7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849211741F1;
	Mon, 17 Jun 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645212; cv=none; b=bVeOyexdZI6U088y87CUWP7MM9ZWs5oX9gD4oJAMpb7aoVaLLm6w82ENsOPRNZnYBu6khwblZFJWCsUEFuL2B5bpgHifQ2L389KCi2nUbv5AwEKUfTBGCAeyvJFDDUney8x9WXj+Fdy8n/m68Ux171J/bjwsEm3nEjk1P8//OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645212; c=relaxed/simple;
	bh=Galb2R72ZDFbuADAfagUUEATITsEl3obGN2wKJQfpbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RAFxIR0GpihJ8zjjZ8eNdp+khJqBkAyr0ElYcQ/Vw0V608peVrKi29c0sknwB9HUVxt9TZZE1GoLO9ufA19xRaj7sHjKAVsH8+V6T7ER/bNYj9yTWZmyV9T46/73A3a1P1UCglxiYLdUIjzaV2JkRABr+TZfSKw5jbmLzIB1lYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/lBgC7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156BCC2BD10;
	Mon, 17 Jun 2024 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645212;
	bh=Galb2R72ZDFbuADAfagUUEATITsEl3obGN2wKJQfpbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U/lBgC7HYfa3awbsv922WQIlVSDWV3Q3dloiCvdd3uo/pZ0H4OXjwohO/1mh2E813
	 8rQ+v0SPPSgq2OTPU/oYCMFCEgsNfxhNQodh3UkfTW2mPRSCOlUe9FVEGP300ZTCZ3
	 ApmRUOHkhWwpqBVCzRN9ZjZ+JbAjvZfAv3JW2EBm8BG7ga/UNGMoC8AqGtLh2z/0Ld
	 2vNnxs7BWXWMMKjXUFbq+hkwyGqYnUwKn/3Sdqpe4Xwg8lHfe7ULtOlacAK0ydg3PE
	 U5mayLHmuAIU5ptRTZ/zq0PnDHFi+GLm66rG21G7zDbZ6dSmg5CGBskdcCWDmYI/03
	 lZ72PQevA5hVw==
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
In-Reply-To: <20240616-md-arm-sound-soc-fsl-v2-1-228772e81a54@quicinc.com>
References: <20240616-md-arm-sound-soc-fsl-v2-1-228772e81a54@quicinc.com>
Subject: Re: [PATCH v2] ASoC: fsl: imx-pcm-fiq: add missing
 MODULE_DESCRIPTION() macro
Message-Id: <171864520667.209755.6049429279245584956.b4-ty@kernel.org>
Date: Mon, 17 Jun 2024 18:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 16 Jun 2024 20:52:26 -0700, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-fiq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-pcm-fiq: add missing MODULE_DESCRIPTION() macro
      commit: 39eab0148752055928c4c54db12d6cf89881e6cd

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


