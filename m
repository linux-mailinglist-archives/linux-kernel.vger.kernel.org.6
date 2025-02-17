Return-Path: <linux-kernel+bounces-517737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF121A384D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00BF16D4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849F21D5B6;
	Mon, 17 Feb 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/EGXLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4121CC6F;
	Mon, 17 Feb 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799518; cv=none; b=GIo6kMwZIziYCHMm+kfGwIa0UZ9CIXBJyfQ+8Qkd/WuQIgTZF7LS+Dzpi0cHcs2DB62bPQzH0gJmHNU1iF5DTmmkpr0ozqc9z/96sNPhtEUWTT8YnAReCyEGzrY9MVbZYpvmN+lA1Tvu7Xmfg5kYZCaTVzHtghl/0c8NSGIAJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799518; c=relaxed/simple;
	bh=bwCO4+Tx7gU9kUyzPdUYqi6Fd1HdmEggPCYdx85+U/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCq7akINQuHZ6j8ZxbQp26d7c0FdHkyScR1eXyI6maqWmGBNOTilZPAf5aGF22Nos3LgIAqyNFa6J1+sNNsYItHzqBcpLwazw74vPQidbK77n0li27fnerVSp3o5AMcx3Cjz8MSSJ4NfZ26m270gzk9mv8hb4nti+jG/DrVy7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/EGXLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD824C4CEED;
	Mon, 17 Feb 2025 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799517;
	bh=bwCO4+Tx7gU9kUyzPdUYqi6Fd1HdmEggPCYdx85+U/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qk/EGXLn7F902xvWDvKE6FwxOw1KzFO7iVEOae3RtqfftpqjaCM+oGHOtXYCahIA0
	 HDYspxq0acnsHBfPShS7EOaY7oek69wGYZztg9yZyptrDdDRYa+kXFaQmlmC1Qcsmq
	 aJA5iHPNEqqcKOGrFJyrPY1p6Wcv1XBHsSxRTiB4FjjEasSxyL2j47qNabdlgAhEFK
	 3cjW4d6oiOwWPMG9TUNjIwfOzNbdnLcC2HMRYMGNw8emFvWPgsQbxA/MnpXajR7Z8k
	 mkjVwgvxbRkd77NtMRnA/J6PkCupdDxImbvU8RhY+auuHfokPmMNMoUCV/9nfEsXIA
	 ekJbjVthZPZlQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rander Wang <rander.wang@intel.com>, Fred Oh <fred.oh@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210120132.53831-2-thorsten.blum@linux.dev>
References: <20250210120132.53831-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: SOF: Intel: Use str_enable_disable() helper
Message-Id: <173979951452.40079.1050416586788749768.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 13:38:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Feb 2025 13:01:30 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enable_disable() helper
> function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Use str_enable_disable() helper
      commit: e08fe24c34d37d00e84009f2fb4c35f5978041e6

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


