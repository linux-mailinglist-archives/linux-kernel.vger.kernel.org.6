Return-Path: <linux-kernel+bounces-524813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9EA3E76F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3511A7AA693
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F9265634;
	Thu, 20 Feb 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPMeJcwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAF26561B;
	Thu, 20 Feb 2025 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090073; cv=none; b=R2w4X+KLEzF5g9SvONvXateZBgqK2Mk+JUrCCm718L2Zo04BBgMXlJ+aKSIpdmiOjlHqX7OhkRudmTXM0XEcbEPm25zWr/+b15stIgfJjBIZEnjtktZan0NI460Io4MoMQnqPshkUAoLuFBFao1mrmygtD0aRrj/WfJn4Py9ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090073; c=relaxed/simple;
	bh=2nHcaqwq501Afb3+1z7ui4ugJwK1kJYJmikmASHfmIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FlQhMxTBU7OZM+xLaPgZiL/yyIVtPaUOFA0HL/py6B+odh0mh4RjwORL+NrUvqHAQaCwB5+wU+ihk/JVHUcnGTZVC9LIhNzwUqf5iYcdOBtrGQXgDD4xVrvWr2QGQOV7mWO8nG8m3Zpxwsz5ftbFpbIsGy69k2fGK048YW5WnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPMeJcwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C617AC4CEE3;
	Thu, 20 Feb 2025 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090073;
	bh=2nHcaqwq501Afb3+1z7ui4ugJwK1kJYJmikmASHfmIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OPMeJcwQPmicrAw5LSJdouT50qDIlGx0nZu4B8hS0Q8Td4l9neDBCyvPpZ03wv6T1
	 Uy/CGXU6RIvXCD1ynowdkjAINmH/GPJ64f940/ILzdswLSHByPqwLhyxROEBcNrn+w
	 YSK5gwUXTtVCM5tghMB+HM4q3+VNmKWnvu5KHLcPTDp8wtluioTowGF8944WaxOeRN
	 7ttxu7WcsJmPz410Q2C1M3XTRkOSnKFv+yPXtuARw9PZvBTIF6EU3rGVvbwARTV7x5
	 lwsUPCBz0d8JXqs8rvvwtFquo0m+dFzJtZ/568rlMhxM+23EGP6nRvrK35GrtCoTto
	 sExihVCV7ASmQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250220120156.1663-2-thorsten.blum@linux.dev>
References: <20250220120156.1663-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: soc-core: Use str_yes_no() in
 snd_soc_close_delayed_work()
Message-Id: <174009007159.2293478.12356716411143352052.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 22:21:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Thu, 20 Feb 2025 13:01:56 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: Use str_yes_no() in snd_soc_close_delayed_work()
      commit: 64899904d6103500ad01be7b763298dc939285ae

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


