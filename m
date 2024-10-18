Return-Path: <linux-kernel+bounces-372352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C39A478B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821481C22E18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B978207A34;
	Fri, 18 Oct 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGBRjuk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A12071F3;
	Fri, 18 Oct 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281689; cv=none; b=h+t38siNMYNTn71jDaPhXCyHz4zcpjIvO42zK8/BItXMwNFhkA5XFTg0t1Za48JhlPpxSODo46DHviMYPnMs5JhJtpEPSEOc9HRXCU6Bn7Zu/30lW+6CfDkU+RCqj7OH3yx3GaJY+TpuS6IXdSH7p4dtvxQ+MRnfOyblRArXBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281689; c=relaxed/simple;
	bh=F/Qg4sroR8mBbE2eR+VURuFEuPYxXZpNpv6skBP+GMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NQ3RxFXoj9Pe7SwlGr6Qqma7urvncuTnguhFDpzUZ2Evd41moqYHWUqBztQarvbfDUk6s9GpKVrw2rC6lNPuVFLhjsFMniSnEzNB6fO7tlIWKNlzWbACasNCiuEWRyDMxDsfTP1LjR0SF/2xC1CxAfF4hW+6ZF50DNHxrVLo0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGBRjuk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E83C4CED1;
	Fri, 18 Oct 2024 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729281689;
	bh=F/Qg4sroR8mBbE2eR+VURuFEuPYxXZpNpv6skBP+GMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AGBRjuk4GAqW1pVdPh0oPnlknqOx+RXlrQYhVYqKU82fCOCGu7IBmssONO+/xn8E2
	 2dPJ3Oic8nm60Ek2iSW7ytFgnpwDur4H4gdr8NbHWGwHzbhTvpYCLV0Pi8smhn5rQX
	 eGTPjWQIUjVjMpVx0m+tjohpS76kGxgM/sPe6RukQoIZIpLEoKRuxB8sfWT7qIc7XO
	 U7WnIlptZafMR+d2cdfEUzzms0rwDkxzf2woFKX9slEMuzjCOCtpy2NYVtdlLP8bhy
	 jSyzMxhV+yoLtThaz4exYV8PgNwtu4OU5JHXU9rc/5xDEmT+6Pn2YZAM+iHET8XeOX
	 JLvru7cZUNFEA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20241018110743.18786-1-v.shevtsov@maxima.ru>
References: <20241018110743.18786-1-v.shevtsov@maxima.ru>
Subject: Re: [PATCH] ASoC: nau8821: check regmap_raw_read/regmap_raw_write
 for failure
Message-Id: <172928168672.188041.5557095423095482145.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 21:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 18 Oct 2024 16:07:41 +0500, Vitaliy Shevtsov wrote:
> The return values from both regmap_raw_read() and regmap_raw_write() are not
> checked despite they can fail. Propagate possible errors to caller.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8821: check regmap_raw_read/regmap_raw_write for failure
      commit: 1b9971a4e01b80afbf061ad7cdf84ac6fbbbde8d

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


