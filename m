Return-Path: <linux-kernel+bounces-322104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F8972412
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68931F248B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65F189F2F;
	Mon,  9 Sep 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFbnoERZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5562582;
	Mon,  9 Sep 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915705; cv=none; b=DZTieJj8SDfUsByEhHuW64rvEXBjdBZ3dBIPwq6/yoPu91vOkevV4ZZDKZvbAplfG7cK8YV/XnjgVEHjqnGxbIFr9OT3HfVqMg8zb2uSknlg3FWkfXz06LRqqoLKnl1pUnmwOabmrzOc4+JFIuVDqg0Avnw+bBzYXTH1A8RCEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915705; c=relaxed/simple;
	bh=jxL+ub2/BNNjbnn0ZgajuJ4HTjl9JV3DFe99yHB85Js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RXMWvwf61vNnhwqqjlCacqZb9pnq/2zmX4hEQluDUubgLlSj3gbwNZvS7OgNgeVpp3QswvWwH+JIx9RZDNAVi/7uH942A+TRbyBT9oO//UyjQT4KCmijfCjJ5vj8A7vwD5QxxCSglSfAGKGBKPMVLJxWRpNIihD2nHjGT7Z3rAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFbnoERZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C7C4CEC5;
	Mon,  9 Sep 2024 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725915704;
	bh=jxL+ub2/BNNjbnn0ZgajuJ4HTjl9JV3DFe99yHB85Js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fFbnoERZ/JUbYGmIOJA65uYscqWs9uIsxE2v5WECHkkG/mReJe7MobdUcT2HoAu1d
	 baMdiRag0IGtw1vxr9XV4i1nQ7prQaoT8c/7FvISDOuqD6o0xvD76DhntReF7FQCfK
	 IF+orY7NOUOxq2yCxz5cxvuFbDdze2+hyXWf3/lgRYU8hQx8d1XjFBOLSFrGXFrbmn
	 XR6hCrsemJoefAdrzwUOpwinYSXrc1Nz/hwGGoUtv7J+hfek35BGcKq30GYov354Qo
	 jdTVgLYYpNxI9DTGDm1yIQwh6yEwOKPWIo1Nig1O/cesoWb1Z4fZahvKH8x3ZbEQZI
	 6GP21X28pplrA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240908134604.3652-1-tangbin@cmss.chinamobile.com>
References: <20240908134604.3652-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: codecs: fix the right check and simplify code
Message-Id: <172591570270.136248.14851761791754524473.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 22:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 08 Sep 2024 21:46:04 +0800, Tang Bin wrote:
> In the file drivers/base/platform.c, the return description of
> platform_get_irq is 'non-zero IRQ number on success, negative
> error number on failure.', so the check is wrong, fix it. And
> when get irq failed, the function platform_get_irq logs an error
> message.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fix the right check and simplify code
      commit: 130eb72d3cb38a629205a2a192800b4b1b9bc5c9

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


