Return-Path: <linux-kernel+bounces-439589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF619EB172
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2496516AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105361A725A;
	Tue, 10 Dec 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAxlVYaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C41A0BC0;
	Tue, 10 Dec 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835623; cv=none; b=ap1WjUDKr1jst5rPZ10rS7PUO8ftehBU336T9/0E75Yiu2NFB4ICx7yY1EgSvrtbfNUqqadU7G7Sd4AcYjDTI+L/o9PmZRfF82MAM30fEhYt7b4+i9pk5h1nlnVoXzRMCpnFwwCkIuy8cfauFnIYyc5Kjliw6fPTZTJb1DjECN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835623; c=relaxed/simple;
	bh=p9Ww/rO7ZyXsPFuMy9KT1BeDWK1Ezu+jV9hVjPJEsD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uUn49vUk+5RvJy/ouXpO5EjQn2E+tSLGfPqhPXc14UF5vys6Z5aDHewTBfzWheg/TnBe4q05IA+h1gi5XduA9Mb+3SUuVMSVygBGzpq/iSSwLwNUCaED6hz3ckUI4VapcqgT3r89mDgJl3WCp+VAB33AGpuZ7MikUSzHlBkFjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAxlVYaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42864C4CED6;
	Tue, 10 Dec 2024 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835622;
	bh=p9Ww/rO7ZyXsPFuMy9KT1BeDWK1Ezu+jV9hVjPJEsD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rAxlVYaY65ty604W3LIhqPvaUjzu9kw/TCslECiIBllIgrlvtxMk5QWw29vCQ+GEN
	 hMlL6F4XOsSQ3joeSPAEb3orXtCK79Er5wKePT/spXpI3ulyYQzLcVAQPxyoNLHdVM
	 YRbIWYqEu+UFfuw1R+vIYI8HPYM0qoeUSQ+ZSc9kC2VadhF1YfMScsJ6Fg83ygA80a
	 lYmiw+8hc6dcOb9uuYzojaojM38+X9r3x0DB/kQPD1TU9fglAEkSLK+/zW5WyAySSZ
	 nt+C51xPCUCazPwUPQf5HyFYYKkRq9/HOWUUBYLqOzFliD5tbUcWTQAZtWCRF9uI8T
	 SR3JUYd3fTVrQ==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Marek Vasut <marex@denx.de>, 
 Andrew Davis <afd@ti.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241203200001.197295-1-afd@ti.com>
References: <20241203200001.197295-1-afd@ti.com>
Subject: Re: [PATCH 01/21] ASoC: ad193x: Remove use of i2c_match_id()
Message-Id: <173383562098.33694.17429584672866095878.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 03 Dec 2024 13:59:41 -0600, Andrew Davis wrote:
> The function i2c_match_id() is used to fetch the matching ID from
> the i2c_device_id table. This is often used to then retrieve the
> matching driver_data. This can be done in one step with the helper
> i2c_get_match_data().
> 
> This helper has a couple other benefits:
>  * It doesn't need the i2c_device_id passed in so we do not need
>    to have that forward declared, allowing us to remove those or
>    move the i2c_device_id table down to its more natural spot
>    with the other module info.
>  * It also checks for device match data, which allows for OF and
>    ACPI based probing. That means we do not have to manually check
>    those first and can remove those checks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/21] ASoC: ad193x: Remove use of i2c_match_id()
        commit: 8c491103c946fb760005044a74c82d7cf6c6f6b4
[02/21] ASoC: adau1761: Remove use of i2c_match_id()
        commit: 56731c80fc3b17850e49913cec262c2bcaa88dcb
[03/21] ASoC: adau1781: Remove use of i2c_match_id()
        commit: f9812846ffdb1f5686154cae18ca8cc765232967
[04/21] ASoC: adau1977: Remove use of i2c_match_id()
        commit: d6ba6f50fae4170a8b7058da81dc2644913a5216
[05/21] ASoC: alc5623: Remove use of i2c_match_id()
        commit: b5e8f7abbb73d0f71ec8742c990c7e1ffa44a554
[06/21] ASoC: alc5632: Remove use of i2c_match_id()
        commit: 99816f3fa964380a50ccc898b08cc7d9dd58c764
[07/21] ASoC: max98088: Remove use of i2c_match_id()
        commit: ebf572bfefcd27584e1b32b0dd51ba71f3fe33d6
[08/21] ASoC: max98090: Remove use of i2c_match_id()
        commit: db2aaa0943803fbba606e3b59b5cf900eced2a5c
[09/21] ASoC: max98095: Remove use of i2c_match_id()
        commit: a8bb9855de4c5ca5b586814b7f8cc4a77d9e8b9c
[10/21] ASoC: pcm186x: Remove use of i2c_match_id()
        commit: b9f99efcc59ae86bcf238719e29427e9519b3878
[11/21] ASoc: pcm6240: Remove use of i2c_match_id()
        commit: 0a7bd3dba60a967032ce8c05b4d81350f01ecc8a
[12/21] ASoC: ssm2602: Remove use of i2c_match_id()
        commit: 6c978c1baeb8449114e8cb35c68832e903f713d8
[13/21] ASoC: tas2562: Remove use of i2c_match_id()
        commit: eb4b5da0ecf61135533574285bacb9dab4fc4703
[14/21] ASoC: tas2781: Remove use of i2c_match_id()
        commit: af4cffb250ec9e26a76c90cf753f1a6630811eed
[15/21] ASoC: tas5720: Remove use of i2c_match_id()
        commit: 06c61070173803a5341be31ff5281d15cc133e5d
[16/21] ASoC: tlv320adc3xxx: Remove use of i2c_match_id()
        commit: 55cf63cc8d951246ec35195ae5a1628beb9c9da3
[17/21] ASoC: tlv320aic31xx: Remove use of i2c_match_id()
        commit: f742875ee2534473ca4bf5ce1e120bebdf8d624d
[18/21] ASoC: tlv320aic3x: Remove use of i2c_match_id()
        commit: 2a169c459d9614dd6edebd8d34ab096b09f134ac
[19/21] ASoC: tpa6130a2: Remove use of i2c_match_id()
        commit: cb47dcedef8dee9e9e64598612b2a301f70a7fdb
[20/21] ASoC: wm8904: Remove use of i2c_match_id()
        commit: 77f3bfeacb939b47e1ffcda000cdf3c52af70e0f
[21/21] ASoC: wm8985: Remove use of i2c_match_id()
        commit: 7d57d1ce9398bb59fa0b251aa2ffa6eafef5cff4

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


