Return-Path: <linux-kernel+bounces-520515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F4FA3AAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9FC3AE63C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6D2862AD;
	Tue, 18 Feb 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynb5WF9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAD2862A5;
	Tue, 18 Feb 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914219; cv=none; b=Y2w7FNrZC22L/Eff4cr4KaW2cV17wxrCfmKUvFa+z6BU/T4+/xo8Ie8e+gpdlnoOW+humnJ9x8ngz7UhreZTCE2u65ZzFkyGxHww0+AWSdJozOu9zoRWwACBx+0fu0Zt7cm+7chWQV17uUznxq5T1ZXiQypTdQnHB74mTmXK1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914219; c=relaxed/simple;
	bh=iugNd5aqwShQWPWcFsJiWz/STHgr3PfIz7/YAOGm5qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FqAnjNXMXL40F5+krpvpiSNRlEc15N9hbv5FH7CFom3cn2QkmYNj42qeOLMUYURcbmlqPZNFVzqbAP7yxKGoZC5XYXz2EHzzo99y+BqfKBRgs75U9CNi5vjoRG4FzG2rdbUkAJtwFyrnk84jQei0yPq8pZbrj7pv6hr9vntg4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynb5WF9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B3C4CEE2;
	Tue, 18 Feb 2025 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914218;
	bh=iugNd5aqwShQWPWcFsJiWz/STHgr3PfIz7/YAOGm5qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ynb5WF9Hiq1Ft0QF/6eM+Ek0mJRXnUxpfU2cINsFQTfyesCyOxJh652LXYTeFB4u/
	 f0wwseXMxCStQQWq2pa7HE03YSGIf2REOIJd4NnoNKOlyilv+0d9FOCdvYOpzH9a01
	 uo9HructJnsihzc2zJ23spLe+DnwP4I5U1K7TuzQ17k3H4Cokw3RZ+2cbfqz5QJzkQ
	 BViO8R9kbblsN9uShQPcVhrtN+sEGMj5dV9++RpN0euWY0qBEJ9cMP4VIjQq7Ls4Lx
	 URbgHg+suF0U301Oq0UAEnne4I3y3qGyQaCa60xxnAYerbd8apQk/J3IxS6+UitglQ
	 IX5jbNM3bihPA==
From: Mark Brown <broonie@kernel.org>
To: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <68973636-eab8-4d82-8359-ae2c8f60f261@stanley.mountain>
References: <cover.1739435600.git.dan.carpenter@linaro.org>
 <68973636-eab8-4d82-8359-ae2c8f60f261@stanley.mountain>
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in
 imx_parse_ioremap_memory()
Message-Id: <173991421399.1713371.18034640725263597167.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 21:30:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Mon, 17 Feb 2025 10:32:44 +0300, Dan Carpenter wrote:
> The devm_ioremap() function doesn't return error pointers, it returns
> NULL on error.  Update the checking to match.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in imx_parse_ioremap_memory()
      commit: b20be2c77ce5341ded1a2d8aec119f6dca8ef1ad
[2/2] ASoC: SOF: imx: Fix error code in probe()
      commit: a78f244a9150da0878a37a1b59fb0608b1ccfb9d

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


