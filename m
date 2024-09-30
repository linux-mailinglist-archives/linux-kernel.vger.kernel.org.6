Return-Path: <linux-kernel+bounces-344854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F246798AEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129B91C2199B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D81A264D;
	Mon, 30 Sep 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZBPHXG9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217921A262D;
	Mon, 30 Sep 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731589; cv=none; b=BcRKTogK35aBMqtALOymNoeoftn5IxOvnk5ZGd5mD5z5cwp/nSGj8cH7K7amjScQnMyeDuGs1NfgcA173Ib6JL1zCHjut1gzMlHWlHGsYigJyNMw6/Pst1azTVBa1qS2ymlC5cSGRZaStLmI4gt7m2yyjaV5mxqVdKOuR9N8l8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731589; c=relaxed/simple;
	bh=5DSDo8MzAb3DNmtRyg6pZv65Kq1qofZob/dU/IC7z7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X339BKVLxWpEsKHiD6BR3nuH0L8N8G9jB1MdNiqvqrhnJGUXbXFNmNu6F8thbYFNrDeT1TfeKQrxNy1Cchj98/QyR+s+Dzu12uymf4sNBSdFXQzUvjuddzBPSJZRUp5aeIsJzmSyTeZv0nVwzrpUZpiFGSsJJHkmLdJIqT1oH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZBPHXG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A7CC4CED5;
	Mon, 30 Sep 2024 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731588;
	bh=5DSDo8MzAb3DNmtRyg6pZv65Kq1qofZob/dU/IC7z7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hZBPHXG9cy/lP+B/6nCN0kcLFNfzs6ynniCE6iamj1tCfeaeedTYMI4Dh3dGUfUkR
	 JE0eKRnCfjliUtpvvwTUiRBipF7DVJGdVjtRb/mRMPJIpcmOzuos1jE6Wz3Pk/ufNB
	 MJsQRWH6VWmb2X59bvtL0VxRfNLKbkB3jJW6ne37jO9pyty8mLoYUYO4APAsu5ZUyN
	 tJ/Ferk8U0FJ37kYCCNHPUChcLgsyVSGWBgoscJBZaWMI6u+AbjGcEXr4xTlZMFFXL
	 RMirmwYm2Qu2hhN1qCsV9W4wypEExojGBY9OSilB977WC2S22kKyA5NwBZ0fpV8R5o
	 pnWD+Hyjlunhw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
References: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Subject: Re: (subset) [PATCH 0/2] ASoC: tas5805m: Adjustments for
 tas5805m_i2c_probe()
Message-Id: <172773158692.2197048.4426255275584939181.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 16 Sep 2024 10:38:09 +0200, Markus Elfring wrote:
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Use scope-based resource management
>   Improve a size determination
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: tas5805m: Improve a size determination in tas5805m_i2c_probe()
      commit: 0e9f73f109025f0d5d16b104b6684e6c03aa0c83

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


