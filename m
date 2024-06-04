Return-Path: <linux-kernel+bounces-200541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D759D8FB16F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D83D2839DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EE145B2C;
	Tue,  4 Jun 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3gG9apA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211B145B17;
	Tue,  4 Jun 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502065; cv=none; b=JBC7ypbi3IPdUkbSwD47jjRO3dUGwGvNpRd7dyed56DOsIDVjgmE33PsYn7MBCEpREJg8L0N1qpeDoPcoUhh4OfPpKltcItb8NjWdzf1gU6Blvizkht68meuQ0DkAkP5QEN91LnZ12JNo+dd4Tcef2H5fufhSyy91iCeyqxQOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502065; c=relaxed/simple;
	bh=Xju8c8pxMFE3CRgZaF9WGkuzO4+OVpEAP7AjG92ajNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g99b9TeO/UvJ5id07A8d22gVmAsY1vAsj1zboqaw/t32lv2aGUBB62Tr34R8RI+HlnDNlxbnai5ovDFXFn/eUZ7Ex8woaIo7tnYT48+Ef4NIgbKjMSQ/g5CwXFOtbWUgKkS1//I3jTPIkrvoHFp5CZq0SCLIBmPd5lddBx1eV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3gG9apA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCACC2BBFC;
	Tue,  4 Jun 2024 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502064;
	bh=Xju8c8pxMFE3CRgZaF9WGkuzO4+OVpEAP7AjG92ajNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K3gG9apAYeYplTHEHOAYIbTTT4A4V9N3k2PEkLkLeudSHpsSRzt62OjWVW9xFoSHb
	 KUavRmmcbUon/ceYmb5UDEcvxVNc6Rl3DTem+I/RflxiuIUu8jHKMCeE/9UnUVZHQx
	 JcSicsSB6gjOuAJEuSgHGcJzSQkop4Q9z7oinjgRvTN5qM6w2gOX7Pm3WpaKc2FCMs
	 gk077UNUroHXR9+NdXfah2UHoKfVxpe9vcV7F2mA0/N0JQf/owSRgf9xo/FWBRlSig
	 zgLzq69oHjGbD2fLzYM7dxKVecqgWvNNSSXph7YTleGPkL92h5X41WvZPtp7aeeaLU
	 SQF+iIql14XAw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-snd-soc-mxs-pcm-v1-1-1e663d11328d@quicinc.com>
References: <20240602-md-snd-soc-mxs-pcm-v1-1-1e663d11328d@quicinc.com>
Subject: Re: [PATCH] ASoC: mxs: add missing MODULE_DESCRIPTION() macro
Message-Id: <171750206150.24919.3462400658045799986.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 12:54:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 02 Jun 2024 09:30:13 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/mxs/snd-soc-mxs-pcm.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs: add missing MODULE_DESCRIPTION() macro
      commit: a73a83021ae136ab6b0d08eb196d84b1d02814e9

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


