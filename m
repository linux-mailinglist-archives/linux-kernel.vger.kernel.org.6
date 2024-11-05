Return-Path: <linux-kernel+bounces-396895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB19BD3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EC3281A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD11E3DD0;
	Tue,  5 Nov 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw5KJOOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701D184523;
	Tue,  5 Nov 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829192; cv=none; b=Z79H/r9Hr9y/k3Zb9OKy7pY1bTLwLd+NgFgD2vFrJjDQJp8fc5GHXLdbSM6+8uQ4YC5qcn49ygo4xQKe/S8E+2fDaV3l5u/xRfFge6U4lyujN596ldvHJn4ZcAy4VOAYY1L11oLO/elM7a7tDeFzflN2GiSlF309QvnUVmZvQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829192; c=relaxed/simple;
	bh=GBpdf1OVO9BOr56k/DS5sh/foQKQ7xW6cGQgQpR2NCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZBEONuhpHDONbUGCUvNiGb5eCkdkPaK5OnKENu1e9AIsCoRQUH+lW/9aDWYjHNf1D79jwOvKJw4qf0087+2+XqrXfaQRf56QgcIASyzkH9zXH3KN9OUZal+7698GGJALwAFSJig9UjQ6P0/OMVMuklq4lnBh0xHqk8II8CDH3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw5KJOOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342D2C4CECF;
	Tue,  5 Nov 2024 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730829191;
	bh=GBpdf1OVO9BOr56k/DS5sh/foQKQ7xW6cGQgQpR2NCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pw5KJOOypZ+1M8BcBE1sks8BopZNvfyjIUSRrCa8l9BsQDa57h+iIrOYogz4Z/R3F
	 BGgMRI3BzVtRJZnrd8EPtO9bkkwfGVHl3pH2Wb9k32RvLss5b4kESmkAPGMFvsHWU7
	 HsfImJ/9oLem4OZommuIE4+MHIC+59xP2TXTed92k01Z0Ns2ew0CGMHx4DACRKU4JJ
	 Rt6gUyszCPAyqEP1rDnwCN2zxwe8JKeNsA5if3fvcBrbsH+KT6vrdO2jglYiHBjqQz
	 2lzzf4V9w7F5Mxn1wsOslkLlsliJgQFtmY7DgHFTgI5KoAAPxXLXe1yuWuZKixE1Wi
	 I40bxMdeGXilg==
From: Mark Brown <broonie@kernel.org>
To: amelie.delaunay@foss.st.com, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Olivier Moysan <olivier.moysan@st.com>, linux-sound@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241105140242.527279-1-olivier.moysan@foss.st.com>
References: <20241105140242.527279-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/1] ASoC: stm32: spdifrx: fix dma channel release in
 stm32_spdifrx_remove
Message-Id: <173082918893.89365.2926884723667800367.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 17:53:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 05 Nov 2024 15:02:42 +0100, Olivier Moysan wrote:
> In case of error when requesting ctrl_chan DMA channel, ctrl_chan is not
> null. So the release of the dma channel leads to the following issue:
> [    4.879000] st,stm32-spdifrx 500d0000.audio-controller:
> dma_request_slave_channel error -19
> [    4.888975] Unable to handle kernel NULL pointer dereference
> at virtual address 000000000000003d
> [...]
> [    5.096577] Call trace:
> [    5.099099]  dma_release_channel+0x24/0x100
> [    5.103235]  stm32_spdifrx_remove+0x24/0x60 [snd_soc_stm32_spdifrx]
> [    5.109494]  stm32_spdifrx_probe+0x320/0x4c4 [snd_soc_stm32_spdifrx]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove
      commit: 9bb4af400c386374ab1047df44c508512c08c31f

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


