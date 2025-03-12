Return-Path: <linux-kernel+bounces-557717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1BA5DCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7FA3A7645
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CB23F37C;
	Wed, 12 Mar 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz99a8UG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E8242923;
	Wed, 12 Mar 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783182; cv=none; b=Lo+9+RPvCrgrMiMyxn1CCPBjEDWMz+RklKTd5jTNhGoPPvB3KLeMbEZT0eZjA/rsgZX6oFzRowXWGQrT3KIcSzrhwdbmwdnMcvNrXZ8AU65iUKmDUfqzzPmyojbcn7D0oGVKVSKIRtvu6VaHL6/jPQApwDiEyTZQGotvcRAqWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783182; c=relaxed/simple;
	bh=H3HybGaUKBS9YrAf0ND7xXzJkEyXkytMuuP5BxOuzL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m9EbCVmjnxhRmmD9exVVUf0SSJvD5HYUBQLY/ldMl3sFWmjFsl5VqM8wZYw7pA6XINWHdr9lx/aLWkv5+UGmbEmAEVtXkd9t0mvFECm6ZgHoS1fPF9aajX2+7xYb25mdlgIurucWgNK0O3+iZ7AYs7hMqTyEDtm4Azq8HPaJKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz99a8UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E64CC4CEE3;
	Wed, 12 Mar 2025 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783181;
	bh=H3HybGaUKBS9YrAf0ND7xXzJkEyXkytMuuP5BxOuzL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uz99a8UGQoTNYfNUu1cSAzael/QVMI439kJK8QuEDN2Mn+CR90x1u1l/jdbWvGr05
	 6zQNVA2Irl8MgLfXQ4HGPXcjGAHUexQzMT2YqRC8mDTmQzuQD4Tg3ufntP8kAqHLE5
	 p8JVecBYxzGEM0P0M/mlljtGV24Xo3A+fvgHQkA0GPj1BA86s/YcGSyrupC1p5yMm9
	 b0h6QypHDraX5O2eJV7aA0BGtOYJzlQu8YPZK6xgcnej0PXwDj9sjeIXoOyn830zGf
	 OnMAoOYKX92D0+fdwslo05WLy1JHcz8/OcmSLcJ2/hnDLTP+Rx03piBnuJpTcLVaF6
	 pbJIlVce0wQKw==
From: Mark Brown <broonie@kernel.org>
To: amadeuszx.slawinski@linux.intel.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, 
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org
In-Reply-To: <5139ba1ab8c4c157ce04e56096a0f54a1683195c.1741549792.git.christophe.jaillet@wanadoo.fr>
References: <5139ba1ab8c4c157ce04e56096a0f54a1683195c.1741549792.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] ASoC: codecs: wm0010: Fix error handling path in
 wm0010_spi_probe()
Message-Id: <174178317936.22408.8969809539586039270.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 12:39:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Mar 2025 18:45:36 +0100, Christophe JAILLET wrote:
> Free some resources in the error handling path of the probe, as already
> done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      commit: ed92bc5264c4357d4fca292c769ea9967cd3d3b6

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


