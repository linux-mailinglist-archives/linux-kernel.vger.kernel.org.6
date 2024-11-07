Return-Path: <linux-kernel+bounces-399955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DE9C06F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DE1F218CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5A213EC7;
	Thu,  7 Nov 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MniWMyBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6B20FAB9;
	Thu,  7 Nov 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984827; cv=none; b=bF1zvGUccrx5dCFcAkAZz1ReDEFW+9EDfnDwDO8kSmZtuwtoyegvhbUOFY2B0pJeF338VZ+nXfD4Ow05rUGV5h7I35ZY35PI1WzcXQGUfcaJ/+EXJNRJm4usGdHNIzThbyqrVqi6flhcuiqf8l35Ca4Po/NBDlO0h7+KYAvUS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984827; c=relaxed/simple;
	bh=lEUFZriDhDkjVwUILii4JZwb1zW3y17U2hvnZ0QMi6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Svk64W81rrkqGAr+MTcaHWVmMWp7oIkYsZjwjQEzapDGBsosebIfHcxoyN625NpzXy3XBF2eewAU5vAyR8q7uw0DI/qcNkcAE+ncLRdENNeSiJyJlsQ5yclYqsHBGARdI1tsvlHMhXo0SkqRK1kscwuZrdyorucoVeCnCPcBerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MniWMyBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A63CC4CED2;
	Thu,  7 Nov 2024 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730984826;
	bh=lEUFZriDhDkjVwUILii4JZwb1zW3y17U2hvnZ0QMi6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MniWMyBjz3113myrrNYUNfEtyzo49n0WO2n2fb+b2ivnphHxvhZnmEI/Wcx6jbUqN
	 WQ1+CW8foD0JpjPqsr6Mk1hYaWcH7sl0+Q3xCAOTqGREKVTT9GNKC3/VdDmWGB9T0O
	 PhzNJj59spsFB3RZl5X5UbBkrxJ1MFdHnN7xElDUn+oqVfSVo2ByFXart7R0ClGRY/
	 pYK254+klX9qGE5XI5PvsZ6Ir7ajZvc0iMME/Iun9U2rUSuI3hWrIdYZfs9a6H2h93
	 NCBe7/GIvHILhRMa3lOo5XpKKAUqAwonKE+LyM51sLZp5rnX2u+LMDsu7Ye87RWKRr
	 PVk5hcqKi9RPg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20241106142658.1240929-1-venkataprasad.potturu@amd.com>
References: <20241106142658.1240929-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: SOF: amd: Fix for incorrect DMA ch status
 register offset
Message-Id: <173098482166.15423.8670682010126055534.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 13:07:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 19:56:57 +0530, Venkata Prasad Potturu wrote:
> DMA ch status register offset change in acp7.0 platform
> 
> Incorrect DMA channel status register offset check lead to
> firmware boot failure.
> 
> [   14.432497] snd_sof_amd_acp70 0000:c4:00.5: ------------[ DSP dump start ]------------
> [   14.432533] snd_sof_amd_acp70 0000:c4:00.5: Firmware boot failure due to timeout
> [   14.432549] snd_sof_amd_acp70 0000:c4:00.5: fw_state: SOF_FW_BOOT_IN_PROGRESS (3)
> [   14.432610] snd_sof_amd_acp70 0000:c4:00.5: invalid header size 0x71c41000. FW oops is bogus
> [   14.432626] snd_sof_amd_acp70 0000:c4:00.5: unexpected fault 0x71c40000 trace 0x71c40000
> [   14.432642] snd_sof_amd_acp70 0000:c4:00.5: ------------[ DSP dump end ]------------
> [   14.432657] snd_sof_amd_acp70 0000:c4:00.5: error: failed to boot DSP firmware -5
> [   14.432672] snd_sof_amd_acp70 0000:c4:00.5: fw_state change: 3 -> 4
> [   14.433260] dmic-codec dmic-codec: ASoC: Unregistered DAI 'dmic-hifi'
> [   14.433319] snd_sof_amd_acp70 0000:c4:00.5: fw_state change: 4 -> 0
> [   14.433358] snd_sof_amd_acp70 0000:c4:00.5: error: sof_probe_work failed err: -5
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fix for incorrect DMA ch status register offset
      commit: 94debe5eaa0adaa24a6de4a8e5f138be7381eb9e

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


