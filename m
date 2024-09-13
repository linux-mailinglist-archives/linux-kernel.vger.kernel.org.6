Return-Path: <linux-kernel+bounces-328542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D287397857F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A211C22391
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0D61FC4;
	Fri, 13 Sep 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmFTTI5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDDD502
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243914; cv=none; b=SEt4N9z1LEnWgurTBWfwT9A0r593yaqdC7FmM3G5fr5kFBEq2UagWTHH3dW+HRqAqXSK/yMdx3SIUFzK8sHzuF5KUAsHHfcpPrg9L5wTJLn3CpRJxxmTSYbPL/Vf7v8YvuXG40RLQrc92vdGG0L170xY7CLp+E2fajwUgItOyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243914; c=relaxed/simple;
	bh=jJ7GGk/SEpPhBsqY9TwU05VGh8FWZQyCHY7jTTS5qEI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iaBoYe2b3vyPtqX4iwe3WCnAumehzrGLkE3Sz8/DYg1julqiIbme/7O9s/tY3VyIYyVsAwjfKY4NO23Poc4ROzgtRdNCicRwmq6sNkeAuIZVsOxrAzYa4G0eCBtNti87lMNd5qEVZ0h32hUjBXS2wfqHJm9m1uaIrvsx3D5YVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmFTTI5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FAC4CEC0;
	Fri, 13 Sep 2024 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726243914;
	bh=jJ7GGk/SEpPhBsqY9TwU05VGh8FWZQyCHY7jTTS5qEI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EmFTTI5nXO9FXCY+Yst89PJEfKEeB3DADT4DgVZfGfrY8yS8igGxbe1pwGDIxlEnO
	 hJ6eIDcFjKv1JF8rK4biQm1TFHqXqZNXpDUwQL3tN1QCyobSW3VP+EinEwhI+auLHg
	 tgpPCAYUtklFsAtmYLojrRkUdiSiP4qFmhn3GfmOS3gyOW+pfojbku3J0JJNdzyhzt
	 Ucb/tzl9QbrFbR/8lJZ6gyeUyMRnu1U+82wP714Kl5HOOAtCpDtLk2VKur8VwD54vm
	 E8qU70YESY+8kAM8E58N5VeYgoXhcaaopwiJouAdIV+J+a01os0f+EZJB3Z+PpLCeE
	 0BUuSWQSV2v5Q==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240913013503.3754712-1-ruanjinjie@huawei.com>
References: <20240913013503.3754712-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] regulator: max8973: Use irq_get_trigger_type()
 helper
Message-Id: <172624391334.49323.11300145569204305018.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 17:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 13 Sep 2024 09:35:03 +0800, Jinjie Ruan wrote:
> Use irq_get_trigger_type() to replace irq_get_irq_data() and then
> irqd_get_trigger_type(), if the irq data is NULL it will return 0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max8973: Use irq_get_trigger_type() helper
      commit: ff97b9c0df585d14c4c6b9c4cdcbeba43f7b885a

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


