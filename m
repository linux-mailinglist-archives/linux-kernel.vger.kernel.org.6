Return-Path: <linux-kernel+bounces-545049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8FA4E86D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AB5423662
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8D2C2CDF;
	Tue,  4 Mar 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU1Yn5dh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851527BF97;
	Tue,  4 Mar 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107243; cv=none; b=gduzAJUPCAU5j5lVwgygw3cf6MkxlIeg9PGk4DZCuytkurIkFJTMfb9fuTP0FW9+YeIazR4cY8r/UBFOQWBe7V97mq6P/L98J4wzvf/ut+Z/ZJ0PWdqys8YbL4nvrFQETSjq64cBOj9SvZe5EPxF4/I5Tbp19X2MDFQuIBUVTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107243; c=relaxed/simple;
	bh=MhVjs7nU5PbSOBE55FuTmaQWMObwlqFgCQjEGH0Y+lM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TZ8Eww0i4/9zrdMxIstdJcRJ3zIcrG4FmLkzPbnuJIyxKlUF0gyd6rIXTw2NKda7Abj8cQrCYfpS7b2dTGxYt6Ja4xGmTTGqFK/hEN8pvJeo4Vx21G0/0OHD8BQdRzdCt3cnAWQ7DQHHzoAgJfRH5f48ElYdjMLSXDYpgdzpqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU1Yn5dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D41C4CEE5;
	Tue,  4 Mar 2025 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107242;
	bh=MhVjs7nU5PbSOBE55FuTmaQWMObwlqFgCQjEGH0Y+lM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PU1Yn5dhIXlG58Os/2U72lM1vAEFOndd3VLvIfU8DJuMfGlcSLpZ31c7q/Fl11fMc
	 aSVHcPPM7FqhbTb/VhZLW3WtE2CGNY2NNVL38SliWDqJ5nxhfbPGmMZxsDg+o14sgv
	 tjj2lgyXJCEUFuRdwKx4sXRQBVsBpwK+63h8j1LHUfNToQQn3ynNGOg016LgUw6FxQ
	 KR92/mhc3aU1q3RSfSzBC7D1CyxxoR0N9bhppcZUrj1xyf8uq3gd/T5OlLc/qKmxR5
	 n2BQLhRRdYux2oBoCdV3CceBQlOznKexVjvkPJIgii4B/M/kv1MoHXgB9Zh57Ij27A
	 B96pSuHHRKIBg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com, 
 nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com, 
 kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, srinivas.kandagatla@linaro.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
References: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 00/13] Tidy up ASoC VALUE control macros
Message-Id: <174110723996.110430.11757515919189327351.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 16:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 03 Mar 2025 17:14:11 +0000, Charles Keepax wrote:
> Tidy up the ASoC control value macros. Fix some drivers that should be
> using core macros that aren't, combine the existing core macros to be
> a little more consistent in style, and update the core macros to use
> each other where possible.
> 
> Changes since v1:
>  - Add the missing first patch that I managed to forget in v1. This was
>    stopping the series applying, as it was only in my tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/13] ASoC: Remove unused helper macro
        commit: c01a74844b74c584160d5253f794bbd2af015bec
[02/13] ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
        commit: b2b6913394488e031ee3d726f247b1c967057b40
[03/13] ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
        commit: 17ec58ac3c08c5c43bbdf5b08020fa4188a3009a
[04/13] ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: aecdaa84adafb086b5b2939898d781bd63d6fe2e
[05/13] ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: 9bb7d7452363fc470b76766b0a6356807e752795
[06/13] ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
        commit: bf19467b8512f855bdfae59ae78d326b1f434443
[07/13] ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
        commit: 516493232a9b80dd4f4f6b078541cfad00973dbb
[08/13] ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: 98413be56faa1c12494f43e7f77746763fa41c4a
[09/13] ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
        commit: 7c5b07b497eab8eba75cf5da00cba493216dfc12
[10/13] ASoC: dapm: Add missing SOC_DAPM_DOUBLE_R_TLV() helper
        commit: 9e6e7e088cb78ce58ea442106b1f29cd7b6ff76e
[11/13] ASoC: dapm: Use ASoC control macros where possible
        commit: c951b20766f019a263b3547b07627be52fff87b4
[12/13] ASoC: Tidy up SOC_DOUBLE_R_* helpers
        commit: 1743dbb45b2cbe5500068900794a355a7e0dd853
[13/13] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers
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


