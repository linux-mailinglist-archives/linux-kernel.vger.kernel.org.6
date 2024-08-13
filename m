Return-Path: <linux-kernel+bounces-285311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F5950BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55791F23436
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519C19939E;
	Tue, 13 Aug 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWHdjH7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BB37E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572308; cv=none; b=b7apcUiXRxzYDWaoteIdKv4QjNd1p2GILYWMJsf2LUFrev9/7WPl7Pu5mWQtobEj2nSPE6wjxEXeMMOFfWUdf8EUfrjCIbncR1l5PLa7Vzsny4GBLquN0ToQ3cImquTtO66U6ya1f2MCRD+vOhTQXOdgagUnqOFeMg9WDxUwEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572308; c=relaxed/simple;
	bh=0UEfAv9+1SbiMWXNtyuI/ht+6xm8Fy5X8SsF38SjSNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dN99xkDUbBNSOOM0gZ16LJmPJhu+OwrLllvlDUD6QftgS58McHsfCvXm1vqjic+nCDZntShR9KQBQ4wDA8ubq4i2mILfbkkGqWCG0VA1gcyRGgOTlmg/O/kPbubIo2bvMYOu6N+7v3xiso/HUY/BWyt3IAjkFARSzyAkbZMzeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWHdjH7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C8C32782;
	Tue, 13 Aug 2024 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723572307;
	bh=0UEfAv9+1SbiMWXNtyuI/ht+6xm8Fy5X8SsF38SjSNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pWHdjH7bOkmik3oMvejfMNLARQHHZ+DeUcQ+clChzsx35av0+O2VJ+2XlXNgiryZK
	 kyXzBMVDemGzmYqMt4r39JfnE7AhjraWulZcQzyPI3gfMliZTOasqC957NvHdyuDn9
	 tWv2sDRTFlnn8zeMK9OybNu78qlCRQ/+tTHObIOiZX+d8Ls/FDHVyZJvgh5zj52hmD
	 fzYPxc/Smt/FwqLpAbxnuYtQr20KIBKqnjrd6EQ+TKueqFd142wJKX9GcUgYpjRLyn
	 HPW9kJdWkhUJczq+Bf7kP45S3AvI5V1N+072AcynHfViy9z53L753e3ddJGARKmYRO
	 NWSfhr7Rnk7Dg==
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
 darren.ye@mediatek.com, antheas.dk@gmail.com, 
 Jerry2.Huang@lcfuturecenter.com
In-Reply-To: <20240811135144.178-1-shenghao-ding@ti.com>
References: <20240811135144.178-1-shenghao-ding@ti.com>
Subject: Re: [RESEND PATCH] ASoc: tas2781: Rename dai_driver name to unify
 the name between TAS2563 and TAS2781
Message-Id: <172357230176.112551.2907822029740578323.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 19:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sun, 11 Aug 2024 21:51:41 +0800, Shenghao Ding wrote:
> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Rename dai_driver name to unify the name between TAS2563 and TAS2781
      commit: 8f712c12f34daaaa2e47ba07cf3b348d3a442986

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


