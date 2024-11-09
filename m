Return-Path: <linux-kernel+bounces-402612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856659C29A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFBC1C219FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE113AD26;
	Sat,  9 Nov 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b97qmbzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D2364A9;
	Sat,  9 Nov 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731122039; cv=none; b=t3G9J0XpykKYBhaK5tkaaS8Xxcqp3GjDENItLKpk/mm32Z7Ogm8r0kACqbYMyW5qMnJmmF6BpxQeS+ff0hj1DPDat75gHyDKVUNiZhCnFXfrO3ct5Doh+MrArWr3Ej0r+yrCm931CAKz4lfsKlf6qzRqWZYvYIgtdDM/B7wmtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731122039; c=relaxed/simple;
	bh=3iuSVudXSVZ71knUjkoNCSsIOWru8sa9e6szXIqlfzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lDycEIQihqVCZsAQQ7JhzRkfzzruJV6HGf8/L82RrHj+yAN/vmQntQo+2PFc8I+pcyE8DvSy7ta73KnJ8wrBX6KoPxqI9pPMWRkYJYppkhIMYu0pdSbX9cb0f85Ok3opJzqTSMXPBd4nDGLMIIww2SNGnL4OS6LUGjYdCwv2qxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b97qmbzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38A4C4CECD;
	Sat,  9 Nov 2024 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731122038;
	bh=3iuSVudXSVZ71knUjkoNCSsIOWru8sa9e6szXIqlfzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b97qmbzxHSMDPTebIajbloR6t/MitYhUl5O/LUAQbMy+TsgopB10WpUI/9piWjhES
	 V1gnbjuYspRzOZipR3l2z2IW3A1oEfqPsHD3TA2AUyem0X5uRIrkPxVcpdeBH8ryDl
	 HEm9L0QOeZC4/7PBHQH2qi87weYV74syaBNRqV9nutFYnq2xcwVPLB0Yd8NUOY600N
	 Iae6osyixnV+3cici8b6Ykjuc4JGPYmOuFFvymAzlMzVVAtxxQuXBHwaIXxylf2WaF
	 FZ/7QdV9bk6NODxQ4FOPhUh3ydjxvvM2+LABxhYipTZuf+6fj9UcPIrK/6pLIpRXIe
	 vMo2mPAowliyQ==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
References: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 0/2] ASoC: stm32: i2s: add stm32mp25 support
Message-Id: <173112203540.168194.9961366675088520447.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 03:13:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 07 Nov 2024 15:47:10 +0100, Olivier Moysan wrote:
> Update STM32 I2S driver and binding to support STM32MP25 SoCs.
> 
> Changes in v2:
> - Rearrange clocks and clock-names ranges depending on compatible.
> 
> Olivier Moysan (2):
>   ASoC: dt-bindings: add stm32mp25 support for i2s
>   ASoC: stm32: i2s: add stm32mp25 support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: add stm32mp25 support for i2s
      commit: c69b7edc10d2fff4bcb3dd464ee26cbf22818fec
[2/2] ASoC: stm32: i2s: add stm32mp25 support
      commit: 125d0f698ad500b0092812e52a6c342ba055ae68

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


