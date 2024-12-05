Return-Path: <linux-kernel+bounces-433680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AE79E5B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E22728A7DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345CC221449;
	Thu,  5 Dec 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6dqKZik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB411DD87C;
	Thu,  5 Dec 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416612; cv=none; b=iUvqPekukSkE5iyE1x4+zRiB8cxPgNH+FKf88nnAgeXn7Vi74R4F5DkdKb956xWpUc/6AKPL0/kRm5q1UhkBbuUnqqc2X07bzvS6hsxuPshXMWscOM9Szgf4Xo/sc0RvoeuDsrGfS1KLZFkQK3bKrZEVPsC6dvH5yaaD2tLKqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416612; c=relaxed/simple;
	bh=EUDRNIf91DhCpv7VcoEeYf3W/mYyiI1JzzqOUbN9pO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d6/36C5y84plm1ZewRQy0TLuID3B7/x1lAbpgIjbK6AlbojBimXtqovmcCCbJAPhNtIgUzvLZSedGTrCTxIHNj1iFeJkjMueGKz3Sol4YEXYZD8tbDw5ZW6TZBOTYOrz7TEM7UO0dYyrqkbbwiHMpfBwcbfp2ZOYxy/zDRS9qFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6dqKZik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7724C4CED1;
	Thu,  5 Dec 2024 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416612;
	bh=EUDRNIf91DhCpv7VcoEeYf3W/mYyiI1JzzqOUbN9pO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h6dqKZikrt4op81i1+61l9XQXVpzuJPRawHLRrzCWkJ7gFEVCYEshUV0L/Y9SdcAW
	 R9b1aavozOx57jBDQ95JUFMd9Q399Rfz/nktY2ihiuJu5L859KoVVJLLcf9HcCM1ma
	 xsfbm4rbK9E4plkWE74RXYs8zzIdSOuVbC1BgTP+k5fxHKpE6U5OTOj8S3AKSNhqUy
	 NbzMHrBdIGy4OXhbhAh/ieGXetRmr3iIY4J72m0H9fMeXC+sa8qleevKAWHx42gbEu
	 HJwcNk0XGtYpnTMpv8FLS/p8MmFUINiZFs9xl5gZiGEAVzQgQ/ziLR6cmk5A5BCNHe
	 t4tAYe1QrSi2g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com>
References: <20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic
 codec
Message-Id: <173341660960.157362.16366009839095486342.b4-ty@kernel.org>
Date: Thu, 05 Dec 2024 16:36:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 03 Dec 2024 16:20:58 -0300, Nícolas F. R. A. Prado wrote:
> Remove hardcoded dmic codec from the UL_SRC dai link to avoid requiring
> a dmic codec to be present for the driver to probe, as not every
> MT8188-based platform might need a dmic codec. The codec can be assigned
> to the dai link through the dai-link property in Devicetree on the
> platforms where it is needed.
> 
> No Devicetree currently relies on it so it is safe to remove without
> worrying about backward compatibility.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec
      commit: ec16a3cdf37e507013062f9c4a2067eacdd12b62

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


