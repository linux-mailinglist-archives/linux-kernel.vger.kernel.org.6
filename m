Return-Path: <linux-kernel+bounces-348033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C961E98E1B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C956281D78
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2C1D173D;
	Wed,  2 Oct 2024 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nng2NEU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E71CFEA3;
	Wed,  2 Oct 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890678; cv=none; b=rdRtyDHai/tLvUtt1tVomt1MCFjVPteKpdUrWNq8+GHJoJQOoKTy4KjJrmB75k2pg/wVWJ8X05lH2nMBFRg3ROg9kYQUxswMHG27ewIWnQOcsjDUN/Wbv4ru0uB8F7zSwOTFdt+7A14rS7sxBdz8x0jkv+3CSXEobsyqDmlg8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890678; c=relaxed/simple;
	bh=ghR/kvQjxBOt16mBK2+QUkF3184nbTdC7o+rvMUEqAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ap9UBECXpC0tgi0ptJwNa77Bu0DdFexYb3r5M2E2aZ/MJ9GQzwRduJIVZv7QqTIKrCBYubnvpszBQS7UNv+1yI6Ox5bHTcVjr1N9/pMZPBU24Z7MCMrNkDV9wqP05ORZq5mz9BKeXgesY0xbqn6JVRTZMVyNcT6lXQQJdGacQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nng2NEU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD0EC4CECD;
	Wed,  2 Oct 2024 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727890677;
	bh=ghR/kvQjxBOt16mBK2+QUkF3184nbTdC7o+rvMUEqAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nng2NEU4ejCnWzgmt5U5CJBL+wMgOFTF+8RFTLMCbF0pvy0vLsLB74nnA8JK4JR3+
	 iTxDSVIxrzY0lA4tC7YatNz5vs3W9WW9AS44L6XOA/kbJCgzt9yfFqJ2ht0p5tC3iw
	 +G4zzxedToVTiy8HFPmbXabrNi0e9Z4H43haxZDdSRprhDtrqGs3nY/rq2T4oK+ppY
	 IpzOb/AH9vBbWJ32D7VoJkCknErB/Im/RpWC7NxvpocHEKbRlTnQQxPJAH9FvCy0VQ
	 QQUcp5aQr5XmtGGqhhyTSvJtBfv2bS5cACSjJSQbVCc/GOj1OSgYVn2PqOR5vDIERI
	 RShlN9wAJwXaA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Murad Masimov <m.masimov@maxima.ru>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20241001190848.711-1-m.masimov@maxima.ru>
References: <20241001190848.711-1-m.masimov@maxima.ru>
Subject: Re: [PATCH] ASoC: amd: acp: drop bogus NULL check from
 i2s_irq_handler
Message-Id: <172789067550.163279.13765967937832147149.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 18:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8

On Tue, 01 Oct 2024 22:08:39 +0300, Murad Masimov wrote:
> When i2s_irq_handler is called, it's guaranteed that adata is not NULL,
> since IRQ handlers are guaranteed to be provided with a valid data pointer.
> Moreover, adata pointer is being dereferenced right before the NULL check,
> which makes the check pointless, even if adata could be NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: drop bogus NULL check from i2s_irq_handler
      commit: 8cd4e1f087b6906bacbbf8b637cac4e479a9cb34

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


