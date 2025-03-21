Return-Path: <linux-kernel+bounces-571768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19AA6C1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68563189F696
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15522F166;
	Fri, 21 Mar 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSDvU2HF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476E22E405;
	Fri, 21 Mar 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579697; cv=none; b=kwjloXH6ZcaW+n34OCumIUF+tmkPmc8Ghzzi+m1hPr93Qeewqn0cwqkrrhdeGjwNn2H70DBAFnIa1vEGGhEwYD3dCV6OH3V+U4k69QBgPmU7jnBoyEq6sNrJ0729VYhZdpZUpVpVgyae4vIWyNfA+LukADdSHY1rBiZMmMaDKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579697; c=relaxed/simple;
	bh=eeYxR7f0iZY1hKXnypXqzksbgvicyU2uUIq3yrFEag8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H5EOOro70ytRXZ/8QbZlTrTYFCrBh3neHG4MgUrZJvGL2Hjx6pnk2wUj3wP36w7rpH+n3zbh2nr9v29lkzdDKaNqLZZEOx2++NsapX+Bw0qT4alFSMi7nG22K6pX9DQSICVz6ApsIlgmfxsJrdKykYOcHCIyXvsvDTRJLJhhIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSDvU2HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799EC4CEE3;
	Fri, 21 Mar 2025 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742579696;
	bh=eeYxR7f0iZY1hKXnypXqzksbgvicyU2uUIq3yrFEag8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MSDvU2HFy2pRCbKSWUbeugzG7hn07ukshx+wcLjxPX8gx3dlQxRASUmk+Mk9hHep0
	 oXiEJ6i8w1Cw09ZRwSN2D9XegkbERXwsQWRDJP3njd4MnC4jHBa9Ml0gp8IL3hkSQL
	 yqNBP/l66mDoBewEY10VjadXPK85gCmXvXykBMgOG/xAg3xXl9bLwfw+0yG/2774ph
	 8NJOoL6nHjITXkyUEJhCz0YxCEuk7574O+P02bWE2WnzI6zP8RtI2/po6e9aTuLJuC
	 kkVMXBCe9631PD+/HgF2+wU7XrF/LhYzd8qRaHsNVmIxHz3xrA+c3+gm2j03qiwHT/
	 JftuuHx8QtInw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "end.to.start" <end.to.start@mail.ru>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250321122507.190193-1-syed.sabakareem@amd.com>
References: <20250321122507.190193-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: update quirk data for new Lenovo model
Message-Id: <174257969276.2379177.13162726793964465058.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 17:54:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Fri, 21 Mar 2025 17:55:03 +0530, Syed Saba Kareem wrote:
> Update Quirk data for new Lenovo model 83J2 for YC platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: update quirk data for new Lenovo model
      commit: 5a4dd520ef8a94ecf81ac77b90d6a03e91c100a9

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


