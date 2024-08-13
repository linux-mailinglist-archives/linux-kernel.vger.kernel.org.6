Return-Path: <linux-kernel+bounces-285099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA995094F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121B71C20FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963621A072D;
	Tue, 13 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGl1r1pS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF81A071F;
	Tue, 13 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563796; cv=none; b=VD0WYnn3TJUcTTsfgHrrwmUWLsFZRY+iDoKjCJEghMqUnhMWTUJ47KmehqpwQZoNsxPn/ycD8te4jf7XS2lFMwQqAwhhYFqHJiDoq0Ju2w/iVI6fKiGcpoYDAGIx8rsWyLEruTvbu2/T/5RHu0mr+lLiuXa4JMpYjF0rHxyd3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563796; c=relaxed/simple;
	bh=Np53EKDPhWsDscuSJzgCTLDXBemNhc1Uzl06zU9nmSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lG5zx8Cde2NIqJVY9gDD+fqrKHkJvKQkK6P+OsqZyOuO8+/vHXtmkWlxhh8ejV4h1ZVABiM8I2tAfXhKBm/rJALzeoq/yGpP0TP7puch4PIST9AiX/8dmb27R347XfiNMuRVf0BUOBDFoxZrJ8DE1t4r1o+VM5sqnTR5wOeW0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGl1r1pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E3C4AF09;
	Tue, 13 Aug 2024 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563796;
	bh=Np53EKDPhWsDscuSJzgCTLDXBemNhc1Uzl06zU9nmSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dGl1r1pSbmOfcEgEwhOANNey/KTxpDRE0vmX8aoLfQPe4fvU4bzKrL1vZbc2O469d
	 bBYVtEk7KkwxDCQv7z9YTJMyRwO30lu8BiUDceC1Ol8RmkmT/versIUMYf8O+XOQoB
	 QhW6+h9PB5JAnzminaE29U7Cu8Ow/kNew71yZX2WKW+pNT+D0VMMcivnQrN2rX3MY1
	 HPgV0gRrSu+yp6GpSNmdDhvHBTcXanbwAm1vlRH5fvsAw/YPzwQYw0E4BCHTWVfEKx
	 tQ4Agvutj0rCvBzmfrWLZt6YBi8xDxLQumTTNyvZcRxlvTNR+VDmhVbUgmbXRcXbhR
	 HtJXbxUZvq1sg==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, 
 nicolas.ferre@microchip.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
 robh@kernel.org, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Subject: Re: (subset) [PATCH v2 0/7] Add input voltage suppliers for PMIC
 MCP16502 regulators
Message-Id: <172356379435.80200.17658639217254735748.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:43:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 12 Aug 2024 16:52:24 +0300, Andrei Simion wrote:
> In this series of patches, support for the *-supply property [1]  is added
> (correlated with supply_name [2]) from the core regulator.
> Link [1]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L471
> Link [2]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L2064
> 
> I modified the mcp16502.c driver and the dts that use this PMIC.
> We added these improvements to provide a complete description of the board power scheme.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/7] regulator: mcp16502: Add supplier for regulators
      commit: 861289835002b733aa8715442ba555b1daa84baa
[2/7] regulator: dt-bindings: microchip,mcp16502: Add voltage input supply documentation
      commit: bf5ba94fa0b90c9433167bf143780af6c8805479

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


