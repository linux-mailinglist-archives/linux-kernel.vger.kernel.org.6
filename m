Return-Path: <linux-kernel+bounces-236689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD9F91E5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE0D1C211EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAAB16E887;
	Mon,  1 Jul 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH8fNkUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020C16DED9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852641; cv=none; b=EqHwmyMITSBnnvbQ0XrX26bn8v6Y7TCyAhy6IZJK67LiDoosWRvMppRdbaOe7g0ptNDUd1ZoyilhmUOHCUfrC8U91D62edi+aJ85XxFZiBouIYQJ88TcMJhx525+V9vFHyP0KfMUXGgVYMPs+538L4Ytsq3FGuXzsIkgWz3/JCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852641; c=relaxed/simple;
	bh=Jr6KxU1uZSc1WvMCd1WtXZr02Xg+bpz2196Ms0qOUr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f3CfTdanYurpVUKgYYiNCBjMhAddUwwQm+4Lh/Y3aDKuc+2EoM+TBRMcgsf71S+oIGYhzHarx/5ngsv5UfA4uju0nQzdi10uLdbRE/4Z7GZmA23rAH/YAPiYRYKz0P1yFe+x8zCfxlYMEiCOTf5/+TYTUuJUoAAMDAN5F2nBz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH8fNkUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF1C116B1;
	Mon,  1 Jul 2024 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852641;
	bh=Jr6KxU1uZSc1WvMCd1WtXZr02Xg+bpz2196Ms0qOUr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mH8fNkUuawcN6VckXgd3GICxQdsjwe6qhkZbESxaJ/XXKCXSs0xDHv/8K3u2qVqXz
	 mpvH64N2c3R3qC9Xyx5DRKcyXEhooySpgTOecLE9EnDKxY+lQ03AVO3UM7aXMIzzsC
	 KRJVJeidw0nVxDB0mMsSIlO323DJKwnJtrUtRAFub2Un5RVRjC9nIYBe+xWLPuxPI1
	 1d51HOqRynUj5ipX5Wj8LwOQ4ttZMmznESRdvrmJyhECfcw9e4ogRaTlVhS37Xs/Ys
	 MTAXxX/JbqT9oDNlXEfVXhOQxBgzE4nZbl4CwvhpTIb05Wkiu9yoMoJ3Ldbkfo3ca2
	 +d/JzFfqSfc7g==
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
In-Reply-To: <20240629101112.628-1-shenghao-ding@ti.com>
References: <20240629101112.628-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the prefix name
 of DSP firmwares and calibrated data files
Message-Id: <171985263533.96334.14332115494301599710.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 17:50:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sat, 29 Jun 2024 18:11:10 +0800, Shenghao Ding wrote:
> Add name_prefix as the prefix name of DSP firmwares
> and calibrated data files which stored speaker
> calibrated impedance.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Add name_prefix as the prefix name of DSP firmwares and calibrated data files
      commit: 55f0a1fa6ea4e339c797e9a3292ca0caa4ab3885

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


