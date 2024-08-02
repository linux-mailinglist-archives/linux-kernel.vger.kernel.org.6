Return-Path: <linux-kernel+bounces-272978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA154946302
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD5B1C215F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EE165F12;
	Fri,  2 Aug 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8AvHhuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD413633C;
	Fri,  2 Aug 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622864; cv=none; b=hXkw++M7unaIuCAP9FTrX2bEgnoK61H5+O+1j880Zqrd8cBvvW6KtTIWYcVhUEtWKopRSVxu48l/UcYURG4Z7EC8zAfoZFNkWdYx2rzjnZlP7QD6UrEL1aamYoazkHFKYD850fLj05dF0tleLkbcG59Y3DvGG63xu8MgsGGw+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622864; c=relaxed/simple;
	bh=SIayKwg6/dUeT/mwVPn/+0LZgcgWn0cXJslMp5cufg4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eR5IaNFOc4FzFcBoV1ds4bj7veSitq7G3P0oDGnFLU87hqV16inqgUVboX7c9F8DmQk7kswR5z1UvKH8wEeZ8RfUp1+XYHSlftRXbz4f52djh87WnVVGt/RctZ9eOPMo3pLnE0dbC1NumP8lTxgqmRzZIrFCFVZcG0AzJVj3akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8AvHhuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68DAC32782;
	Fri,  2 Aug 2024 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622863;
	bh=SIayKwg6/dUeT/mwVPn/+0LZgcgWn0cXJslMp5cufg4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c8AvHhuCfvhgpAl8cS4jYym4/+PoRMJY/eIMj8cS2d2POJL6GpOY81ktu+SjVs07Q
	 rcee2NwjJqc3OHMNhfjlWsVPXoXrDNWXz9dawbgbetLI4UwMRVL3b7A76wdLIZCtUt
	 r4PISXYw9ioHJKZXyrHRHvgA4h0YgEZX2SCY6VjVdo2TfP7ldQrDZ4jMMWwYGTM0KH
	 wpEuRGMdl2i9cpbJia9sigPl2c2WsjpaaRWH/B3BsHYJpqGtr4yXx8tu3hdkpNBqI9
	 9Htf/8zcwOT//dNXUU64fDrFg+qV6POBh2xZFe3AlDtBevNHSCFM4JOtui20g54u4d
	 SodKAx0RoMldw==
From: Mark Brown <broonie@kernel.org>
To: ckeepax@opensource.cirrus.com, javier.carrasco.cruz@gmail.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <2c08558813e3bbfae0a5302199cf6ca226e7cde1.1722544073.git.christophe.jaillet@wanadoo.fr>
References: <2c08558813e3bbfae0a5302199cf6ca226e7cde1.1722544073.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: sti-sas: Constify snd_soc_component_driver
 struct
Message-Id: <172262286152.83468.908434920268261104.b4-ty@kernel.org>
Date: Fri, 02 Aug 2024 19:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 01 Aug 2024 22:30:05 +0200, Christophe JAILLET wrote:
> In order to constify `snd_soc_component_driver` struct, simplify the logic
> and the `sti_sas_dev_data` struct.
> 
> Since commit 165a57a3df02 ("ASoC: sti-sas: clean legacy in sti-sas") only
> only chip is supported and `sti_sas_driver` can be fully defined at
> compilation time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-sas: Constify snd_soc_component_driver struct
      commit: 11c2d223713b7a7fee848595e9f582d34adc552b

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


