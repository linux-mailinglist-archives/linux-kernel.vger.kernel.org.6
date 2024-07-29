Return-Path: <linux-kernel+bounces-266197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0EA93FC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CF1F21135
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC9188CC5;
	Mon, 29 Jul 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb+yU8MG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494C16B73E;
	Mon, 29 Jul 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273452; cv=none; b=ezCid8o7V1xJdFwIO6hcIx0qjPQp4s0G/r5De3XTc5iyz1JjAmEgtMmhYxXfkrRPj3PhO7LZ2B49gqq2ppNtxaAPu0E6R4UbzCondPO963X348DHM6NDf1j2gip1bh+UNDsMMmkmtx3WScMF4qHcqOqJXLweBm4KtI2vLdIc65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273452; c=relaxed/simple;
	bh=0oCbFyazV4V0QRH9pY87aoH1nnqT33dgn4DPEnU0YzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rvEMt0ZjUneHGhGCafR1vMGqu1nZfvQHXXpF9iJwAMirWpyThvXWnfboaxDh4LO6mAqwQb6V8g3jcaxRMWk0mQa+xiwFE7Yy8XCIgzTlKVuLv5zoRZZHErp5jCHTmNluSKwNIdy5AANCf3p6bORaIZxVOFThXpUf8fyIJkI5iA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb+yU8MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D37C4AF0A;
	Mon, 29 Jul 2024 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273451;
	bh=0oCbFyazV4V0QRH9pY87aoH1nnqT33dgn4DPEnU0YzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bb+yU8MGUF1IoSzYeWvnDsHGJBnVuRXCrPW0wi8hgaYIMkhrQFoBcIuyi+sEErph3
	 jNTTYUbUdqbBf79ye+aiDNTfWqSGoI13QRXz99deSGPDEl+xVzm3XIvFRwLRkc3ILf
	 kr7VARZNBmqx02C0KM01IaZGiTbz9ElR+p4VPVh6tWtJQFevl1PS6juWFFib4SPIuK
	 ZwERUjhJZszoeOY/b4cvP4vvsjz/P6Aoc9dy9ScuAQy/Dgtvs+deWx8WT3DOQx59Gf
	 hx51tO/xdMizRm0W+IAHuxv445V/tlE9oSaWF7CQeEGnqzUXyP4NhwmwqP2K54WFlM
	 aQqIUAryeu32Q==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240722063657.23018-1-animeshagarwal28@gmail.com>
References: <20240722063657.23018-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: fsl,imx-audio-es8328: Convert to
 dtschema
Message-Id: <172227344847.109775.11150603605763736185.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 22 Jul 2024 12:06:51 +0530, Animesh Agarwal wrote:
> Convert the Freescale i.MX audio complex with ES8328 codec bindings to
> DT schema format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,imx-audio-es8328: Convert to dtschema
      commit: 00645b42e3ca6a35fc4a357dd769bcef41d4a077

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


