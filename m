Return-Path: <linux-kernel+bounces-214628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A9908750
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7684D1C23140
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947D1922E1;
	Fri, 14 Jun 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCWTZwRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D918C33A;
	Fri, 14 Jun 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357099; cv=none; b=JR52a9FIy2Sv46gZk25eaAeCPRCaQ8IW0+3Wy7O+CWwI93HnX3ZS1dXWp1go4dLvt8jjaG/N0tqJNBSsYmEX1yBUe+7c68j7xR095IBYlRUEXIQtHbVW06crHjiddEaN5uYRQ6S+YNc1qf8Og/Rd3erC0tRKvx9yBxwn4hrEmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357099; c=relaxed/simple;
	bh=O5kc28lbH4t01HLT1wS8PwFPEcZXeuB0ELq0NAIyPjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZUYY+5BvgDd7WLwl+Axzhw2oJZHA6oD0w3fA9m9h/SQWFbmR1TLSiZNUT1f6/lenHkXwoeQId9CwrElno2dcVbt00GKxi2w9A5nX+ygN+4VW7PCGrkyAn6d43zqDCUQOoIxZmncXBnJBlIHNvDyF/GEfMJ9PwS7ghIlGVvRhrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCWTZwRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7030CC2BD10;
	Fri, 14 Jun 2024 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718357099;
	bh=O5kc28lbH4t01HLT1wS8PwFPEcZXeuB0ELq0NAIyPjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iCWTZwRcvVCSP21qA/FLhovAdDIulSJl1VwUJPi9ls2quluhGRv7RFqc8UdqZeGRn
	 DSE/krIOndKxKSEfiATpH4wdS2VGUNrE5Y8Fp8yfiUeorqjGe9CZCbzgxY/U0JRl3Q
	 /bYPa7k+WT/L/fF/Oddq/H+UeJWSSw8pNZpIYsW9kwOYtngGdSrfpMSrhFtWHZq3il
	 xXUTRinbRpnLzXAhSRlJ5DSK2uojz3DwIO4LQumLmn1i65MQRfDRbjh1uZ+oN5ag5i
	 aQzHlUUzkgUtm/g0DGHWJDBSubvWxIJb5CQi5FYm9QkS3/6sTFMJn+JgAeJfr23KGh
	 W3CtpUP2/DKiA==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>, 
 Chris Morgan <macroalpha82@gmail.com>
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-Id: <171835709508.262359.11220442613835711253.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 10:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Thu, 18 Apr 2024 01:07:31 +0100, Andre Przywara wrote:
> This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> original patches in an immutable branch already, so these here go on top.
> Patch 1 is new in v2, and adds the IRQ status and acknowledge registers
> to the writable range. Thanks to Chris for pointing this out.
> Patch 2 contains fixes to the regulator descriptions: the LDOs had the
> wrong supply source, and two numbers were wrong. The datasheet describes
> the voltage ranges and register values differently from what our macros
> expect, in a way that literally begs for off-by-ones, so here you go.
> Also there is an actual wrong number in the datasheet, add a comment to
> document this.
> I don't know if that's still feasible, but those two patches would be a
> good candidate to squash into the patches that they fix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/5] regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
      commit: 0057222c45140830a7bf55e92fb67f84a2814f67

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


