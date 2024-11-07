Return-Path: <linux-kernel+bounces-400714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C59C114E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AC81F25978
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBA218D80;
	Thu,  7 Nov 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7l5vIRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA88218957;
	Thu,  7 Nov 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016341; cv=none; b=jYRPJ9IIrFGiZhd7Hk+KeD1Utp/00aujcdPVbgVuQ0FE7LY6/86BpGx5u9slgvTBcUlx7eeyN3mWx5BWfR1+lI9l7CI2UFXdfgujnBvSfv7Y8HdQ9UDnhNIkI6P94l60Cjn+gshwIc63EHmIH/a6peE8oGNucXFs37B8orI5Fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016341; c=relaxed/simple;
	bh=pZlXXjMp+LvTEKn+ZGAIRGqWWu4Sh8kXSZp6RNBri/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=liuTFKof2OInAA/SxYgo7YXGNljBEhaTTDdJAtaZBULRG0LcCiwPBe4chyhLGcm8a5lpVqW1J9ED1LAQBDrgFR9NMLmUWNKLgg4ewClMQAitQ4Qo1pj5s+9BWXdJ67hIxJ10M+++i+lfNDMSJCNfIx99NfOnMs7IfqpX/FYwvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7l5vIRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48144C4CED4;
	Thu,  7 Nov 2024 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731016341;
	bh=pZlXXjMp+LvTEKn+ZGAIRGqWWu4Sh8kXSZp6RNBri/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G7l5vIRjpvvfawjV8GngNJYHsxSaBnDSrmFbDYm39RmmwQ94nBlmAElADp++6vAq3
	 /2EVs8wcf8gEWATrHFR7YO9UNnvBrSAut22PHLYdA05o/GEU1FHN7aGTf2fb0o06MH
	 RRKT4FyHQi8QutrNr2w/FMShT8KGOqdSOhssnbB2oHc4Q6XyO/GMFX2RlbMQLKbq9e
	 RL+hzz2omZsWrbWPQDRgEbkvDRbhADuFs6i81G4mm9kPegO46Uf5LeYUaLhUtkbEbj
	 1aaKIG6QqN5BnAJp6uRlpFMtxhSCDN6YSOjGfX1wWvMob+CJSoxcsget+hgEzbhfha
	 qW6+vVHXEfE8g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Kiseok Jo <kiseok.jo@irondevice.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106005800.7520-1-kiseok.jo@irondevice.com>
References: <20241106005800.7520-1-kiseok.jo@irondevice.com>
Subject: Re: [PATCH RESEND v4 0/2] Add a driver for the Iron Device SMA1307
 Amp
Message-Id: <173101633902.271800.3646827162492611433.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 21:52:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 09:57:58 +0900, Kiseok Jo wrote:
> This adds basic audio support for the Iron Device SMA1307 amplifier
> 
> Kiseok Jo (2):
>   ASoC: dt-bindings: irondevice,sma1307: Add initial DT
>   ASoC: sma1307: Add driver for Iron Device SMA1307
> 
> .../bindings/sound/irondevice,sma1307.yaml    |   53 +
>  sound/soc/codecs/Kconfig                      |   10 +
>  sound/soc/codecs/Makefile                     |    2 +
>  sound/soc/codecs/sma1307.c                    | 2052 +++++++++++++++++
>  sound/soc/codecs/sma1307.h                    |  444 ++++
>  5 files changed, 2561 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
>  create mode 100644 sound/soc/codecs/sma1307.c
>  create mode 100644 sound/soc/codecs/sma1307.h
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: irondevice,sma1307: Add initial DT
      commit: 82a1ccdf616d396c99f535febb6c997781c5c26c
[2/2] ASoC: sma1307: Add driver for Iron Device SMA1307
      commit: 576c57e6b4c1d734bcb7cc33dde9a99a9383b520

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


