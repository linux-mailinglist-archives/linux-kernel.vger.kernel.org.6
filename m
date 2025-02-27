Return-Path: <linux-kernel+bounces-536743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0017FA483B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4913B8688
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888401D934D;
	Thu, 27 Feb 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy8dsJl5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A91C7003;
	Thu, 27 Feb 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671585; cv=none; b=NYRRExUft2LZABMBsDDvxNXwlQi64XJiNLOvft39ZQ2ssZzkwBQ/TPxNFEbK7FI+JBfO4gF8NaQxciR3gzAa0ra/jMwDa5wRR0q43iARxX7FUCgcnuJskdIMEytmA1TKX1ZVnmZMQVNf3aRzu1B/6VOupS+qaiOTuERZdpAUFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671585; c=relaxed/simple;
	bh=TBF7wUkwR5l5SAlFOkV5L7qayuPJGqlI2MqDmi1e2Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mpqu83FDfl0FknhY+itfSq5Sd+81/s5p7DoBa6r2mYpbRh5vCeAsxFO1Kj1kmi2BUtrvVlcER3kTHiOULoCUTEgNCw/HIgc1DQc2B2IVIIa7rL63EaJi9ebqbAYdibl3ygnj283cuYonjALVAjQx25pFJsP/40LLpWpByzEcIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy8dsJl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908FEC4CEED;
	Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740671585;
	bh=TBF7wUkwR5l5SAlFOkV5L7qayuPJGqlI2MqDmi1e2Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cy8dsJl5R0GGYabMm31a4uFGRKRsFfxDV0JxeTwy/T+jLa4Rls9aVmvo9ZR/WQ+5D
	 L5UAIUySR+ivTBBEiktecSu+8ja+NV9S+XuODphYxQIzh06YTnKgaDwdrHlwhTCpCo
	 kc0sfT4pcosTadJqQpxMk0qSVpQLocvBZZTiTLGnBXENfvcfHs4bMoQAuyETw4q/2I
	 w+0hY4OrS7uikMUTjszPLDLiOf0lz7+kjX9+lptK3DayTJ4A8OchnIT3HMmNQn5bOO
	 owKGVkvrHForNoID6Yn2elgqZ/H3GiRQZnO3F6Ua7CR0B/eThfOVp5QuSxpudr4rrQ
	 dc75GWBzG50NA==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20250227131939.1040168-1-arnd@kernel.org>
References: <20250227131939.1040168-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: avoid uninitialized variable
 use
Message-Id: <174067158231.70060.14955037927245786834.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 15:53:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 27 Feb 2025 14:19:01 +0100, Arnd Bergmann wrote:
> The 'msk' variable has no initialization:
> 
> sound/soc/mediatek/mt8188/mt8188-dai-dmic.c:311:4: error: variable 'msk' is uninitialized when used here [-Werror,-Wuninitialized]
>   311 |                         msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
>       |                         ^~~
> 
> Set it to zero before the loop.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188: avoid uninitialized variable use
      commit: 79ed408b2402e8113aa5a298f3bb9088ede58f6c

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


