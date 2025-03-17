Return-Path: <linux-kernel+bounces-564922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17457A65D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3D16809D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE81E5208;
	Mon, 17 Mar 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe5pmIow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50B143748;
	Mon, 17 Mar 2025 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237225; cv=none; b=Nyv2p+lsc5FcbW/MTHi1mLWa78QNKGP4byWWRCKlPP5KQlUT6ii0MsiRUld7QvyZeZcFyUDjR6gSVTM+Pg0pr8xcfPpXr4Cvn5ZGjHoSeyqaWDsWuzbzpSiKDIR58ZfL6UZHANw/Mqg3TAa05efgA5loaecC7dD7dbd5D4Xh3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237225; c=relaxed/simple;
	bh=yMXt4xcTxN/VyZY3CTEhTkaSSfPWNnhgA4XwK0Qdz0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tqUfttPJkC/0L9TVgXfWvi4BOhEtzO0jte3GH1Hns+XcgvWf/aFHBGCCTepVmEGBnPC/TadAqDWXlpNynfMI+szDztTtvjF5xi5gPhqqUs4ECw/XTC6L9jcXdvbwhJVnfWv9CuCVk0k+F/VmfSkCEgb4vVd2BZwszKi4XIMUXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe5pmIow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0CC4CEEE;
	Mon, 17 Mar 2025 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237225;
	bh=yMXt4xcTxN/VyZY3CTEhTkaSSfPWNnhgA4XwK0Qdz0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pe5pmIowVqnFyhsjicNpxuognAsoaR7yhu2CjQTxJDQhH5rZgSwCkuZKgK0Jn6PzT
	 1bbgkITMyBSDF+HorSBmfYxZ4maeZ82Q7Pxdimav2c5k8i/qdQRZlI7HxNtW/p5ICi
	 r5kEpRmsWP0pCc5BlroEaHkqIvW7Sy8W9HQoHivs/vWrsVNGLlUfeQ1HKnMzmN+FW0
	 HRUefCWsFVNu2rFEtsCviAIgjyXUTY8eW3g3gnWmxAm7mEu/EBy1EmXyom5tmEWrww
	 uiytVOaEYDSHttXMrRS9UU3zL3UUtaAedidPzM3K3j7lOXwmkJPqSvJqSaM59MJNeu
	 +UqQfOdpd3C9g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Zoran Zhan <zoran.zhan@mediatek.com>
In-Reply-To: <20250306-mt8188-accdet-v3-0-7828e835ff4b@collabora.com>
References: <20250306-mt8188-accdet-v3-0-7828e835ff4b@collabora.com>
Subject: Re: [PATCH v3 0/4] Allow retrieving accessory detection reference
 on MT8188
Message-Id: <174223722189.287878.14772373895585128225.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 18:47:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 16:52:14 -0300, Nícolas F. R. A. Prado wrote:
> This series enables the MT8188-MT6359 sound driver to retrieve the
> MT6359 ACCDET sound component from a mediatek,accdet DT property, which
> allows detecting jack insertion/removal.
> 
> Patch 1 describes the new property in the binding. Patch 2 implements
> the sound component retrieval in the common MTK soundcard driver. Patch
> 4 updates the MT8188-MT6359 sound driver to register the audio jack and
> initialize the ACCDET driver for detection, if the property is present.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      commit: 3fec903f2cb18805b1ef22a0e310498020c1f15e
[2/4] ASoC: mediatek: common: Handle mediatek,accdet property
      commit: cf536e2622e2b0a60c99e799995b6e9acf539c17
[3/4] ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect
      commit: 0116a7d84b32537a10d9bea1fd1bfc06577ef527
[4/4] ASoC: mediatek: mt8188-mt6359: Add accdet headset jack detect support
      commit: f35d834d67adbbf121ee4397376d9eac21d99a85

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


