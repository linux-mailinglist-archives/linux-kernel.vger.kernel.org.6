Return-Path: <linux-kernel+bounces-211983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91B9059A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BA1C21FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645DB183068;
	Wed, 12 Jun 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3imqW9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970371822E9;
	Wed, 12 Jun 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212187; cv=none; b=kR0/AoW3opbcdjMXU3rf/fi73zSWYhN6QWSbgENW6VKhNCYQ/lah4nnBKcZFX6eOhCYsFwBXDU7N+a2t0qQILq3fQVH19Ssmr1/SMMyeR7E72X3mWKlqxBRb9jdOkWdHpGTfJjCow0NQUlC1uGC6/mHPGXp5iqyFfSFcCrr/vSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212187; c=relaxed/simple;
	bh=DGmFEgFvihFdxQvmqz4ZN/g91RcvtXzAkLA+2ZHUehY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NGbm+tX4zGesb4K8Gqu/HNOQUf7YMn3cXt5wwd8jquuhhY0MWSvlN5W0/QLUrDBX2OHvZizVNGH9OauynvPtIDC6midvllTDf+QWz02Ik4SK3+pqYNcreOpprb6LOFVYNh2vUePQk7aRqus1TzK4iD8ZozAS6ivQGqWJZ4WHex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3imqW9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6637C4AF50;
	Wed, 12 Jun 2024 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212186;
	bh=DGmFEgFvihFdxQvmqz4ZN/g91RcvtXzAkLA+2ZHUehY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H3imqW9P9XFmNrDHk+S9fa3HMBPc+kiQkeLKEYY0m6mMSuBI2SfsSvZajyPgwuNqt
	 gdQaDe0xbfV//r/N8nCEr3xqfS4iRKYXnxzCVQQaYmcPbOfQKS6akzpDM0ZjE0o5Sw
	 77jmlq2g+nt60kE7/Patsnt/EX5yv1z6garTA4ANCEclPRAc6koezf6MhkmfP3diHP
	 knyz+pQBCFnFbfTFG4Dsz2UMP1X1to0NXk3cPmJeNou5vz6KWOZjNDxsxdocp1CesD
	 lokZHcEyumHIj19KDodY4Ub/3/Bnz0qNW/BFW9kyPiQWuc8lERjGLmvYBKjp0Rdg8+
	 uKH0TgCyCw6ng==
From: Mark Brown <broonie@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <01590109-cf27-404b-88ff-b42bb73ca1c6@moroto.mountain>
References: <01590109-cf27-404b-88ff-b42bb73ca1c6@moroto.mountain>
Subject: Re: [PATCH] ASoC: samsung: midas_wm1811: Fix error code in probe()
Message-Id: <171821218296.232443.6293513321320642950.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 18:09:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Sat, 08 Jun 2024 17:24:31 +0300, Dan Carpenter wrote:
> This accidentally returns success instead of -EINVAL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: midas_wm1811: Fix error code in probe()
      commit: 5c33876a20e1f42471c2b6fd1804428311d35f1f

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


