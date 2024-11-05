Return-Path: <linux-kernel+bounces-396816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505D9BD297
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BC1280C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC721E260F;
	Tue,  5 Nov 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Ux5N93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BE1E202D;
	Tue,  5 Nov 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824707; cv=none; b=pGLfOo1KP2GD9jpePWZYsXHhYwVYU9BJlOBXC+5RNHsNLNajC5737lsi6h1fgIT9XQWIl4dNY9yLE/ja0D7b/Kaa9oqpNafoBSQbkfUvypkuOXNCdAQhyNMR/afzx8DBvvlTCK9BjSQE7X64RUA7cPGzS7Ls6/jZy/5ZkeGIf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824707; c=relaxed/simple;
	bh=BNDiyP5Qber8qAQ6J6f8+1BV74cAqBSDKd6FIp3qpjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oJmSeL/ONgGegF0pw1x+vAPakOHDJp4Ulm3Rg6xv6rlqyQioSzUhTmdRQ8nfZtLR4E3sE7iHtzy3R7o6Ux0PkvrNMCkwZOvnhpM0KaqcEQTWVMxWa5u5IvWTjVtNmxoUK9LOkkn7A+8OPOzbwBACOVHDatzEeExmfrkeLednvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Ux5N93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2C0C4CECF;
	Tue,  5 Nov 2024 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824707;
	bh=BNDiyP5Qber8qAQ6J6f8+1BV74cAqBSDKd6FIp3qpjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R+Ux5N93hoWuF7EnrDKb3QHuZDO/q4dDvxI7l2rzIdDGCBXDuUHLL8MJm7ree+OWs
	 uBn12mgiBR2tctyTjA5FQWlb657GtbzP8VZWFvCZEF2AAcHxp+uezlB7qaoRlb1kKn
	 gFs+AWdnuU54LdxwrJOO3uyCvC5n97yvE3QVjizUPKbjzmswXJVjmkPJGwuzNQ2u9b
	 P7UVXSWMS3/llfTDESCK0YlQaZWTs7Wb0aOjhpzbS6R8vUkPe+ET4lsfj1jZrjkjPa
	 VxjVhrJbxE4tpLsH+tWa7D8mtNW12oNtmzX+e5w4MFZR8Y5LUWxO1YMGoUklUVZoE1
	 tNw4wunfag5CQ==
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20241102123630.25446-1-surajsonawane0215@gmail.com>
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <20241102123630.25446-1-surajsonawane0215@gmail.com>
Subject: Re: [PATCH v2] sound: fix uninit-value in i2s_dma_isr
Message-Id: <173082470610.77847.10440868668572486122.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 02 Nov 2024 18:06:30 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
> 
> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
> error: uninitialized symbol 'val_1'.
> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
> error: uninitialized symbol 'val_2'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: fix uninit-value in i2s_dma_isr
      commit: 28f7aa0c015036db260adbec37891984a31ed4c2

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


