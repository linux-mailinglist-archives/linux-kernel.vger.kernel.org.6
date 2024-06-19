Return-Path: <linux-kernel+bounces-220892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DA90E8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7B81C22A69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FD132112;
	Wed, 19 Jun 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD0Kheyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DE4D8B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794462; cv=none; b=sM87jeTEFfMNjjI0d+nBUmasPDJrv2r8oNtRsQjWsKFl8V68H7OUYT0oIkKFkbdykjYVmwEP0BiGsfwe7WM/0Ohd+/PEYWzK2BC9d2MkZyGF9SVIIn/mbJfLZpupqOqpsI8XEjt6gNgjeiTjiergk0jbkVGJGthhGROAaMuBRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794462; c=relaxed/simple;
	bh=WLiVIcEsI1MsoU/pGfWwCO4FNjNshUkTXjY2D+QEGRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MUDdQyVsZo0x8Enb0eXdQFWWasBe2yFL6dFBeSKKfPlwGNGRAMFNKqwu6Z5yG6JzJLpsl8N5xZq+I3G8XXmJRg18mV1iU325rKuyDTENuSOkO3nLh1stiPpYglx3SDubsOQdnVa49V56t008g2EJ6B3e4E882p1MDqOz/+ZVsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD0Kheyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE351C32786;
	Wed, 19 Jun 2024 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718794462;
	bh=WLiVIcEsI1MsoU/pGfWwCO4FNjNshUkTXjY2D+QEGRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SD0Kheyq2Me0xq6d66yqChXOJfd5Vn5tqqefdyQ8dtLeW4BOCOYAtZHq9kFFZCo9f
	 i8/+9sgsGnbEPY8J8DZaXK6L4n7/3nxPARNhHsNiLpjwCF89PCX6/8FNwpeZZMop47
	 yv/GA0bEJWjoetNtQ6E+b/I2hOQyhUMNau151eh0dmnLBAWQAwk3rzhIM5asYHkPWI
	 2wcvWePLpRzAHOqFG5Jo3AMvvfkIkp9ZRETOF26vP9beWWZKFPrg7Y/B6d+B1QnNDM
	 2poWtcuRdm4I/VUdIAMosBQ/4ZMYjcixUvhVydks58D8FztUSYWXCG3dlrUi+eXup7
	 ZGToiwKURDdrg==
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
In-Reply-To: <20240614133646.910-1-shenghao-ding@ti.com>
References: <20240614133646.910-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v5] ASoc: tas2781: Enable RCA-based playback without
 DSP firmware download
Message-Id: <171879445548.57943.2834143802060399469.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 11:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 14 Jun 2024 21:36:45 +0800, Shenghao Ding wrote:
> In only loading RCA (Reconfigurable Architecture) binary case, no DSP
> program will be working inside tas2563/tas2781, that is dsp-bypass mode,
> do not support speaker protection, or audio acoustic algorithms in this
> mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Enable RCA-based playback without DSP firmware download
      commit: 9f774c757e3fb2ac32dc4377e8f21f3364a8df81

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


