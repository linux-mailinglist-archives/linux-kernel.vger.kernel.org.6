Return-Path: <linux-kernel+bounces-566670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F264EA67B01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0893B3DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA5212D8D;
	Tue, 18 Mar 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNN91uK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4F1AB6D8;
	Tue, 18 Mar 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319115; cv=none; b=NAxCZnpsOuFI7CHEwJQIMm6nY0afjxMNbabULYzSLyyLc2JAoGKQ4DSeNeSUXdL0BbPbctdSqxm+K/6M9mhuzg0q+XYtSz6qM96dAYx85nAfliBCHig+G7U0FxZ/nSVd/Iaz5U1XtV3bAU6SDQNfVvJfNLMlQakC8EaUgGr5NuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319115; c=relaxed/simple;
	bh=w3w0eom8TFIcWpUjP2gh6FpcyIwp6pHrIvP7MHMMYLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rCvekLBRWbWQGsRpQ+OB7GG+Fv6ZSfAiqZroxb70nshvFB0qPzztac99g0DgGtG5Ff9Zv9lKl7nqSjMO56dUOilOaoedhh5H/C2b/eTiR6vVVKqo5jPDhTpLlu/kPcZrLYEhRohZ5aM7wziJPxqJpE/X3LsOXgT/89xe4PWfStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNN91uK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11F8C4CEE3;
	Tue, 18 Mar 2025 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319115;
	bh=w3w0eom8TFIcWpUjP2gh6FpcyIwp6pHrIvP7MHMMYLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tNN91uK1SE1trZ6SEklSj4xBPGlfiRNCWZnsHAz8zt6Vf6PHQ1vhmAoB0Y56EJ4Tv
	 itLunajritUQ5mX3HLxmXg3vbsu3+0vPiuH3qWIt8BdgLCa22n09k+7GTaH6UQACjL
	 rIkm28I1HkQgB67vzpBceCh3I06RP0DqvhJrlHJ+VvW8kVgo1+4aOaiy8nKLKjYIoj
	 ki05issQXDxAO7adZXuE7W+MR+mTd5uMeJAwEOr8bZHd9ZzkC0dvqlVjOzbjH6Tvdg
	 jiqba5qHvi4uSu6rFpERYBTXQCj2L45J149wHuhBECMKNnCiXBxeq8dq67Uc6YH96/
	 h7YctAAMoepFQ==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, Jayesh Choudhary <j-choudhary@ti.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
In-Reply-To: <20250318113524.57100-1-j-choudhary@ti.com>
References: <20250318113524.57100-1-j-choudhary@ti.com>
Subject: Re: [PATCH] ASoC: ti: j721e-evm: Fix clock configuration for
 ti,j7200-cpb-audio compatible
Message-Id: <174231911337.192994.1707640060973057001.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 17:31:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 17:05:24 +0530, Jayesh Choudhary wrote:
> For 'ti,j7200-cpb-audio' compatible, there is support for only one PLL for
> 48k. For 11025, 22050, 44100 and 88200 sampling rates, due to absence of
> J721E_CLK_PARENT_44100, we get EINVAL while running any audio application.
> Add support for these rates by using the 48k parent clock and adjusting
> the clock for these rates later in j721e_configure_refclk.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible
      commit: 45ff65e30deb919604e68faed156ad96ce7474d9

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


