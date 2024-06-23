Return-Path: <linux-kernel+bounces-226336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF2913D30
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A731C216B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B218412A;
	Sun, 23 Jun 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsnbygFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEF18411B;
	Sun, 23 Jun 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163313; cv=none; b=pAO6oUjOWOLMqaEgfJmCNhjK2o4XJnA6Zb+1WmSOx9GZ21fbRgoYTfTpXBZhuZBSeZdyjSCbIC+9SzsnfUiPn/689wQr61raVe3/sbQc2L5+6XjLx3xQJEVne6sQC3IBS5ri2DGTOkSXg3Kpx0KsXfbtNrO8YiCp4xl6K6QHudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163313; c=relaxed/simple;
	bh=p0KUc6h2/ow17wD5avXezjtwzpeQ+9BtZXkrRp+Lbfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DABgHdpHrbuF2bKpjgmtqD34yjyYsCYEFGVUXVPZ3TsEO/2Yx3rOiFTqQ1ZOxuAfellGjYAMLjwLl4P6Sjv7nedBFiNzZ6swZT/d+brrkX23mLsxFavmx9r6ywZL8VlrF3dYT+wb8ejAqMn3yL9WgzuJ3KCK0Xz/Uu+QV2RpPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsnbygFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C260C4AF0A;
	Sun, 23 Jun 2024 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163312;
	bh=p0KUc6h2/ow17wD5avXezjtwzpeQ+9BtZXkrRp+Lbfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RsnbygFkkiekf02I+3kkQCiQD60H0sdujZHBcTbc3I2jPYdy7Hq6ROC4BFCEmcNQ4
	 /b/PVkH7YS+bUWjOuFF5XizMs/s4vKkAnIe2sekaL1WNevyaYPV93tBdu0Zrg1zXlw
	 WRiL4Ne6XXI1peq92wkLb/XKcpakj//Z4KrDUqu+3UxHHQjaBR1BohMz2xLEBJX/qi
	 zesSlQB5RJ6qxBGrkGYuOsddhBsqZc6Zj7WnZH40tWo/UBdrn/zfVvOo6az+OUZbcS
	 JJM7/1lg89ybOfjC67WVSy8h6OUdhQ28SDIlDw2e8l8Yn7sJOkwCuA1Twk8POteDqA
	 9gcafFCpQdoWQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
In-Reply-To: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
References: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: nau8822: add MCLK support
Message-Id: <171916331110.350242.11572228488455429379.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 18:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 13 Jun 2024 10:46:49 +0200, Andrejs Cainikovs wrote:
> This change adds local MCLK handling, which would cover a case when a
> reference audio clock is present in a system, but is not allowed to be
> changed, see [1].
> 
> [1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/
> 
> v1:
>   - https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: nau8822: move nau8822_set_dai_sysclk()
      commit: 9292013bd3738bd00ee78bf1705620a9881031b5
[2/3] ASoC: nau8822: set NAU8822_REFIMP_80K only once
      commit: 9c3b21cc8528d52321c66236c3b794300c78d9e6
[3/3] ASoC: nau8822: add MCLK support
      commit: 2604faa7b71291b0ccd17f8d6009f3ff6dae287b

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


