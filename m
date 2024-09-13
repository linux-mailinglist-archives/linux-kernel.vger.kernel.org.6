Return-Path: <linux-kernel+bounces-328531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4938D97854E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC60287FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4B757E0;
	Fri, 13 Sep 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnObwBVf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7A29402;
	Fri, 13 Sep 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243176; cv=none; b=t8VQ32Q0lGk+8L5kHr8At78txbwQj7zO0uLK2RpOA7806rMGjmk/nOcSOWHyo0YSEfk+U9+f0P1fBWo8e92GWIgoZaF5/bLPOCbfZjSuPCAnyXNwydp+KqELEcqxdrz1uNVrptTIwuZFcDkKpLHqmmR7+Yhu3mRIfbZtQzE6/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243176; c=relaxed/simple;
	bh=2THK3Qa5hpEcl3liEPlYzjlcVVBqTpMJPQbdU/7/h9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qYcxzRMGXaTm0bms4XwD9LIkeZ10unwQVh0p5pHF2DUQHardHCgZ00Unk+RvUUA0zXaUv4ZF61rtevxk1ByYp29yf8XuehAKzG8RP547OpnUgnugrdyC++MsI321PVA97E8bLXsxnCLuMp5TqNzKsSXgeeD+yLxxNb1PMHz9zZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnObwBVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70384C4CEC7;
	Fri, 13 Sep 2024 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726243175;
	bh=2THK3Qa5hpEcl3liEPlYzjlcVVBqTpMJPQbdU/7/h9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AnObwBVflScon9QfWYEcU32GDZMJ/dBFoVVdVeTuCUEe5Q+wc0fft7Z8BToDIrAXc
	 JQCl0rYbrZAmjZElmSKpq2icTT1ELjl4ilB/O+K8yc8CO7Ce0DFPZPiYHuhFgX518Y
	 GsYLNttJWk0A25LjyxO0/9nNo7aRWhZHRR0TnouG9z9HDeTFiNWvA+Faok6rE37s1s
	 LvgqZ3G35/yltWXmiwzZpe1F1vJUz5gL3XL9A7IAeAc3k3s1cG0zTJ936Wa/ISalmY
	 mIiS6FomPAwVYA7XMHe+J+7cQ5NP6QAdkkxUkD72tfeGxrc8XRG2EdZsFp5aYdbdgf
	 GDCZcA9W+3A8w==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
In-Reply-To: <20240913120621.79088-1-andrei.simion@microchip.com>
References: <20240913120621.79088-1-andrei.simion@microchip.com>
Subject: Re: [PATCH v2] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
Message-Id: <172624317318.45716.11241819837265266294.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 16:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 13 Sep 2024 15:06:22 +0300, Andrei Simion wrote:
> Avoid removing these controls, as doing so can cause issues if the stream
> is initiated from another control. Ensure these controls remain intact when
> the stream is started or finished. Instead of removing them, return an
> -EBUSY error code to indicate that the controller is busy, especially when
> the audio filter and the SINC filter are in use.
> 
> [andrei.simion@microchip.com: Reword the commit title and the commit
> message. Replace spinlock and busy variable with atomic_t busy_stream.]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
      commit: 2ed1a4a5c0058dfd78f5037576d668a37d0ec609

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


