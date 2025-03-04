Return-Path: <linux-kernel+bounces-545438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C3A4ED27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A0716C504
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24691259CAC;
	Tue,  4 Mar 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IViO4f30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69997255244;
	Tue,  4 Mar 2025 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116064; cv=none; b=VkwGKjQZuDcLrQnYrm/EvwzNGiuOwlcnWTjyrdUgdTdGgJiEiGSkZVTaoVRn7UpCdanrLwkcWY7Msntv2Rhgu0e9dJ1KkpgGsa8JYQ2yYQBwc8wnqbifUcDZBCC1lPDFtTS2f1IdbzOV9WTORGBevw1QKW+NbVjLiXmDWJ39quM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116064; c=relaxed/simple;
	bh=6MnWChvdZA4s+8fxB0dv8vXGdMG4i5FgUOx+TUcX3rE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JNJxk8UOEbb69k9KfVUI6SVQTyWoBAEtxEpnBbyXPYGXINwBFFZ6aOohxB18chlpSBznggV1LaHs06gSqu4kIUr1fstcBtnIbP9HqOdoK0jQPYID4SYT+rZ52Okx+UBOTyv/pnoy6j4s8uowsm3xKqPvT0G5QUvia9uX2Ecn96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IViO4f30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13915C4CEE5;
	Tue,  4 Mar 2025 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741116063;
	bh=6MnWChvdZA4s+8fxB0dv8vXGdMG4i5FgUOx+TUcX3rE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IViO4f30mVkst2x3qHPFh8izeOtVaw7uz++VewyC1C4wRjjXNjkPpsvdbCKPh5a7p
	 LqeXcwXMOBn+5V4SsCSDB4zkQJ/L06PEH92xc657CrC1OKTP0fjMViud/W7PWug3Xt
	 yPOn3BPv2+hsD5y6O5mAh1cC1VOX6ZQIyvHn4ZXfS6Y8NQDAnYA5VViId/1CcZpwmk
	 KMW67znwGXnZVSH7YKBEcvgHahVyteVyEVvjBoYk73cF2M5BlW/FWFAhYsheUY2uyD
	 pM4hhX+5F+r32BkLurL55YngI2/BkcGNpQ0ySuBcL2f2C3OvYIZP5suiuVfTftmCRz
	 6WUb34kNPuMlQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_audmix: support audio graph card for
 audmix
Message-Id: <174111606081.246439.10804205280595861731.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 19:21:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Feb 2025 18:05:04 +0800, Shengjiu Wang wrote:
> Change 'dais' property to be optional, that fsl_audmix device can be
> linked with SAI device by audio graph card.
> 
> Shengjiu Wang (4):
>   ASoC: dt-bindings: fsl,sai: Document audio graph port
>   ASoC: dt-bindings: fsl,audmix: Document audio graph port
>   ASoC: dt-bindings: fsl,audmix: make 'dais' property to be optional
>   ASoC: fsl_audmix: register card device depends on 'dais' property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: fsl,sai: Document audio graph port
      commit: abcb9a1fd89144536f3ef604f700e94424867366
[2/4] ASoC: dt-bindings: fsl,audmix: Document audio graph port
      commit: 5fee78e517ce0765def9387659fc56a1d5532c60
[3/4] ASoC: dt-bindings: fsl,audmix: make 'dais' property to be optional
      commit: 597acf1a04bede55e3ad8a7922bba286c11112d3
[4/4] ASoC: fsl_audmix: register card device depends on 'dais' property
      commit: 294a60e5e9830045c161181286d44ce669f88833

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


