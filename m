Return-Path: <linux-kernel+bounces-428130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC09E0A86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FD91632A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13F1DDC02;
	Mon,  2 Dec 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxwxveaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD71DDA00;
	Mon,  2 Dec 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162302; cv=none; b=o/58X1xlbxK6K40IUUIM7xBgLSVQHbYiE8bWea8EV4Tesjl69WXpO0EVAIFb+3e34xWOGa2ykzqPM6kboQAExb8k9vz4VOXCCxlhZXVhMxvLS8wA5G/ubqR/9WyZcxfGkg1jmdz6I3jJHSFTiNvaoroypw6bZqTZSSfRqpvQ3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162302; c=relaxed/simple;
	bh=wc8acshRqgtQ9murXkgXyF6rYDtZsm4FCQBigsu9Was=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pb+gmJ1Mc+TMKclwMerup3SYi12KK28+NJ7B/xy+zXbtfeN7Dd0MCdAiYm4GKJAxunoyCA6M4eW5WSfVuIdgxh2EPmYlwtloYgGzpoFDZVveWPz/WBCZURcnw2jqXKjOKC7fGCHdmT/BgaQ5E9cOCVRFDpHdW5ePquzqVscI6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxwxveaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3311C4CED2;
	Mon,  2 Dec 2024 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162301;
	bh=wc8acshRqgtQ9murXkgXyF6rYDtZsm4FCQBigsu9Was=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XxwxveaLWp1s1ZFjAPlLaW4QsbBfMo/1bflADROH0A/fMOTfRuJTJWZMzeC6UAJg2
	 Gjo6v8h+XulHT3gerrbSaLomp/KXN/LnkbFcvfk2gi2iZEmnMwmXSmf2OwPgm5G+TS
	 0SS65tMOTpp2+kiwLHBX+J9swE9UAw0YFzrxEPNHWRcI/PtXJZjrwvEKu8sKzMkR+w
	 4NF+zsfKM44YxjSQPBgXNHcw7VlTlK+V0HlUDSSV73hgRsHbNOc2iNy+atFfzMDAhH
	 repU5hFVi1L6DIkTgLNM4YNqsjTAByxcEXAc6pCjOS2jbvA4HZ8NU+7YjbR4Z+xR2F
	 lRzs/YMND3srg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <d5e686f47eddb14245d0fde693ff77ae749f7a08.1731689646.git.christophe.jaillet@wanadoo.fr>
References: <d5e686f47eddb14245d0fde693ff77ae749f7a08.1731689646.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs42l51: Constify struct i2c_device_id
Message-Id: <173316229946.189181.8001844951815488004.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:58:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 15 Nov 2024 17:54:25 +0100, Christophe JAILLET wrote:
> 'struct i2c_device_id' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> While at it, also add some space to be consistent with cs42l51_of_match a
> few lines below.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l51: Constify struct i2c_device_id
      commit: 3787255c967ba64dc72adc3038f0cb81211bd297

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


