Return-Path: <linux-kernel+bounces-564921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65187A65D19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957C9189633D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A51D8DFB;
	Mon, 17 Mar 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrAqfi7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB84143748;
	Mon, 17 Mar 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237222; cv=none; b=jSdpeLRyTcd436Oorfoa4GKb3CslEnO+e28eS3SMEAGkSonpYpbq4sUdPIqQdyipdqzbQ2K274i+3qIhPt0GtUnRPQSgduPcLWZjM1i3F749TuHFME/Ht5KbpJqF22MZgbutsL9nzCKxFhdHi8htNEP4K56yg0f8D1E6VyzELs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237222; c=relaxed/simple;
	bh=HxVzpYI9x47IeMZvH4BdX9GwVI0Qz5knIVuS0Jconhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lTdiuLN0MZH4mbJ5HFmmgpIzl4ejftXqWCnEzfDf/U09n2zSnnAOSdqSzDIlBl3QZHm4ovgx5pqiMOJPIQxdWH2fh1tU2cOFFonH1Z+wVUM9MLh6sBU2fQV3UGjQy+KU+5HA0QdrAVl/4Z9BhSUvC6jhMOSVRLL0fQUVt8COeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrAqfi7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8ACC4CEE3;
	Mon, 17 Mar 2025 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237221;
	bh=HxVzpYI9x47IeMZvH4BdX9GwVI0Qz5knIVuS0Jconhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GrAqfi7cD/H+cHzZ6RtlF3OKQfeRomkwTolDpEuIefSPVxQLcYNW8IYOTwCO8WYvh
	 0J2WN84vnd1hJ1ntjXIaGtoq+4UcqpZOjyC2XCj2ZWGRWUM+CWqjndBuSUYXsZDfpf
	 KNfEqAC47MfDUhXU27pAahMVS+txpg3AZd9o3lONjqaeR2k021kCT6zTE02DixQPB6
	 CFZq6njrOi1JA8X3L+UsLeDPNHrRd/DYFhqlHTE4wuDmB0/6ypqRuSp4J+iB/nj+bg
	 Hz/UHqHFqu/B0+/TpgjNNZYpqZe76mq3dSCEEi33VfaBhWuR12AC/DMMIjPMaBxLq/
	 5gJV6ykYWE3Kg==
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
In-Reply-To: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
Subject: Re: [PATCH 0/3] Allow retrieving accessory detection reference on
 MT8188
Message-Id: <174223721831.287878.9212541577191425735.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 18:46:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 14 Feb 2025 12:14:28 -0300, Nícolas F. R. A. Prado wrote:
> This series enables the MT8188-MT6359 sound driver to retrieve the
> MT6359 ACCDET sound component from a mediatek,accdet DT property, which
> allows detecting jack insertion/removal.
> 
> Patch 1 describes the new property in the binding. Patch 2 implements
> the sound component retrieval in the common MTK soundcard driver. Patch
> 3 updates the MT8188-MT6359 sound driver to register the audio jack and
> initialize the ACCDET driver for detection, if the property is present.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      commit: 3fec903f2cb18805b1ef22a0e310498020c1f15e
[2/3] ASoC: mediatek: common: Handle mediatek,accdet property
      commit: cf536e2622e2b0a60c99e799995b6e9acf539c17
[3/3] ASoC: mediatek: mt8188-mt6359: Add headset jack detect support
      (no commit info)

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


