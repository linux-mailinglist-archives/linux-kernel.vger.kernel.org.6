Return-Path: <linux-kernel+bounces-404364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC99C42E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0AE1F21A49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE91A4E76;
	Mon, 11 Nov 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLtK4rKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2D1A3BC8;
	Mon, 11 Nov 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343435; cv=none; b=peDs/v/F+Wd45sn+l/JxcGRFHbp8P4mofjxu5tHyOriNmgy/bJrPZREh9B8lXENu5hrLl2WRnwSA//X3XLzAArZGvqoZv9gNFNGa8wYXlBhNJPcSTMjj0wdubAIyx9J//ytl6HLpBIuBMlF5Js4uHIhaBEpJ5IM3mgAkc/ArX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343435; c=relaxed/simple;
	bh=+THKv8bFBNp01IW6Q6So54Rj6RkeI0Ny3NWfKq5gGK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sfRtt4CAdQ9Vw9xXlfFOjuC97egu6k5bSgny+5rjsVc+mArKkd1mKwizdbb5P3gx1BFdtDnV4QdaCX199ELVtg8ChPQo7A/1n2oLPUyHZwUH9H+NQCuYy92LekXoxCgnUjDKJmvI9Sh2ADrd6NPTihrY5tHSvSKixgKXX+Em1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLtK4rKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD48C4CED7;
	Mon, 11 Nov 2024 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731343435;
	bh=+THKv8bFBNp01IW6Q6So54Rj6RkeI0Ny3NWfKq5gGK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BLtK4rKL+gpP+pQFX/tBVJ+hUGq8ay9mokFf+ENetcB3Ytp3YNQJcFwiroTwhNW3l
	 wOOTS6vcYOW3P3ldDnuKW4W/yrkawF6FTVY80esbz23/p79sQxOl5S1JWvCL157Z2C
	 bE7Krbjjdh5Wqp2d0tFDRXOVlioooHJWWZGTmeodd+ZXSjIGJYdYqp/iEAvuZIwo9t
	 TFF1DyePzhqw/NgfPGnJUjvrrWOzCfjj3pYCg2kXUkJvjtc4KxtIKq2+3PGlcH356k
	 34+Bv3Q59sxsyWscJi2OpZ/okO3Z2LkkHrXU4+ReSF0iTpbVBmtopXuHAqueCypLRR
	 yKmLuiqlz2RxQ==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241105135942.526624-1-olivier.moysan@foss.st.com>
References: <20241105135942.526624-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: dt-bindings: stm32: add missing port property
Message-Id: <173134343208.341130.17895048996231459327.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 16:43:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Tue, 05 Nov 2024 14:59:41 +0100, Olivier Moysan wrote:
> Add missing port property in STM32 SPDIFRX binding.
> This will prevent potential warning:
> Unevaluated properties are not allowed ('port' was unexpected)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: stm32: add missing port property
      commit: 98d34ddd43de0b040bd3ff74b511be7074b0b310

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


