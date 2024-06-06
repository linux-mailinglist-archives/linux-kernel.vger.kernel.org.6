Return-Path: <linux-kernel+bounces-204516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD88FF002
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C1F289EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA219923B;
	Thu,  6 Jun 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JszW8j6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A417168C10;
	Thu,  6 Jun 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685345; cv=none; b=rFJXbxM9Ydbuq4yc3CfI3co/waYTPjPmgk4IbLoMznRx4iJuHWcEZ3yp+KuHjS7STn+AlGgqGo9LzRI82q4bdPRkQVUDFf+yE79oAv80LQfbqCOiihNLILBBsNhFnKYfla5Dgpm7i4MyiHxF4Jr2LZfKA/+4eCnItYd3ow6WhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685345; c=relaxed/simple;
	bh=oIsOBi3YR+xt6MMQIParPVbOIkxTmT9b93g53VHm6E8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HEJfluSmTxa3e6ckxta8NEe3/JHS1wtPPhslXVXY+SCOfToH2kTgiY/OR5RbkGErAvBjAQ5jQ369OrHiaDheEm2FTtgadYI5L4/rqECYC90dW08TZTibxptUYU7FHwwh+8x+wBgHtptUtXSjN85eCO3tA4T7qEmbsDZ2jxa+69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JszW8j6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71569C2BD10;
	Thu,  6 Jun 2024 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685345;
	bh=oIsOBi3YR+xt6MMQIParPVbOIkxTmT9b93g53VHm6E8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JszW8j6N+zTB16PXUB8fTcXyXCnTYis0sjPAsRu2jibrMA4xFXHdWj+hkW+EV6NW+
	 +r799vIpjVSgNJ47hO3z7Frnf13eety5sF/rNJZF5KX4FbSnhfiLQKUPpSn1Ircl5w
	 1gIgDPT8A7nsVszi09+EraAK2ElIujyVrLwPXI760R1iCe1aNjHAz+1zhRE1jKI7+Y
	 4Fbda/oGDCej5GlSJOs0pEylDlnisoP7pf0ryTPI6GsFDwsMW8muXaNyJUkpeGy2BO
	 bQ6XIxkTC9olQ9y9dKYANo6AI1uTZ/ynvMAgC7EUw4PH0JfR+qqP/fosZTV363w/v8
	 OpDRbMCMNcUuQ==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 kuninori.morimoto.gx@renesas.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240604101030.237792-1-andrei.simion@microchip.com>
References: <20240604101030.237792-1-andrei.simion@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform
 to fix card init
Message-Id: <171768534216.1578869.5370523933497005788.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 15:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 04 Jun 2024 13:10:30 +0300, Andrei Simion wrote:
> The removed dai_link->platform component cause a fail which
> is exposed at runtime. (ex: when a sound tool is used)
> This patch re-adds the dai_link->platform component to have
> a full card registered.
> 
> Before this patch:
> :~$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0 []
>     Subdevices: 1/1
>     Subdevice #0: subdevice #0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init
      commit: 2ed22161b19b11239aa742804549f63edd7c91e3

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


