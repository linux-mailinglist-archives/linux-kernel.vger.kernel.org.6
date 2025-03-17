Return-Path: <linux-kernel+bounces-563843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8772A6498A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6123B3761
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754CA238157;
	Mon, 17 Mar 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoV+YGpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC8185B48;
	Mon, 17 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206662; cv=none; b=XyMvhoam7pxh/kTochhZm7sQItBd4OhVzGzOt+FniU8tWscTH7/gfPFQsmqIODvmVhDw8XhjcFfQp+uWqzSQ/UbIF4Cux1XKtDKQZTTvkB4tRPwiwPH/5YVOtaOdDFXuhXE8Hd/EWdAwxMey5cuLtuFN6LzsqGawpWmObfT9vPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206662; c=relaxed/simple;
	bh=pzP8/X6TY0uEnL+EQ95e3TSnvM6UdQpCfUDOo2pVmRw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=srnXE8JiP9ATBq+qXNmX7sgUy47XVvGn3/TJcT1nJmDS5T+R01DD2YUmHfLhablp0WXNChySbNmlDz2Xk/SxE2LXCpErAKW/u62b+JCWEMLSfjAIvHvS4gXDWwTERqHlOpN2ioEKgpiDt9cudDJ5rzyvM8Ax6xk9RR8lBZw/Wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoV+YGpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D85C4CEE9;
	Mon, 17 Mar 2025 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206662;
	bh=pzP8/X6TY0uEnL+EQ95e3TSnvM6UdQpCfUDOo2pVmRw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UoV+YGpmpVy0Ki7OuQ2ReZvXZR9aLgYtSEUGbcak51ie93AF5MXToaF81QaMMVM/T
	 KkqOJpZQ8fc3Q51Wkknh2NH0+G3yRqaURNhlep6LGHVw23bt6yrltnRcABpc8uxkEz
	 ng+HJuPeJzy2m7jL9Z6fMQr86ZIKQWTKZFzGMJJ6YfoFldrnd6A4YvK3bk1nM7vhWK
	 3yfPQVk9M5lGGYGq/vpsbuY2oZB94XKRvXilsW4BbDBVr37rQ9ZReGEzJgIvDWmnFx
	 F/38PkNPzYHu3n6RA8fIVIZjI1r595/vY21/XIq+SvmVvhErvRVXZh41hD2BmIPrph
	 8tjjRfaLMmSMQ==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <20250312072635.1429870-1-nichen@iscas.ac.cn>
References: <20250312072635.1429870-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: cs35l56: Remove redundant 'flush_workqueue()'
 calls
Message-Id: <174220666031.86423.18380455333670933184.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 15:26:35 +0800, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove redundant 'flush_workqueue()' calls
      commit: 3cab1fc85f9d381de6767fe97299eecdb8c868fa

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


