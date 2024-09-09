Return-Path: <linux-kernel+bounces-321843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C3972030
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F0D1F244CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80352170A37;
	Mon,  9 Sep 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKXTNXXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C916EB65;
	Mon,  9 Sep 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902329; cv=none; b=ZoPoCq2A2ANtMT1Epuh4i4z74ebKLwy0Igzcz0eyshhullfX2RsOiZWvGJN7upbRqq8R06IzILDEX6nWlz6mTrgjSSt2I3UzUGk2Fhzovpvs+1iad6Qb+0vt+PGhIDHUPMdmrV8BrgDxZQgq7qxZ+E0y81d2kibzCxaVXOIrKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902329; c=relaxed/simple;
	bh=mMa4F2Ikpxl+0XWDHV62Rd8ajny+lL3xWQ2nZtgMGXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jHL4QBGYEpRGhzXLX2o7wotFX8TAVoN3z3lk/LgOEUrRw9NNeMm8eKg5ZN7dVFse1gDS7fHgKo/++somy7zBdd2xTq3MnxQJwR28eJQpKR9jO+e+LhYtOlGvgF08ZHxGVZoyKYnp44hyugYGrdgqb5OgEDTliCJC12jWpV4O2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKXTNXXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E703DC4CEC7;
	Mon,  9 Sep 2024 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902328;
	bh=mMa4F2Ikpxl+0XWDHV62Rd8ajny+lL3xWQ2nZtgMGXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cKXTNXXJ+wCRMVeJpXJUj+lamG1WOtkAxx+hxoIRKIEEPmLUruNOIKNoXVnWIK1Tg
	 nGgi4theZDC1UgqAxfaQ4kvA0ooejTuByshEZ/Fn1Pu1ZE5ISsENdv3KpVzvjOHGrm
	 taEBdx70XuwkT3J+zyt7UnhqX8mrZJf+Q4w1zVfheMX3fnO000nB1meWA86w4aVpSm
	 4XH7B4cygUp77+Nvd+kX6hnTJI9i+1d6q7PbIapvgOlWZPSQALEXUbJj/mAtsUEUE5
	 A7VGRwzcv2FMFhfuAfapWLVvSufq+AHX06oGjJnq/ZvDiCr4Ksy0EPFVxcZ+EXytdV
	 ChcwUDp7jMb8w==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906-tlv320-filter-v1-1-6955f53ff435@bootlin.com>
References: <20240906-tlv320-filter-v1-1-6955f53ff435@bootlin.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add support for loading filter
 coefficients
Message-Id: <172590232308.1707146.7048822902174477472.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 18:18:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 14:20:58 +0200, Romain Gantois wrote:
> The TLV320DAC3100 Audio DAC has 25 built-in digital audio processing blocks
> (PRBs). Each of these PRBs has a static filter structure with programmable
> coefficients. Once a PRB is selected for use by the DAC, its filter
> coefficients can be configured via a dedicated set of registers.
> 
> Define a new optional firmware which can be loaded by the TLV320DAC driver.
> This firmware describes a full set of filter coefficients for all blocks
> used by the various PRBs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic31xx: Add support for loading filter coefficients
      commit: 77b696f489d2fd83bbcffeed363baac8f2f6ed4b

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


