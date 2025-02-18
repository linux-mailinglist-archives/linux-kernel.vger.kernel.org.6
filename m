Return-Path: <linux-kernel+bounces-520517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F8A3AAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAF63AC053
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4A1CAA79;
	Tue, 18 Feb 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA/+ZmWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE591D6193;
	Tue, 18 Feb 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914228; cv=none; b=hYcoR0aGsD9hdmQK7FLqefdUs+nrB4Wt1MSrBiNTAS2y6nF1pf608Fyc4P90/BmFDTDVrldVMTGvizE3KtQEum0rHoa6oDjwz0TrSKWOi8QgaHALc2Scox1JH8iTREb9Zs7ImK9PVS+yOxr+2MvmsuL0+36leGyZwM6SqUeKIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914228; c=relaxed/simple;
	bh=Q2f4Q77ZxtAHwIj0TA+cUIks/SfvfVoLP55KGfTHXtY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F+0mM/NNAZF28FB/bQ/oW/AfVXe93IFH4RNVyB698YIhAE8wtaSr4bFi9Mfl9+G0vuZhNooa5xGXu7fkm5MtwyZf6AT5gpDxyHI017yGoc3UewjWbtgPev7w1rjNpA5Wg2dMg17P9HcNwzv/D5exm8kiA6f8+LTuZp+Yi5F+HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA/+ZmWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950A5C4CEE6;
	Tue, 18 Feb 2025 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914227;
	bh=Q2f4Q77ZxtAHwIj0TA+cUIks/SfvfVoLP55KGfTHXtY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MA/+ZmWIs01t2MPpzoXjfx9yIuNBMoLHYTENYpQ4yORDB06ifQsNZNJnX5PX6viCw
	 ZbbAkYJcBLFrwkFQtBsKKyA9wOeQQ4FHjADS9024d0n4Q1+U9A82ivPIvRK2moyOUk
	 +OX7mqLcNROUrsyj7vNgnHiWi3gVdZ72dy6Ilwn0OBlj3nUC2ZuZRmxbvhN6sF/Asy
	 RORGNYOk5OW22lo9Fzs2TiobOydaTFBilco26EHAeeiwezslJ3MGjvPuXDIM16DYTq
	 PzqsRy7rw6XrroWXPTf5oWxpfbT9Zs6hJPM7dVqlsyGkOt1dWcfwoaLOGdi0Fl7YGw
	 iY2mBMAqJy+6A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
Subject: Re: (subset) [PATCH v2 00/29] ASoC: tas27{64,70}: improve support
 for Apple codec variants
Message-Id: <173991422225.1713371.7641143097837420691.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 21:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Tue, 18 Feb 2025 18:35:34 +1000, James Calligeros wrote:
> This series introduces a number of changes to the drivers for
> the Texas Instruments TAS2764 and TAS2770 amplifiers in order to
> introduce (and improve in the case of TAS2770) support for the
> variants of these amps found in Apple Silicon Macs.
> 
> Apple's variant of TAS2764 is known as SN012776, and as always with
> Apple is a subtly incompatible variant with a number of quirks. It
> is not publicly available. The TAS2770 variant is known as TAS5770L,
> and does not require incompatible handling.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/29] ASoC: tas2764: Fix power control mask
        commit: a3f172359e22b2c11b750d23560481a55bf86af1
[09/29] ASoC: tas2764: Reinit cache on part reset
        (no commit info)
[28/29] ASoC: tas2764: Set the SDOUT polarity correctly
        commit: f5468beeab1b1adfc63c2717b1f29ef3f49a5fab
[29/29] ASoC: tas2770: Set the SDOUT polarity correctly
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


