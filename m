Return-Path: <linux-kernel+bounces-226334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE1913D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE29F1F232B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E93183093;
	Sun, 23 Jun 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUDRwJn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE51836E2;
	Sun, 23 Jun 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163309; cv=none; b=UqUlWQlL0v3XQ2bTbZGQ+Gj69k2H5h488dFgublIVoJunvDEePbngyQHAkbMOWiY1yWDp43Gs82eih/bFmL6HZoOy3gYd8Wo10N6lWvbfyUjDuEIyBN/uIQgaZQtW6blSFS59H/tkjFPfpJBPjKjHTpsQUvIle5fU3fr9MbCwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163309; c=relaxed/simple;
	bh=hqHsU/ytros7zlMhVXXRaDb8uWaZIiY2BwlJTdGlQi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lzgQ7rUtAtt9U4nL1XdPvs9flwFcAl1pL9dB7QGs9LddAKdBZ5Ia7gV5wPXtqhZIWxmcKQPye4+oJvT3VXGLtAYOhtSOLKzsf3I4kuLgHJp5qNMTRDEx+RJYZmZV6OShX3G/grQ5c80Gvif3icdGjuyQVq0PAp+SuWkmPoPLlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUDRwJn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB9C32786;
	Sun, 23 Jun 2024 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163309;
	bh=hqHsU/ytros7zlMhVXXRaDb8uWaZIiY2BwlJTdGlQi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RUDRwJn+ir7NGPEFmk3ra3S/+A1uMRkOSuavbEo0zJkzbZxXb1VAHprHB27Si7t51
	 L4R971MZWLsJJ6iUBzx2GujCIHLVjstNoboNvuaIGUzWBdZtFhWkRDPvVBhDk1EyGW
	 nf/FJXkq9+00ewfzo09PuoNRTRWkYOKx1T93cer79rlvuBkJyiKaUDrfgWgXDEZEcD
	 MLnW0NZNgGfEFS+s5npUEDR4oIMI3CA37tR0SBZfWi/b35wifp8x6MsbP2uLQyxXA2
	 H99H8s8RvcQEvf3MQ6C/jP0qF5yY5V8Z81JP8SPsZn0sTEi01hWcEwCmXFwaIlYlDl
	 h62TZT4NUxfLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ricard Wanderlof <ricardw@axis.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20240607-tlv320adc3xxx-micbias-gpo-v3-0-59dbec8b98f4@axis.com>
References: <20240607-tlv320adc3xxx-micbias-gpo-v3-0-59dbec8b98f4@axis.com>
Subject: Re: [PATCH v3 0/2] tlv320adc3xxx: Allow MICBIAS pins to be used as
 GPOs
Message-Id: <171916330513.350242.3221156381590082355.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 18:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 07 Jun 2024 17:22:03 +0200, Ricard Wanderlof wrote:
> In some cases, depending on system design, the MICBIAS pins on the
> chip are not needed as such, but a couple of extra GPIO pins would be
> useful. This patch allows the MICBIAS pins to be configured in the
> device tree as general purpose output pins, controlled via the GPIO
> framework.
> 
> Owing to their originally intended purpose there are some limitations:
> when the MICBIAS pins are deactivated, they will float, so will likely
> need a pulldown in many applications. When activated, they will
> assume the voltage specified by the micbias1-vg and micbias2-vg
> properties, respectively, meaning that the resulting output voltage
> will be 2.0 V, 2.5 V or AVDD .
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: tlv320adc3xxx: Add MICBIAS-as-GPO properties
      commit: 4e617f0cb2dd9675a3b2707c10d89f0f5303ad1e
[2/2] tlv320adc3xxx: Add support for using MICBIAS pins as GPO
      commit: 6c01001414ce477311d872c40e23dfec4866d608

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


