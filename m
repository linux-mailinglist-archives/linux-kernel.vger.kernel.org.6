Return-Path: <linux-kernel+bounces-361149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A242A99A446
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519582854DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E500215034;
	Fri, 11 Oct 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg8O+5np"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BC218582;
	Fri, 11 Oct 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651584; cv=none; b=NIJ+y1AB2mhCuOG34UKpdBJpzFhOcnzuDj09tGgOal1yOLXCYyxfictnztptV0zlTzOKSlGs9e1v/97vkgjCQOLS65K0wF6NcYgU/mkPeseXuCrUydKIdGxpsS/KDi9/mG016W8mDH+R/UsqkCv6rc/UE3OCX2OpSwauJFCu9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651584; c=relaxed/simple;
	bh=gFBGQ27Yb3fK6JUGLLuuf0FHc4yeWf1xfje+sPZhA8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZaaJ5Mdx80sXzVcfRnCh9VK8W9eE9to3YOsHJtu97Q8FmdkXVJx3aSClSaf/PCjfFaGmn5WslqY4IPYQZDVFuT/1swnDvxBv4QqJWeGnDo9j8EI0w/BcmzBiRTx4yJLwvRtAopfE8iXLGz5E4e2BgP6Uc25WBSKHMHsJtMfv8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg8O+5np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E845C4CEC3;
	Fri, 11 Oct 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728651584;
	bh=gFBGQ27Yb3fK6JUGLLuuf0FHc4yeWf1xfje+sPZhA8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cg8O+5npSw7cHbeEN18BV8Sg0fjMCBtSOCGYOTGaN8wptZenvs4fSoi24Ydp5OZam
	 NlaH91ZT5pmVNLeJFb42ctNavv3MmMLJgGBg4Dl3lPoxHTOQBi0DnYypghdxr1n24Y
	 EPK+oV2spbMEQza5e1xbggH5MaCl4YEQ5ILYmXiALOFBWECh6gpmLGVt/dVIzfgUFn
	 Qjf0M7tnM5jkpCEVmNFWUUY5P4wUsJhlWrzJx6s+3FjCy8B/53AOkSnVFJFnT3KoGK
	 J9PrG5alyk+Z3cxg5BVX7nZUiFe3WxB4aIT/kEm0nnw/K5hQBB8tRiFj6rIsWhM6Rs
	 sQEs+lsdUvADg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241011073115.2384-1-tangbin@cmss.chinamobile.com>
References: <20241011073115.2384-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: codecs: Fix error check in es8323_i2c_probe
Message-Id: <172865158268.3890194.6525404124592679888.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 13:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 11 Oct 2024 15:31:15 +0800, Tang Bin wrote:
> In the function es8323_i2c_probe(), devm_kzalloc() could
> possibly return NULL pointer, so IS_ERR() is wrong check
> in this place, thus fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix error check in es8323_i2c_probe
      commit: c1789209701143b50cba3783fa800a23df30a088

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


