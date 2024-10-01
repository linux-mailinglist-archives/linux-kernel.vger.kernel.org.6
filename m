Return-Path: <linux-kernel+bounces-345755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FE98BABD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68BC282995
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD31C0DE2;
	Tue,  1 Oct 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOagfMCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE01BFE12
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781228; cv=none; b=rZRZCwyN7VHMl61Tn+n0nORbFUuOPJOs84Mr3KZ1Puf6WWGSD3bJgXRGmUHvkAK6L0P2M30B0FerERtcsw3uPwaPLB7RY/JCP6I/suck79qXes8WSkoKiV0PO1nOcEGdvKSz0/HQ6iGYejpISiIetTl9K8ytbHQ1kc3wwfxgwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781228; c=relaxed/simple;
	bh=c35KkO6fBFQ7CR+Hda8cEc97H830zEQRHkVC1e81rE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=et8FC8vA2GiP5f5S5k4qdZyKBXtTqm84Hsxwip47Xz4AgYNikHAGJCCWopDK6+uoYVxUlguQYju1VA/tb2DSlHoHwMwWfAJE4AK47JKgHf03iPxm1U7VtV9nT8eZ4WARBdfSNqBHeAGwz/O3GruyPQsTh2LhneBWaYd/M8nEyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOagfMCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A181EC4CECE;
	Tue,  1 Oct 2024 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781227;
	bh=c35KkO6fBFQ7CR+Hda8cEc97H830zEQRHkVC1e81rE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OOagfMCa1N+6RRm89zOuaZuqawCC7tWh/h8y6QGNapN/qFvRS/4YDUMZVQ87mBV9x
	 N3smNq410QZEq9nc7dFRQMvPb7l2QDXD9ukL6yB2YM5N8bKg0IC20UD1jCur/Q1CVC
	 /4uF8BwCrX2RHlmmrx/dfWGH2sJKIeYxV7LzY/CDlyq2+hHGbB8ZYQb/QiygH26yeH
	 M/DeetI0dCPtC8CIjdhk4Yz0wxEz0XnW46WbiBz45UDkRSqbJnXjSV/RTt7RT3dfFr
	 4tcg0seowCxvIZrUNM1hkVjePs6qMUeZiAKkuT2Hpaijl1nstNXhYH+x3CMa1m+AwE
	 R2wOIllwQNDkQ==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
References: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap-irq: Consistently use memset32() in
 regmap_irq_thread()
Message-Id: <172778122592.2280830.17214503699693551737.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 11:27:26 +0300, Andy Shevchenko wrote:
> The commit 4d60cac951fd ("regmap-irq: Add no_status support") adds
> an additional branch into IRQ thread handler in regmap. It wisely
> chose to use memset32() as it might be optimised on some architectures
> and hence give a performance benefit. At the same time the old code
> continue using simple memset(). Update the old code to use memset32().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Consistently use memset32() in regmap_irq_thread()
      commit: 21e9a1dd01b17095192ea86decc0c2081451612e

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


