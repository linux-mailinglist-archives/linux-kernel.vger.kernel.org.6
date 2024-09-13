Return-Path: <linux-kernel+bounces-328848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4DB9789D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D81F2892F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFE15098A;
	Fri, 13 Sep 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmvKtO2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE67149C4A;
	Fri, 13 Sep 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258662; cv=none; b=V+3wpKbFgFb/ZYVC/0PJ44Ys/Cp8iL5yLR9CUQFiUNAjmD37IwWAgNcYc+tuH8ChRV0TWM+vP8/Slp93gyOrGZyF5B9qhsl39VJUDpgLF+IMPMgEKKKshPxTDCUkGm23F8HXJ/3vUuTPapCJES8hedvsQafl8sgxG7myQbWTq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258662; c=relaxed/simple;
	bh=i/6TOYgjpBWAH5uVb5krSoAhY2fbdTP2qTf1a1yeLtA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DVDW3J274hOR1yiQYNp6lEi4g9NCk2CJ86GO9qUybuB7U7qoLG4F0qnAKadKET3H7fKBpqqnc/sq2CoGY3HfIZ4b7SdUq2twFahVmXkvETykoeL77CwWlYB/jH3dPIZwPCboCuLdC/Uw5KXcwTwwfyfoQwkOFzWAPbfs6csz9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmvKtO2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EB5C4CEC7;
	Fri, 13 Sep 2024 20:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726258662;
	bh=i/6TOYgjpBWAH5uVb5krSoAhY2fbdTP2qTf1a1yeLtA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CmvKtO2AdvEi1Al9YMfU50u+e/qS4ncz6X6oZJQ210MfTlieGlJ/9gVpxjhsQMUYn
	 xXKl75Ji6anVZGuCz+3Izwvk2rpur4SGPrFqKcVD41+sf4SXp7QUcRqZ2hgKb40LlY
	 P32v8CuJ+k87PN46qFCr2wYYsxH1LTnxVQa4YYOwfVni043nffC/J38CQFFZPweJ5Z
	 KC/pWpyWRTNEaFkMGC4pBWyWFDdp6D9+l+oZr+sN1j8I7GYmfCROJQtDFN8CENTftz
	 ZXUhpAEODGrc1BXL7usn4pBNtn6ChUI7wtQDXRMF1HvC/Rk53FTdElEjFBInzhUxQd
	 i9Y/y0yq8CnsA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240908140259.3859-1-tangbin@cmss.chinamobile.com>
References: <20240908140259.3859-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: topology: Fix redundant logical jump
Message-Id: <172625865918.96457.13311075047833556471.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 21:17:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 08 Sep 2024 22:02:59 +0800, Tang Bin wrote:
> In the function soc_tplg_dai_config, the logical jump
> of 'goto err' is redundant, so remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix redundant logical jump
      commit: 2772ee6de6cf94e5f2a0c0ce6067d0796a4170ba

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


