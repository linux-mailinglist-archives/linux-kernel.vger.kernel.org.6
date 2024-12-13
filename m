Return-Path: <linux-kernel+bounces-445347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA809F14E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDEA188E7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D71E766F;
	Fri, 13 Dec 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW/hkW/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E1E048B;
	Fri, 13 Dec 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114416; cv=none; b=du2wdoImurk9lDFeDkz4yI4r1GmeRaWQEjlXv/6KV5J/Z+fvAJQwo5G8Sg1+cyQgRGfOR0jZ4qbS/A8zlqcMlbNf1ZKzIwc4ncVjFrASwJNroDrmgI8dJ/jNLGYE19+TTeNvYODDCgRJ1qHEMkeo/8upcYWagEVYOu81+OioItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114416; c=relaxed/simple;
	bh=P3tmUV808PlrjWsZVtbrocOn94r84aBEve7EkJbB0EE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s00pA/zhMPaNDlwW1h2LPhXtNQ/YOlKAy4qojNH8N7VcHOlps7ahrzaPfY9uVVON9b+Agak0sCWPN5lByAtKb56ciP96Zccsbbz0ThenXl/hb/TfKyOF/J6oykblSQDNtW2H3I+DWQZe4g54uu3oC83a4pyEE52iKUgx3fs1xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW/hkW/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FE7C4CED0;
	Fri, 13 Dec 2024 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734114416;
	bh=P3tmUV808PlrjWsZVtbrocOn94r84aBEve7EkJbB0EE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GW/hkW/w4LfVW7vmvSCzUowi3MeqRbp9dbVmP0o3wRkp4JtMwCZCG79+FVhf/j0Of
	 MnuSBxmfqlo0KPGBS++3BysSzndZu1Hdaxe3EHoLA15X40DFXT3JyWki5wO0dryuc2
	 dWP6k9/leMI6l4gjoUqdSuNsVuv31O8woGU5dOvKz5fj5uCtpnp9936Nvp+Hx07I4O
	 3d5tjoefGu5tMRn52ndgRX7MGveg2KkBFs33XqJViKu5p8o/DLiCP29uGNU/7zZZyT
	 ZhPnTSn1Su9rQx0DKB8J6eAGu42NiGQSxPQqQtCmKw827xdcG0Mxhn9cVBs/Xmn5eH
	 GMq//v75OxzOA==
From: Mark Brown <broonie@kernel.org>
To: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com, 
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
References: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 0/6] ASoC: fsl: add memory to memory function for
 ASRC
Message-Id: <173411441355.280424.14935284209276568628.b4-ty@kernel.org>
Date: Fri, 13 Dec 2024 18:26:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 11 Dec 2024 11:08:43 +0800, Shengjiu Wang wrote:
> This function is base on the accelerator implementation
> for compress API:
> 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
> 
> Audio signal processing also has the requirement for memory to
> memory similar as Video.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ALSA: compress: Add output rate and output format support
      commit: f4425e3ab2f796d442a44f31262eade9b6427ff7
[2/6] ASoC: fsl_asrc: define functions for memory to memory usage
      commit: 8ea7d04a4e9e30876c9d8184b4b8e4cab33e0372
[3/6] ASoC: fsl_easrc: define functions for memory to memory usage
      commit: 27147695aaf7ccb0edc3f21454b5405c9037b4ba
[4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
      commit: 24a01710f6271ec32b629d714e6a64a69665128b
[5/6] ASoC: fsl_asrc: register m2m platform device
      commit: 286d658477a43284f7be2539b059ecc90ba109c2
[6/6] ASoC: fsl_easrc: register m2m platform device
      commit: b62eaff0650dc6dc2a4bf0f50714f2357a23fc71

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


