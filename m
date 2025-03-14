Return-Path: <linux-kernel+bounces-561728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE448A6155A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B67A4624
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3C202C34;
	Fri, 14 Mar 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPejpvPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FC78F2E;
	Fri, 14 Mar 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967568; cv=none; b=FGPPLldsLwMph5HjznJtYS8xAgD8LVytmGg9VkvzxhYse15yuuSBk1jdYwiz84QluLUMrsqoKpppE6Tz8y8JiWQAkS5Pd3LuZMObecFcifH7rzJriWtT6oBoDsoCI38GYkbLaKbf6q+Ny7RfnjoWXqA1KfriaGSqZNcgB5OFdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967568; c=relaxed/simple;
	bh=/uS4Ng/WL4Jcl0Ypz9LMLA+hr2onBnAyckmY9Xp0WYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m0IyQeBQgtBqrNyNKp1BwguHHEPZ1SHWsZOGACsdZLj1XCTv+YjPVRdLBFnBFMcXNbomfzMAlpGpX7erlL4qIJftIt63Ycs7kY2rTnGBTdN7x6ewjOG4y2z2iuchYyiQV/S8We8e5lOoiUY/Xcl0aEy2qWeA/hvxPD51r5pDXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPejpvPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3215C4CEE9;
	Fri, 14 Mar 2025 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967568;
	bh=/uS4Ng/WL4Jcl0Ypz9LMLA+hr2onBnAyckmY9Xp0WYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SPejpvPIxJ3EItLLujVnFxouIcFjY4+owwjJUmcJD+19EVLugbpxI4TkF/eBm0w3J
	 mTTlsL2Q+IbECocAChsyEtVhMEHSFbx/X2rzanjpN3AAmnnmPLdxzUwPRRhGr0Gakt
	 QiTWToAQcWp+EgeVYDDHzxM65Jm/b4NWAna+wWSwZJBhpPLHT/HJoBg40BERmFRXBH
	 cxO2pXqNQlOvkn9yReqYMnokyk1EcUYv1ET09Q+aI43rReDO5O66teSETXQGQZ6VKW
	 lqUYsmshwNU9k5BevBTe0J9FHzPD8j7Y2NINAsFgilmBNC/DJE6MXS4uHzPz7slHo6
	 VtWusLum1IuGQ==
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
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
Subject: Re: (subset) [PATCH v3 00/20] ASoC: tas27{64,70}: improve support
 for Apple codec variants
Message-Id: <174196756357.19728.11723701852037310950.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 15:52:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 27 Feb 2025 22:07:27 +1000, James Calligeros wrote:
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

[01/20] ASoC: dt-bindings: tas27xx: add compatible for SN012776
        commit: 25a83f870b8a25a4b10bf5ba474a017ed5a72e7d
[02/20] ASoC: dt-bindings: tas2770: add compatible for TAS5770L
        commit: ce9233937f3233e277ff23395e61ea690c769bef
[03/20] ASoC: tas2764: Extend driver to SN012776
        commit: ad18392962df46a858432839cc6bcaf2ede7cc86
[04/20] ASoC: tas2764: Add control concerning overcurrent events
        commit: f8d5f28e3f2ece5a1392205022afe30c87107a9b
[05/20] ASoC: tas2770: Factor out set_ivsense_slots
        commit: 6553ee024b4452ef861de10605156c9d79e208ab
[06/20] ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic
        commit: f0066c8d1d3298e9f9d136a365139bac733e84c5

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


