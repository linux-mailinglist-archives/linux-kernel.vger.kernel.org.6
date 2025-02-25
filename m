Return-Path: <linux-kernel+bounces-531981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB4A4474B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A5216F963
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FB1624F0;
	Tue, 25 Feb 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrjWj1lq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D421ABC6;
	Tue, 25 Feb 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503026; cv=none; b=JlJk5ovpmNQ9LixT9n+Nf8YPmWqAvuwnlJtsfcW67UeG6JUSX0oqdqQZX0IIMmHJCE8b3X+t3mPty+gY9e5QktvAv5mdAJmDmPpw+vAMlWWWqRZ2p+wo8/XDR3itZ1Dzw1USn8lHRFuh+0Hl9b8AmPtFhTu3a2621KK66QZga1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503026; c=relaxed/simple;
	bh=QjKx6PnEreTmGevRICTv66dbF9KM4R8MO1GuCfDDlD8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZyyqduF/9QWKOpMW0iBeX305oHwiUlUmxCHjqoi+wxLmUZQch6luAVs9ibqnMd//xNJr+sjGAQAaUzFF6QR5ofmI8UM48yGRBx7W4URrVsuDPcoOPW7UR8zGaFTNYIG5AwOlnOhd7r9kDVbN3X7XtpTUaBTEg3nzDhvf51rDUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrjWj1lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBA1C4CEE2;
	Tue, 25 Feb 2025 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503026;
	bh=QjKx6PnEreTmGevRICTv66dbF9KM4R8MO1GuCfDDlD8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IrjWj1lqai1dG0x8uiajXo5PpZ/zYHo5eXSqcXl9oLB7JfeQQTLUWEuqnK6I75Y7P
	 rmAFAOp4o6QtQxuhGuqBozC2ASpOASgneHHO9tUc6FdbckibMhVCb8+QI7qrXpLMdw
	 zsbQNhcRkwYA5BVYYA+bf6siRUzWL1GlxFQa9cIrwrXfKfML8QgV8vFbGQovPCy35X
	 rC4qFPjZleOIP3NDvk5XoA5X5lob+AqoQDq4Bg9ojP342e7usFCVJ4m3lUmAZIoS8z
	 qa8PgXzUR0HGrkpjZvJvDYJQoPSnG/jXkhHECm2b8coLdECTfUDGpV6PQ1Cr7oEUJT
	 rX0Cz226bssxA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250211035737.3886974-1-shengjiu.wang@nxp.com>
References: <20250211035737.3886974-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: imx-card: support playback or capture only
Message-Id: <174050302203.104078.14585047916828539805.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 17:03:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 11 Feb 2025 11:57:35 +0800, Shengjiu Wang wrote:
> Be similar to audio graph card, support playback or capture only
> for imx-audio-card.
> 
> Shengjiu Wang (2):
>   ASoC: dt-bindings: imx-card: Add playback-only and capture-only
>     property
>   ASoC: imx-card: Add playback_only or capture_only support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-card: Add playback-only and capture-only property
      commit: 8c6ede5cc4226fd841f252d02ab0372cb92ee75c
[2/2] ASoC: imx-card: Add playback_only or capture_only support
      commit: 1877c3e7937fb2b9373ba263a4900448d50917b7

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


