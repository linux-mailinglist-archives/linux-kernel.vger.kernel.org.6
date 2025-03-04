Return-Path: <linux-kernel+bounces-545048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8CA4E85D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003B87ACA80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5FF264FAD;
	Tue,  4 Mar 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgdYGRRo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CEB26036A;
	Tue,  4 Mar 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107240; cv=none; b=Y66WFmod9ZqLVL+dJgJvtXNUnC2XJs2DSnlgpwF4E0uvhH7wWjI78ZQZujx4fKb8esQ5LxB37+Rj2loewb8eejD4f9en3kqOomsE8ukZmbCeTP5dYBP0iIVzSSsbw+RrEAx9nKBuJm/wIIpT+6G7kHHeq83UjcEEKIjVSn04eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107240; c=relaxed/simple;
	bh=1V2BR+/+pRAV+0bGkTwpyUK2px8hbIAwmyk7usKUAQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ior9EzloVaYMhJdeb6Y8mjhoHjzTfyesVcMZatpTsS9D5GxS8fricJlEdJ1MLLqwc0mnz/7a3WAW2vgpH838IOa/5qnyg/eenkij1aPo/oxAJCD8LrNP7u7t3acpTOjeBOEK/Ylok1TI1LhhWHs8uLp8dzgp8Xi3/oq1VCqYOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgdYGRRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DCCC4CEE7;
	Tue,  4 Mar 2025 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107239;
	bh=1V2BR+/+pRAV+0bGkTwpyUK2px8hbIAwmyk7usKUAQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RgdYGRRop+UpdvY7iAq+bc7F+/8L0OhcDiCK/5oXhx1nbXHc6nd1rQrlgKOkNmtyb
	 sbQ3RdgcKiyoTSI4bNmDn6HLCF9oi4cJ/Ok+lwHozsIt5qma2naSilvqhAlqh40/48
	 GzzPTp7HOL+eL2cKDXlHaUiYMva9DUAUMJ3h3cPY+JLZacNqKTtb5jZ+AFqCMFkzbc
	 0pZL6NMFw4BDsUy3vc7IlncQ1G5cyK4i7LXHPCH53PQACIe95BN9Bzdi35+DQP+pSw
	 HPomc5a08im0TX4XBmJrrogKAGzATcpzxHa/TlbbS6jZbAtA7CyS7efocHBsBzazqC
	 egtnsbezGq4vg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com, 
 nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com, 
 kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, srinivas.kandagatla@linaro.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
References: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 00/12] Tidy up ASoC VALUE control macros
Message-Id: <174110723687.110430.12251793505899077322.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 16:53:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Feb 2025 15:31:25 +0000, Charles Keepax wrote:
> Tidy up the ASoC control value macros. Fix some drivers that should be
> using core macros that aren't, combine the existing core macros to be
> a little more consistent in style, and update the core macros to use
> each other where possible.
> 
> Thanks,
> Charles
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
        commit: b2b6913394488e031ee3d726f247b1c967057b40
[02/12] ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
        commit: 17ec58ac3c08c5c43bbdf5b08020fa4188a3009a
[03/12] ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: aecdaa84adafb086b5b2939898d781bd63d6fe2e
[04/12] ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: 9bb7d7452363fc470b76766b0a6356807e752795
[05/12] ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
        commit: bf19467b8512f855bdfae59ae78d326b1f434443
[06/12] ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
        commit: 516493232a9b80dd4f4f6b078541cfad00973dbb
[07/12] ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
        commit: 98413be56faa1c12494f43e7f77746763fa41c4a
[08/12] ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
        commit: 7c5b07b497eab8eba75cf5da00cba493216dfc12
[09/12] ASoC: dapm: Add missing SOC_DAPM_DOUBLE_R_TLV() helper
        commit: 9e6e7e088cb78ce58ea442106b1f29cd7b6ff76e
[10/12] ASoC: dapm: Use ASoC control macros where possible
        commit: c951b20766f019a263b3547b07627be52fff87b4
[11/12] ASoC: Tidy up SOC_DOUBLE_R_* helpers
        commit: 1743dbb45b2cbe5500068900794a355a7e0dd853
[12/12] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers
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


