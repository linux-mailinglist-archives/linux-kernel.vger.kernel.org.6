Return-Path: <linux-kernel+bounces-577319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4AA71B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05083BBB90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CD1F560E;
	Wed, 26 Mar 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi1IWah+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350E1DE4DD;
	Wed, 26 Mar 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004928; cv=none; b=jAp5d616DNhzCfVCg+ku2oFnoSs0aMrLlLSgLFHGrpWEnK4zxQatP9SLJ8gQ6ylFt0WEe7/BCFKJBvQcD4ffZ84UJecJbJoeVqTV4WIqC1Fk4YrRhm9bihuHP1al1RsF7PvwGnwljkWVFjofpulTtfVD9/itpVTK9IGN8ntBz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004928; c=relaxed/simple;
	bh=pplppaFO6QVItJzckIXcvuGgTnawmTNkFco0NUnLDSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fL03ffhPzQgq4X/dehf6OJBIgTNuv06JyYjZuai2dEqrjMQuu31f9OXR/jDRiwtN2ywSVxTbuMxAYjKeft38HF3DMKb4r1/kTs2cVT5fV9CSgJwLDjCEZXxcTl9GHbhO6MR+Mi1yUgvVkmRfllGroq783g8nMq/3vt8XIyn2byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi1IWah+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD8C4CEE2;
	Wed, 26 Mar 2025 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743004928;
	bh=pplppaFO6QVItJzckIXcvuGgTnawmTNkFco0NUnLDSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Oi1IWah+AgayPD4ZBxF9DOlufsIXXZcMcmtsArfJHU/q8aD70rz2aN8wwrMjgF6EM
	 qMRYiIqaVWHK5Pg7bPL0ADYVcI6h96SCZYMPTy42YSsQIG3e5dZEP1vtfCf0WMNoow
	 I2rChsdf85Gv45ai2aWz3VvTNuXsz/903BqteMS9wGAvm0Io0sR1qjOtTpRvIHylVd
	 sxl0Ww3GeU1bvPvI9ETEo90WOk8CWVdFyVmSRl4YD6fJ9Qx4H00C0fOmki+96VCb87
	 W5Xwluqgg/heJak5OnsINpp6NJc37Ttc+jdGAOJz4Ya2LZSfSGVFmq6nntXw+aI/OT
	 6EeiZt3hXZ4EA==
From: Mark Brown <broonie@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <8d32dd96-1404-4373-9b6c-c612a9c18c4c@stanley.mountain>
References: <8d32dd96-1404-4373-9b6c-c612a9c18c4c@stanley.mountain>
Subject: Re: [PATCH next] ASoC: sma1307: Fix error handling in
 sma1307_setting_loaded()
Message-Id: <174300492606.114957.8504606772761953074.b4-ty@kernel.org>
Date: Wed, 26 Mar 2025 16:02:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 21 Mar 2025 17:35:25 +0300, Dan Carpenter wrote:
> There are a couple bugs in this code:
> 
> 1) The cleanup code calls kfree(sma1307->set.header) and
>    kfree(sma1307->set.def) but those functions were allocated using
>    devm_kzalloc().  It results in a double free.  Delete all these
>    kfree() calls.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sma1307: Fix error handling in sma1307_setting_loaded()
      commit: 012a6efcc805308b1d90a1056ba963eb08858645

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


