Return-Path: <linux-kernel+bounces-344817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498298AE87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA8A28394A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548A1A0BF4;
	Mon, 30 Sep 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdMLkfMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E51A0BC8;
	Mon, 30 Sep 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728657; cv=none; b=H4Pw92jp0Y5XFm4rYEJMHnkVjFjoFiZW8tUmL4LF4D2iWa2UI94shSQjiryORLlKuAa1jeHj6ObmSwveVC8fBL0U6V1xaWhtoClby4en+tuNvniNs9jM4STxHTt9hpCzDu8IwHQLptnY/qdJ+dvXx3fIwBSqRiUtNAu7bubdwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728657; c=relaxed/simple;
	bh=pcP3hBEi9y72cQ2R4EzM7rzibaYlvtHs7R5GrRv3yyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ixQg08lKvqtjHmp17ejdTvqGUXvBgQsH7+MaIiDsZU+KwW2cDbYHnMpM+hUpcViEPp/PWxYUvlsz1BSdwUhejneG40pVh7mxVZzy2b1gGpY1xsDbuNtcYkHE6Rj20zlknJCP2soJM6z1vtS1pLVR3eAf+cHPTerky2zzy3Aim/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdMLkfMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FDBC4CEC7;
	Mon, 30 Sep 2024 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728657;
	bh=pcP3hBEi9y72cQ2R4EzM7rzibaYlvtHs7R5GrRv3yyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hdMLkfMd64fraj/gBVbB+CU+RJeCZIwilSevMEmP+tPzG2kVmrSqAzV2+0b7ew/wM
	 H9+xaY1reYeWehepiAkXsWlnTvnP5g8aF86yJtZJVOlgkU6jPYK1PI214h0vWscqZh
	 Z6RjAeSX+LEmU/1+gUaFc+EiDCgHZxk5N+EVy1izWaWSI+7irHr/W703ij0+Whmqv7
	 2otrkdzodZKHUtMBDpKO1MzviG7Pr/7IAE32tZyrr0+SNIANPDaKVV1O7hpzLujwEu
	 CJs1VYI/NUTEcadumqK9lq+BiJjzJKaG4BJSyQe8m2hWPDfTBq7MtOpXO6jnNyObrE
	 Mt3j/QuMj097w==
From: Mark Brown <broonie@kernel.org>
To: kernel-janitors@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f9d7a026-a67a-4164-80f4-578b1fbf71ac@web.de>
References: <f9d7a026-a67a-4164-80f4-578b1fbf71ac@web.de>
Subject: Re: [PATCH] regulator: Call of_node_put() only once in
 rzg2l_usb_vbus_regulator_probe()
Message-Id: <172772865592.2147169.15364434698443632490.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 21:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 13:34:45 +0200, Markus Elfring wrote:
> An of_node_put(config.of_node) call was immediately used after a pointer
> check for a devm_regulator_register() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Call of_node_put() only once in rzg2l_usb_vbus_regulator_probe()
      commit: 7368e9f4e25bea507895bf194bd1c72d693840b2

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


