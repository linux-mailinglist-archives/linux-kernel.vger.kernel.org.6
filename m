Return-Path: <linux-kernel+bounces-280124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2ED94C614
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D801C22798
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22215EFA0;
	Thu,  8 Aug 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhCj/MDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCB15ECD0;
	Thu,  8 Aug 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150620; cv=none; b=eJ68pCd3HWF3C03BpQ24tqJe9KqWLG6p1neOKuYgwJjGVR0q4iMxdR0cJP7oxuHSmEjcwC4EC6fTcQxQ0NUVBlgISGk299RJJMyFk4Opf7Tyh3qpzxW4MJGAnp1RP2EAxdCi5kuWfKCV49gRiajx2BJgkGRHshf6NiZY/6PRLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150620; c=relaxed/simple;
	bh=8HZW9ydPbynTwHn2r0OXZgO4S5M5/tgIuH3d75AJA0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dwm0NMFv06Ft+zxXdPcP6ReYCx1jzovw1JGNLUkPXcTzIFdGeJSEgHP/sglIl5b1qGRHhH8QzdIQuxiCjBIdEnYWvy+X78a1Vza91w8Cj0zjK8N85MT/LH96pamlX23d8tQ4MNyxC2c45VMDKAekXyBo4jpxZnxIPDNh8uDJ+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhCj/MDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5500CC32782;
	Thu,  8 Aug 2024 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150619;
	bh=8HZW9ydPbynTwHn2r0OXZgO4S5M5/tgIuH3d75AJA0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BhCj/MDPwqsTvO3JLNkrAB9k7dGBoLzqHUBEpMVCPYWHzVb//6U/3Bu7qfFHiVNOu
	 5XhU9Zj45yz4eDsztzVZT+32vIvf3AWrFU2rqtvvP4h1oPSvQ7x15SSIdIWPnvfA2p
	 Pi+TtpvQSOqytHTykS4+hcTdwck8CdCcf/bqaIuFKQ/1klNx0Gtbbhb2Ly3cyQ8iyj
	 djApxLe6xJMFY9SvmpqXic7Ka081kFshTyUNNr7blsoA1PFWcPgjIzE6QXL0tymzDY
	 zAmyGxjwRbmsolaTRPGwPTue8rwjM9WMoTk0VM8MEep1bb4tWtst+eHqi9MkEA2VKG
	 h7jxhlbxPkkmQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/8] ASoC: SOF: amd: Fix for incorrect acp
 error satus register offset
Message-Id: <172315061079.475406.3339971086228165624.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 10:43:13 +0530, Vijendar Mukunda wrote:
> Adding 'dsp_intr_base' to ACP error status register offset in irq handler
> points to wrong register offset. ACP error status register offset got
> changed from ACP 6.0 onwards. Add 'acp_error_stat' descriptor field and
> update the value based on the ACP variant.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[5/8] ASoC: SOF: amd: update conditional check for cache register update
      commit: 001f8443d480773117a013a07f774d252f369bea
[6/8] ASoC: SOF: amd: modify psp send command conditional checks
      (no commit info)
[7/8] ASoC: SOF: amd: remove unused variable from sof_amd_acp_desc structure
      (no commit info)
[8/8] ASoC: amd: acp: Convert comma to semicolon
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


