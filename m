Return-Path: <linux-kernel+bounces-169025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5EC8BC195
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633BAB20D89
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9C37714;
	Sun,  5 May 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsPiD4mE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EC2C6A3;
	Sun,  5 May 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921396; cv=none; b=VX2RsZbe+7VQJw0cgiU5vjyleWLeIVZv0hGMRqzkoRLBCzhbN4iFA3I7H11yj7CNjogpaBJlg/MlvTiaTE11eH2AK0tq9c36aUIx1y18XhRTzFZCAkFyP8ZwWKM5JCkekQW+bm8lDJV4soOtM6pthQh2wm5mLbohPbpeOf9jiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921396; c=relaxed/simple;
	bh=oPE8LDuukrepCZDNBL3OUxIxwDD30ihJBAhHLx9X8t4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exuTnTyX034pIOIvdZ3Mh04kbMsj+VrPknGsEFjvlGdvyU2RmRueiq1bWsnf2tDXsvyhp5t82a+ql0ILvTBCERtof7lNZiVaAPkyox5p3DY0gzOlLDTYy5SB8l/3e8yCpge0w0FTL5S+3IFFiUxmApqr4rhl23SZeCiCyCUxq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsPiD4mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01065C4AF67;
	Sun,  5 May 2024 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921395;
	bh=oPE8LDuukrepCZDNBL3OUxIxwDD30ihJBAhHLx9X8t4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lsPiD4mEIK71p5yF+C4j4SpIWv7eIH7svdqYO9zD03Ks/sAQvupfnwWcXA0njDKdH
	 yNWYMrm/ON4piogM26WUP3466UZDkuTN9aJhLYYpSxsEuMUAHLx5CMJWk0EH6WlB9e
	 +852GDSY1dLJmnTnQXXgHPTo1ZHGEUrtv1QegJ30kH4XQvggtq4M0sVpxPpLFQezuj
	 kjb3ttQU4WT17yoZCvgL4rpUxjbOJDRkoF5XDwLtXyJeauWc/lPFU7ODmnK7ZRVSTl
	 Ig2e42fgDtXOfKT9PSIblf06jmf6ZogVP4jkXLI1fMSE0yFlmzpcx3I4EjJGnotyNd
	 HynQPdrq34aMg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
References: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: acp: fix for acp platform device
 creation failure
Message-Id: <171492139176.1933443.4741403457538760265.b4-ty@kernel.org>
Date: Mon, 06 May 2024 00:03:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 02 May 2024 19:33:25 +0530, Vijendar Mukunda wrote:
> ACP pin configuration varies based on acp version.
> ACP PCI driver should read the ACP PIN config value and based on config
> value, it has to create a platform device in below two conditions.
> 1) If ACP PDM configuration is selected from BIOS and ACP PDM controller
> exists.
> 2) If ACP I2S configuration is selected from BIOS.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: fix for acp platform device creation failure
      commit: 09068d624c490c0e89f33f963c402f1859964467
[2/2] ASoC: amd: acp: move chip->flag variable assignment
      (no commit info)

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


