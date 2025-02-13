Return-Path: <linux-kernel+bounces-513145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A03A34204
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DA16960D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B8281360;
	Thu, 13 Feb 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM1XYQBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B013281377;
	Thu, 13 Feb 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456974; cv=none; b=urkaGEeAbQLXItBIoxREDpUtSzrFB16DykTsQTy7pNgvq8aUkR0vSq1aohphWlngu0DPOQASnA/cJXn+BJDfqnALqxXVs7pedNwOLl1/BdgZQATsX0yi4FOF4Plxt3aAJofhqXMG0WIix3f5iJMraeuj6RAXKiCmwCpNjxNsIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456974; c=relaxed/simple;
	bh=HUdrlX2MtZKsLwMOSsoa4AP7fbIIfr20YZg8Tm0wdYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pkAs1vph4LajHo44jY9X+ehpHRHd0c/JngIO8p8eokBwPwrNx+BDKnFquoMtQFTVmyTerVAggZQTgIlpuAyG39UMx6QlE2ZoRSn8d2hKrgqhUSBVzS6+18xq+MLdS4LTHC+si+A3N+Y/dpd9ghc0Ig3Y9Y7mmpQWZ7Y+89bD/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM1XYQBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131FC4CED1;
	Thu, 13 Feb 2025 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456973;
	bh=HUdrlX2MtZKsLwMOSsoa4AP7fbIIfr20YZg8Tm0wdYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TM1XYQBgWt5Zx3+B1g3byTwhgvV3eN9EnsHfNCXXJFQR1H4eYQAJik3H/N/lJGIa9
	 l/ony8uN3cDb7u3rIGm115wJoCZ0EqLbumn8ip/zT976urzefWUzxVHoTXvuJGxdpr
	 o50kQlcSm/AhDI7oRxA3rw1pb1tqFvPvAw6NLjZ4LG/eaz2wORLwnJLl5ngS3SYP34
	 HWXy30lsOrw/ovif2VKbvQqB8XDMDlbRNMjyuVIDCAAMRT19JgFh4H33P9k0Hd8d6b
	 36wameN+RBrq0PtKea4id1Texva6p6AU6MFCDrrBnxPLQyrhlRl3Prs++M3Qy6+QFB
	 7xRIik1A3bthw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: venkataprasad.potturu@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com
In-Reply-To: <20250213103652.1082203-1-Vijendar.Mukunda@amd.com>
References: <20250213103652.1082203-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: use switch statements for acp pci
 revision id check
Message-Id: <173945697146.151957.15841988796176463409.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 14:29:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Feb 2025 16:06:52 +0530, Vijendar Mukunda wrote:
> Use switch statements for acp pci revision id check in SoundWire
> dma irq handling.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: use switch statements for acp pci revision id check
      commit: 828c0aa63706410503526d0ee522b9ac3232c86b

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


