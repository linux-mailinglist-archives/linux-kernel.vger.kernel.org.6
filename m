Return-Path: <linux-kernel+bounces-337324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C29848A9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D601C227B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8C1AB52C;
	Tue, 24 Sep 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzPWueI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B8168DC;
	Tue, 24 Sep 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191706; cv=none; b=JjFZrN/VXaJ6q1LTKl3j0eU/jg2vBsRJSfc0bwo43EXzFv7IUqTtxYZ7nsA2NtjmfqCnF1k3Xrn76G8w9LGKIPgXOdHftnNcSSQTpxP1mj45qG2O8g9QRuvDwgYMgesv35hfCna7HXrwHEj6Uju8xn4gec7458E16mjpBoMDgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191706; c=relaxed/simple;
	bh=ZEjyvtI0yfzK8QXNQjqiSQbp58gUxIahW6TghC62ghg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GAtt0lxFBqU8ptgLMjVkd+BJeIcmamW/fBU+1qgJVAxtfhjudtYiEmqPBo0iucdDJF+7bj6Zact0/0pJGniYhZbk15lLVdqEEDcZTdI26J5MEwg7bW96Tp1Ca5g6cZNpFHa23nHAiDSjldPRCjEkOjMfKC+sDn2F7hBdfEAhMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzPWueI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBEEC4CEC4;
	Tue, 24 Sep 2024 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727191705;
	bh=ZEjyvtI0yfzK8QXNQjqiSQbp58gUxIahW6TghC62ghg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SzPWueI1bLknRl/5kZ5tn4uhaqRFq4IbBgwHqlgK3cncJrKRvytdVyqe0g3mHfl8A
	 aIJVBY4KnEhF9bclWgS4u285Cu53pqP/WCYjj0+Pew7ou45tDA+JuS4vlaNStI7OxA
	 qGr4WFPgcPg9b8yxJ2RdYibjPBI9rSnO39l2rOHL64VAL7g24JNu2UTrakmhQ0s6/f
	 m+pTdNCRdtcnSNkCaAbILkf6NftVCv1U2etCas4BxH16XB+6MhCJnusSdiYOEoQOLA
	 Q1R+eiNw8lAmamzgCHnImYYdzJlfGHvLIF4hy/8kx141it0oSOqiUJXiWGMl11eSnj
	 8wL29Y8pbAfLw==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240924081237.50046-1-andrei.simion@microchip.com>
References: <20240924081237.50046-1-andrei.simion@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Skip ALSA restoration if
 substream runtime is uninitialized
Message-Id: <172719170222.1967204.5882794297957729469.b4-ty@kernel.org>
Date: Tue, 24 Sep 2024 17:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 11:12:38 +0300, Andrei Simion wrote:
> Update the driver to prevent alsa-restore.service from failing when
> reading data from /var/lib/alsa/asound.state at boot. Ensure that the
> restoration of ALSA mixer configurations is skipped if substream->runtime
> is NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized
      commit: 09cfc6a532d249a51d3af5022d37ebbe9c3d31f6

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


