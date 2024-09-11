Return-Path: <linux-kernel+bounces-325324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139E19757D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03B61F2818B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87D1AED2C;
	Wed, 11 Sep 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="josjBkr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17918661D;
	Wed, 11 Sep 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070567; cv=none; b=fcEedPlkP4WzO7qe5IJGmYMCzi1UQTy2hkdp6GLhpX8K4BcB9fHvKGA+K0DTfjXqqyeU9VpvXJbR2TAxppW0+ztlolQY+rtKUspJdSR/+9TPYE9lkdEhSyb8X6CphJTqgvxeWIWkd+Be4py22NqcZ9Mj4BifDnAveXdAFKvnHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070567; c=relaxed/simple;
	bh=CkGJc0b0X6zqDALs7FLOySvP17G4aTD64zilKSbV7LI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HVYWbiL64llUl486i38gB7S2xlog79oqrni9qeK7fb1mv/qU/kWi2Sy9iLPNyeFELaC57glBhJy4nJ4pABbTx6bm3djxEsh5/mAPMBgJj0y3zdIYwXXBOg7LEqdCPS8K4fK73SWNGt0UC2XBT/ZPt1amKyASf7xXdTmNfZn1/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=josjBkr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08369C4CEC0;
	Wed, 11 Sep 2024 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726070566;
	bh=CkGJc0b0X6zqDALs7FLOySvP17G4aTD64zilKSbV7LI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=josjBkr5qnkyctiBzWFJaMcf9muNS9pRLhpzWMG4VBmqrB7AQ+cGx5JpGZOtJIzSV
	 4E4wslQ6Jwd/3yCyoU4AyR1eNbb6wHFdd1Ws+JscdMWZqcbBftOzixHKUejCuA6XYD
	 wQTv6OCKPMc0ZpVm9JVCmqJ3/x+ahCu/MRTv1m2syTPSZbrzdeIQX/76m+QoiqYIVI
	 pxb46e7Inc2bUkY4dP+oJBU2wn6ozLGM1CzXcg3ZkrFjncYJ9XxjEY5N96iVDvtpqr
	 oo8Y63OnITgN0BZQFpiQxbBxYxM2pgjy0+bEUiaXFfHCbRTfPqK0nDc1m2UlpOsc/i
	 W4yeGGm2k4ZYg==
From: Mark Brown <broonie@kernel.org>
To: herve.codina@bootlin.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nathan@kernel.org, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, Su Hui <suhui@nfschina.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240911115448.277828-1-suhui@nfschina.com>
References: <20240911115448.277828-1-suhui@nfschina.com>
Subject: Re: [PATCH] ASoC: codecs: avoid possible garbage value in
 peb2466_reg_read()
Message-Id: <172607056375.105227.14107234534010047644.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 17:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 19:54:50 +0800, Su Hui wrote:
> Clang static checker (scan-build) warning:
> sound/soc/codecs/peb2466.c:232:8:
> Assigned value is garbage or undefined [core.uninitialized.Assign]
>   232 |                 *val = tmp;
>       |                      ^ ~~~
> 
> When peb2466_read_byte() fails, 'tmp' will have a garbage value.
> Add a judgemnet to avoid this problem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: avoid possible garbage value in peb2466_reg_read()
      commit: 38cc0334baabc5baf08a1db753de521e016c0432

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


