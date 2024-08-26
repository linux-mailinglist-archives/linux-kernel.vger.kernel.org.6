Return-Path: <linux-kernel+bounces-302339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F195FCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8A1C210AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7419D07B;
	Mon, 26 Aug 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryhTXtJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F119AA4E;
	Mon, 26 Aug 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711828; cv=none; b=fjrNPOS3BeuxWwqQh7Zi6GmhVR5zj0fAbWozKRwEMdsMBrS8y8zQHUhXarIpw/FsuAI0xStrJPZ1AnaReEs2/SEf9czuYAn9PyuQLzJBwkbwBRstm5HCzzF6y182INMzl3zClD/BqUecSiIwf4FqbGVIGaYB0aKqf47lNNXF934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711828; c=relaxed/simple;
	bh=M0Ntd6s913U5SOeV1TIdFxvvzwDT79BkVPTJjzmt8gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PDOhvmeNZVNqNl7Z16KcymUr995bWwM6GAWyH7MnY6ddIvv2Nf7gPsMtSIYRytJcILXuwZd1Al5l/ITpj7LLybTaEZa2ZnfzbT73YG5kZ7ktpMmStAX7KhKock7QiOzA9YP6AzgscpzFk99f/zQnazhmM5nnI7rFQKdUW+8lBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryhTXtJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B3CC8B7DE;
	Mon, 26 Aug 2024 22:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711828;
	bh=M0Ntd6s913U5SOeV1TIdFxvvzwDT79BkVPTJjzmt8gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ryhTXtJXPh3dqovOWwDUQ1RYohxer3IcchVGxS7K9Z24kWywHCbddiVSR25zMIwuC
	 wUHlaOoaXrsxe/eqWry5jFM6fiEDdadcnWWbnY81/iCBXunS0WK3ZpmRLA3yfciHY/
	 5uHCsp+hG7Xb0lgF4Ax6+EbH2m1NCvfc6eqvKqdiwKf13bdavU26I2nZkALXs5QIdP
	 /UR5KVmddJA6im3LdaoFA63yeIIhaGe80QU05z5QR30FjppaKFxf/dBumwoU9L7zXe
	 omX/B5t1+rDVeHQlnucrhRTUwYQgRqctNeOZovukVVuG5wtuOkusQKmQE8akVj9fLN
	 nAAAVYPnhgfSQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, Liao Chen <liaochen4@huawei.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, 
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com, 
 u.kleine-koenig@pengutronix.de, andy.shevchenko@gmail.com, 
 kuninori.morimoto.gx@renesas.com, robh@kernel.org
In-Reply-To: <20240826084924.368387-1-liaochen4@huawei.com>
References: <20240826084924.368387-1-liaochen4@huawei.com>
Subject: Re: [PATCH -next 0/4] ASoC: fix module autoloading
Message-Id: <172471182196.865478.11843966952043605315.b4-ty@kernel.org>
Date: Mon, 26 Aug 2024 23:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 08:49:20 +0000, Liao Chen wrote:
> This patchset aims to enable autoloading of some use modules.
> By registering MDT, the kernel is allowed to automatically bind
> modules to devices that match the specified compatible strings.
> 
> Liao Chen (4):
>   ASoC: intel: fix module autoloading
>   ASoC: google: fix module autoloading
>   ASoC: tda7419: fix module autoloading
>   ASoC: fix module autoloading
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: intel: fix module autoloading
      commit: ae61a3391088d29aa8605c9f2db84295ab993a49
[2/4] ASoC: google: fix module autoloading
      commit: 8e1bb4a41aa78d6105e59186af3dcd545fc66e70
[3/4] ASoC: tda7419: fix module autoloading
      commit: 934b44589da9aa300201a00fe139c5c54f421563
[4/4] ASoC: fix module autoloading
      commit: 1165e70a4a5d8b4da77002ac22b4c5397f30e00d

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


