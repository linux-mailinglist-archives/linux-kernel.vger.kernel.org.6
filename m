Return-Path: <linux-kernel+bounces-221139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93690EF61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F41C20BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459F14F9DC;
	Wed, 19 Jun 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+VzVMSC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CB13DDAF;
	Wed, 19 Jun 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805027; cv=none; b=EMV7JdKmqViqQ6YIEXy8Lovu8vT7meDWLV89n55HYm70wq9QGS3//njRfvI+bkKlQE0E8ui4pXKczT0LHxjD1wbXjOzK1x4Ib9iV3Wyr0xrWf2pVQd5yIQzUmwaP7TJTPCvLcGB7wt4LQEXAMPS75efSiBsvQ1jQ/6VDuvknzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805027; c=relaxed/simple;
	bh=FLX3Mf3ll9AxE0VU3xuCklsvwIGMSeYDjjyugAHjTLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FE/ckw8Zjy503MHRfrx4B43Xv7nq7CtMcshfsQSbKpPMFs8qOOiZn12VoEbF+pAxdODAOdNy6804NOQLMIaerl3AdNWHPukUnjgZYRYR5ti0M+CJjDRyCenGTUZbtSol4940hKOuMn9fOggLVGu2r9fDFXjjZ37vzKtASr9ebsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+VzVMSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDE0C32786;
	Wed, 19 Jun 2024 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805025;
	bh=FLX3Mf3ll9AxE0VU3xuCklsvwIGMSeYDjjyugAHjTLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l+VzVMSCl7/ZPMBh5V7ZjUqpl8t3IhbMQd870iLe6SxvU7t/vRUCa5NijV7MBm+yB
	 xmaGL66vaurpcbXV9o++1HNAeJS547CyrQs/t7oho2es3fSrT/43BuJOeaajkaR4cg
	 fHB8TyiCzvSUFkmN8StdTDCl3N41Dny8+htNiDfTYs0sC0QaflaygMs7465cox6eCa
	 1hvfyCXD2tu/xRJDEqTS8qcnCETi3DqwrwDE63NnbtzUlwQnJDoUe92+lYdikJfR4a
	 Mh5QHr+w3JBE8PIvOOnu/a+Zl2615exsQis+5uWjiXJnucAfGLOCRtFF3RbPNXfBEh
	 VHV9qZ8lU3ipg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240617135338.82006-1-simont@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-Id: <171880502423.147445.2048207564281092382.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 14:50:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 14:53:38 +0100, Simon Trimmer wrote:
> IRQ lookup functions such as those in ACPI can return error values when
> an IRQ is not defined. The i2c core driver converts the error codes to a
> value of 0 and the SPI bus driver passes them unaltered to client device
> drivers.
> 
> The cs35l56 driver should only accept positive non-zero values as IRQ
> numbers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Accept values greater than 0 as IRQ numbers
      commit: 3ec1428d7b7c519d757a013cef908d7e33dee882

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


