Return-Path: <linux-kernel+bounces-169024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC58BC193
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1B91C20976
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C9364A4;
	Sun,  5 May 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzXH59Z/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAF1D555;
	Sun,  5 May 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921389; cv=none; b=fcq8DpeFYBB6V+f2+DQ/JzHWEWT6N4wYeWDfxyV6OyJTVfdtjPjm3JNfV+F3GLh5FxuzZEskIKiaFgy3YBpjcAon9yGPkp2AHV+RTM9HkrH+7HK8shVXsuXwWojllqvB0tC2WrJD20XqCQ+2CDe2Nz+MCpRlxB/5U3sqes0X76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921389; c=relaxed/simple;
	bh=cDCbqGq4PYQvTiMigUTFtTPKjHRT31+tOJuaLyRVt6Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kEW04DxGMKeakGU0wkqIo5dlPejIMJOhnc647U+u7qJSeRiKwpqFrrTO/y3otsqT4aoMUKnvxNk8tvtCRhUxx5dgunkxhbRD1UDubCkRtjM/vMvr/gJy4UsEQdr0hjJroM2nMh4PVhiznF2mDA/XzBKVBeVxvNZbwU2ikA0GxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzXH59Z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CD4C113CC;
	Sun,  5 May 2024 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921388;
	bh=cDCbqGq4PYQvTiMigUTFtTPKjHRT31+tOJuaLyRVt6Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CzXH59Z/++xMm24MJj7aUh0VZgQii1lcxPVDI6FCQEN3nRBcJzgNncL2NVZ7lEqy4
	 MQndcsRsvaG4qfiSVV4D6dewqU5WDQgkUohfu76uCckYmPbMoJCsMa9SeCx91d5yQC
	 a9135QZvjsVKojDbHbF0ZKaFghZWCZOgZAarVKrNcZCeXZFDHnREg/ldS05qNpy5wv
	 rM9FevbtNnGpJideGTWk67dhg3lgXildxXOaqsxc+5DNJd1VTkT14ENjUAXB0d9cGs
	 QyKx+RIyaqQ7sAQwbU3NCVf9b+sDOzI+4dXVl/8ZndExhmBVtWjUU6xO8c/EMtDSmg
	 fKGP5Do86Ubjg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240501175127.34301-1-krzysztof.kozlowski@linaro.org>
References: <20240501175127.34301-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ASoC: Use inline function for type safety in
 snd_soc_substream_to_rtd()
Message-Id: <171492138663.1933443.10503961369232756319.b4-ty@kernel.org>
Date: Mon, 06 May 2024 00:03:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 01 May 2024 19:51:27 +0200, Krzysztof Kozlowski wrote:
> A common pattern in sound drivers is getting 'struct snd_soc_pcm_runtime'
> from 'struct snd_pcm_substream' opaque pointer private_data field with
> snd_soc_substream_to_rtd().  However 'private_data' appears in several
> other structures as well, including 'struct snd_compr_stream'.  The
> field might not hold the same type for every structure, although seems
> the case at least for 'struct snd_compr_stream', so code can easily make
> a mistake by using macro for wrong structure passed as argument.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Use inline function for type safety in snd_soc_substream_to_rtd()
      commit: 9723cab054d59d770cd1927f92fe315c26cc6a78

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


