Return-Path: <linux-kernel+bounces-212206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDE905CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742B01C2322D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B18614D;
	Wed, 12 Jun 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDy8K6tz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECB84FDF;
	Wed, 12 Jun 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223668; cv=none; b=btFpjmuXANvgSXU6zVIQDeDzbDtRe5zkkwaTfYdqKoeEpfcgUJWr+KDhF5UI8WdRWZLV+WqNda15RA4OisSMhxo5E+HnSMY2+GPBPUXK2NjPUMNKRSELI36b3a9KSRLky0FawAG3hE2tkPnAcYxHsC749mZXzF0mplcHYXzUsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223668; c=relaxed/simple;
	bh=MWggHuDmnRYrL6/F/g0nQyheyownkHUkefYD5cQ+7EU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgMhOQu7oN0e42e9sa46rebveOUpUB4jy61/xciBFpaZxrK7N1m2T2+YM+HhoiGDLQnNyN9bvSBCf4P0/UgPGAA+Nd9ufNBTEAhDWfL83AEwqt2xUoAcC4JtjHOwtrNV3h9WHwBnYBUUoxgepNlY5yyASIcU/PQ1k1mDODcfpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDy8K6tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05D1C32786;
	Wed, 12 Jun 2024 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718223667;
	bh=MWggHuDmnRYrL6/F/g0nQyheyownkHUkefYD5cQ+7EU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dDy8K6tzIR2SW38mTPuGne/59hM0GYaWIWx++6nRhpxUcQvdYeOWmQYITGsROmCbg
	 RLRNSy3f/W0Lu6Q0pVB2ldComQ7iqf96XMvmFczK5evPGziHapzFZYmuZg2qsEjTRe
	 o2K9jJghL3hxrS1byOebezsWYFePPNmeBJQ5Xl6fSraFKhhPMTws7MZisx0OUlX+jb
	 W0trPF8GArt0iYZMhiaku6yqk7EeBd2psHvmBc6kOY6cC/1iqmAq3nm315WywKoEOV
	 E8mi/5300RFGzcGtDKG9F6yvfNVFTi+20ZvHXN48GjV5sj51QLh/fzDd8LWeP+gRcu
	 y6IZsnXUPVYZQ==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jai Luthra <j-luthra@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240611-asoc_next-v3-0-fcfd84b12164@ti.com>
References: <20240611-asoc_next-v3-0-fcfd84b12164@ti.com>
Subject: Re: [PATCH v3 0/2] Fixes for McASP and dmaengine_pcm
Message-Id: <171822366586.240528.375456084176371266.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 21:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Tue, 11 Jun 2024 18:02:54 +0530, Jai Luthra wrote:
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

[1/2] ALSA: dmaengine: Synchronize dma channel after drop()
      commit: e8343410ddf08fc36a9b9cc7c51a4e53a262d4c6
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


