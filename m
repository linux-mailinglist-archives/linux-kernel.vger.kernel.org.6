Return-Path: <linux-kernel+bounces-239588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C919262DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB202B28566
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB117BB1E;
	Wed,  3 Jul 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pozSQlOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9917B51A;
	Wed,  3 Jul 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015632; cv=none; b=ueAIuVudK8DTBXjwsOTFlrw0TpIXFL2lBqis6uc9P4U8Ud8SR2tgXsbK3f3zKGTa9iegH+1+lj06tEyvfA4vd6LLHxpkhvcAySylfePD8M6nU2MbNS0momnN6uUKLOZHLaFBOSpJUc9fThWQyHzshs0+C4f+HnjYM16CIEgtMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015632; c=relaxed/simple;
	bh=cg4oQWa4mAvOE44mdOlcpdj6cbZ+HMPUwfv7SHiAbQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y0+dVM8k/Wtc4sHT8orRQjxoiYkAsXV/+2x5OOFQmrp47qMlXQ4XkrO7ZzPYZUgIROZdjN3qDm/+z3/faZqGcrr4L7t6TOSmg8Nl1D4n4zxDwZ1eLSjOAmHBds7nzqYXwKGEMqe/n83UQl6kkzQP514pJ9DADa2a8T2CeBMz4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pozSQlOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C45C4AF07;
	Wed,  3 Jul 2024 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015632;
	bh=cg4oQWa4mAvOE44mdOlcpdj6cbZ+HMPUwfv7SHiAbQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pozSQlOP0sdfd+dpy5AHIdtEZc2q59DrIN3Ite/3XX7RzlDpnJ0Zp8o4ocQSD1fWp
	 5Vgp2/jRIfWDsgm9HsK2G1f8krds1YE8j4PCvvEqPSE7aEGyrT094SkcyPALUhHABc
	 EC46aHoU3H6cft9nY3M6P+uN6NVuQGu6DpLttyw/q0gfWt90yllorgQKaEfSs5XlMg
	 f1mKGCZi6Pj6Rk0DmnwSMaQaFxPIYdX41Y0/rcXI5nwLZm2ZXegGRAA6Yb9sRvVjgr
	 657oKwd+BTXoxDK5TnzX8SV//1M6GHKg2ox9QJ9muwltAeUxaxsd7WDesk1TmVB1Yx
	 Wc6S2OYm97T0g==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240702215402.839673-1-robh@kernel.org>
References: <20240702215402.839673-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: tas2781: Use of_property_read_reg()
Message-Id: <172001563047.37877.18071249071920971995.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 15:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 02 Jul 2024 15:54:01 -0600, Rob Herring (Arm) wrote:
> Replace the open-coded parsing of "reg" with of_property_read_reg().
> The #ifdef is also easily replaced with IS_ENABLED().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Use of_property_read_reg()
      commit: 31a45f9190b5b4f5cd8cdec8471babd5215eee04

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


