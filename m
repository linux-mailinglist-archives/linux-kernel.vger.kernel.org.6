Return-Path: <linux-kernel+bounces-266199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62393FC44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E81F218CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE431891CF;
	Mon, 29 Jul 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvM9NnbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA41802A8;
	Mon, 29 Jul 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273463; cv=none; b=KABkhKGFAHu8pcmEOj7R5VUlssjg/xsuLTxQV+OLN3F7XVmXDvkb4ORB0c+PX6KSEU9pmmQrjD0UARaPf8A+jeA6wCEsyZopXSSaZkwBWQJ8j8tGLPDRm8fRaEIQMV8pL7kfa9pIDY3k37jNiDuEbbMW6+S48UaLR9oK3o/VEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273463; c=relaxed/simple;
	bh=IgGPgeudGRZ3VVlhR5DSGTj9KvKP6DefgGLMu8OF8Qw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GnXRrsRKcRgdYhKj8/UYAOu9QUMiPT+aZ5bOlpUTo0LB9nmbBa9jph4qyd+rJqV6YcEEXjseIhaqj31kOE1MFZrjmQrZ62VnGn9JLz9in3ND8CwXLjfmj7wl/mP7cN4Wjuhgdk3tFZynTvQIZD1s3bMzLoVmle0/NU2thVrRvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvM9NnbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67709C4AF0A;
	Mon, 29 Jul 2024 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273463;
	bh=IgGPgeudGRZ3VVlhR5DSGTj9KvKP6DefgGLMu8OF8Qw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hvM9NnbEV128nkj8XteXiokTuYFvJikp8m0r2kZrxGzwq3fb45cwuPyyin9o7702Y
	 lgybZW+YK89nWs7DJmu/nPFHmz2W9I5lgRUMahRm3nPnDXdYrOqjnNV4Ef0oilZm0G
	 dzzmLJ7lgnfgj/xcKa1BHKtHvN3ZMUgnOJHgx5n/Mxl96//LFp4oCEMZlg5ap8v+T5
	 R0UmgkJIPx5e+PZPizSQ/ykiZX28KlzN0NMGC7rll1Lt5I5a2ZFAnVPbZxlBhASud1
	 XYktslMZBBAvyHAtfDOwyhUKdDfUc5HJcuHkGwwEpCAzoKypxppdfwIAVYgo6qXDl9
	 r/o3sd2n3u/AA==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Jerome Audu <jau@free.fr>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727-sti-audio-fix-v2-1-208bde546c3f@free.fr>
References: <20240727-sti-audio-fix-v2-1-208bde546c3f@free.fr>
Subject: Re: [PATCH v2] ASoC: sti: add missing probe entry for player and
 reader
Message-Id: <172227346114.109775.10465470972478318748.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sat, 27 Jul 2024 15:40:15 +0200, Jerome Audu wrote:
> This patch addresses a regression in the ASoC STI drivers that was
> introduced in Linux version 6.6.y. The issue originated from a series of
> patches (see https://lore.kernel.org/all/87wmy5b0wt.wl-kuninori.morimoto.gx@renesas.com/)
> that unintentionally omitted necessary probe functions for the player
> and reader components.
> 
> Probe function in `sound/soc/sti/sti_uniperif.c:415` is being replaced
> by another probe function located at `sound/soc/sti/sti_uniperif.c:453`,
> which should instead be derived from the player and reader components.
> This patch correctly reinserts the missing probe entries,
> restoring the intended functionality.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti: add missing probe entry for player and reader
      commit: 6b99068d5ea0aa295f15f30afc98db74d056ec7b

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


