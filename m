Return-Path: <linux-kernel+bounces-239858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35A926626
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087FAB243F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDCD282E1;
	Wed,  3 Jul 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhGbs0cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A3142624;
	Wed,  3 Jul 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024239; cv=none; b=QIgFlssrm/VGR6LnEjWDCGhvzIuwvox8hg8UuIv+mr1DL5FzJOpuTpPCrfhSwgH7yHo8v3EaDg364Zre11msmE1nScp8BADirE0Oujv3EkUww2eOw2vZTfLFvufMKN+I8GLyOKkyrNgUeC3RRUPP7XRi8anVvBaE84BHhCC2MjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024239; c=relaxed/simple;
	bh=tbw4IjqXUR04CkMFwlqotJR1pTI1NbAbfwA6PTNVkYE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K/XZz+SarjD1IMlTfXdkCwQ/5ruMWvcHw2R6HikgRaLfDBwp5itcD+JyQZm8i2bsNKC3+ILJsJCG9PcEynBYGY1OPdPGUwTGGwFD6YMNoCICr3tEeyadtSPIXtp2wHe1wjlBim50SerUrKHg5tbZcy8iDphgcwySe4lBit3PWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhGbs0cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF21C2BD10;
	Wed,  3 Jul 2024 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720024239;
	bh=tbw4IjqXUR04CkMFwlqotJR1pTI1NbAbfwA6PTNVkYE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uhGbs0cz+lh5Jr0TI6K7d7JJFV3jwor1ByoZyfHg+ROERKhTX2KwjYle0gI70vSRu
	 a9ZFvzQDl+Xq9VYbMo8c4lLE2ap46PcOrE4ZUVt+eNxQZHu7xgVzJ/jI2axq56jx9T
	 ZHYQtQRbq/O8WqlZfiSE5mRUlBEwn63DKMxGXFOAFQWvCVhfkeadv7EZVX7FTK3uRq
	 FiTh/wrl/Mt2KheRaaqlwYupBX+7XVmU6mA14+cRZScuSJoHbHuG6iiw/nOPe6TTNe
	 7SYj8qxx0I0sMsZc3Vn9ooFLIpJqf+ao7gcS65cPtSuOa9+D3XapmMgsB9XAHB4LHu
	 ZVoewSoyUGuXw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240628094354.780720-1-chancel.liu@nxp.com>
References: <20240628094354.780720-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Improve suspend/resume flow in
 fsl_xcvr_trigger()
Message-Id: <172002423642.71782.11871848740483876915.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 17:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 28 Jun 2024 18:43:54 +0900, Chancel Liu wrote:
> In the current flow all interrupts are disabled in runtime suspend
> phase. However interrupts enablement only exists in fsl_xcvr_prepare().
> After resume fsl_xcvr_prepare() may not be called so it will cause all
> interrupts still disabled even if resume from suspend. Interrupts
> should be explictily enabled after resume.
> 
> Also, DPATH reset setting only exists in fsl_xcvr_prepare(). After
> resume from suspend DPATH should be reset otherwise there'll be channel
> swap issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Improve suspend/resume flow in fsl_xcvr_trigger()
      commit: c288f0a1c08efa65f9e3bb7954eb3cefb966c97d

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


