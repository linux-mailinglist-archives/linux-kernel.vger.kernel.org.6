Return-Path: <linux-kernel+bounces-212205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE606905CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA6F1F24C74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2984E0A;
	Wed, 12 Jun 2024 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URn75nSC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762C84A54;
	Wed, 12 Jun 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223667; cv=none; b=dLetWIzUFrp92Yqx9knJlG+eb1JJ4pFYJl/wRhjsxzQfkoqAgiKSjL+bTMYRKuHS3h2ppJFCgjyQ3stZa6wo5kYW32PkzR72gLL7x0WZU1/Gp3gCG5cBAjrxT0wQ+BIbdoIObi0E91zIieo9+N7AJfR4nHtCFavdkC4IZi1e4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223667; c=relaxed/simple;
	bh=VF8TXFGMOrc2cxAUxWDWimJvw5tB56D41Lk1keK3LeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hiJugSX0ZIqBjAuIkHMhh14dd9bfKzy+NmF2ul//XqbQ1GhXXdzN0RjKDZ9fIZExpcHH/ONcTVPSoz0JwmUE2kBo1J6iZHDBVcPWDftf9FYyUIwRG11dY0S1K9w+gt0Oxc5KWnLkdDZrFjVBYGSIKe4VsPp6VCZZjIcuRJ1ZN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URn75nSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD16C116B1;
	Wed, 12 Jun 2024 20:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718223664;
	bh=VF8TXFGMOrc2cxAUxWDWimJvw5tB56D41Lk1keK3LeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=URn75nSC/5cJcxRzqWCubCrsZPUXg+sQT5quwWqRXU9XoCocneYRWaQXa+HrxUI/9
	 4/VyuQaMxztk7v9bKgw/f5E56QBqxmXd2th+W/m8cyde09j+WHqe3pAN4RHI5rbXlJ
	 hJ82/sz4V1lNPDYlW4si+Se31a3cOF6t6neKxAvx5evZPi2TpmjZqUnNGJxlCT9jLn
	 JmfHI3DkUFoZ1IwU1q6sLEdzw7RkOrFXh7GMLrCWOTSseA/rPq5+HgeAj6XLcYtnpg
	 PX3E/Mg/wmWwfoxawleZuSrJC9vbAn9HWM8jAolAiQtap2RUqylNTu/7UH7ILLv8ZM
	 N5DumOTsT3cZw==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jai Luthra <j-luthra@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
Subject: Re: [PATCH v2 0/2] Fixes for McASP and dmaengine_pcm
Message-Id: <171822366136.240528.8303514508385610793.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 21:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Mon, 10 Jun 2024 16:25:59 +0530, Jai Luthra wrote:
> This series fixes two patches:
> 
> 1. Fix the dmaengine API usage by calling dmaengine_synchronize() after
>    dmaengine_terminate_async() when xrun events occur in application
> 2. Use the McASP AFIFO property from DT to refine the period size,
>    instead of hardcoding minimum to 64 samples
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ALSA: dmaengine: Synchronize dma channel in prepare()
      (no commit info)
[2/2] ASoC: ti: davinci-mcasp: Set min period size using FIFO config
      commit: c5dcf8ab10606e76c1d8a0ec77f27d84a392e874

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


