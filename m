Return-Path: <linux-kernel+bounces-250925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A192FEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46632813E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AB17624A;
	Fri, 12 Jul 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtXLypBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756F16F849
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802289; cv=none; b=MMSJ3KsaCP4mQUK+x1gfg3vFU+8VirX4eOw/8j560kLBBp78XAWcYLDsUUdJw+hiojSNQvZ/pF0YTbYnr6vJh5Kc28LueUwhmz9Srae2bYKquLUy7xKCqiKgl20YVJl3xibigYWsIM+6T4P4oraXBaZ3t4Q1L3MculyaqJMPisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802289; c=relaxed/simple;
	bh=NunoeZtgEB7m2qmzgxHSz4ZGe+euAKHwYFP/rBZ8Bx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kojaNj/I8K7eEb/mfxgp+GflCIQVjPBOh1PO4ctFZPuOqo99Aps+I1gXOyLnG/FYvCBS7fDKmU6w6Yx74Jsd4jwHuLhrU/fOZpEkLaHTtPUgvyu25O7gS+VcsmuJblfGEmceFeBRMyet5Xls5KKvUL7Pvp7/W/8igv2yW+W7Udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtXLypBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D4CC32782;
	Fri, 12 Jul 2024 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802289;
	bh=NunoeZtgEB7m2qmzgxHSz4ZGe+euAKHwYFP/rBZ8Bx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MtXLypByEcan+P5AnZxQYTNpl2+3Yc0BnHSWwPJ3+9eK/s19ti4VnG5qsp1dlPm5v
	 W8cAMvrQssfM1du1hi2nB4golZuQPsZ2bY8GBb+G8qFe2RA1IkQCxhVfQOOCb1Veym
	 2+f5WL8ywNk20zkoKyTfW25Bmqpv8vtfdSXpWZHibZUdZ1M1zBCVNx+GqcrrxPo//z
	 vl+Cio2m22hZvpoODBZFRroIndlXzq4F2uQlTdkQ5O346D9VwCoUofCVAJsAChZZa3
	 OoJ5WSjkZXZ0NZ3c1v+3cOGPj7dOwt2OlbpVg//oPDtSbH4nw6mo2xTUBIelOgO9oX
	 V3qwBJMQRxK6Q==
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
In-Reply-To: <20240710064238.1480-1-shenghao-ding@ti.com>
References: <20240710064238.1480-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v2] ASoc: tas2781: Add new Kontrol to set tas2563
 digital Volume
Message-Id: <172080228320.548034.2855852943661036499.b4-ty@kernel.org>
Date: Fri, 12 Jul 2024 17:38:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 10 Jul 2024 14:42:37 +0800, Shenghao Ding wrote:
> Requriment from customer to add new kcontrol to set tas2563 digital
> Volume
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Add new Kontrol to set tas2563 digital Volume
      commit: 75ed63a5ab5d1d2872c735bc7edf8fef0e2fa2ea

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


