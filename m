Return-Path: <linux-kernel+bounces-262410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63293C6B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B960E1F2289B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1919DF83;
	Thu, 25 Jul 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGFaBFor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7319D887;
	Thu, 25 Jul 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922000; cv=none; b=BNNKUyzZBZn9XLQfHpFSNMayNXCHFHlfF1p1MRmpAc/nzqhYAnzxJFxUMkaodjY1IJNeU42PYZMBRTNyTRCn6UJ9ueSN1mkX81GmZGGlRZPSRnR/Xa993EQGPwxJcTmw4dlQRxLtG4S4IhJrusgnSPj7dZ0Y/bsHELpnKrsmqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922000; c=relaxed/simple;
	bh=b1xxyMOUKEHTM0fgA7cD5Ky7WM4hglICYTCKS++76WM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eLTH8zKIK0Uv5cDX1M8rLTU2NYD4+FeihfC8RfbLXdK/wxH3TlR3zsFo8zKmTPHi+vuBt4LsXC2lbRhgnFlz5GwyKJlGz2BtlUNOsHKmQGBdsulRd+z7RyeCaBxObjhyhsFsoKLg4MW21OlqbZWImmrw88R77dS7/nNUW8Ac7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGFaBFor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161AC4AF0B;
	Thu, 25 Jul 2024 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721922000;
	bh=b1xxyMOUKEHTM0fgA7cD5Ky7WM4hglICYTCKS++76WM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LGFaBForeYM7v7INCmm8bGVhoycA1yBXjiM4EkajMOqGcSngGeisvOGul/VNRlRvV
	 X2+DZ3exNLic5d3hTcEPUV6JcJS2Y9nHCvuaRwxPyPHVRVKtFbczyE0YtKCnvvlV5K
	 MOtjzMAea32xMcAlHbw8z6wZmT2F0AO3wFJ9zo9WVtDiy+DVOvOpc30OeGhTL7gKIV
	 ZSKHKyiS7DrkkNIL1+ivKOf8b9BY3/v9eLwUSxPllsCQ2IoxM7gLRF834HeERh6ns7
	 gqX/sNYkALTRA3DXBUH2eHlEAGnadBA3hc6cy43mIqKarCkZGQ2bx8dWdRCFribHV4
	 LoNM5DdOCMRAg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 elinor.montmasson@savoirfairelinux.com, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1721877773-5229-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721877773-5229-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Dynamically allocate memory for
 snd_soc_dai_link_components
Message-Id: <172192199718.45693.5848047744878489432.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 16:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 25 Jul 2024 11:22:53 +0800, Shengjiu Wang wrote:
> The static snd_soc_dai_link_components cause conflict for multiple
> instances of this generic driver. For example, when there is
> wm8962 and SPDIF case enabled together, the contaminated
> snd_soc_dai_link_components will cause another device probe fail.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Dynamically allocate memory for snd_soc_dai_link_components
      commit: ab53dfdcdd1ec8df8729890aefa5b0e3c900afbb

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


