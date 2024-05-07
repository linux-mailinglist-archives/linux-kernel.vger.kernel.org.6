Return-Path: <linux-kernel+bounces-171588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D868BE616
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46CF1C22A03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322115F326;
	Tue,  7 May 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPqSizRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D615FCF6;
	Tue,  7 May 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092505; cv=none; b=MyeCcAEXkYzovtVSVp1K+Mph0Xa3bdf6UZqIU/01fQGgGVBumbjkE8PmLu+v7gwIAuHXRdI/NtIIX3FQhF2+upftDVoxaXWvldjy8BUJYDZz9YD5pKkCyH8idJNxea/+ZyHV7ztEhQ4uH15oSEOqXQeR5Hi2S4fO24Z068BO3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092505; c=relaxed/simple;
	bh=N0nCKnQCByT3IK3m7wyeGknqiLgIC3cuB/Cu7ARwNXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jJ3JR07A05PNrLUCHiF58jib12QSKCKE4AJ8FxtkRj6FC/gwVBwhRPZ5BnBLemXmiFLnBZJtJ5LEj2NafM9O+zUA0pqhdWWO+tFN4V7lffCuazdkwAePzlsGlr9A/bHupiiIDMUFfJ6ipoTZib8gZzy8oYqDsakUYzKDYZzumGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPqSizRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C8DC4DDE2;
	Tue,  7 May 2024 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715092505;
	bh=N0nCKnQCByT3IK3m7wyeGknqiLgIC3cuB/Cu7ARwNXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aPqSizROc6nkC1M30JjjYa4TqcuN2LVFmDCEX1yiBaD4A67donhVsuOX9Ts5WoG3v
	 W7M1GDOTWsOl0Bufm3yPAxx/uyA+mDq9vY5n37fGNLecNUa6gaXx4VBEN7YCBbahCG
	 Njp9f9QREQYHjfJmdBJw16zMIroiBGhcw7e8bg8ysTCzgsgqnILvLaAi9LnOvR6e+x
	 5aC0qnj4STAmYHg+/nHDJKCeOfrAvZNJCIfBluGe6zFo1PqLTpQliUBvK3T308ncrg
	 wqERY3tSpi/Q5NktzUyTtltwJYK8JrQac3n8CNEbTXAtzWS9nd7i9Q3jVJxFImCOyL
	 7QpsuHopMIsDw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
References: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/4] ASoC: use 'time_left' instead of 'timeout' with
 wait_for_*() functions
Message-Id: <171509250290.1985791.3642675927789530835.b4-ty@kernel.org>
Date: Tue, 07 May 2024 23:35:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 13:54:33 +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_*() functions causing patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> obvious and self explaining.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: codecs: wm8962: use 'time_left' variable with wait_for_completion_timeout()
      commit: cfcd957e63506273dc54f34b320172c8709244c7
[2/4] ASoC: codecs: wm8993: use 'time_left' variable with wait_for_completion_timeout()
      commit: 0800660d8c59539b628f5a6646bb63091d58152f
[3/4] ASoC: codecs: wm8994: use 'time_left' variable with wait_for_completion_timeout()
      commit: 19c70b4668306632d3cbbecdf5fea98b528e873e
[4/4] ASoC: codecs: wm8996: use 'time_left' variable with wait_for_completion_timeout()
      commit: 4e1f953a4a447b5e001655b453505c4c15904c61

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


