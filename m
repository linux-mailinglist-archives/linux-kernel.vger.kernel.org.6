Return-Path: <linux-kernel+bounces-354187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E3993930
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C49D1C2319A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1A18C334;
	Mon,  7 Oct 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU1Y9BX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B916E87D;
	Mon,  7 Oct 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336614; cv=none; b=Qy7dcSUW+18E+ikVU70gpqa2nj/haR/ZHg2A5cw9JDTqfD1cSp7Xz/Mu7S8OmQb8V/i6W/gn47pomW0nVlQwV5mutcfyedGW8lcTQJYbgdGDNId7Lk3e5rI4O/dfaARRdt1d4CwRm5SHB+mG32IfFT7d9vhc24Kejy5VhcdE3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336614; c=relaxed/simple;
	bh=8o+yrEOOtiSiBfWaBp1QfIZYWs4xvqSa5neZU4qy49Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T6GRZUcZ/KL0YN5lemYK2um/uqCHHhpY5aMTyFgH/W614aoQgXyL+wxoYCQOEaW8YOW2RuPqjDOnSUFBGYvE0rxPmb6MBxImKhtSKhUQmNYh3Cn+4Vh7lFah5SykkRo6RWJAIAk5IoUTJ4Ioxjc66enMi5oze6pKIy4Unt0N9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU1Y9BX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16EDC4CEC6;
	Mon,  7 Oct 2024 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728336614;
	bh=8o+yrEOOtiSiBfWaBp1QfIZYWs4xvqSa5neZU4qy49Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nU1Y9BX1SobaMtnlYNWyiLFyo1C4SFdbgigsuJOrrmVl+hpNOZ4CgQo9gOw8znbSC
	 4T54XVJtVNigk4qQgYSNT5bnhQL7GgpiWMGKkHB1+xsELWg2yN23neB58PcXuPcFhb
	 sHKzcCS/jvzeCN3oXoCzCQDNaaS3fBsZKf78RwWzIFe8w04Lb0FI0YXPTOdxONksnw
	 nF3tNTYFeL84t76nu4zo7Z3DySBIDtQq+XR7yyepujHhgaEbozm8Oosj1g170rXhtj
	 nt91ANdW8fNBkZLLTLReWrE9si7+KalxTwVwqmsDOYf0AWVRu2hmKpU5DYj7RzGUMJ
	 tsBvRHeaknSSQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.dev, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 dan.carpenter@linaro.org, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
References: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/3] Fixes and improvements related to amd soundwire
 machine
Message-Id: <172833661153.2566981.7852746403843852691.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 22:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 07 Oct 2024 14:23:18 +0530, Vijendar Mukunda wrote:
> This patch series consists of smatch error fixes and code improvements
> related to amd soundwire generic machine driver.
> 
> Vijendar Mukunda (3):
>   ASoC: amd: acp: fix for inconsistent indenting
>   ASoC: amd: acp: fix for cpu dai index logic
>   ASoC: amd: acp: refactor sof_card_dai_links_create() function
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: fix for inconsistent indenting
      commit: 914219d74931211e719907e0eed03d8133f8b1b7
[2/3] ASoC: amd: acp: fix for cpu dai index logic
      commit: 7ce8e4d380d68f34edc96c7efcf95b1476e7f033
[3/3] ASoC: amd: acp: refactor sof_card_dai_links_create() function
      commit: 0372abfcd81a4db94070d235e1ae3ff928efcab9

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


