Return-Path: <linux-kernel+bounces-549280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03CA55042
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B4D3A95B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762C21149F;
	Thu,  6 Mar 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZjGhNJV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0006145A0B;
	Thu,  6 Mar 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277426; cv=none; b=tjsrKOgoA4IQFAiGy2WQX8qMChb1sk8jTLjx7rYCjyq4iiTpUih7YEazHKuq9zIYoSmZ1y2Ar3JWn9VdIXDu12EasV8EyJt9lGxY+8LSwVGBu61UlJcLkwHow2rQfhNVbZ0XmoM5nkNIUXWSanI3JmFr7cKsfM3v6UiJr1dkEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277426; c=relaxed/simple;
	bh=/CafB9CjLNnG+rUtDUJvwj69pDk3YEJSnvrK28dm2XU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a7aFtU38Wy4OXUdfJ62hqWUQ9MbQwFc5Y4qSYJKGzw35cLDwA1+MaUggug2ahbpwFTO8Za1fxmIsy2KGh8lM9u+DynLVxPSvtlz5cBYt7hYU8AZbnwUm+NoMOA0L1TfjzZ9uuOUQQK8S8jZmjdficOYj4uzb+KT8LG34/olSH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZjGhNJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD4C4CEE9;
	Thu,  6 Mar 2025 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277426;
	bh=/CafB9CjLNnG+rUtDUJvwj69pDk3YEJSnvrK28dm2XU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fZjGhNJVPiS+5DWgPnN3wPSh0t0snj6e1EfGXc3qWoCYZGssOhO0fFZerSWxAegIF
	 rK4A6EeK5Y6UVAJpYmDr1DpgMMAvHhxR1kjKCRsFlT+CN01HP57rrb5+FI24TYBhIr
	 yaS8Dft5TzQySYQlPDGscgpeM1nmCGH/zTKoY7Xkemh5Ry44tRESV83Gkpi3E9Y3C1
	 q6etvJwc7SKYbRbB0S765WtsKsLKodYhhHfVy6L6754Z/kCSkhBQXgv+4uap+znr3S
	 CLGhie4n1//oc5g7oKNGICaUe6tMemrnErIkQ46GMETWZmezGG+0fiwhwxe/0GjWYy
	 I4hMCi7rthuAQ==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305172738.3437513-1-arnd@kernel.org>
References: <20250305172738.3437513-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
Message-Id: <174127742288.138495.6148679586151752029.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 16:10:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Mar 2025 18:27:32 +0100, Arnd Bergmann wrote:
> The custom suspend function causes a build warning when CONFIG_PM_SLEEP
> is disabled:
> 
> sound/soc/codecs/cs42l43.c:2405:12: error: unused function 'cs42l43_codec_runtime_force_suspend' [-Werror,-Wunused-function]
> 
> Change SET_SYSTEM_SLEEP_PM_OPS() to the newer SYSTEM_SLEEP_PM_OPS(),
> to avoid this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
      commit: 2c2eadd07e747059ccd65e68cd1d1b23ca96b072

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


