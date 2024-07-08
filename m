Return-Path: <linux-kernel+bounces-244447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC292A459
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A328230B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696F13B2A4;
	Mon,  8 Jul 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkhvNsxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC245139568
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447969; cv=none; b=VUFz2LxVLsNEgZQ38UTKVsbEM1l9ohgKGevV95CSvd800JFCTIm/wtQ28AbtBSrMI5SQ7wVILy+B5GPtCNAvwhCSvH1m+PJgEb1PKvJ2iTT9zTApdIyVy2g5yZWQ7lAxMf0/Yz7aO9PeXZ6UyasxL+yiOYpj/IEOCmWRCsG8y80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447969; c=relaxed/simple;
	bh=UAONCeebsplpzb6v0IQ6ozOfZrmocNxAZ6+xro42huM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mt+XP4TLgp7zc4ju4mgSeHipEBWEGKe/vrMnFrfqABKya5yDUsueuj95iZaubFhq/tgAy0JfVye0HWqICskqPCCqK2M6Brpfhy8W1u///IEFGGaxHP9XUiZxL0LRgfnz2xFyt9RrY3J7yEfQsY2s/KjjvfxiYUibuqG9fgx2HMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkhvNsxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60C7C116B1;
	Mon,  8 Jul 2024 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720447968;
	bh=UAONCeebsplpzb6v0IQ6ozOfZrmocNxAZ6+xro42huM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EkhvNsxtuY9YHFkT725PDuEZLyDf0TPGKwH05guyoF3C+nYy9nCISQnstDs4ixYcX
	 3E3S1nMjZYSE2AOBj3+vqFQROhWaK5VR0PxdpV42vOYdeYCHyr6OJnGIAQHfNQwCAb
	 II1g/sG3lrj1tN3hrD7awJO3fEWZBAc52edXSNptMYfnRTRHOmHQ4Nkxj+LlFQW2tN
	 ot3WKM7B5+L0IjDj9YU6g/ZoV0R7Icf8ZzY+tdCIHW3m32XwjXflqOFKUPDnja+Mg0
	 fVtNaBhhhpol+0GC1BvNXE/IUYCaKd87yVjKxI0wjtcua9vhqrcsh/3tmehRUp0G5r
	 6Il4FwtqWjEVw==
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
In-Reply-To: <20240707083011.98-1-shenghao-ding@ti.com>
References: <20240707083011.98-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: TAS2781: replace beXX_to_cpup with
 get_unaligned_beXX for potentially broken alignment
Message-Id: <172044796258.45994.10321780261934158542.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 15:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 07 Jul 2024 16:30:07 +0800, Shenghao Ding wrote:
> Use get_unaligned_be16 instead of be16_to_cpup and get_unaligned_be32
> instead of be32_to_cpup for potentially broken alignment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: TAS2781: replace beXX_to_cpup with get_unaligned_beXX for potentially broken alignment
      commit: 1cc509edbe23b61e8c245611bd15d88edb635a38

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


