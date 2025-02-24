Return-Path: <linux-kernel+bounces-529836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B24A42B90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D8C1797C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657026618D;
	Mon, 24 Feb 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrQTMUhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE41C5F27;
	Mon, 24 Feb 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422145; cv=none; b=JohucLUN7aJKSrqXjyi/Y5Al1TAWIpDO3bZkNdk2AkojCQyg69WMXiFlpm3h6JfNSkj7+eqAYciTEy7NfApKyYej1F+WIG+AbIWwkCd4+JztDoMdwvA5Q/TyVMe4ziqDYLAC4d1FePLAoMSzVIEGrVI4RdA2/oM9PRJdQPm1LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422145; c=relaxed/simple;
	bh=Ht47a0c85YIjceFFL4ZLJ9SXKsfewmGSeF3ignBjavM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JHp+W0Jvu4J8c90VKXjXE8ioX67bwmvsnhxCBlx/ZJ3zBjnCkmtckzYKKxaK/XMeeaB3vb9pTIwouYkQ7qCP09OT5bjh2lqP2smQfUFMibqVH/pUxlMWVA+yJFxj/hiqynlouRrhd505F5REfX0Mw1P789VNs3odaJ+aMQBpbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrQTMUhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26185C4CEDD;
	Mon, 24 Feb 2025 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740422144;
	bh=Ht47a0c85YIjceFFL4ZLJ9SXKsfewmGSeF3ignBjavM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VrQTMUhJiImF6tR3+Fh6YJOslFBDX1kJA+azbv8WdMkiSncZ9pD1z87olRBBqTfYF
	 JapYQ7h7txQYFsYbbJ9Wk/SmiXaLn9aZZQ0AuBxpoKsOQZXI5+3D4p71Tv4aDHCToJ
	 JPcc0Rr8P1gUNgQKKl+JFhiCKiIU3PFXDNxOb+OWah4zVSrAsW2X1ZcXbO8cZnXNrx
	 fQlLZtQyZuzA0X75Rh9QbVqL7vLDyqRD7inGZScybpado4phyuPC3KWSU9yN47E+NT
	 9IWP1VdZ/ETbQfPlsCPfPSiEhNXrtkHhCvfP46iP3m0uL2Ohs6jvZJXfb1JDt8Ou66
	 l+/uV2ZCbxb1Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Sean Cross <xobs@kosagi.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, Mark Brown <broonie@linaro.org>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250222-es8328-route-bludgeoning-v1-1-99bfb7fb22d9@collabora.com>
References: <20250222-es8328-route-bludgeoning-v1-1-99bfb7fb22d9@collabora.com>
Subject: Re: [PATCH] ASoC: es8328: fix route from DAC to output
Message-Id: <174042214288.92672.849071469187216884.b4-ty@kernel.org>
Date: Mon, 24 Feb 2025 18:35:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 22 Feb 2025 20:39:57 +0100, Nicolas Frattaroli wrote:
> The ES8328 codec driver, which is also used for the ES8388 chip that
> appears to have an identical register map, claims that the output can
> either take the route from DAC->Mixer->Output or through DAC->Output
> directly. To the best of what I could find, this is not true, and
> creates problems.
> 
> Without DACCONTROL17 bit index 7 set for the left channel, as well as
> DACCONTROL20 bit index 7 set for the right channel, I cannot get any
> analog audio out on Left Out 2 and Right Out 2 respectively, despite the
> DAPM routes claiming that this should be possible. Furthermore, the same
> is the case for Left Out 1 and Right Out 1, showing that those two don't
> have a direct route from DAC to output bypassing the mixer either.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es8328: fix route from DAC to output
      commit: 5b0c02f9b8acf2a791e531bbc09acae2d51f4f9b

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


