Return-Path: <linux-kernel+bounces-223702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E112C91171D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C78CB2164A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE64436;
	Fri, 21 Jun 2024 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HneLpggF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E193207;
	Fri, 21 Jun 2024 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928375; cv=none; b=jhR3qorLf1OfkHjOfwdvySmUj42pp2+ab+GvF7IXfRFIPgXwP6lLDPgoFJ4kiqjBAvqaDluwD3V6lBXlTg5+1NP4qHzzapuV/JXl+La5AwC7FA0M7q0Y4jVtlIK3QDufLyCRyoA/Rxm7c8S61BVf6ZfIyteJmp6h03nTWGtHYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928375; c=relaxed/simple;
	bh=VNSCHiO08SIk0htqWDW6NDFuvYyhidq/ovhyfUV5Kwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cou3aXMVkXhHGYGF+zvRkCV3R0pqhbEX9BTHjLYUA4xVAeMxd0scQxRzbzftBfbP4K28nfuKQESgoCf/8JMJTtXpQ0MlSvkQSM76fi1tHmdRRMBOWz1rL7aZdwRnkEeYWWbmeibDGEykCS5QD2iE01LOjff1d5hiPHrgUVaTq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HneLpggF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A7C2BD10;
	Fri, 21 Jun 2024 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718928375;
	bh=VNSCHiO08SIk0htqWDW6NDFuvYyhidq/ovhyfUV5Kwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HneLpggF5aKAge/YLzIW5cLkwl1JRmjRPAHCL9AVCFqQnPr25XKP9Z/YFuOrHFRQM
	 Z8WthZPFSd05AbkIJE7UTae1fx3IHUq3s75yr3U83zQfEU7QtJmzJG4jZ8kmRpLC7g
	 GnaeNLH2rHkUxgRcg5o5IBMpWKQ/TttntERYGpR3LDYgcAM/3dsaPM6l7wBTgQGhA/
	 neiEPwmWUsUSVCSmbh9khUQsFK/ciT5j9FvzPL9Bf9Mf7fJu9oYg+fsrARZuPkG5Mc
	 9+IhU4KVKb2ttRGmnF0TsxJugRTTvceAmV7z+zF4iyxnLV1CDS4yio89WNd6nDyYyV
	 k6sIw0QXHXRaA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, 
 Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, 
 Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
In-Reply-To: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
Subject: Re: (subset) [PATCHv5 0/9] ASoC: fsl-asoc-card: add S/PDIF
 controller
Message-Id: <171892836830.273016.4379202325839599426.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 01:06:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 20 Jun 2024 15:25:02 +0200, Elinor Montmasson wrote:
> This is the v5 of the series of patches aiming to make the machine
> driver `fsl-asoc-card` compatible with S/PDIF controllers on imx boards.
> The main goal is to allow the use of S/PDIF controllers with ASRC
> modules.
> 
> The `imx-spdif` machine driver already has specific support for S/PDIF
> controllers but doesn't support using an ASRC with it. However, the
> `fsl-asoc-card` machine driver has the necessary code to create a sound
> card which can use an ASRC module.
> It is then possible to extend the support for S/PDIF audio cards by
> merging the `imx-spdif` driver into `fsl-asoc-card`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: fsl-asoc-card: set priv->pdev before using it
      commit: 90f3feb24172185f1832636264943e8b5e289245

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


