Return-Path: <linux-kernel+bounces-307339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3D964C18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A02B23AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C91B5EAF;
	Thu, 29 Aug 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIh9HtIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747241B5EA6;
	Thu, 29 Aug 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950369; cv=none; b=WO//I6zUAsrMP79oJtUmswUawnvmPIM6H5yxJwFS3OlsJocbJcPA/vnVaLZKQLYIbrfodDjlJGM4mn4ongUCRD4Oi5k/BR77sCk9rDg0MJ6j246CXNUPRkQWQVsJf/ELv+BHUiQFnGH6tBxD5yoTolqpS6qUz6jAr5/efXQLqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950369; c=relaxed/simple;
	bh=hnufhCbXjNCAMLwQDuHCdh0s0iVsisj6beB30jVpEi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OvPhqGT1vLv7JkwHG3i4KiMlstwW5V7ufpB0BJ+K2Ib5+QhA5BcwgFad+DRbK3fTWTu/oObU5RWj3oe8DHKAFpR2rTT69SKcyuiFVGnk5BE7236ETz2Z50ZesyjlcVPArWNYVd9TCNfrJK9LpFX4sw3+fJaM9FPtalyYAC1ud0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIh9HtIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB4C4CEC1;
	Thu, 29 Aug 2024 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950369;
	bh=hnufhCbXjNCAMLwQDuHCdh0s0iVsisj6beB30jVpEi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KIh9HtIn3Xk+UPaYoDfruElplumKEor5QZulYQepcz5AEw4bKg8rbC9Y3djnXLsH/
	 WszTsGl93p2DWQLlM3/Jze6uqsP2vZ6D6NPcSfSMP4/4yh5UPsGjrjgtWnHlaRVjSr
	 6CU4Qug5zBAxyxqQPliiu0u+k56SxOVOt8BoHPvufSlarplUUuZ3x7eGkaimyeOBw2
	 QM5DugDCC8nA6HOFlOg8d0rpa29Sz4Y4h9H5FjRgUeED4BmyJvgqGDNmojAhEdx5ho
	 qximeILAZnDl6VWUQhDAYxcqL5s12k2SWEjovr0prd6AVEuIZNsKuU/M6eginunv/E
	 80umz9rKbU+Sg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Cl=C3=A9ment_P=C3=A9ron?= <peron.clem@gmail.com>, 
 Marcus Cooper <codekipper@gmail.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240801-asoc-fix-sun4i-i2s-v2-1-a8e4e9daa363@gmail.com>
References: <20240801-asoc-fix-sun4i-i2s-v2-1-a8e4e9daa363@gmail.com>
Subject: Re: [PATCH v2] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-Id: <172495036615.681615.13022036067408318288.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 17:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 01 Aug 2024 14:07:19 +0200, Matteo Martelli wrote:
> This fixes the LRCLK polarity for sun8i-h3 and sun50i-h6 in i2s mode
> which was wrongly inverted.
> 
> The LRCLK was being set in reversed logic compared to the DAI format:
> inverted LRCLK for SND_SOC_DAIFMT_IB_NF and SND_SOC_DAIFMT_NB_NF; normal
> LRCLK for SND_SOC_DAIFMT_IB_IF and SND_SOC_DAIFMT_NB_IF. Such reversed
> logic applies properly for DSP_A, DSP_B, LEFT_J and RIGHT_J modes but
> not for I2S mode, for which the LRCLK signal results reversed to what
> expected on the bus. The issue is due to a misinterpretation of the
> LRCLK polarity bit of the H3 and H6 i2s controllers. Such bit in this
> case does not mean "0 => normal" or "1 => inverted" according to the
> expected bus operation, but it means "0 => frame starts on low edge" and
> "1 => frame starts on high edge" (from the User Manuals).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode
      commit: 3e83957e8dd7433a69116780d9bad217b00913ea

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


