Return-Path: <linux-kernel+bounces-522662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C452A3CD09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE983B712F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851325A334;
	Wed, 19 Feb 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGnNpcku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F22144C8;
	Wed, 19 Feb 2025 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006487; cv=none; b=mCpAxnqwEakFWo1bHpLrssbdoOc18RNfXqkm1rDd2w79caTK8EToBFHCdwm0jrMFgzCB8YUCpa8nagvjWnrTKmaJFPU5of7qwyMVkkKNkfu4mxP2J40HPumKT7V+wCnEuDaC0MIi9qsmZFVQSwL8KftELxAVlkrtctmmwM/2cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006487; c=relaxed/simple;
	bh=I+A01oyCPAWegDfKNBg5egPYCS/mb4d6oYAOH+8ek+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RacWsXybWaDDNVKlwGlYUpePudWa1gacWyLBWl5BJ/BKIIu6ygEROyxMebVOPHVaTy3ZjkJCbXT4ic2QWaV+V46pbCRgnoZelC3A9V6pHSf6846MNvHXB1NFNeJPhIJBxy3dEWt3Q7zP5sUfEyDSSGtoVID/plzx0PDNLiMLxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGnNpcku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A732C4CED1;
	Wed, 19 Feb 2025 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006487;
	bh=I+A01oyCPAWegDfKNBg5egPYCS/mb4d6oYAOH+8ek+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SGnNpckuf6GdHBs0752cJ/RwRGCwtrdCYPo+MYfrukd+Agb+lb08P6P4+kD9y2LVz
	 J3a3hvu4YJdFmpioXIQkHPAkSGgErgJDv+R9MP/SQeZL04VWfZBLcLNQt/wuYxY/TZ
	 9RLoOyIgyrHweDYZtCWWRYLwc4T8Ge1CjpzMtBNOyY0enKNLgg9EYYBuBkLUXpwrHc
	 5mmM+hBP4vJ5MhOEl468npC5tJTGSfKVKrARryWi5+p7J/6BDWga+nI6ry/qe7G7p6
	 tKTNpvREfRu9qq5hiHY5dcQBTXGiBUry/l4p8iv/0EYFfof15qDf8DSCKqYLC7vXD9
	 M8e7EkC1Hjw5g==
From: Mark Brown <broonie@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, 
 Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H . Peter Anvin" <hpa@zytor.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
In-Reply-To: <20250217231747.1656228-1-superm1@kernel.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
Subject: Re: (subset) [PATCH 0/7] Adjust all AMD audio drivers to use
 AMD_NODE
Message-Id: <174000648081.2064138.16099679978882177609.b4-ty@kernel.org>
Date: Wed, 19 Feb 2025 23:08:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Mon, 17 Feb 2025 17:17:40 -0600, Mario Limonciello wrote:
> The various AMD audio drivers have self contained implementations
> for SMN router communication that require hardcoding the bridge ID.
> 
> These implementations also don't prevent race conditions with other
> drivers performing SMN communication.
> 
> A new centralized driver AMD_NODE is introduced and all drivers in
> the kernel should use this instead. Adjust all AMD audio drivers to
> use it.
> Mario Limonciello (7):
>   x86/amd_node: Add a helper for use with `read_poll_timeout`
>   ASoC: amd: acp: rembrandt: Use AMD_NODE
>   ASoC: amd: acp: acp70: Use AMD_NODE
>   ASoC: amd: acp: acp63: Use AMD_NODE
>   ASoC: SOF: amd: Use AMD_NODE
>   ASoC: amd: acp: Drop local symbols for smn read/write
>   ASoC: SOF: amd: Drop host bridge ID from struct
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/7] ASoC: amd: acp: rembrandt: Use AMD_NODE
      commit: e211adcf36d0ccdd31af7398af4725a47d74b3d4
[3/7] ASoC: amd: acp: acp70: Use AMD_NODE
      commit: 135c6af1cac5465529469700d16c0c44b24ce317
[4/7] ASoC: amd: acp: acp63: Use AMD_NODE
      commit: 8f969537149d672d40a0e75a83f39451a5402780
[5/7] ASoC: SOF: amd: Use AMD_NODE
      commit: f120cf33d2325fd95d063eccbff2e86ffc7f493a
[6/7] ASoC: amd: acp: Drop local symbols for smn read/write
      commit: 40d05927830227f2a1701c61e8bbe65287a03490
[7/7] ASoC: SOF: amd: Drop host bridge ID from struct
      commit: a261d77fec147b9974aacca8ae8f0693feede838

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


