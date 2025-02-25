Return-Path: <linux-kernel+bounces-531982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF8A44786
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A803B5E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE59197558;
	Tue, 25 Feb 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMndOmQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3614A60A;
	Tue, 25 Feb 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503031; cv=none; b=cRnvqWjvKY0UHazDqFhU98HiyRzetcUEdIEY/h/R2ehiJ9uNRJiMkFf6bX1QZFDVznwlXp888uJilmFk/+coM2/IXE1k9LLKsI9wMjZoG9WuuOzscxRJnr7WUN4J14I484XuzWnuE7/CZG+LkOkE4oVlTpYUPmdr9OYpKoZ0aEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503031; c=relaxed/simple;
	bh=m/Rhl9xk8wb/gA4pl1Wi+ZgfjJHp6A4PuropwF5UbcM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=unuR8K96T4+7BdvPVAKeUCjPCCwspx98UOdOj5Bvy1bvh+p/7rtTxXnKbI/rM6yMfi8/fMmkHtB8QTrhTNInhE84GW845xO6cVOFDTNyACHQJmv+slSn6S8ntZNAOobtaEbG6SP6M2yYBHQLiNAmSrZROHVUh6QGkb2n8x6oIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMndOmQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2A9C4CEE7;
	Tue, 25 Feb 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503030;
	bh=m/Rhl9xk8wb/gA4pl1Wi+ZgfjJHp6A4PuropwF5UbcM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EMndOmQmf/64HxjrnZOJV3XEL66bANshmMnGQu6jQUgnrLdh14x8E6YqA4WNj+JCX
	 UiK16lOpKnn5WZ1CN8qshhMRjYcopfxJl1KZY3okjGR5Z2bS1PT4/+VPqKXaFwB6wx
	 GaKxUVbP0z+pxmCX3KE/Xeg6qUKLu5RXvTO4Gqvb1EUYR3XHEeCfTY+0q4tUEq8XT5
	 ojKPuTCLsVIqfZw9Inz4N+s8AM99yQzm16VWWLXGXQPLymOla2qx0tsVlWnwHIaL0F
	 +fbHN30DytgN3R531Bgva9TbEBaTNp8Y8RIdtziam8mDF0KRgvnCkNXMH44H/9nlvK
	 Eg0XB4AwC7CBw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250217021715.284951-1-shengjiu.wang@nxp.com>
References: <20250217021715.284951-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 0/2] ASoC: imx-card: support playback or capture
 only
Message-Id: <174050302640.104078.14845338578152445669.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 17:03:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Feb 2025 10:17:13 +0800, Shengjiu Wang wrote:
> Be similar to audio graph card, support playback or capture only for
> imx-audio-card.
> 
> imx-card can't directly refer to audio-graph-port.yaml, because it is
> not based on 'ports'. Add playback-only and capture-only property
> directly
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


