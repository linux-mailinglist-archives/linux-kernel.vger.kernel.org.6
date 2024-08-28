Return-Path: <linux-kernel+bounces-305368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E610A962DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9DCB21638
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC331A7060;
	Wed, 28 Aug 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqppbnoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038C1A3BD1;
	Wed, 28 Aug 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862619; cv=none; b=Txd4AVVMM0loV6ksoftJ9Y2y0IN1qkwlDGnHhs8doKZxrIN0+fvVybnfTVFssdyeZgmR5mKRSRFVuyTYS2877Cjc+UqIq4SYamZrltqJqEhosPIrc3deEjqQgvJ0tt5dELfu8JD2xHWs5lliA5Qw0klT57VrMO8Hd5+R3znfbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862619; c=relaxed/simple;
	bh=H23EnDvtE9OmuESCjNLixSU/rsMuNsrNorY5cnn0tc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W/cyRSu2B1tnLO98eroSvdE47i7pC47h3wLTjegH2rJ79p03BV2vXY1DMVB0o6OwS1clY8Am27g4rn8DASnMNkO/txrDyMM22Rfu6OlLy42b2oQehdY1GFUAl1HIZRcA/wL6JsMK0vtXcRkYl0uMVpMxtWExXw3X+soFeBP46kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqppbnoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B651C4FEFB;
	Wed, 28 Aug 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862619;
	bh=H23EnDvtE9OmuESCjNLixSU/rsMuNsrNorY5cnn0tc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CqppbnoU5zqQYj3dMyaprtr0/LUbAdMYK7D/fDuKlbYr5JU3UZLz78VYL8CZo/O/c
	 Njk37dXQms6suXRdMbDtmth4IWvu90OiZ5ZZpeoNWXNYyBxX09w3T0RI/4MSGGfnGY
	 XEkvcneRAz+JftITxHNv/sKtDz83qBxehvakWm9lih3fLiNKSk083ykam9bu4uvBqu
	 4+NghREbcVEmxb/xokqOXpWJMwn52qey4e/5Eyp8MgeKEDUZb+ParJ/i4lomd3H2ip
	 VMN4rFd0eI/0vjZLXa7gU+JkIc232DjcjFd2Vpc4MVX96OiVm5bFQY/AWp1DgxDN/N
	 zJNC0ElDN9oUg==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240821041006.2618855-1-wenst@chromium.org>
References: <20240821041006.2618855-1-wenst@chromium.org>
Subject: Re: [PATCH] ASoc: SOF: topology: Clear SOF link platform name upon
 unload
Message-Id: <172486261586.92851.5753757974025267172.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 17:30:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 21 Aug 2024 12:10:04 +0800, Chen-Yu Tsai wrote:
> The SOF topology loading function sets the device name for the platform
> component link. This should be unset when unloading the topology,
> otherwise a machine driver unbind/bind or reprobe would complain about
> an invalid component as having both its component name and of_node set:
> 
>     mt8186_mt6366 sound: ASoC: Both Component name/of_node are set for AFE_SOF_DL1
>     mt8186_mt6366 sound: error -EINVAL: Cannot register card
>     mt8186_mt6366 sound: probe with driver mt8186_mt6366 failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: SOF: topology: Clear SOF link platform name upon unload
      commit: e0be875c5bf03a9676a6bfed9e0f1766922a7dbd

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


