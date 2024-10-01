Return-Path: <linux-kernel+bounces-346448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143498C4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644D4B2214D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA01BF7E7;
	Tue,  1 Oct 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r57J77hX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B91CCB4D;
	Tue,  1 Oct 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805193; cv=none; b=YX2P3nb2AlaQ78lr3vNz7Lwm7Mu8o+ukKGkwYSZ9TI5UBt8CwxpRwpQ+fNvy6wCPgDaiLMDVnWR48LlyeL3RIAmKCdBphjtCBe8sPkkGzqJPPsE5IG80u+sLgJxo7FdbEUlB/X0WFhuOPZtetbms1XkGF1RkA8zvDmIvUa9Ar4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805193; c=relaxed/simple;
	bh=bbZoAyvXIxNMuJ9OQ/XRQbNu6LdQ7bQgd2zv46meGJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IWTQoYVym3RZCOpc8rnRmDA2KPiB7a9xGuJL2oBG1nA0zPaKwHZY2Lguk98lu0SFvSvsRRDL+TSXWz+1yfAMvudad+oQlUaG2kvPjU2sAe9pS6ryj5IFrqdP7uQvz91bzKZOcB0Jn9bLAj3V/HQlyFqk0tkskuI9VUl7Hklf5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r57J77hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF54C4CEC6;
	Tue,  1 Oct 2024 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805193;
	bh=bbZoAyvXIxNMuJ9OQ/XRQbNu6LdQ7bQgd2zv46meGJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r57J77hXdFirG1aq5RkV/Gl/E1coUgID2M5wS5A77z9/kuSnXS4o2APuq/b7LtZXb
	 AGPkuctWSYbgwlHT+cTAN7VQ8PUE2eZzOgc+8TkoLjoZHsAaxGYesRpWzjhb/jO9Mb
	 QTndUJyGoMWGZDIZ2yy1I+rsr1UYeNUuHtRTAxAzFYWkkTatOw8vnXXkgMtHOL1hUm
	 g3D49g/Nzt6zYgOnkL8U6qauw074YlzkEBX/APOt4Uq2ZLWtNc6/jEsWoM1SvUQQTz
	 UuxRgGduhV4jMVELIhg4fKRAKOtti4SxoMAD3qG/v1qL3arn0AzqYlmxyyLgAV8vzi
	 hpZaXnj4hnCNA==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240916131910.22680-1-andrei.simion@microchip.com>
References: <20240916131910.22680-1-andrei.simion@microchip.com>
Subject: Re: [PATCH v2 0/2] Updates for Atmel SSC DAI
Message-Id: <172780519017.2298697.15357043212367234961.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 16 Sep 2024 16:19:08 +0300, Andrei Simion wrote:
> This patch set includes two updates for the Atmel SSC DAI driver:
> - Address the limitation with the S24_LE format.
> - Add stream names for DPCM and future use-cases.
> 
> Codrin Ciubotariu (2):
>   ASoC: atmel: atmel_ssc_dai: Add stream names
>   ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel
>     limitation
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: atmel: atmel_ssc_dai: Add stream names
      commit: 879c9151572317e8ddb6ab6c57a7689bf580efc9
[2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel limitation
      commit: ac8775d7de5a8ccac225a398cbce9fb9fffdbb9f

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


