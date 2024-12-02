Return-Path: <linux-kernel+bounces-428198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA29E0B51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9C7282A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DCB1DE3AF;
	Mon,  2 Dec 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9myYdIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFA1DE2AD;
	Mon,  2 Dec 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165470; cv=none; b=uGYrUwxG9F3xb4raW2EFgOdqh1E1+UJH76UFAYqlo3yFjvKVbdVsFm3kYipDPoYM6WCotOaz3EeR8p86O7CIcLD+LXcyfN9uAg0MKgNRsU2Z2rfyp770cprIiOx1ybm5xJW9iKv6jxsw4GB/2wldJlR7Vsv0JyCht66ibNMwIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165470; c=relaxed/simple;
	bh=idmCVNF8okDf2CsW+WI2oYEXGIaaGzWX5USrzU8qlYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AbGMfTMPayRkXMtICQ8MS1S6cMIrm7jtTzEZwCSgS45ignu/VCAyhD0QPukw5YWJpYatmOW4hAqgxsD2mhBvgkOS4gwOjMCklX9KGpPNdOtXNiuYNg5LxBUOjbC+wO7pNHNWXqN2zfdkchVOo3YmWoMzrOTgeIcTa/vhWKpHwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9myYdIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE97FC4CED1;
	Mon,  2 Dec 2024 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733165469;
	bh=idmCVNF8okDf2CsW+WI2oYEXGIaaGzWX5USrzU8qlYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L9myYdIgq0emhBlqT/BklvyEBOTJ/Zp7+otY0YHCJvtmJqX/L3eyObvamHKuhVbZD
	 EO8lTP33PuJGvCeMikW8skmOrA97Ob9StxU3e0QZcENfwQHHPGtzKUxeok9rz2olNl
	 RcZyRlGCUxaiZ5FTRfvOkxsiJVH00wm6F+8TS5kTEBsIACT/hUkPQs5zxHcIyv8VSN
	 hLdDV8bFcWt2yJZGMegqCQ2UhaHy6yM3oakWfUEV0vkklx60ws0jKTFlaYNDUBCTje
	 ewoy5/qdycbzrSxEhEIqCmCCGplvjakCFGQzMqa8fF+djNjR9wWEK6rwxScBqLiK0d
	 6THVIBN0KreGg==
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <67d185cf-d139-4f8c-970a-dbf0542246a8@stanley.mountain>
References: <67d185cf-d139-4f8c-970a-dbf0542246a8@stanley.mountain>
Subject: Re: [PATCH] ASoC: SOF: ipc3-topology: fix resource leaks in
 sof_ipc3_widget_setup_comp_dai()
Message-Id: <173316546535.198929.8706974535147335807.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 18:51:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 30 Nov 2024 13:09:06 +0300, Dan Carpenter wrote:
> These error paths should free comp_dai before returning.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-topology: fix resource leaks in sof_ipc3_widget_setup_comp_dai()
      commit: 6d544ea21d367cbd9746ae882e67a839391a6594

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


