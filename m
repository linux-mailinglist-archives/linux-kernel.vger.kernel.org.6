Return-Path: <linux-kernel+bounces-517569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B58A38287
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E76D3A50E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF4219E8C;
	Mon, 17 Feb 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6f87SYp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4D217733;
	Mon, 17 Feb 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793438; cv=none; b=ecABmzOyNTvxfx1X+IRVfCOTtPeervHMV/gWrggYx8az8gIT28CH4wWLACK/8RzAQwPRPbBFUg3F9qpzTTjDu6aZ7JRZJEXLb2ZKmGteXio1blzazv8Ib4h6/TOkE/vdj4Axe6k4P1BuLv3ZLNFIwfv4/vsKoULYNME1y8LN8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793438; c=relaxed/simple;
	bh=HUGZHMnwHSyonTTeXcEt3TS6l+rI6EOru85XAt7Si/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NC4Gq9OoN0xWqRhWiQUvPZxq4h5WIrNmxtfR+tzWls6BfeMm4hYRmDL7y+iks8TvDqBsMNEMcKoWJHi6X+jtBni2NP1vyIOqpCnoz81lWQXIsvmwW9p1HTaUbedE0PeYO3PxUwoDSCktIpqV1M6qyVbmJ/nDXUFZ7djUDppTReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6f87SYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E970AC4CED1;
	Mon, 17 Feb 2025 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739793437;
	bh=HUGZHMnwHSyonTTeXcEt3TS6l+rI6EOru85XAt7Si/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b6f87SYpL/vdAUuEoSjhuSQ1LDS9J4ho6P+A/VQ1BjA1PMYmA4++gYwXNNm2lLyhE
	 RBe0PUYFxVt3SKqB4+UHRescHnMskNlRo21kiGX20zDjmDmDxVuRc177p9rAE2SGuv
	 nP/AVx8JR5C3YiHYOx4NVLH70j7EPgGxNiLv6pMHZZXa8wQNoV0TZcC/ZsDOdoB5Wx
	 6rBSo9llUPwJiXVyQalhmPCaiIYPkAV8xIyIM3+/3y/1gl2o9zh3SLRRmwTvIX1cK/
	 KheZDD+8w0EFZZ6jh3E2B34Xm+TrYEs2iPszyePK/3PZK/OUoLWbZAMxvP+hSrLjSp
	 AloIkEdR9Khag==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Hector Martin <marcan@marcan.st>, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.org>
References: <20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.org>
Subject: Re: [PATCH] ASoC: tas2770: Fix volume scale
Message-Id: <173979343450.13947.18258886798038196730.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 11:57:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 08 Feb 2025 00:54:35 +0000, broonie@kernel.org wrote:
> The scale starts at -100dB, not -128dB.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2770: Fix volume scale
      commit: 579cd64b9df8a60284ec3422be919c362de40e41

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


