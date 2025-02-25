Return-Path: <linux-kernel+bounces-531483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E36A4410E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA8B3AD3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7541269837;
	Tue, 25 Feb 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aozRsqQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41815269819;
	Tue, 25 Feb 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490729; cv=none; b=g9oXDeABSebUPIprbYQ5VhzKhkUWg86szRmeW36xOhShppcbMGKJy1+JcSXXGowhleVIhUfzjDEK62QuoHq+o+jH30jdOQmFqE78K5OeOJmQALaevA80y8zl6bDLlN/g1OUdz9V0s5o7NrzKgeOhpaSVmKQ135HBgDKhJgWX4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490729; c=relaxed/simple;
	bh=bJ3NHtM9/m9NUKbxneBtDPd7ROoBbzlkPBC3/NbsPqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nFKkWHM9R2NszlEGevks5gg5ZnTu1PaJ/mJjm4xoErXgYNH7OfaN4LH6EkhDcYkzu0VZHAbPzelAtPkxm43MXkxc6e702lYnu/sRtnHhFVD3fNmOlTlV1aIWeuQbSuMa8X4qEwdl69+adinmEQEZA3ZuQxRTKxWl4a5wRnEx2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aozRsqQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFC8C4CEDD;
	Tue, 25 Feb 2025 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490728;
	bh=bJ3NHtM9/m9NUKbxneBtDPd7ROoBbzlkPBC3/NbsPqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aozRsqQcxJytbSXfak4vSwnCDDCrH7+LkABfWILugEivMpJONUQtuia7FcMU8ndmB
	 ixDXHiPlBQ4imWw2fDG5LoPr4IbhUs5AzHEElp97IYpQ0IBER+Jh8svQqtYiAwiRT7
	 o8g57BzTJFhg98uon5ILu1KB2iyDsYSpGbOGOUaOyvoCJjn8AiDf51xSlkNOSw5rJx
	 ziBEaGtdpGsEN5mLIcn+xsYCp6xOum4DXB+8HY1yOVHq/u/8+iG6nrqg7gTafImNMj
	 oNNrJispyfCYpK8xD5KnUDEsnwGERpHLf/y0XGuW8xzFSSCStG0dUwKg3GMrNEdv7c
	 EfJDLWyD7pKVw==
From: Mark Brown <broonie@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrei Simion <andrei.simion@microchip.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250222225925.539840-2-thorsten.blum@linux.dev>
References: <20250222225925.539840-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Use str_enabled_disabled()
 helper
Message-Id: <174049072628.42497.15584165793923327558.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:38:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 22 Feb 2025 23:59:25 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: atmel-classd: Use str_enabled_disabled() helper
      commit: 88e09306b7e0f8a9e9f9c729ac13ccd11ed9679d

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


