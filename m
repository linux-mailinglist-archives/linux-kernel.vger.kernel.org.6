Return-Path: <linux-kernel+bounces-355215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B135C994C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E321E1C21170
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BE1DED48;
	Tue,  8 Oct 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu80MhJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAE1DE2CF;
	Tue,  8 Oct 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391918; cv=none; b=fBnTfsrMfaXtm1p3slOrTvY7Jx/7LJc2X4IAgVKhV+W2AvXefXEKIm8pCrf6vl4A/8RJGqpeaF0BJq8tASKcOaF9v8z9cHRHj9oXPOEXxw7Vs7gdCR/a/WYFRp6imewxHpCWA/EBbgnIIqn1zDBjMx90MIQK1EzxlQqpbYHytPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391918; c=relaxed/simple;
	bh=5N3muN/1X4NiCe63rOjxyZnAnkXxwydb5VUOMPid/n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tIhyGaZA6QpG6EjJOccUPL7iXOV+xqnHeYwB+nAjCApcl462FDID58BssFbsk13nADNPzw1kWTByAhXM184/LXscTiuTVRoVsaipxD4W+WXT6HgExnoyBk97y6x5qo+S+80qpW913+OmTRxRbQmpUejogc565fQ7+ZfE/pHmDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu80MhJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1762C4CECD;
	Tue,  8 Oct 2024 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728391918;
	bh=5N3muN/1X4NiCe63rOjxyZnAnkXxwydb5VUOMPid/n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mu80MhJoe9qMwu8J2hT65rA7oA1hQzk2s0M1A9DU3IGOapdOpid/afEY98/2yI7u4
	 6aDS5VBc5OvlI3EozDJiutUw0V26R48corLYlpmNpqaPaSvdkL8IekibsJ8mQsDL1b
	 zHu31sUtDMFeRC0/idGcNjF44+EfBsQfd14iGQcOKokk/Nk124kg/Q8IO92pAEjskR
	 ghaZ8jIIerROwTYutrSAvoZMAnT9Oj1ATOIJ02FCN6tJUHBvfQxsdK1llGJ5roo+f0
	 Ja16ZPEZtXB0HBkjrpjCvT6POwdQ4EVTuUguxko97qUxjym9Mw/SHdpgh7ZjQvpJL8
	 svpRbSviCGYMA==
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
In-Reply-To: <20241008091347.594378-1-venkataprasad.potturu@amd.com>
References: <20241008091347.594378-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: Add error log for DSP firmware
 validation failure
Message-Id: <172839191267.2607981.16181271445711989031.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 13:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 08 Oct 2024 14:43:44 +0530, Venkata Prasad Potturu wrote:
> Add dev_err to print ACP_SHA_DSP_FW_QUALIFIER and ACP_SHA_PSP_ACK
> register values for PSP firmware validation failure case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: Add error log for DSP firmware validation failure
      commit: 0a5c40393b123f3f08e428143985ab0c5ddb4d28
[2/2] ASoC: SOF: amd: Fix for ACP SRAM addr for acp7.0 platform
      commit: 494ddacd4a2ae5fd1c46ea49364eaab4fc1e5461

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


