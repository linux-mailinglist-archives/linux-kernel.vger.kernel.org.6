Return-Path: <linux-kernel+bounces-317687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4D96E22E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC847286990
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DD188017;
	Thu,  5 Sep 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV+s/gii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18D186E37;
	Thu,  5 Sep 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561747; cv=none; b=bt9zdwClCwfGRMaETtNvz79vi59ddvw6agS23vqHdU8siAw8EZAs3NPilelIO49TI2wTYfg111X5x+SHXrHjFOHo6gwt0Gip2NxprhX0/V3X6JPBWHE4iEAiZN9nAv2lGLdIINXnzuJj3QQUhboV1qQ4Xcc6zuJTnhjhI4x/ONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561747; c=relaxed/simple;
	bh=4eWG/a/26/vZU95IBABJgRDgFGSUm8AvCLiQp6PJwQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IUK+oThr+Vv+OdyKhSEn9pTRMU1boawLo9GA6/BKN1Bo4ODc4yUitD/5QiCRi/jTSZAPZZQq+YPdYqgVba/i9C1rRNn7rAQld+eOEy/1fWmsXm3DafuMFoNbLztaY4+eDsGLUY6ALNlOKqxqZeKcvbbsyuKJgmC4RjEz6SZBedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV+s/gii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58B1C4CEC3;
	Thu,  5 Sep 2024 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561746;
	bh=4eWG/a/26/vZU95IBABJgRDgFGSUm8AvCLiQp6PJwQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mV+s/giiqa2lTulNqxBg2vltuHE7NO/2vObB7ZNwXKPdSfwEiCKW7MQwuYBO2knWU
	 tRpPi0dWs9oN4ufQFxUegT2HKYIbf/gQm9CP6d9qThM+hPLla6lveIImLmVX6PGPtY
	 VIZXzcoWzCar2VqiK5Ty5xMg8eDzmYMFg99UyeK6UPJF7FTiA4DcEJjrH8HUL+KqeS
	 QzQCo+3Vv3zOXLBxLQZ5Zaa4MuBx6ss/VqqbhQJFo3g967w6qd6LSU+VfEoZ6DATTP
	 OMELBiKR+Uxcb9JBR1W0NB29/S/6atbMAJAx3ktc3qn6TmbzhYfkbFlWElbQm+3lM+
	 yNgp6FcD1UlnQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, amergnat@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Nicolas Belin <nbelin@baylibre.com>
In-Reply-To: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
Subject: Re: (subset) [PATCH v8 0/5] Add audio support for the MediaTek
 Genio 350-evk board
Message-Id: <172556174352.65454.6443840128203694133.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 19:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 11:06:57 +0200, amergnat@baylibre.com wrote:
> This serie aim to add the following audio support for the Genio 350-evk:
> - Playback
>   - 2ch Headset Jack (Earphone)
>   - 1ch Line-out Jack (Speaker)
>   - 8ch HDMI Tx
> - Capture
>   - 1ch DMIC (On-board Digital Microphone)
>   - 1ch AMIC (On-board Analogic Microphone)
>   - 1ch Headset Jack (External Analogic Microphone)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: codecs: add MT6357 support
      commit: 5e2404493f9f6028bf143972b18c88156c9893e6
[2/5] ASoC: mediatek: Add MT8365 support
      commit: 5bbfdad8cf8d4b2c3189fee8e6300b38f65f8d72

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


