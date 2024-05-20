Return-Path: <linux-kernel+bounces-184111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E742A8CA2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB781F22018
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0169139568;
	Mon, 20 May 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnd9u+8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B46137C58
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233228; cv=none; b=LFLo6/StiVNZOvOcRzpBXExQ3lxiHn10yWMBVsKZqMqzNPPoIZeaFKiQWH/w0MYFT09U4kFR5HfVXhmCYyBYuS0h2w6+YFC9AJZHkWGm0nk+XJKc9kbfTloPAm+0RYSrZ/nE1cTtoLgRQeETETsEI9GAPQUxItRtisBaez5nQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233228; c=relaxed/simple;
	bh=heBPNyLYMv8R6LBJX6UZFrWUSwJLJR/VKe8VcBYMUcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hWNfdzCTfeUhPEJB9V7a5Y+e8td/Wv0HpYSZ5Pb4DZbDYk83nfUdyNW6NVAA9yulHsHoGp6fwAceke1g1WrDHRLmxw+93V5vVbvd5hrYEQ3E6IW2QqJhTj1Pgq4J+v3fxmGbNGm+xxczH67XLReS7k3YiV+xyBmDY4LL/6n+EQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnd9u+8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783CC32789;
	Mon, 20 May 2024 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233227;
	bh=heBPNyLYMv8R6LBJX6UZFrWUSwJLJR/VKe8VcBYMUcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mnd9u+8X4gLHHC/bHqUgzkQRfAcDGrKZRYYz7dyB8mD+yGPsmsrXkT8ZUGngI3jvo
	 hrWWzCAuvOexV30seGB1LAuEyQDED85cKXG1Zzk1zQ6fz04kQOujB2MfamY/QHOkq4
	 QnVnOLmAbtHu/FvQ4ZWqg0WdSRVmh1pPb4HuOdxpTwn0X2bG4YPnqJxGZrt1ex1pZa
	 DGW/oyElu1CIXZNCnvfxKgTofarjCjNZKUbeRfvvE09wddYCcHOL99XS3PpDN0XNAb
	 wE5M0MxPTkOqpjocO0eBc9uvVpP2cTbj2CmVm/bkb1Fe4CEhoVcXCVp2k6qs7HO3qy
	 a5y8PSOckcuHg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 liam.r.girdwood@intel.com, bard.liao@intel.com, 
 yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, 
 cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu, 
 Baojun.Xu@fpt.com
In-Reply-To: <20240518141546.1742-1-shenghao-ding@ti.com>
References: <20240518141546.1742-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v6] ASoC: tas2781: Fix wrong loading calibrated data
 sequence
Message-Id: <171623322336.94469.13172149100331733795.b4-ty@kernel.org>
Date: Mon, 20 May 2024 20:27:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Sat, 18 May 2024 22:15:46 +0800, Shenghao Ding wrote:
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params. Remove declaration of unused API
> which load calibrated data in wrong sequence, changed the copyright year
> and correct file name in license
> header.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix wrong loading calibrated data sequence
      commit: b195acf5266d2dee4067f89345c3e6b88d925311

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


