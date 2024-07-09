Return-Path: <linux-kernel+bounces-246720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1AE92C5B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA89EB21AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAB18786B;
	Tue,  9 Jul 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVk2dDCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954B18562D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561840; cv=none; b=ZPiBNL85hkZ51Ky3ggvwdxN0oTumO1c1Irtf94MvgOkuf4nsg7F8Jusn3Dj5Jcc3iarPmwZmMnueobVZDBZ9rnsh3wDqXv0ptUU4/GtLP7OcvHgx4IDOzuckgtOSq1xgX0/dQ2rl0edjMdhZUvQFJN/Ch9ZNQhIDHVssLS2iNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561840; c=relaxed/simple;
	bh=FFuhkeWpCgZmxUgtB/VSGlDy6rMj4px88cAsiQEvKrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ceQxgNVZgulL7wgFPqa2WWr+5WlqmdM55wV4I/gEC7ju6l2J+Nkled7U1JzZM196hDJT22mmKt5GLyUlV9JJ9Oh9GjXN107v8nHjdEEWFP7sXoWeEICsvx5CLFRCEBQrV0lSsXgxePTgCfH9wm41QMrPaOPvcAQnIi4GP498+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVk2dDCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EECC32786;
	Tue,  9 Jul 2024 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561839;
	bh=FFuhkeWpCgZmxUgtB/VSGlDy6rMj4px88cAsiQEvKrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cVk2dDCg9odvvweY/X54U4rpNNccWk7MzFezF+6qTU0T/3ZqhEXrcrvaQSX9Z3mHI
	 /fExsFcIA6J8cC5GbjWtCjPOKw8HBInjGAb9rKgZ0AajDxBcFWrvUnwUOFFEewlDej
	 Znbv6rS8MnVAo82uaJvgkxSX+FlAf5xxJuPf3dcITO3qlpAPUaUJrWsRiwmumwmxaL
	 2iLt5sw+0U6noWDH3480zhL8DC4MRcicfRNlFOaGngb8ADU3bD9u2TsMRYxeY409nH
	 1N+DFeHlckjFWOJG4BfaXIFjV+wewsElG0DzFouDPC7wo+fuPl1DUhEU70DhXJCdJO
	 PJG5iV7hSK+yw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com, 
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com, 
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com, 
 yuhsuan@google.com, henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, 
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com, 
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com, 
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com, 
 darren.ye@mediatek.com
In-Reply-To: <20240709043342.946-1-shenghao-ding@ti.com>
References: <20240709043342.946-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: TAS2781: rename the tas2781_reset as
 tasdevice_reset
Message-Id: <172056183406.72205.2485192359283053968.b4-ty@kernel.org>
Date: Tue, 09 Jul 2024 22:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 09 Jul 2024 12:33:40 +0800, Shenghao Ding wrote:
> Rename the tas2781_reset as tasdevice_reset in case of misunderstanding.
> RESET register for both tas2563 and tas2781 is same and the use of reset
> pin is also same.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: TAS2781: rename the tas2781_reset as tasdevice_reset
      commit: be5db7581f59621ed9cb9cbf6bebccda38263eb5

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


