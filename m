Return-Path: <linux-kernel+bounces-513092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF36A34161
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98157A5E37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283828134C;
	Thu, 13 Feb 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPoSaAu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6038389;
	Thu, 13 Feb 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455696; cv=none; b=p1uMryBADMB1YZeQ5HUnoC7Z40u4Tkc6woCU4j/8TcsM9A2ap/rUPc8aNU1LU7mzI1OzKj63HQovxQ14yFGtrMtWb3hhgyhJF/LPsHaEthEHYm0k7mpKu0eNSs492TA6uXiVOP0Dhxpcf+FQcjV0IjUdTsjJGuz8s9rhoJC/mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455696; c=relaxed/simple;
	bh=r1KafGyCz1KTAkGpi3NYt3q72aE3wU997ChKRQT9+AM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g7rjeMXPwQKf0f6TvzF+iEoM1Pq2q/IvNeFSRE9TNxHaoMspgEknXSOPVpEFqjYG623ryr5VdllHXj/k9IXv3GF22A9nF3xzENz61n2U+qt1OjdM+lz39Ffn/zAlwvMls8NFo5KkmAz9B5wuzRu8rR8ol0aO14DxBNKaE3qr250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPoSaAu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EC5C4CED1;
	Thu, 13 Feb 2025 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739455694;
	bh=r1KafGyCz1KTAkGpi3NYt3q72aE3wU997ChKRQT9+AM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CPoSaAu2vf1OgUPzJOdAsLcl1QV6xnbgFfDsgeYR/nVzw6lK70tufn0ArfjSwWQh0
	 E+DtLhuP7n5LfrKtUkbw5zA2tef1lxMfN9NAtY5/GYGauvnPdgv+NZzQ8cymp8j9BA
	 HWqSOE6fdiHqroFWvZuOadrHwPTveSBpDQR1t3oMl3HOdrPNvCfcLqMDCGIJ0Y7y6z
	 rp7X2VZAvY0iRqZlBxBFfYyQ1D2YAHWtUrKnusP7XNWkrkFk/DCRUDkhFNdxp7DYcg
	 QCP2DRmsNnRSvabsRXlSaFaS5bY7TZj5pmis+4qBN2sQCTSqft3KINoejkMAUqDGwO
	 bPEST9AkKQaVw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250213070518.547375-1-shengjiu.wang@nxp.com>
References: <20250213070518.547375-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: imx-audmix: remove cpu_mclk which is from cpu
 dai device
Message-Id: <173945569179.146917.8081621260856817199.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 14:08:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Feb 2025 15:05:18 +0800, Shengjiu Wang wrote:
> When defer probe happens, there may be below error:
> 
> platform 59820000.sai: Resources present before probing
> 
> The cpu_mclk clock is from the cpu dai device, if it is not released,
> then the cpu dai device probe will fail for the second time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmix: remove cpu_mclk which is from cpu dai device
      commit: 571b69f2f9b1ec7cf7d0e9b79e52115a87a869c4

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


