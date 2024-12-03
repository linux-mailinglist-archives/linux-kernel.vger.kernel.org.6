Return-Path: <linux-kernel+bounces-429974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71F9E2CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B18CB32A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9E1FBEAE;
	Tue,  3 Dec 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQj1QnVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F01F891C;
	Tue,  3 Dec 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248258; cv=none; b=PsF7pjqAhNSbkJlcqEEWwKTasbrHje5aTWBruD1zL6F0omV2rowsWQNG2+rgO+8Oi3yS29ptDy9soZ/HaEq5Y/gNWJM/wV9y9urZP/JXxFTcp+Oj/eaYwZMtSz5hXxAof7uu9qDfUL9IFMZ5CrS6tT7seRZyGvJBSLlC/2Amvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248258; c=relaxed/simple;
	bh=OSrO/elSn5qIF+zISWp/GORkYyBZhWFrJkT400xtaug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HQgYJyZqfFyR6MkcrfAKh4yio6gtuwMaLiod0E7KfYCg83+ceLQ7e8Xiu8MoWVA9iLhFemv8v6XkQgtL76O5/t+AihDNDcolo+Og4ssT2p8QZzESbfrvoP9+UBAPKORZb4PWEXvK8XD01d139sPBmPt6sn6XccFi0ew3U9BzO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQj1QnVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826AC4CECF;
	Tue,  3 Dec 2024 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733248257;
	bh=OSrO/elSn5qIF+zISWp/GORkYyBZhWFrJkT400xtaug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qQj1QnVapS8uBGnl89xNEjYNhkPYsYeAz7sgRrEIqcUwbU2NWG8gcPe6OVlzWb8V9
	 cY3jARPjtO/dFw9hnJpa8XHGtPQaJAzBTj7ecfwaCE2f+Pw/EH8jd6o9K8z/p2Xq1h
	 XEPWwWPfodOOZLq4i2wGlJSsAw030tB+0yC398aO76SskILKk2oRv/ZPfl6rHPE4KT
	 dMfRmqrUEU61RL2jbb8yp8n4FNq09qpoDb+7ujD/I7S6QeurnIBfNBXlsXHR1LSeeW
	 uDJTmlzsZW68yujhGWIS30PWg/DBaUEdqjr/az7SmHheZiV1pn4Kk2Vn2oYkRNOSmd
	 iMrOoHevVofLA==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20241102125712.2647325-1-csokas.bence@prolan.hu>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v5 0/3] Add support for codec of F1C100s
Message-Id: <173324825387.459040.17438717506518048504.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 17:50:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 02 Nov 2024 13:57:09 +0100, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit c2ee9f594da8 ("KVM: selftests: Fix build on on non-x86 architectures")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sun4i-codec: Add DMA Max Burst field
      commit: cabd4ac290a6ceb87c8dbfb5a3251750e24529e7
[2/3] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
      (no commit info)
[3/3] ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
      commit: 2198deb823a6ebe110b737614421a4687d3327f4

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


