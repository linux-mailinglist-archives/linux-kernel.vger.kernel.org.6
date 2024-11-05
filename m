Return-Path: <linux-kernel+bounces-396815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C09BD296
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046751C2222E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46F1DAC97;
	Tue,  5 Nov 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvaRf/uh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C2F1E1A18;
	Tue,  5 Nov 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824706; cv=none; b=WIVP8ZZz/4SCrR7RzIOqb4kcpjidvZH87/vpGQCW7JwYs6sIzYgymycwMBhYu04XjTt6DWtvUw9EH/XdAX57btj7mWJkuUiErqlZYGT/c0lk3KdbKgWQcxB1i7GDTU2dxBLqV0epbaWMBnYZ4jJUb2HCspdLXs+lIABKlYLxu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824706; c=relaxed/simple;
	bh=omxC84VGn/+YQr7YbyZx+jQOt5oTJWK99g8fh9uYgT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JbXHhATKuYlyiIMYYDhArp7trwafEiop1+0mBfgBbBZmkhiTV9LQaeyhC2Z4CUU6j84BKSIUfd65GFRueJhDD69FnVeSu6qpmv9xARtxX2ALKL37QEwqOPQr8Txg5kebN1pfCwZm5HmikNPkV+Mj3bE4JBg2HmmZIm8mTOiQBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvaRf/uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2500DC4CED4;
	Tue,  5 Nov 2024 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824705;
	bh=omxC84VGn/+YQr7YbyZx+jQOt5oTJWK99g8fh9uYgT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DvaRf/uhp2xk2i+id0MOV/XKBXEpoPGF27r9aIiU8ES8BhUS5q77LiwNV32tTkqWp
	 n+RCTU3Pn2wPlAOHxpxykq8dChEwd4WqOCpaQSeIToC/kBgRDGDU/kEg0xIERNSssh
	 jkJ1caVmGpeZBZK5a2G9l4JJ6ycq+hZ1y6oEPjwFnMRfQcGPyNPgp0xF6J18oJR1LV
	 /XyL/or9i5/T/ssqty5KadvXy9rKQJDxuCRqFz/BbpiwXLoqAQg4qaFUyqW7zqc5qk
	 JfzwqDuHJ/D0+i1cDyWM2UIDW4oJOxMKeKJ3O4DkSEi+rwAes9whSKQGJUEZ+cOdUY
	 D38kuNRb/TSkw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: mario.limonciello@amd.com, Vijendar.Mukunda@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, ssabakar@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241104091312.1108299-1-venkataprasad.potturu@amd.com>
References: <20241104091312.1108299-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Fix for ACP SOF dmic tplg component
 load failure
Message-Id: <173082470287.77847.14499487480313142859.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 04 Nov 2024 14:43:10 +0530, Venkata Prasad Potturu wrote:
> Stream name mismatch with topology file causes tplg load failure.
> 
> As SOF framework assigns dailink->stream name, overriding stream name
> other than link name causes SOF dmic component load failure.
> 
> [   35.474995] snd_sof_amd_acp70 0000:c4:00.5: error: can't connect DAI ACPDMIC0.IN stream acp-dmic-codec
> [   35.475001] snd_sof_amd_acp70 0000:c4:00.5: failed to add widget type 28 name : ACPDMIC0.IN stream acp-dmic-codec
> [   35.475013] sof_mach acp70-dsp: ASoC: failed to load widget ACPDMIC0.IN
> [   35.475018] sof_mach acp70-dsp: ASoC: topology: could not load header: -22
> [   35.475072] snd_sof_amd_acp70 0000:c4:00.5: error: tplg component load failed -22
> [   35.475083] snd_sof_amd_acp70 0000:c4:00.5: error: failed to load DSP topology -22
> [   35.475090] snd_sof_amd_acp70 0000:c4:00.5: ASoC: error at snd_soc_component_probe on 0000:c4:00.5: -22
> [   35.475117] sof_mach acp70-dsp: ASoC: failed to instantiate card -22
> [   35.475254] sof_mach acp70-dsp: error -EINVAL: Failed to register card(sof-acp70-dsp)
> [   35.475261] sof_mach acp70-dsp: probe with driver sof_mach failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix for ACP SOF dmic tplg component load failure
      commit: 224b898f7c5ff575b02911e21383f271761bdeb6

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


