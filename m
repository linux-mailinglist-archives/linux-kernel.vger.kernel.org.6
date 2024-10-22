Return-Path: <linux-kernel+bounces-376961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939AA9AB81E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36B91C23497
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A21CC15D;
	Tue, 22 Oct 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRySlJva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09A188599;
	Tue, 22 Oct 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630831; cv=none; b=ErNl/6ikSqvQ2Wpl2rA9uATqwNDUc3GOfkQs36NkHiHQa5LIfg3zRXiwZMafCy3qnu5/0gFDaGRXYI0VnIiwN1okx9X0jAx8SHsduNoUOND2U4hfLN5eKh2uPo8xLWFKAjUaU2R07ySd+u+fA9Dh6A/fosphq2Y2Q+0pvVWGx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630831; c=relaxed/simple;
	bh=xqtlUhw8rmrDSpNkrqtyPtQIJUIMIG4Xa/kCuAim9xs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hfl6G3UdEMFtxfKFSDietfF/QBI46vi+UptkrMQxcLe4LeJ6oRNG8o9Xq6s3hSZtvxzrldBnf2yQfurRmXp3rdzYHSW/0nlov9DdiUm1STbRnh1kG1KpeiQIjbAtJoeoRZrs3c1eutXMPSuyaI/c34Gp51Gk3DhUi2/MD+6yjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRySlJva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAFDC4CEE3;
	Tue, 22 Oct 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630830;
	bh=xqtlUhw8rmrDSpNkrqtyPtQIJUIMIG4Xa/kCuAim9xs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=sRySlJvaDIgA7CqpeVCHlCjQ9N3IDeVH64OWYdmvNY7+5xl4VEWoVhw9/MPcuQgnf
	 CjEVJa21+IvZCM5NRpxh0eVky+wFMAVGZXkeixfxhlUvDW1I2bD9aTb2AXSGn4j2Su
	 tGtIkgCGfsoOg8lzflkZsZ93+pv5E69x6WOT6W7KHZvdy3vopi8SEAuqkgTR2FdIg/
	 aXPBI0WTQZ8L6vy3jDSa1XU2b1OeSx/koxQx95XBW/S/CM+VfiJMPkzYvchVKvBv0l
	 DI2zIFB51RfszhjbrHuyL5KorFUaGmputCN/bdy+V9ohn61/BV5Ra5CEVSs7E6NxW6
	 PLR67TCUEBhAQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1728368873-31379-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728368873-31379-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_xcvr: enable some interrupts
Message-Id: <172963082823.164184.11756068817626809151.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 22:00:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 08 Oct 2024 14:27:51 +0800, Shengjiu Wang wrote:
> Enable interrupt of cmdc status update and the interrupts for
> wrong preamble received.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_xcvr: enable interrupt of cmdc status update
>   ASoC: fsl_xcvr: reset RX dpath after wrong preamble
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: enable interrupt of cmdc status update
      commit: 06461e288abcd6d67d0a870cd25731c79ebe66ab
[2/2] ASoC: fsl_xcvr: reset RX dpath after wrong preamble
      commit: 1e5d0f106164d2089826c16bb521891d1d06d3ad

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


