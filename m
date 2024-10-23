Return-Path: <linux-kernel+bounces-378547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02FC9AD21C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E024B246C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60F1CBE8C;
	Wed, 23 Oct 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsEi+qTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBD5D8F0;
	Wed, 23 Oct 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703258; cv=none; b=IXmxV34D4FgmGdxDaICFKmR0pKsvlFdnsAUps+/BkQl1D8sU7jhqIxNFf4UzK5E0e5CookvlHjFcI5QOg/3KELYmDb9xfUx7s0HgZmdClx7lxonKLBEGpBVzoJCbXNDzMWcLdoGcAOXyoWsxVRbZSB450Zn7EAZxW05vaUBmLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703258; c=relaxed/simple;
	bh=pCakaD5ysHmugViv0AHD1Y1Y2ECUCJOpD8zllBC8d2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j87IAFUDck6eeWGk7d06qOnQ9ccbxYA4UKjLA/uZ67Z77SHZh6QCgeb5dzaqm77mWdy1+YsQyuDjWyiriyhowDM29ulsfSbF5I0p6x8/B5FJnD7VTR0BMACwPoGtrYVFhaV/v/T4oYuYG/ZrmsRD2B/WZxqCInukxsw2e6GQS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsEi+qTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD51C4CEC7;
	Wed, 23 Oct 2024 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729703257;
	bh=pCakaD5ysHmugViv0AHD1Y1Y2ECUCJOpD8zllBC8d2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AsEi+qTJUGYvwjstEZlIsgu/9Q51yaNf3BEZDqgye4Ey0SQjG7Cjnz0WzMjyrGplA
	 yI0TI7wtzhqnBfQJ8tu3X3BkopiRr9pbN4SuqioPjrqcEg189kug95mv9qMz2LQlqQ
	 hHYpClt0w0JmRQ0kc5avRliXQ3qnFomXqPeO1HvBwKw227/fHadP2tz3U+6LnVIO0A
	 eJ4/YEFqN6rXyo5RCWWba1rQmsbeu6zQsIYvXeORuwJboJjNqrrkEcHXd1FtQPpcUV
	 E79XQVftmYie/Vk+E0EsIw3uI1Q8XDFBziullbrnITKMLvzCIJugW7+LpWD66XR3qY
	 LBdmBHXDSgccQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Igor Prusov <ivprusov@salutedevices.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
 error27@gmail.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20241023144421.1720234-1-harshit.m.mogalapalli@oracle.com>
References: <20241023144421.1720234-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] ASoC: codecs: fix error code in
 ntp8835_i2c_probe()
Message-Id: <172970325510.86642.1481020060843547661.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 18:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 23 Oct 2024 07:44:11 -0700, Harshit Mogalapalli wrote:
> When reset_control_deassert() fails it returns valid error codes stored
> in return, pass that to dev_err_probe() instead of
> PTR_ERR(ntp8835->reset).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fix error code in ntp8835_i2c_probe()
      commit: 9c2e48ee9aa64f609709eeb120cf728d66d4a145

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


