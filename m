Return-Path: <linux-kernel+bounces-238214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728C9246E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D5F1F21994
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842281CB33A;
	Tue,  2 Jul 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSBsnTtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E141CCCB5;
	Tue,  2 Jul 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943402; cv=none; b=jPlKUxErV1lw6Z3YmFkEbFf9YKIRfJ2BV/6qKML9GSQlYdCymNRG30S02LK3pqWbtRK8l0mQ6qxn1vRu4iv/4gamD7HtliachxP7rjDi/TlrNJyAYUiSNmjEVMpqi+Fks30mVuQjcE5YB3HdObKEl4vB1aKe3Ih4kBEKJiVSns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943402; c=relaxed/simple;
	bh=Er855fFtE0tkTlrfhmXtCi5qQalirVV6oBWt2PpMAcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DjY2j7DfirM0O0deIUXp95+fPdG8ralSMfIdW27Zu5fsUaBNTDAe6TQbZsrnSfw75T7QmJL1yjobzf68NGhAXMpTCCZ2m3Yk+WOjFQCa9TXjqAIrhtyKcAV3kXGw1DeUPLMuaT23P3XVQLxWFsfcDEr6EIT6dlz8PLU7dtEC84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSBsnTtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C287C4AF07;
	Tue,  2 Jul 2024 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719943402;
	bh=Er855fFtE0tkTlrfhmXtCi5qQalirVV6oBWt2PpMAcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qSBsnTtv333Tg5/uNsOrIT8MBev3AQVNEGGM7Kfk7qXhandVtK+zgy5oWN/zz0cMn
	 AKjOn2xJrkow1BcvWdm0q7YXxEQZclaGrlw8UvLNbYNvJZyzOJ6MzcdbdBzaPvo0i0
	 VI64DGTw7ccbUG2lxgwnPLqiWvsIinNLRF9z7EuqVJwMwk89RxK18UTEUm5n/VrTJ6
	 DjUmqM1wuqVpN9fYl1eMFOIKJKZqEPxI/pPP0B8HS2ePcbneeaXeCynK3pDqXXigmr
	 AU617yqWTTqi6AfUd79xrw/tZB1boPoB3cMBgRR568j4I5y5ZjPEIjKNTagkuVdgtn
	 wpKdDNQy5etGA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240702110809.16836-1-rf@opensource.cirrus.com>
References: <20240702110809.16836-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Don't allow writes to read-only
 controls
Message-Id: <171994340097.996226.8732396451392780066.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:03:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 02 Jul 2024 12:08:09 +0100, Richard Fitzgerald wrote:
> Add a check to cs_dsp_coeff_write_ctrl() to abort if the control
> is not writeable.
> 
> The cs_dsp code originated as an ASoC driver (wm_adsp) where all
> controls were exported as ALSA controls. It relied on ALSA to
> enforce the read-only permission. Now that the code has been
> separated from ALSA/ASoC it must perform its own permission check.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Don't allow writes to read-only controls
      commit: 62412a9357b16a4e39dc582deb2e2a682b92524c

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


