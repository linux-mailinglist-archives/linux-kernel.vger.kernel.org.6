Return-Path: <linux-kernel+bounces-517735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C5A384D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBDE16FCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208F21D3D3;
	Mon, 17 Feb 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSdQPm9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C321C9F7;
	Mon, 17 Feb 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799513; cv=none; b=iPQ6H6mmOZqY3x0Pp0tdUE86NjGL5jpyDJtvosT5VPbcIuWw35Kg6lCykHitp4lEQ/lwKwd+2Vv6ElaRC3/gelomrHD2rDVVXb5zkiZWP7bKP3ESXGASrw2WfznhkDt+TOYZ/INcejYCHnI5mQjUHuM253yHilHdI18TbeQcAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799513; c=relaxed/simple;
	bh=2w8pPQ0zq8k1Ozsjt8gIVTYmhZ8HLvWKbueiEqiLBDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=stzjayhdnz7orCPhCYurjPqn/bbz7/ZZomJz/EcQ/qt+joYE4Tm8uI1TIFUNEUI5peeVdX9Zo2MDWMBdhhZlF20URzgkBUL3wpdvBtpzbp3HXEylFYKmc6IVBlC7qkXkYNzQhBZU3bpifA4KK+aW3hpVFF7fgELA/6/tyXMsBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSdQPm9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D84C4CEE2;
	Mon, 17 Feb 2025 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799512;
	bh=2w8pPQ0zq8k1Ozsjt8gIVTYmhZ8HLvWKbueiEqiLBDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lSdQPm9OGT7/NXJPsLdst27FXd+m07r1p41LvlVZ6SKfZKpUWIg/ZxwEQucwo9wT7
	 3Wxpo1HHp0uj/1V+4FJ3O2/nMiyfoNgCUD2pEvyD+jp3u9LJFyPsZDimQ9nTydFdl8
	 ekfWv72obVh8XjVhV6H8F3DokaVNbBR41CNZJjxSrrKbrapurhfJb58g0kyAE3lWAg
	 y+y3OTxHljMmrYh4y6XrG+YNpi96H/WaHlX9mKM+mWWQnWyXvPlb752NcYUNZg+gqF
	 bjuyT7GvQDbyEO4yo5HrdZYnuaEVGuyFAA4yVzuyosv6FtMT/LDmYTQN/7AJBHoMDa
	 8IdJ5uQUxfYbg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210224453.363638-2-thorsten.blum@linux.dev>
References: <20250210224453.363638-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: SOF: ipc3: Use str_enabled_disabled() helper
 function
Message-Id: <173979951004.40079.6013987770041572128.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 13:38:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Feb 2025 23:44:54 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function. Remove unnecessary curly braces.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3: Use str_enabled_disabled() helper function
      commit: e0f421d73053eaeb441aa77054b75992705656c7

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


