Return-Path: <linux-kernel+bounces-539486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D228DA4A4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA1189AD13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121111D6DDA;
	Fri, 28 Feb 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE00zGYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9A1C54B2;
	Fri, 28 Feb 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777756; cv=none; b=HDxVCuSGbAiD3+eExQK6a6CoAC8Zn1NDRwOpxYjz6wIbX0fAd4EAUvoZy2KADkS6dQMSiWuUOaudBKiQLwthxGaXfsezsnHJyrHqbsJEOIkdtoATK7QSsml4zop+TKoImR0JQIIVhFGie1HeQhvP9z4GEc5k6ncw+9ggksBYHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777756; c=relaxed/simple;
	bh=QJ0zj7q3m9VCBWyN4qRgjdsWckJViQOTLhy+VWuHH+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CNo6+Q0t9LwqhlWwxxJbLLC+4ai40nEZpQXypWjYVtbrGn6uDm0edgQag+71CNVTmUn5jt3RuUd5ETvedIFh5ycOIJzsBdcxhlbnPVaf40S4rqiVMVYMtn1Fpr72cxecYob6SiZTxcrAagq/Y7NHagFjnp9FCdOMg8q9SSoiZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE00zGYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A1C4CED6;
	Fri, 28 Feb 2025 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777755;
	bh=QJ0zj7q3m9VCBWyN4qRgjdsWckJViQOTLhy+VWuHH+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qE00zGYo7RbZFlefLj31un3are+kZDjTdfJAedqV22tQksPSKeTcZBwP6PLSUnH0Q
	 0pHdbfzxt/3MCgDdbMG6ZJXDJhw491xO6VFnzMvX4X+vbiShfWW5bc2bAj+sDpPxlu
	 XLU13odEliHXol4VamgB9TtlgdfWo1sFJBGuXCZCJnJWpzyz7OuYv+e4RQApJIKn0C
	 5MqWjyuj5JIVFzv/IRqg9VKoSRqKcsQlwPDm+M2//X0aSatn9FsJMY8ySUx4NuXgGz
	 1q6H4ljhhbHKFxJnVOu1oIvf3RVJON5gfw/JBKAe2zQGVIpxOVTuvABPcZA/otoLI5
	 yANTXce4Z7e5A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, 
 andriy.shevchenko@linux.intel.com, cezary.rojewski@intel.com, 
 amadeuszx.slawinski@linux.intel.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, jbrunet@baylibre.com, neil.armstrong@linaro.org, 
 khilman@baylibre.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org, 
 Raag Jadav <raag.jadav@intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228062812.150004-1-raag.jadav@intel.com>
References: <20250228062812.150004-1-raag.jadav@intel.com>
Subject: Re: [PATCH v2 0/6] Convert sound drivers to use
 devm_kmemdup_array()
Message-Id: <174077775241.602624.10081824574862077124.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 21:22:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 28 Feb 2025 11:58:06 +0530, Raag Jadav wrote:
> This series converts sound drivers to use the newly introduced[1]
> devm_kmemdup_array() helper. This depends on changes available on
> immutable tag[2].
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: Intel: avs: use devm_kmemdup_array()
      commit: 0bd862846e7f89910252cbef8718a757950f1683
[2/6] ASoC: hdac_hdmi: use devm_kmemdup_array()
      commit: 3e706be02befae55b50b240d4360b5993f9879a8
[3/6] ASoC: tlv320dac33: use devm_kmemdup_array()
      commit: 69aaab0e65e9bd7601740c1e14cc6de86dafb621
[4/6] ASoC: uda1380: use devm_kmemdup_array()
      commit: d9d71a6e2d19a2f3ccebea0092b8ddc1e935886f
[5/6] ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
      commit: b26205e172ca035e327e49edb0c2611e5d2ede8d
[6/6] ASoC: uniphier: use devm_kmemdup_array()
      commit: c173b5ee81a25e8aafb21ccdb7ab457da7783bf1

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


