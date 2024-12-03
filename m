Return-Path: <linux-kernel+bounces-429976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1DE9E2A02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093ED2856CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCA41FE46D;
	Tue,  3 Dec 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr+Jo7AI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2C1FAC51;
	Tue,  3 Dec 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248263; cv=none; b=XyV/MiJSYfyn7dD5xn7f+c1rIfbCUZwaPYxDlTmEPg3PkFtv/oOiFKfuUO/rUsp4aenbuA0su04Sc/O6WlK51ByGUaidsq0UqBNfz1rbcFE4nXp7oR3T46wSM9uAiqt2m9cVZ4MseMOgqigWKw2aFtqpWgoODBeMvebGXH/2xL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248263; c=relaxed/simple;
	bh=5p8vEzZ8oE54TBgFSDxwhE30LNOudRqhkcJKN4lnoSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ujftdBTe7mivyfGUSNSStCj1a24AEOs67LWJ4BELbFfAUmRaqpln513fVfB8a8DG0lnUwztNE51bKYS16pVrhCsbbIgVcBiTrWRQ8vQJZaZUGriQL9oHzIIMrVBttkBPvK+TusWOLIJ0D/9lwYePvtvTonEALl0hoo0UxdfXaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr+Jo7AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293EFC4CED9;
	Tue,  3 Dec 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733248263;
	bh=5p8vEzZ8oE54TBgFSDxwhE30LNOudRqhkcJKN4lnoSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dr+Jo7AI5gaM3Qai4tsjbWIuJim3Y1vImcD6YE3kfY/L+sIcqLyI3VMCzqrNJDidZ
	 1NczPyr3O3v68KpCIp+ejbd6YFc97KVhss17XGTyKmFPrsv8kz4zyZDl3Iw79wBhV+
	 ikevbvI/gRzaI6QztP9waYtbyV/Cm3f57LNi5NP6sEe5/p+7jRA13NUdmNjXOJqM20
	 wHbrqBKzyETWlQ74ClcPzPjf/woB78myrNA+Sr/63HGC3MddIpqD5OLpJj7InGLstC
	 HyQt/fhaAszt3ffIAXGOaCt+tuGhD10aQ7ypVLDkLY0tADZa6YNo7FS32YVO3PL7pI
	 k/DZgrUBKczyA==
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
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Subject: Re: (subset) [PATCH v6 0/3] Add support for codec of F1C100s
Message-Id: <173324825989.459040.3874572873005288609.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 17:50:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 23 Nov 2024 13:38:55 +0100, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: sun4i-codec: Add DMA Max Burst field
      commit: cabd4ac290a6ceb87c8dbfb5a3251750e24529e7
[2/5] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
      commit: bb2cc3014d74dfdab0b358b4539a9d2747598663
[3/5] ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
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


