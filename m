Return-Path: <linux-kernel+bounces-334098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80197D29B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED8286F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6513CA93;
	Fri, 20 Sep 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZhVAj8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5D824BD
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820543; cv=none; b=CRScFfsaXbvLFgU6Xo0ht+RiL6BuKANeMEx9QTgAn08ztCY154t/gZJvmWh6XZMbd718rEbDTSZvLyzzVSj1ELR0YzcnIKgBt3iS5yzM3+vmvtNV0nXy6e3xUUiKefE8U92zW+8+tjDWFFkhZRsrhh9oWyzXQ5KNeRzs1l46p9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820543; c=relaxed/simple;
	bh=60s4AnSUBYLnAs2LLbYv1rI0vTblMwEDXFJ/ddNuHsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k96D3L9okeCXDwS2bhtjaYBwYIABXhdr9h4hJr0/mXW1Ede6t/ynJxsrNGrMHs3cWVOBzKSJIjWl/6q3Qh6K03PJ8CRN41a08gg3g38mUc2XYUFPEkE2+77Y26JZhx8//LykaEX01esLQ+hgPABGS60e9G1pusP791mRPMXNvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZhVAj8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA277C4CEC3;
	Fri, 20 Sep 2024 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820543;
	bh=60s4AnSUBYLnAs2LLbYv1rI0vTblMwEDXFJ/ddNuHsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DZhVAj8BYAkmamADIlocvxwemPJwwhD4CyyP6ijpNvuHk7ZCF4vAW3FNq6rve53xy
	 bWYRfREFAZX7RguU1G5oYuRJgMKn1IeRmJpBGOfCqcQSMRqxZdFU2HCW2dG7J9wuXx
	 8jTcPK1yQe4bOXfts6S3nvZxxfrSoL2zTGoMeCyG7TOKLggQxUgtsEoq+yRktOHUlL
	 KILvqOdeTDCo2DtvohFVbQ1qNXohDmOOH1nILZGgyxi+NVHUf54YX7/M17p4+dOKhT
	 IqpNfzshK9tIDTAjY5Tehis49p1O3pdb2L2WuFGs5DTUBljEYkYzyyaxK9C3WSXfVG
	 wllctvsFelDdg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240919151654.197337-1-rriveram@opensource.cirrus.com>
References: <20240919151654.197337-1-rriveram@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id
 function data type
Message-Id: <172682054035.1859092.8371317736754373491.b4-ty@kernel.org>
Date: Fri, 20 Sep 2024 10:22:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 19 Sep 2024 15:16:52 +0000, Ricardo Rivera-Matos wrote:
> Changes cs35l45_get_clk_freq_id() function data type from unsigned int
> to int. This function is returns a positive index value if successful
> or a negative error code if unsuccessful.
> 
> Functionally there should be no difference as long as the unsigned int
> return is interpreted as an int, however it should be corrected for
> readability.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id function data type
      commit: 01e709aeaf913a4d0e04f9957d399cf6fc3b5455

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


