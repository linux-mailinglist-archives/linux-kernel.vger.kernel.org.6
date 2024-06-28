Return-Path: <linux-kernel+bounces-234268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3AC91C47C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FBC1F22B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F21DDCE;
	Fri, 28 Jun 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8K04298"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3481CE08E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594421; cv=none; b=MJmevIdKOsDCiuThsaLURYned7AYZRHhlqR4iEgISDqM220IdwDD2YRWKjc8jDaZaCFeHLxnZ2yXBBq9MGZGZbMbKve+l2P6nICfuqYAOl3NIx2IDbwzX7DyPrdj4PbN0SI46NLmAICEQJQpxiKDDxHlRUoE3NVeNGsjoTOS39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594421; c=relaxed/simple;
	bh=1RFinm/cPZYC9mpxmSXlKDXt3LLEft9BIYps8Te54Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BK2KgYWppcSp3zGL8j7L2fsbHrb4unKR5OpAtT5FIc9bipTu3l2TxLeOf0SP7/5e8HKjFTxU6TNKR412xt+LMLMr0bGNeHAEUZuUf9JAQ+USQBkYHWhrVCvPs6Db42c8pLFKjHLupQJ7LW0jb9ZaLIV8K9zMH/ahel8iBGxQIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8K04298; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D947AC116B1;
	Fri, 28 Jun 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594421;
	bh=1RFinm/cPZYC9mpxmSXlKDXt3LLEft9BIYps8Te54Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B8K04298o2v0tFF0KY1zlUqG1QWe2B38/9UUfJwyAswB+gdI4+ROcnDz9Q98mh6Ih
	 VMP0+BYNNHiwbY0uEQkuqbzyDCa4UtG7DJb+c9hiNFWRZUFrBmiCJsPNfeaBZY6Jhi
	 0bWv1X4fWRBLeoerfR61nRl9FHqaAIIKiQzqAyBzAuKSzAHbIQSIAnIEigRY4jqOWY
	 SK1zJg5KDgnRg8j86iPFthSCh8yS9lE/W6QLN2IXPLoaEANISF8Dw2MqI5drwyMWEQ
	 bm9X545hcSi1TmXsqOPDJPEben9/qm276GrWZJlobRNjtnVFz3/eqBbujaQ7oG1kzh
	 uDzs/MCGziMFQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240628123256.2019224-1-jbrunet@baylibre.com>
References: <20240628123256.2019224-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: tdm: add sample rate support up to 768kHz
Message-Id: <171959441961.130075.4855510935970492560.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 28 Jun 2024 14:32:54 +0200, Jerome Brunet wrote:
> Add support for 705.6kHz and 768kHz sample rates
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: tdm: add sample rate support up to 768kHz
      commit: 730674b21db12be6ea6b3034c618de5d7a16987d

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


