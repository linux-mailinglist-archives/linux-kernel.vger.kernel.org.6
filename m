Return-Path: <linux-kernel+bounces-302340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0395FCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF891F22E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787E19D8BC;
	Mon, 26 Aug 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdyUMeqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71719D892;
	Mon, 26 Aug 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711830; cv=none; b=JYguJldnqMQWrjVOfLwPHsfM68icqKCwsNYoRqjChtuVFFU1TmDeNB9UMWVAuh7c2qz3LQTzh9gUhJg1WfpgVfbmENmfioXv0vu1xLndjl9riYHY7kTM6G2i0SvMs0MtZlxkaCBBZVZ5OX4sZ6eyzThtkgQ4HDsWGIKdwiZPGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711830; c=relaxed/simple;
	bh=owF/uU5XYoewaMP+Grcjv11JWy/GgILqWerwTJo4fjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mqAYGvqyQF4CknmBHT/IsPvWf0PkQ6lKtScYgw/whJ/v2FjcRoLFaOgv9ndI6jzPMzA/3tg8Yb0QxZyenfupEmn+29lQZ27Mvvx9rmaBoddXCtO97NkNkRNhQxwxrZUcXnR8XfW6YwjwALUhjGkzGAkJG5URY6jV+12lfxaQDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdyUMeqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CDFC4AF18;
	Mon, 26 Aug 2024 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711830;
	bh=owF/uU5XYoewaMP+Grcjv11JWy/GgILqWerwTJo4fjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gdyUMeqk12Yv+9HlARB+KuO+eIf1Tnn4+0As0q8jcIXXsXpbfWmtjy8TWFELz8UhN
	 3MCOjoCnRHSnDdwtxCDa+BMCXaFLZZ9GE+3o5okHGTbkhpN+5pZoQfHyDAEyEi6M1z
	 Xc69NjdhiAKUfz8vqs1QKT5Cyteqn4xxETM3uS8bgamdWI4j1YBe58ih02Dc0ZVZye
	 adCRuI/e43OPMRxIFDcCRrJNEYG1K4sNTrW0GBjChW2dvGLCpwxVoh/HbvFIC+Q5EB
	 RoKv3bhlg9Mt31R8KV5A7TTgewQs1O/L/nib7oGV05mAzpJKUEMdRehykDjYIkkNUV
	 WCFKzofa9lDZQ==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240826182442.6191-1-laurentiumihalcea111@gmail.com>
References: <20240826182442.6191-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: ipc: replace "enum sof_comp_type" field
 with "uint32_t"
Message-Id: <172471182590.865478.17639735740855065708.b4-ty@kernel.org>
Date: Mon, 26 Aug 2024 23:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 14:24:42 -0400, Laurentiu Mihalcea wrote:
> Normally, the type of enums is "unsigned int" or "int". GCC has
> the "-fshort-enums" option, which instructs the compiler to
> use the smallest data type that can hold all the values in
> the enum (i.e: char, short, int or their unsigned variants).
> 
> According to the GCC documentation, "-fshort-enums" may be
> default on some targets. This seems to be the case for SOF
> when built for a certain 32-bit ARM platform.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc: replace "enum sof_comp_type" field with "uint32_t"
      commit: 22652022c7eef3c4ad6ab5f13a6dfc7f25f853d4

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


