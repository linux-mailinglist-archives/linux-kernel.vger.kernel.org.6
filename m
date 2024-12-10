Return-Path: <linux-kernel+bounces-439796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D479EB401
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4664285E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCA1B422E;
	Tue, 10 Dec 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlL0x44Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35861C07C5;
	Tue, 10 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842286; cv=none; b=rek9mdsF3i6HGcmVA2o6BaWOfHP5x8Wojhe/UNRIdlxI7n+N4yzSHpXeQ8/8Th8HWlaqOMQlt/sfMuIEhz3qXGhAaGrJCM9MFC4I27WYIlK7N4IFCZhMnKvX6vtgNowEd0ihLes4NGBgVlNVUH+2HNOF2Tz0UJkfXKYvKPjl2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842286; c=relaxed/simple;
	bh=vcFRyMq2LgyT/jZlk9FVwHCu7zwyckkYnKycWPJr6ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MOF9UguRuuvaMXFpa+r/BcKKl8q24V9ZEOTD4Fd77xDkhZr7Mnw5/AO08ZS65aVyvgRZbYpd0es8SnRfb9+RX+fsEHIGIr/Il5PcWUCDeJY3K0OXawEiZt+cddYo3siRwIR/nkf8iFHYcgFvakzbtF124vQRLPPJ55Sa4rJ/q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlL0x44Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FDBC4CEDE;
	Tue, 10 Dec 2024 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842286;
	bh=vcFRyMq2LgyT/jZlk9FVwHCu7zwyckkYnKycWPJr6ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HlL0x44ZrY+g9psBGk58yGcLzU6rmxdvvL/U2yD9CqqjJYjPnMZ41rN+p1LreLf7c
	 tZCdX3rrBboA9Y6njpVnDvZ1igfRoaMO8Qx5BzXMUPxYDsAIJ2HXFY4jk9y4fS+nxG
	 TM71JgY3hHNnjBj27TvyH2n19qEog+tucsKSeYN9o7aTbaw+J9p53BX3L8dNpFjtMn
	 QmQ1M1Qk7cR0zYtZsCCFKHrqVWYBrnN8u3kauOkjZnoBB5GRRD8c0od4T7mKge9UCS
	 vqpiClJ3pOnr9Tj8Tbqyi5FKDu0W1CsS/XOIwNa9ShiyIGzRDLH2Zw7gfsf0clZ4MI
	 jtoN9layVBmGQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241210091026.996860-1-venkataprasad.potturu@amd.com>
References: <20241210091026.996860-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: yc: Fix the wrong return value
Message-Id: <173384228352.64342.12647978237032666087.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 14:51:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 10 Dec 2024 14:40:25 +0530, Venkata Prasad Potturu wrote:
> With the current implementation, when ACP driver fails to read
> ACPI _WOV entry then the DMI overrides code won't invoke,
> may cause regressions for some BIOS versions.
> 
> Add a condition check to jump to check the DMI entries incase of
> ACP driver fail to read ACPI _WOV method.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix the wrong return value
      commit: 984795e76def5c903724b8d6a8228e356bbdf2af

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


