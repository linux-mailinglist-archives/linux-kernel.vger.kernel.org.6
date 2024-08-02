Return-Path: <linux-kernel+bounces-273157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2AD946508
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D01C211AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83115130A7C;
	Fri,  2 Aug 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBTeeDqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC27CF33;
	Fri,  2 Aug 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633999; cv=none; b=qmwqvJXwgeowVaYjYPibiaTp3tPjZXtEciAIIA1rVcyqYLDhjdzZ0QgNu494qBQsBoOOeIYDh3Ps1mKAuhzMhwEzqR2pSq9S/V9L4BALrRqgdqo5ju5zeRMM6mzmqwMpopIlpTmPSJ0EBHyxrkgMxDmjmCCrEXkbKsUmFGjIc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633999; c=relaxed/simple;
	bh=xPpOgoirjlpTp6dIkK1onCx8bz+DwC/ESltou7nhPII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b5QQLjY/CalTP6m3+XchmnOiFF5xdleBf/UnmJiG0HuZeUCMN0UBCbWdnNA1Q8YzWmGunsCN554wpw8afgXG53kxvXrn5EQ9I1tMeVPTAguJppwq8TJwxafy0zfgALWO1DBWnYtBd4M7qJ8nfHZCMrkXkUHsX6+JLk98qH+AjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBTeeDqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B85C32782;
	Fri,  2 Aug 2024 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722633999;
	bh=xPpOgoirjlpTp6dIkK1onCx8bz+DwC/ESltou7nhPII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uBTeeDqDk4FJpBnvh59txdULuMSlyeHec0h17tIktJckFKxW5lGA1LsUv5q8datEn
	 vFbeDNsRKmwhWtSiPA+Gc7HBXQXO+h13ky4cfKFiW3bWe6tN+a1luI5DfI7ZkqpQ1j
	 JeElDwqCv7SCS/rADZeGTsRGVFkdNzA8pHI86aJR9GXuc6SB9HJo14z+vRHb3vQ6sR
	 yDRyn3ECafo1GyA/4L8cjqZPiGCGsK16jDMtUCcZHoeCzVu2ROS77XgVNqpEUe3/eD
	 7v9m5pknjQCVsMF4aNmoG3Le9NqzEHqT9DH3oB/nfQvqTERXOKsXyOW0KK7FC+0Aye
	 ESyU5lJntzVCA==
From: Mark Brown <broonie@kernel.org>
To: ckeepax@opensource.cirrus.com, javier.carrasco.cruz@gmail.com, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
In-Reply-To: <1f04bb0366d9640d7ee361dae114ff79e4b381c1.1722274212.git.christophe.jaillet@wanadoo.fr>
References: <1f04bb0366d9640d7ee361dae114ff79e4b381c1.1722274212.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs43130: Constify snd_soc_component_driver
 struct
Message-Id: <172263399662.130801.3172998123321447676.b4-ty@kernel.org>
Date: Fri, 02 Aug 2024 22:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 29 Jul 2024 19:36:05 +0200, Christophe JAILLET wrote:
> In order to constify `snd_soc_component_driver` struct, duplicate
> `soc_component_dev_cs43130` into a `soc_component_dev_cs43130_digital` and
> `soc_component_dev_cs43130_analog`.
> 
> These 2 new structures share the same .dapm_widgets and .dapm_routes
> arrays but differ for .num_dapm_widgets and .num_dapm_routes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Constify snd_soc_component_driver struct
      commit: 839e231a53b824a62bc3696ad3ba1dcedc4f4167

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


