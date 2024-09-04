Return-Path: <linux-kernel+bounces-315481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803996C32A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B41C2440B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E71E1A20;
	Wed,  4 Sep 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE1XrfpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9C1E1A0E;
	Wed,  4 Sep 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465354; cv=none; b=dDTBHK4a3cnyV/zGd7v6kzWNZuh/dzc9uW+gM08vb+IoqrxQdphDk9xz6d0GrnQ/2GcZn3WabEG1Bn52wIXR610ohujrofQ3lOv4siaKXHAWkM/CAIgFzlQGswBH+mvBxm7L7bnC/5kk6X5w6+4yPX/iGqhP0aom+X05fffUfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465354; c=relaxed/simple;
	bh=EFuL4YqN+HRnd+i7MSZNWWoRMVk6Uny+7W7L5xrMbZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i9eElRAnYSlBN6d3y30YysD6EW8Q3IJ+68PoJEOH7YY06E9A/i/vSt5B1eFWW0nTAdTOWCYxi5TmVERNJ1mQ5eTrWtfjSFZ1ovG7kHSmepVj0C3QNs3iEB2+q5RWEXvjSFwm9yslp/fExn6HG4CKBSCkkMoZvkioPmO+TIHuOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE1XrfpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB9CC4CEC2;
	Wed,  4 Sep 2024 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725465353;
	bh=EFuL4YqN+HRnd+i7MSZNWWoRMVk6Uny+7W7L5xrMbZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eE1XrfpV//GARKx5SVOmW2jSvmIhEtx5BmXWWrCc+JkiZ0TRFJpPTsPsq77bNcNc4
	 uSg3vMsv5BXrGEBxdJHt9ecmMIgHfRxSsZ97kqJb8EIOK3x5MrpKVfVHpOex5vwRav
	 6eZqbKsv0gsxbKoMIL8vvthNEEQDLD593iQ0DIPHQGqFnfaHeXnlJnsFimKslSs+e4
	 BM7gwaRzv58Y53JiPGOMLZ1snM3VcIQqATF23R/S7BL0UMmOxC708MUiWIu/QDsV/P
	 k7erOQIjgBkYUgEzCK7RxidyOcqGhGqzrzw4eyTo9JmC0M44oU+ZSVaVVqJRIfmqGY
	 Gk1y/P1MhDZLg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Liu Jing <liujing@cmss.chinamobile.com>
Cc: perex@perex.cz, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, linus.walleij@linaro.org, 
 bartosz.golaszewski@linaro.org, kuninori.morimoto.gx@renesas.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240903093623.7120-1-liujing@cmss.chinamobile.com>
References: <20240903093623.7120-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt2701-cs42448: Optimize redundant
 code in mt2701_cs42448_machine_probe
Message-Id: <172546535092.70927.12098749632274765487.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 16:55:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 03 Sep 2024 17:36:23 +0800, Liu Jing wrote:
> Utilize the defined parameter 'dev' to make the code cleaner.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt2701-cs42448: Optimize redundant code in mt2701_cs42448_machine_probe
      commit: 77e6a5e40aa393492cf3f1d2623d7d1dff7f33de

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


