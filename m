Return-Path: <linux-kernel+bounces-399954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F809C06F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EA5284C12
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B021315B;
	Thu,  7 Nov 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2klslHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30862101A1;
	Thu,  7 Nov 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984822; cv=none; b=ZlcC28BXIaCA6BTwGE6IpVBnSfdP297TMcarMoZjv3HwcoEbB5cpGCUCx2JQcPlTg/1sanOgKqawz0j+buIW3DziLGX4jmsm4SjjLo+rxFmKxx4sz58M1r9bnaE7+09QTD7fXiXUub0TX3sQYQNk10g6H2vnynnVNEcPYNqtNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984822; c=relaxed/simple;
	bh=WpXkdW58NwJpi1pGQBZHFsJuQ2oNn8UxUGi30Sv955k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P1N7xi/fe3Z8iFFqN0A8KF84NVbUrrbbVqTYaPmfTMda1wMPhAmerSfDDgOwbZdosArcyI2eKOPAgWWed7fLCy9FwvyFuaF9Mh/2uc1MdfxV/ySKYQAg+4Ge+oyDSlzDweUz2DAWuKdpnj0bWDccqMwU2/hHqKG8xNW9A2nAzGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2klslHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA61C4CECC;
	Thu,  7 Nov 2024 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730984821;
	bh=WpXkdW58NwJpi1pGQBZHFsJuQ2oNn8UxUGi30Sv955k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W2klslHatOvfEzop97ZNdi5LkY8g3XSNRpV8nQURb9wLjqSNTxFb75WKIappO9f/D
	 bqvgHZ18Z995UzpcpvzQV8+ajMME7/1tRgPO9+BSZOnTk/Ws+ws0ZhEjR9L/5SKqn6
	 MchKVHlmHnK08ZqI1v27lxBVPvh0cKOZZOm/Tri8gaFbZsrQTbqGu7K316NuYg9mEU
	 L2Z5rLdWj8tUxyqPzBWumXQgAGblQG3+UZFw3Kz3Ct100XgN2y2HkbwSExbo3I0sBh
	 R8XUgIFFpsN5QJkKLn5hMTWDLMh52N1q1wI9RUSdb3co+1PmhWtdlGlk2cQd92kk2A
	 5QJ/xu9/UKasQ==
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
In-Reply-To: <20241106101455.1229113-1-venkataprasad.potturu@amd.com>
References: <20241106101455.1229113-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix for incorrect DMA ch status
 register offset
Message-Id: <173098481508.15423.6358343520867651072.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 13:06:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 15:44:53 +0530, Venkata Prasad Potturu wrote:
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


