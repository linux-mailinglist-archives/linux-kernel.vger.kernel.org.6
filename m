Return-Path: <linux-kernel+bounces-532316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF6A44B64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB747A5E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B511EBFE6;
	Tue, 25 Feb 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTrZE4Wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28671B2182;
	Tue, 25 Feb 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511966; cv=none; b=BW5XGfqM6ewyFlbFwcBsK7n5VH2CwKeL5JTvaErnUcz36IuD8CHmu9hIPUpZh8ge3II0BYebGYD35zYyLbPlN5iOXP6TGeMFLkhY6ZGdlq0gDKukFusiMAaAWlCqM0v9Mc5vTekurxR8grTnNEIPCwD/7I3zjiRMWoNNq51V6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511966; c=relaxed/simple;
	bh=EJ0p7kJP7tcBXTVtX2EQW5Eqt9I/PZY1PRXbITilg4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oF4ejbuA3lzc5VjAVk3kkm5nWvIgBOL46UC/Smi97ohi6JjvMKmlRH+VEfYVmoulEo/MNOfzhCihZWgMVjZVRKKJxXK9EBb5UwJMzjoAfjfVHQqRcrH/nXFN9qe0MN47wbL8O+gU8f9CtNORQzWmk6yNLx/2s6aJTL2hlMIglqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTrZE4Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDDC4CEE2;
	Tue, 25 Feb 2025 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740511965;
	bh=EJ0p7kJP7tcBXTVtX2EQW5Eqt9I/PZY1PRXbITilg4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mTrZE4WuJLivocdDlOAyUC2sQPoGHxDaCYT9NHKSq28BUTlAulfb4fehDp0FsRufS
	 wN2GyPsPi6OmFzTc6Ee2sTqgm3ETtXKtEe6iEdhwM7NDGtfgbvQFp4cOJ8WNAcZfBT
	 BFiGFR6ejC//8RQRWhkzVwv1JEOxWPjZq/K8aBcaurTcLTt+xmYzVyl5eL1Yx7gEG/
	 d5hPZA2+vFU/+Mx2BzCzyS6yUNx0qvgMlmexsoD8ynAY+8glKvJmR/lCTKClqV9Lc+
	 CyfjXuELUxxY24pzKEo5rik8bu9FfV+No86fQNUU58QoDTwOBhtCTXtmOZwL8WPsSy
	 V5yFbpl2Z+/Iw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 parkeryang <Parker.Yang@mediatek.com>, Zoran Zhan <zoran.zhan@mediatek.com>
In-Reply-To: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
Subject: Re: (subset) [PATCH v2 0/8] Enable DMIC for Genio 700/510 EVK
Message-Id: <174051196206.229034.7513749709146445847.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 19:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 25 Feb 2025 11:33:46 -0300, Nícolas F. R. A. Prado wrote:
> This series enables the dual digital microphones present on the Genio
> 700 and 510 EVK boards.
> 
> Patches 1 and 2 add some required clocks, patch 3 changes volatility
> handling of some registers to prevent issues, patch 3 adds the DMIC DAI
> driver for MT8188 and updates the AFE with its routes, patch 4 adds the
> DMIC backend and widget to the mt8188-6359 machine sound driver, patch 5
> adds the audio routes for the DMIC to the Devicetree, patch 6 adds
> DMIC_BE in the dt-binding and patch 6 assigns a wakeup-delay-ms to the
> DMIC DAI.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: mediatek: mt8188: Add audsys hires clocks
      commit: ef6a24c79d5047c029577113af43eddd1d0f1bd2
[2/8] ASoC: mediatek: mt8188: Add reference for dmic clocks
      commit: bf1800073f4d55f08191b034c86b95881e99b6fd
[3/8] ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as non-volatile
      commit: 7d87bde21c73731ddaf15e572020f80999c38ee3
[4/8] ASoC: mediatek: mt8188: Add support for DMIC
      commit: c1e42ec04197ac013d049dde40d9c72cf543b5f6
[5/8] ASoC: mediatek: mt8188-mt6359: Add DMIC support
      commit: 390ebb24b3c3a95e109c28e14c2ec9fe3f0f8aaa
[7/8] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DMIC backend to dai-link
      commit: f00b3056843d14754ac1bab2106cf5599680f115

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


