Return-Path: <linux-kernel+bounces-285070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B19508D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D064B223D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31171A2C02;
	Tue, 13 Aug 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIRq4xqQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EC1A2574;
	Tue, 13 Aug 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562376; cv=none; b=unes8iXXUhqRn6+fr9rQ43sPoIVjkTq8zAEsfTrjn8ihk7tC1KB/Fkys+tloXvuKLhj9ixgkPAyNZYvEB6a+VvOJiz5WtidJjvxjKxTmoqlVfzacm4Lnjb1toGw688SfYTHRcSOvIXwmwApLLCgF76/x5sFksBTqGgl8vFOMuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562376; c=relaxed/simple;
	bh=Bc2bqEtPf1DXDqArwIt8orSIwhE5/SndDXTmeixZlA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dotu+v3c3TIsfVAI+bATwVBPsXVJyYlYEiygsetwGHWNeTOgVWRZChZ9a05D2YLbaVKCwQPJVMayJ/7Rg8HmHnzWlb7XHYo1StlRwyQlOC5nR1mWJGf3Q96NYSlcOebnYxVGrB91/amTunIwTm9jBOSBJTZF3+60JVMoWL5AHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIRq4xqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BD7C4AF0F;
	Tue, 13 Aug 2024 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562375;
	bh=Bc2bqEtPf1DXDqArwIt8orSIwhE5/SndDXTmeixZlA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uIRq4xqQ75yYT2hoAIfVNVvjlcqquqofASETYCKS7ht2+uKm42CHlq7dkSVmfH7xV
	 ozGQgQ7sVQUgeQNjWlT/K0vnbju8NlqEcxcEsCIlBKNVtHWbnGidP1NR+X4fD7d79Q
	 Q1v1hvMav8a3EVB3e05pp726eSCw9YfuOebSbDR86mViruvGdEKyMjVS96hMG19Jb/
	 ioTKcrCjFHSSKJn7z6I72V/Ntl+hVefYTYSbK8pP0j4IAR68Qs40kbRohGiwyRnIAJ
	 aD2CPTOAtdmtZ9zLFEc2yCsjTK8NlvXgfrvS9+zbNxgZluX4WG+af1o8kCB25S8inR
	 hTptKsK6Sv1RA==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <96561dd2962d4312eb0e68ab850027f44350d070.1722952334.git.christophe.jaillet@wanadoo.fr>
References: <96561dd2962d4312eb0e68ab850027f44350d070.1722952334.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: rt1318: Constify struct reg_sequence
Message-Id: <172356237360.72636.10828998960842254413.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:19:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 06 Aug 2024 15:52:24 +0200, Christophe JAILLET wrote:
> 'struct reg_sequence' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> While at it, remove rt1318_INIT_REG_LEN which is ununsed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1318: Constify struct reg_sequence
      commit: ab73c7c0e5800a44690023cfdfeac72d3b6b95e8

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


