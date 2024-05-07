Return-Path: <linux-kernel+bounces-170550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7718BD903
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9051C1C210D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FE79DF;
	Tue,  7 May 2024 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXUZg10z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D10523D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045748; cv=none; b=MF7AVYRB7yAeV8S2VnxH028bU1a/pyKrK/bhhEXTMw4A8F1YYclrZks44B4YMIOAqqjbSmHtGqfDlFcCQcb8OL9r4lZ1l2j5SxqLVSeha7S/bkfHjbfuoerK6zTitndityoQL2Zy5fRHeXFORsYX7eN+OM/zWeUnx410D1r6qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045748; c=relaxed/simple;
	bh=i4HnHQzydUh3clXw1HQgCDinqsGXvhs5w/dIG4yr6tM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GCDmg0h+zaPlIIvSKsxKVs1aHddYccW478YIk4GTihX9T/t/LLMxl5lFE/CzmD8+qbh2YHfB6jgMuJnxeTymp4BcnqOaX7r2QdG5g1vS7+6mNbFnXLpaJwuIAVdQd8EYK+EGh2s/aHK0rLHAulc173jT/VM1q1LvnGvvtZAkPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXUZg10z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE3C116B1;
	Tue,  7 May 2024 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715045747;
	bh=i4HnHQzydUh3clXw1HQgCDinqsGXvhs5w/dIG4yr6tM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EXUZg10znflx8/JeaPt/Hi9xIRMfdQA2o/GpPOvONurSvlt44sCjhhA7GBU6yH8TL
	 8X+ohJSZUJ7So0gvZS7u1BfjneYH/vnGx0+fJ0+y/nTnuNtCuqE9xC1mXzI79GL/qN
	 br/s0BOPUIxJemHLTER9inlh2hANLtzmh43e+CD9Jm/rGo0PM54tuLryVBbIxuuL2z
	 f446PXieb8lk+1iOc1lPNbrziKr8Ej6P++vNbDMdfxSKWnMCaiHkRoUZ9JAQOR9IJ6
	 RMoWfBSMz5EqCelzMufmSzPxxphU2m+RBaauHHd97v1JRto1dheAEpu0ewtROmNY4c
	 bW7XCUdN0pGfw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 liam.r.girdwood@intel.com, bard.liao@intel.com, 
 yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, 
 cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu, 
 Baojun.Xu@fpt.com
In-Reply-To: <20240505122346.1326-1-shenghao-ding@ti.com>
References: <20240505122346.1326-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v2] ASoC: tas2781: Fix a warning reported by robot
 kernel test
Message-Id: <171504574426.1980570.10154577788713612869.b4-ty@kernel.org>
Date: Tue, 07 May 2024 10:35:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 05 May 2024 20:23:45 +0800, Shenghao Ding wrote:
> Fix a warning reported by robot kernel test that 'fw_entry' in function
> 'tas2781_load_calibration' is used uninitialized with compiler
> sh4-linux-gcc (GCC) 13.2.0, an update of copyright and a correction of the
> comments.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix a warning reported by robot kernel test
      commit: 1ae14f3520b1a0ad144610a3f592c81a3e81cd1b

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


