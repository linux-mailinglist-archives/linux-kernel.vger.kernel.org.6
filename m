Return-Path: <linux-kernel+bounces-280121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED694C60D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874D2B21F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DE15A853;
	Thu,  8 Aug 2024 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WixlTFq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC87E1;
	Thu,  8 Aug 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150601; cv=none; b=YoaV72BdRWXLyupnjcuDDohl3Zzv2/ravM3UH0GzQeSHcEri/6avmgY4wvetBhSU1ThUuA77XegsHPe3VSBmh4g2xiSCVv/6cdcRpS+TwrtMCq881SigEyTVlz0/zVy48/voIugZ+DpphxRAlYI+pS/va2owQ/LCw7uE+U78/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150601; c=relaxed/simple;
	bh=7c4tQRSAELTB1T8amQAP3q6kd8OVoXeWj2W715x9jIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LqVL2XAhqN59/pJFGZZWRJ753nHnXZoo41eY7PpSHpy14tpxM+ZXhTP0bY7R6bEFDnN+jgwg2Vm8kII3SBZrLq90e2DHgUCHKmQ/E5g7DMjCi0fKtVYGty99Mk9p9UzJDBnlGdcft3gwUxPz40cT/bObi5DT2LVPyZYfx+sSOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WixlTFq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABCCC32782;
	Thu,  8 Aug 2024 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150600;
	bh=7c4tQRSAELTB1T8amQAP3q6kd8OVoXeWj2W715x9jIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WixlTFq0j1bNZegfuhsDPidaMkO1UMMoCEpakA6WQAbgHAATKM/qL2CrLZlYrteet
	 Rtcs4/Dx/Ur2nCg7lOjqBEcP/SVmChvg7VMZayqpBWwLddXZRmM6ExqymPzYZjRT6E
	 mI3nRNUruH8YhEg3rXpPr8cLGttvEL/SC6AnXtrdf2HBH+UzKCkj4AnIRO7z1H9Lkk
	 3cpbWo3vtTxDYBtjav95DrXk44TMyJ4E9elV5v/8GRi89DtjgYOqC6Ck8k4FGBglgq
	 4tKkN+ibwx7DqrxlfUCRTHgcEt/0Dsbcpf99EhVG/G0Q+lYoA42RpEAVkpfRcK3j2S
	 vpxkaROuzrBJQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 sunpeng.li@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240807085154.1987681-1-Vijendar.Mukunda@amd.com>
References: <20240807085154.1987681-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: add ZSC control register programming
 sequence
Message-Id: <172315059143.475406.15663956148866112375.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 14:21:48 +0530, Vijendar Mukunda wrote:
> Add ZSC Control register programming sequence for ACP D0 and D3 state
> transitions for ACP7.0 onwards. This will allow ACP to enter low power
> state when ACP enters D3 state. When ACP enters D0 State, ZSC control
> should be disabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: add ZSC control register programming sequence
      commit: c35fad6f7e0d69b0e9e7e196bdbca3ed03ac24ea

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


