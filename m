Return-Path: <linux-kernel+bounces-531733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F5A4443E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E71188BD31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF3B26BDB7;
	Tue, 25 Feb 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu/o1aR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92A26BDA4;
	Tue, 25 Feb 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497010; cv=none; b=AP3dSoFad1Yz8Ug2x5SdawANMS9zZ7ljsAQHd6bPXGYdP0rlWCzQjIn1Ub5KHfsmY0+7o+6Y6V3O4RXY5CZAqtRkbSAcGglUQbhkb2jLcBGTjLf9RBTReUvvEaXo3NQrfQokxII/+lAYIc21ClVzzlU0uJjD4/nNmbQ3LIwQKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497010; c=relaxed/simple;
	bh=Tzn/9eNWuHdFVskUYV6vkNglzOC0sJhfMg7yZDmW82U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GdUjAu/YLGsz4qLFBSxlKPjdMPgxUAKD7CvrdqS8z3qfDTrBvFGLMYNbh8BshgYVMqBGNnqggHgevsmDkwTNnUJAfu2ZvrCEFIhvKuTbbDsFpa5eZvxQRnI3g/98xAnAOnw6oAikub3W9XaMi0bKgoNYEFW9B6jMZ0sRx/zt6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu/o1aR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF54C4CEDD;
	Tue, 25 Feb 2025 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740497010;
	bh=Tzn/9eNWuHdFVskUYV6vkNglzOC0sJhfMg7yZDmW82U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gu/o1aR/lmSVyHK9F3eiDPcxFDUTIlT4zmj7kAA6rXq5qDsAzvYeKtvIMfg9CGxvH
	 tKUAuBEbQbFjkhqkeyX9jF82FMatB+xSVMi0x6xxd7XWz+tOxCZ9EC7ttH/QF4WO99
	 ZkzfxK/71Hg2hSCrf3tmH9O+IPTygZI99kwZzcGxij95lbGAp2o+HziAECGvBPJhd9
	 8FTYsX37A06nIBlT2pWeos/wsRQGTxgJpf4tZxJ3f6ILzG3tVAt5OmZCvt1ZLyEPGK
	 lbndOS4DltfphidRKZv07ru2tgifG7PRDcn1f3zQoYHVEOjrjjvVQvosEoVJ7w1Fgd
	 25ii37gvR0HRQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224221214.199849-2-thorsten.blum@linux.dev>
References: <20250224221214.199849-2-thorsten.blum@linux.dev>
Subject: Re: (subset) [PATCH] ASoC: amd: acp: acp70: Remove unnecessary
 if-check
Message-Id: <174049700783.77394.8393718992202773075.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 15:23:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 24 Feb 2025 23:12:12 +0100, Thorsten Blum wrote:
> Since list_for_each_entry() expects the list to not be empty, the
> iterator variable cannot be NULL and the unnecessary if-check can be
> removed. Remove it and indent the code accordingly.
> 
> Compile-tested only.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: acp70: Remove unnecessary if-check
      commit: 8fd0e127d8da856e34391399df40b33af2b307e0

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


