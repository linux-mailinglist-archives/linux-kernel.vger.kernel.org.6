Return-Path: <linux-kernel+bounces-402515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3519C2893
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A41C23A24
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58C4A07;
	Sat,  9 Nov 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5WhxXgu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363E2F5E;
	Sat,  9 Nov 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110708; cv=none; b=SJI50JHOfsnirLfPzIRirG8/tXkkdGx8ofYHw07C087XtpWVIpfpXc6EPdyMBDXdA8UMIYYIyUypwMF2rrp/oXU5XsaX86J1l4rsYoM+Uvcit3pu80AM4cG97X/IJKf11PCoOJK9AyhAHhqcVVS1CsJ+jpgyGxfEH8evUkGkd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110708; c=relaxed/simple;
	bh=7j8VtJ4gjtJ4b92tHiQE8ipEQ76bvrHUL0Jy8Mdih+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dq+KzRI638SLNciC+aPAH3rzjLVW4J4HxEUl5uZIrNHdaAdYnm5gnxFkhZnG4q6S/+KdNrL9opUD91BaYstr/KDVw68IVHuCWnzm2D4gmRvfNx2SbKxJRxrrhJ47y7CadDWZ4SY9DZqdHJlH4aPd6GfidykGdbNTEbTWUn/B8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5WhxXgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF8BC4CECE;
	Sat,  9 Nov 2024 00:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731110708;
	bh=7j8VtJ4gjtJ4b92tHiQE8ipEQ76bvrHUL0Jy8Mdih+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X5WhxXguPWoxCgYvXXuW0Q/mJ3eRvhCHCj14z1rwQRDmJNuXTEtyKNLpRD+CvDI0H
	 C84Ni/YjHG8FLsqESYox1sBzRisRgBMavDSdZH2j4Be/GJvekKgH2bbsZfUUlDvZuG
	 ACSij+TteLqA4Vx0m6bqCLV7hx/n/6Z5U8+5Zx4rVbjeuRmHR1ZMR5LJoY4am0NuTe
	 z9K718Fkd+xy6+Z0CqBAvhrNDZ0J1+BqtP1RGCug4PBvYc4bUZdvs5KJxuIzjae92z
	 FgmWi9NiglkiWAWvvi7K1oUGti/jM/pudwDyxVTgxRF0EqBN4FmSqgY56WRx34wzbr
	 EaYAcw9Z4CWpg==
From: Mark Brown <broonie@kernel.org>
To: kiseok.jo@irondevice.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241108011617.2284-1-tangbin@cmss.chinamobile.com>
References: <20241108011617.2284-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: sma1307: Fix invalid logical judgement
Message-Id: <173111070657.137066.4136445041221456128.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 00:05:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 08 Nov 2024 09:16:17 +0800, Tang Bin wrote:
> In the function sma1307_dai_hw_params_amp, the variable
> 'ret' has not been assigned a value, so the logical judgement
> is invalid, thus fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sma1307: Fix invalid logical judgement
      commit: 08aa540a196a672b8597fb611e2dc25e42986bd9

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


