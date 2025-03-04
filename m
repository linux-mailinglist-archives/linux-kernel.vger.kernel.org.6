Return-Path: <linux-kernel+bounces-544157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A044A4DE08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AD7A549A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710E8202F92;
	Tue,  4 Mar 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp7FvLQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373C1FDE05
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091641; cv=none; b=GDi+swR3Sk8/NC/HoUJ3lgvQTdWThgl0eUptB85JZlyNorpcdI4xlHFaQw5FCfwznD26xG2IF1LMaHTmGvm8YMugDE6WXFfUnTE8WB6binUTLxEXG8/14y0WgLVUYrRw/I+clKo0TeVkHqvYi21f1kodysb5bT70XDyuD4JhM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091641; c=relaxed/simple;
	bh=+Oq4qborciN3DUoZ8cclX0JGNzd0VTbYzFALe57YoB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JpWU4rJoC9Hg/R1wmyhkrx9uvt3bDmkc61yEzjEJ+E7rG5OS1v7/ZISSB+EP0IvDqiR8lVu6U/pfQRy0wLPncTRfHwGB6j8KZM/wfSqe0OiiSh6x0eLpnxt34SnMmPuoUy6WgoG2+yFyzHn1KpezDjpQo7KV3lVuAzq6gMZckfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp7FvLQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FDDC4CEE5;
	Tue,  4 Mar 2025 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091641;
	bh=+Oq4qborciN3DUoZ8cclX0JGNzd0VTbYzFALe57YoB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kp7FvLQjCHpKoC4yJGp5A0Z75h7ahSVZHdI7ezCoSQK4lPylNsVISWczDD4LMDWQo
	 OjuZUerP9DyqG7uQKmKpSK0F2cB3tM6l0lMrDuzKlKAbUMMxnBsQliXdpGUDmkQLuP
	 Oub/btjTWLBn+XOc2AI3WejQEXZBKi9mPc62hWDRuwqkninUAOx79vkyfKbegh+eke
	 FxAnAiRoCCYVcv238BKwIrwNseCyNI20aSFCPbdYr8rv1zw+aJaRtjIoQ1/lTPzL9J
	 09pTu7J3OULxC7IphGgdJmbYjUTAN9gH+EPqTHUQ4SBhhTKSfhf2gv8vruktadHhHF
	 /Lvzrdam09usQ==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Frieder Schrempf <frieder@fris.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bo Liu <liubo03@inspur.com>, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>, Robin Gong <yibin.gong@nxp.com>
In-Reply-To: <20250303132258.50204-1-frieder@fris.de>
References: <20250303132258.50204-1-frieder@fris.de>
Subject: Re: [RESEND PATCH v3] regulator: pca9450: Handle hardware with
 fixed SD_VSEL for LDO5
Message-Id: <174109163933.26710.17795041039558652228.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 12:33:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 03 Mar 2025 14:22:54 +0100, Frieder Schrempf wrote:
> There are two ways to set the output voltage of the LD05
> regulator. First by writing to the voltage selection registers
> and second by toggling the SD_VSEL signal.
> 
> Usually board designers connect SD_VSEL to the VSELECT signal
> controlled by the USDHC controller, but in some cases the
> signal is hardwired to a fixed low level (therefore selecting
> 3.3V as initial value for allowing to boot from the SD card).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5
      commit: c8c1ab2c5cb797fe455aa18b4ab7bf39897627f6

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


