Return-Path: <linux-kernel+bounces-423451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAA9DA7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496ADB2A50D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC051FBCB2;
	Wed, 27 Nov 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr8e21Wa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9921FBC98;
	Wed, 27 Nov 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709608; cv=none; b=UYOkWfMBJ90Tj0nCyMl//np2A9VrsBnlTm6QPwpUNR661XwFOqRpfhxYhe91BxHCMhYnP9IcMMjAuuTbCL+aSODGsEBtLEp+SIzQJkuxnPg67rcmDrlpgfQAGEgS7KFbNm7tQV0rk8kB0IHvF4fdUZFVN5DecVli0Y0SzD71RgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709608; c=relaxed/simple;
	bh=Tv5cvq2RgINXn8PDA5t2XSd2bmj+HeJ5oa/gl47q78A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mqjVe9xgkEBNcNkFvk7zCNOeQhvpRdAS65dYma8geqw22wM8MQuiYZZNqldZqTYW3dfp/c/GtjW7Umx/P3SiQ19WnZPV1e+ZsaLXv+d8iw6hUaifns6Qcu90odCBOfsR2Oigk0Z/dJjumtZBFpePvgNmTCmFCUc1d0YR+eGcOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr8e21Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E24C4CECC;
	Wed, 27 Nov 2024 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709606;
	bh=Tv5cvq2RgINXn8PDA5t2XSd2bmj+HeJ5oa/gl47q78A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fr8e21WaORVm3rr7fng1OjQIehgnDrbBCsfivQAVs5Zq4iqvomDxLgO2/m2KHFMiI
	 GPeaNtV6K3D8iRQG5FU+IE6PNJI0Tal9xdgZIMny0BjbuDD9X9RaIxNbg+/1MkAd9x
	 KcfaG0gLr0PECSpv2UqjwnI0leEQzY8BepN6CsVcQFrrVWWiZfbz+6AweruKTxle6H
	 jRHrBStcSIJ0C1PiNutJ2lmuu82mw2V+o7LJ80lv07dbMR+qiuKA1FMwsMwtx00A9n
	 xXvC2SYDH3NQvHU9bw2Xo/odVd7kVB42UVu/IQdSyaM6IvlpwqazvZ4mTSgw/RiT0b
	 4tl0LMpFuXdyQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Tim Crawford <tcrawford@system76.com>, 
 =?utf-8?q?Attila_T=C5=91k=C3=A9s?= <attitokes@gmail.com>, 
 Techno Mooney <techno.mooney@gmail.com>, 
 Jeremy Soller <jeremy@system76.com>, Malcolm Hart <malcolm@5harts.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241127112227.227106-1-venkataprasad.potturu@amd.com>
References: <20241127112227.227106-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD
 entry
Message-Id: <173270960306.162310.9745646028251378835.b4-ty@kernel.org>
Date: Wed, 27 Nov 2024 12:13:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 16:52:25 +0530, Venkata Prasad Potturu wrote:
> Add condition check to register ACP PDM sound card by reading
> _WOV acpi entry.
> 
> Fixes: 5426f506b584 ("ASoC: amd: Add support for enabling DMIC on acp6x via _DSD")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry
      commit: 4095cf872084ecfdfdb0e681f3e9ff9745acfa75

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


