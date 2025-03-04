Return-Path: <linux-kernel+bounces-545386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4BA4EC42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365627B02CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F127D76B;
	Tue,  4 Mar 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SchpDhfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3124EABB;
	Tue,  4 Mar 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113512; cv=none; b=atRt/aMaskewrVRiyKCbM1bufU+fmShSmlCNhELMFTWT7Doho0KmqsmIuCDmj0aun4zt4KeJ1cF34CTxXZUZxPufCVOdMOW6pH6EruO2wGZ5ziSIaTe6EEwuXx8o3OT1TXtkTTX00cvIc98FTn/YHmvChQeBA4IDMJfnewbCROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113512; c=relaxed/simple;
	bh=DuCorhQ04kUNeL9S8BHnsloluKtrkxjF3QEO7eEGDbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M8gK0C+f0HDE4BPGCWRQFnKcHAudzke18onKN2zsCht2+7xOjPsTm5Fk+ZHdzVoLxKqoGPYp+SdtUShjluikqCn5j4P8CoFZRi+mpnJK3ug6JXGKS30j17n+E3nGZuOoTEaHdX4mDokeygOmtTo442GtvLoTyDTRwK9mtS5DWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SchpDhfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B035C4CEE5;
	Tue,  4 Mar 2025 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113512;
	bh=DuCorhQ04kUNeL9S8BHnsloluKtrkxjF3QEO7eEGDbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SchpDhfVMRV9vAfZ2gNzNJxcK1IfSSg9A8lZk6+cvZm4NOvdvVGPK3JGCmAUKQKqF
	 MVsdpzU/dyGcdcFpI1xiW+yqqhEj4CDp4ESydGGTBgFe17qSWwDZ/s4DI6IH1KSMMQ
	 sAFH6o+uEZMG7/kG06uGg7as3rWSXlQPUwtNnjO3enXoGMkx6mAIbPF8v0Tj7xCu9j
	 ABYayI8JfyA3Z+OFNsIG1mt/PdhkYgy1eVQl9HT4HEsx+ZZYE2zwBOA4dzr5ZEOnYk
	 bjG+FEJHAf2lqPgLlaY9nJ/fuy7cBlhE3JqyomPq/pdWz2L0jX5kgLRILSvfLoKGyh
	 kKi6i8b7QhgqQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com, 
 nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com, 
 kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, srinivas.kandagatla@linaro.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
References: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v3 00/13] Tidy up ASoC VALUE control macros
Message-Id: <174111350895.235764.8799430713993803159.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 18:38:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 14:04:47 +0000, Charles Keepax wrote:
> Tidy up the ASoC control value macros. Fix some drivers that should be
> using core macros that aren't, combine the existing core macros to be
> a little more consistent in style, and update the core macros to use
> each other where possible.
> 
> Change since v2:
>  - Fix typo in SOC_DOUBLE_RANGE_TLV refactor
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[13/13] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers
        commit: 6db63090272768785e6bb4a3afa16650c1e96c54

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


