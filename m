Return-Path: <linux-kernel+bounces-314863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7C96BA24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733181C22425
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B081D2208;
	Wed,  4 Sep 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD3HQUw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609A1D7E44;
	Wed,  4 Sep 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448607; cv=none; b=iOBxaObE+JapOgJ3Ml6VloQs2UbLZYKeWzafXRA+q6XTBrUGPcW/2koOkHlhiWV44Dd7AVaJ1a2nyhnGSrHuNiZ3WEJ5KpZ5I6i1TXp1HBOMwpfXnUZ7oUN+Sk/0egya12FnMQO6WJhTBmoUJFRZ9WX7tpEXTZ84nyzo5WBOjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448607; c=relaxed/simple;
	bh=qSO3yyRwjPHxSBTfBfqxB3xWwOqLqpYZ4js+mwJ4e8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W6haCwyrV9wyLWPFhOuWhUqvu48o0AYEFyvXiMoMSpXRLlZ032UI94wDL28G9rzi+9uJzx0SNrQtJc+j8UZuOMVV/3qGiuXxNAwNCdLGQ/y/FRLtIGAvQVNKQAbTKPuJCl/Xf0iHcEMw2jTjPDC3Hj8aGQBFsmaKFPG6Ky5H8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD3HQUw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A4EC4CEC2;
	Wed,  4 Sep 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448606;
	bh=qSO3yyRwjPHxSBTfBfqxB3xWwOqLqpYZ4js+mwJ4e8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VD3HQUw8TLGddJffCWTxisyQx0iZ4Io+/vN6eUyIQPvMSRvclxpjWy91KSNXzt7K5
	 0W3o250OkUtHHhKbJZmcDF9bQVVVrKKN9UILStpFELO9P19wL1ZrOtk/FtyMnFppGn
	 zUOmMjKCgp9XSa9/7MhlItvJWza57QgEfMNEA7Zyskkksq0/UZzZGZAwRwe9Sz+5ks
	 qOOEcFdd2GMwbhXjFdhUIbh7SwBwjvFvNfL/Jd8fTlBOfEvD57Sicl9RVZHUSz7xor
	 NX/sSm1csd/WSACebRtQjIqYMlocGhxfKjKlIPuAroHrIsYq27hs1XPqfLzI605OeP
	 mx+Nw9MojWbOQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 marcin.juszkiewicz@linaro.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20240830203819.1972536-1-heiko@sntech.de>
References: <20240830203819.1972536-1-heiko@sntech.de>
Subject: Re: (subset) [PATCH 0/3] Fixes for the audio setup on the
 rk3588-nanopc-t6
Message-Id: <172544860433.19172.15489715396080759951.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 12:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 30 Aug 2024 22:38:16 +0200, Heiko Stuebner wrote:
> The Nanopc-T6 board does contain some devicetree errors, that came to
> light with recent changes to the board.
> 
> clock and port properties need to be part of the codec-binding like used
> on other codecs already and one property needs to be removed from the
> board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: realtek,rt5616: document mclk clock
      commit: ea8f615b399988abd801fa52a5eb631d826d0ba4
[2/3] ASoC: dt-bindings: realtek,rt5616: Document audio graph port
      commit: 92ff90cffbeef9b1a4983017555a194f8bc83f77

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


