Return-Path: <linux-kernel+bounces-398925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6F99BF819
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAEF1F216BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDA20C48C;
	Wed,  6 Nov 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRCCFG5X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73E20C47D;
	Wed,  6 Nov 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925615; cv=none; b=W2TEtZHQkNRPPjMLee1rt5WkTII9SiIFiqp0JOhIUTpIY0E63P/2WgCAh/BFTdhZrsSM8gRbze+1K3GhVHvyJB0sAyg6+KKXm16mME3oUp3n1VxcH38RA5UlSaFTJr9sPvcnRWjiW6ZS6CmLFncAn3kDco+XXLAd+ucpPUmuVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925615; c=relaxed/simple;
	bh=923CZFJy8JdY83rephxGRT7AkdWFW5aNGZ4i8ZHrnbw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sF9oN8apbEeX/EGxVOBjddSt6b+3mYEzpoFmiSS1boV+lypQXqMQbOCy0XkEy2iiLzVrPgfw37DoIP8Bj4ntitbxmPmLeNqe70SIXqLGuLhYBZtOkaj5n7HfA+pSFBbi8+BHTdNYw97qYamd72Ksk5aaI2PgX7nKSAyJ4VoB6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRCCFG5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF84C4CECD;
	Wed,  6 Nov 2024 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925613;
	bh=923CZFJy8JdY83rephxGRT7AkdWFW5aNGZ4i8ZHrnbw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KRCCFG5XS23l1fcbfq1lad1MCtWAtRPLRXGDvx6bqGAfHXvHgFO1lEfbDt1N9SNAH
	 SYGqDHJ/RTrPZzoBWpwbnDHez419bie4EuG7adn5BfppzLignXgck7AnYZZOpbymZg
	 wEBSrAy9FAEMWwTUa/4BcuU/KAhRj1jrZgRugViOMiH3+p4OlxUzDMsXFkMAiecDaL
	 iEcn+b0IKJi6Il1XbsfFkILsTzc+mCwRcwqAX8i5fk+rgDv9363ZPEsOD3kn9tIuj4
	 UVV+s32mtAU2TuSSq+0NSJTP8hvqH3vXhK+Cbsf5bAWq60LfMw25Cf+CpCPEfWHUnL
	 32gHrrtdQJPHg==
From: Mark Brown <broonie@kernel.org>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: kexybiscuit@aosc.io, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106024052.15748-1-jeffbai@aosc.io>
References: <20241106024052.15748-1-jeffbai@aosc.io>
Subject: Re: [PATCH v2] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro
 14 2022
Message-Id: <173092561130.197490.16695681375736124776.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 20:40:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 10:40:50 +0800, Mingcong Bai wrote:
> Xiaomi Book Pro 14 2022 (MIA2210-AD) requires a quirk entry for its
> internal microphone to be enabled.
> 
> This is likely due to similar reasons as seen previously on Redmi Book
> 14/15 Pro 2022 models (since they likely came with similar firmware):
> 
> - commit dcff8b7ca92d ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022
>   into DMI table")
> - commit c1dd6bf61997 ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022
>   into DMI table")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
      commit: de156f3cf70e17dc6ff4c3c364bb97a6db961ffd

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


