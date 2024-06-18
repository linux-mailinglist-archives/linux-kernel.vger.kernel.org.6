Return-Path: <linux-kernel+bounces-219615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FC90D58F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8121F2300C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17D16A927;
	Tue, 18 Jun 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJrjCGPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFA1667FA;
	Tue, 18 Jun 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720547; cv=none; b=nLzHzOLNCp3ZMYLH8fjwuBnjbCiSggYE+HCpKevchEEGySTZQCmdmMyFN+KxxrhYmGkZZwp1JPuQqVj6nf87TlChnZWNKEqzocn1amzHTcRUIthzUZv0pzREjbu5QllfpBTwVb9nxXmQ8vU3bNRhZijZ2TFyQv9+q7oCfB2DXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720547; c=relaxed/simple;
	bh=z0aiqnYxRofh69taB3z0ijaSldf6h5lhocM5coo9Xdc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zu8fT8sUSuu7GE68xKlvMODVLprXdlQI/6HFy1dkhrVpeWupAe8MUxqQ4VFcz9pBF/2otHItwo7oht/HjDsrOSH93gUeZpNhXDoEuWyio3Y9omZwR72ywf+PPhkO5sE6cbCTK1zsSSm1sovbOceoEnZCt1RzbTETVNsxY4NaKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJrjCGPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C1C4AF1C;
	Tue, 18 Jun 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720547;
	bh=z0aiqnYxRofh69taB3z0ijaSldf6h5lhocM5coo9Xdc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hJrjCGPaaGr9k+pN1RjTpxGrrTV6mUiO6Im0ZzxwrIjjBFA8ZYrOosj/6UYiRjF0L
	 agmThfPkP8To6o4lywlwNX0u7z82no77gYQIUwzz7ME+G6h1KBtzPb+WyX8MGRytFO
	 NQZVGM4rR/cuvSo3+XGRdCS7bPisyWlIB4YXDvXPPsT3S0rXuRHNf8s6KoAn3uMFqw
	 J14/dt8zuBOtI9q6usgUUHvEU83EUpEWubi3A9z03/DFNZOPh+w5ZfJ0P4Tuo4TW9I
	 8BSjRkoITdC7uX2YnobxJmwsan8ExmaFIVAJEqwqdELv6tgnRN0h5cynzOPmEeEFLS
	 O6RDinvi5fzpg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
References: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-dai.h: Constify DAI ops
 auto_selectable_formats
Message-Id: <171872054460.81836.3714158879000443319.b4-ty@kernel.org>
Date: Tue, 18 Jun 2024 15:22:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 14:57:34 +0200, Krzysztof Kozlowski wrote:
> The core ASoC code does not modify contents of the
> 'auto_selectable_formats' array passed in 'struct snd_soc_dai_ops', so
> make it const for code safety.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-dai.h: Constify DAI ops auto_selectable_formats
      commit: d4a7d067e061c95c6387cf537258082074a4d299
[2/2] ASoC: Constify DAI ops auto_selectable_formats
      commit: 595265c92668cbdbd9f299c49907734d468c12e9

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


