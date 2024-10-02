Return-Path: <linux-kernel+bounces-348034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C498E1B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376B7B22D68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF521D1E70;
	Wed,  2 Oct 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkvuwkyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1661D175E;
	Wed,  2 Oct 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890680; cv=none; b=NNDLDq63DQ7DhFxCIQ+15U0Ni6wbraNU4dlzwKbIOqzw7tR7nS4jLZM/PIJG6mN7N2lfNtyW/M0Lwj3cZpbUNByvdNDDlsZOxjZnlWN48729yLkG98Rl7YQ70sgp+nODFhNeyEJ3ounCPU08R1DVWb4XBZCQBZ7srdmTDLDeco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890680; c=relaxed/simple;
	bh=PJvobQ+6pW0tnPhodEWxo0BjiswVOyCa1be3irMLxL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dS8V6XsA5uxFgF03Cp4Euo5+FLsn6BaybRgiOwl7zOiD3zj4Fhbtpbv0PVrQsDozs5JT9DqbJAc3l+W8nQUA2kPCJLwuCDUYuAnaEfM0mPtsxXz1D1ExYLm4MibEsgHfErUc4qFtjVRulU/428phEtYOk0ND6QHw4Ao5SIYPiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkvuwkyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A4C4CEC2;
	Wed,  2 Oct 2024 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727890680;
	bh=PJvobQ+6pW0tnPhodEWxo0BjiswVOyCa1be3irMLxL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pkvuwkyBuJCFd8uQgXhuDSGlSZeYSm4GGo5umjQNRtfiAg1ZEHX0whAaHOsbGy5SD
	 oXyXhwOGa6yD2y2cY6mujNlr9c8Xyhcm/HjDsIkzjU4zAB3Ck45flLbtBPwrgIhXJk
	 19Wz6Z9sdgm778Zf6jRyn2Br9MXPtgYOMcp5zYs53LnKwib/Nj0KTMkaylpQoyh76U
	 K+eKP/qxW3hLARWchVORnObHdQYYgmbG5OeKLlFf9bG/sr1QyT8vl6DZJtxnY+BdoX
	 vPbCiXstkzYNx8jT1QolStK3bKpmzsIy5+uxgcAqK5ST4KHrNp7nLOC4SUZzR3BuAF
	 RI3vt4WSHqFQA==
From: Mark Brown <broonie@kernel.org>
To: yung-chuan.liao@linux.intel.com, ckeepax@opensource.cirrus.com, 
 Charles Han <hanchunchao@inspur.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, 
 peter.ujfalusi@linux.intel.com, tiwai@suse.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20240925080030.11262-1-hanchunchao@inspur.com>
References: <20240925080030.11262-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] ASoC: intel: sof_sdw: Add check devm_kasprintf()
 returned value
Message-Id: <172789067806.163279.17671589406788007022.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 18:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8

On Wed, 25 Sep 2024 16:00:30 +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value is not checked.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: sof_sdw: Add check devm_kasprintf() returned value
      commit: 2c0b2b484b164072ba6cf52af1bde85158fc75d4

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


