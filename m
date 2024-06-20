Return-Path: <linux-kernel+bounces-222530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BD910354
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB5DB223DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C01AC764;
	Thu, 20 Jun 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND7yUXF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B21AC451;
	Thu, 20 Jun 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884044; cv=none; b=mzH4ZHOezYMtYBQN1EaUXQZsvDDyB5g3mLjGI5LS/y2hSi7sgdh7WeKmpVV5npvzI2VUSHOXDzGVI5CHMb3EBfpgpmnyLLYs/nBsu8drkM20N5hdMFp9tIQzGuEU/EHl3fs7+NkyTGgd7mkPaCPM3o4K0PrK3v9Xb+gfv8edc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884044; c=relaxed/simple;
	bh=rbeOxems1FuSby3UK5MmTHjuVfReL3BNUB/fTrMgsSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ag5OBJbwakYasDOerS8WrMVbuMV68VNFaVtty88HTG5MyKc/QoEn15ZrLvKYr2vYLA48EaA4p5loQJ0x57ufaL+TJ/Dr/kV1QYtIIbEOYmXFLfPScMZMoCvd37gDjcLFsDWprZ6Q6MN8zYQOHIY2ZUPY9mw8x0yjCm2QhJnxKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND7yUXF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6EC4AF0B;
	Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718884044;
	bh=rbeOxems1FuSby3UK5MmTHjuVfReL3BNUB/fTrMgsSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ND7yUXF05VcA9LHJDB+fZ/aK7w4Kib15dQY470C2WchRa7f6li1bXbBO7PlFuwsEu
	 N9j3Su5Ul3f0pdNS6FH5Xv3s76ln1SFife/y2RYbFklB++NE5XJGKAgAWA7LR3X+5E
	 d5KhaDN2vba9O0Dxsk9olM8EFYgl8sQUi4JGJ4HDskgJuFIVMfN+aWygBQP6BWoCX5
	 AlWAeW0knBdARv3YUpkTnpC5LaG9OdRFkUHW2E5RFC6rXp+yIRC7X2fwxzj2iTPRV7
	 50D2ixnxkLzb0UCm2k11DBNUSEj/aAjvD8DK7o/4xsb4fubk8T6c4GQzerB5GF3ACL
	 nokANLX6c73Rg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
References: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/8] ASoC: amd: acp: add a null check for
 chip_pdev structure
Message-Id: <171888404167.51171.12647863943133504224.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 12:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 12:58:34 +0530, Vijendar Mukunda wrote:
> When acp platform device creation is skipped, chip->chip_pdev value will
> remain NULL. Add NULL check for chip->chip_pdev structure in
> snd_acp_resume() function to avoid null pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: amd: acp: add a null check for chip_pdev structure
      commit: 98d919dfee1cc402ca29d45da642852d7c9a2301
[2/8] ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()
      commit: 70fa3900c3ed92158628710e81d274e5cb52f92b
[3/8] ASoC: amd: acp: move chip->flag variable assignment
      commit: 379bcd2c9197bf2c429434e8a01cea0ee1852316

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


