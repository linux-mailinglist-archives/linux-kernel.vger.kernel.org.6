Return-Path: <linux-kernel+bounces-184863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73E8CAD32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD541F21F51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AA6BB45;
	Tue, 21 May 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WESx5rs/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91420B04
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290332; cv=none; b=tGNxpPsyMPypGjf50lyTZWCOIsX9+owqy5ZTjJAHK4UjLSuM551aHjEN8cSVxyJWpS5ufTAQFVbimFyPdDd8TDqY3Sc2ZmtF3sZ6eVHAmvkb/Em2Y1GA9Gi6Q1b7WVvS43lJ6qE9Vj1uX41VY9aDD7flzGs/eZkmFtPXc/r/CE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290332; c=relaxed/simple;
	bh=A7Pxi147mbN7hWZK+r3Z3NFPs2zx6bs4DMDXT6cznWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O9LGqFhG0sD6edsiKc3PL1Rz7FCIYvWpJIM6Ha9kK7eJETS3X0aj4nmu8DCr+mVXdenl7bd9mcpqcS9c9slrj09JrZJWZn/Zssu14ImSYZZDHQLt+pLFotiXlUadieCvDL+WTBG3InBVgWw957DuFvTqygLcYBLP1oByeZmN+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WESx5rs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57100C2BD11;
	Tue, 21 May 2024 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716290332;
	bh=A7Pxi147mbN7hWZK+r3Z3NFPs2zx6bs4DMDXT6cznWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WESx5rs/XKVkudIrGI9PywnYl6f37OCFlVevX8Eq6I0tWhewVTjxJG6z7BNhapUbM
	 79c9d7upJLH761VqhN0fuqKcw09EAV/WnDUOuYavq0WiXzk9zOrdMDHaK5mRfvbPHi
	 wgpvxbOoO2NRQ22nrKVr7z/Y1G+VTkUO/2FaMPuknzXwBbijwrtAlSe9+tcw8F/FfV
	 JLPmWxrD4D+7jEv/50/A8tJ6p9eZOd9ZVkwVKXnxurvRbPLU6XXk+QNMIRJmMi+VnT
	 o5Z5Cjv59n/OxaIAoyC4Zd6tp1MYQs8KS+4cs3mUbJqcGtyHSddD/vjR2tu6maguLv
	 FKxlnElqGb0YA==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZktD50C5twF1EuKu@fedora>
References: <ZktD50C5twF1EuKu@fedora>
Subject: Re: [PATCH v2 2/2] regulator: tps6287x: Force writing VSEL bit
Message-Id: <171629033106.30658.6765942472496824274.b4-ty@kernel.org>
Date: Tue, 21 May 2024 12:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Mon, 20 May 2024 15:36:55 +0300, Matti Vaittinen wrote:
> The data-sheet for TPS6287x-Q1
> https://www.ti.com/lit/ds/symlink/tps62873-q1.pdf
> states at chapter 9.3.6.1 Output Voltage Range:
> 
> "Note that every change to the VRANGE[1:0] bits must be followed by a
> write to the VSET register, even if the value of the VSET[7:0] bits does
> not change."
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/2] regulator: tps6287x: Force writing VSEL bit
      commit: 1ace99d7c7c4c801c0660246f741ff846a9b8e3c

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


