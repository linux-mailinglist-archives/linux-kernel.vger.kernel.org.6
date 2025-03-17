Return-Path: <linux-kernel+bounces-564592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB1A657EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB617B617
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6C619EEBD;
	Mon, 17 Mar 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHgrafX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91819992D;
	Mon, 17 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228640; cv=none; b=pkCtdqqqUaUIx4FGfsd/nCZ/RgPI85+0RP+cACTPPuCHAdzFlmumwVYAHYogWPFKkfu1NBdUi8Bu9kEaOvH/s9LaZBq354y2dHBQ9oaNgfHOrJ1gPojFjnkk6tcO85NZ9giJaI/SYzzGYDHFm858V2Z140LY20bka2fLEJ58JVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228640; c=relaxed/simple;
	bh=S8rkvyTlbJT1gIhv5b/YRSUsQaaIxz+gef47gM4FQeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EPolYucsKCbXnpVh1408Mzb+chXlSmqjaUSxW6ONm8BMgqw9STFFrW/3C5GkHnE5eYf9qJzganCdxcP9+z8X61K95fmTLifh1o1JnbLsqDlV6mQjOBCyk6thXd1U2JMz6qh4Bk/I7Ydq+GTOc3hNr1pyzG63vbzichtHts3wO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHgrafX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01545C4CEE3;
	Mon, 17 Mar 2025 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228640;
	bh=S8rkvyTlbJT1gIhv5b/YRSUsQaaIxz+gef47gM4FQeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eHgrafX/Y7f+UnMCDf310BPSsrehHgdQnjS7tlb/Vz9nUGn4IdyMwWRPbJ4QtXBVq
	 6RfTjHTbt4s3SOghrDbX0FbHMkuFyZrhe8ha9Ka5gwOaAdK/co+U5myIyoRNl4+nG3
	 SqRYjMSWX2kiLLq0NB+NdpSIFXg19HNJYh459wh/rpuVl3ayXuVSdIMkFu4mo11/M5
	 A0t1bnJZLRKmlC4Bz4q5Wo6GyYFqUqXxiA+SZ5F9NewLkxoXLEWeFDjDGXqmev6y3R
	 ni5Rh0q0RE4lGNyaIKFvbpsN+Okh9m/Yx9n5aV1Hxx/TQNQ2bp9nNFKsBFZktzsDNs
	 nky42SkDhXM4w==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 syed.sabakareem@amd.com, nathan@kernel.org, 
 kernel test robot <lkp@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>
In-Reply-To: <20250317072413.88971-1-venkataprasad.potturu@amd.com>
References: <20250317072413.88971-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Fix snd_soc_acpi_mach id's
 duplicate symbol error
Message-Id: <174222863673.227953.6804777136695160780.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 16:23:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Mar 2025 12:54:07 +0530, Venkata Prasad Potturu wrote:
> Move snd_soc_acpi_mach id's of all acp platforms form header file to
> amd-acpi-mach.c file to avoid below errors.
> 
> ld.lld: error: duplicate symbol: amp_rt1019
> ld.lld: error: duplicate symbol: amp_max
> ld.lld: error: duplicate symbol: snd_soc_acpi_amd_acp63_acp_machines
> ld.lld: error: duplicate symbol: snd_soc_acpi_amd_acp70_acp_machines
> ld.lld: error: duplicate symbol: snd_soc_acpi_amd_rmb_acp_machines
> ld.lld: error: duplicate symbol: snd_soc_acpi_amd_acp_machines
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Fix snd_soc_acpi_mach id's duplicate symbol error
      commit: 9c2c0ef6400980f09b377be250f5dff14dbbf3b6
[2/3] ASoC: amd: acp: Fix acp_resource duplicate symbol error
      commit: 09dc8031f4a84103f4ba8f704ec21f1926b04366
[3/3] ASoC: amd: acp: Fix acp_common_hw_ops declaration error
      commit: 77ad261ecc4aa1b09bc98b32cdbfadb5e92197b7

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


