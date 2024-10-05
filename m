Return-Path: <linux-kernel+bounces-351646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5499142D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728701C2245F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6922615;
	Sat,  5 Oct 2024 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb/Ik5ac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F03FF1;
	Sat,  5 Oct 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728100280; cv=none; b=Aq7rAKMeyBE/jGp1zSKXo34E8XN6UqSAkx6T1BXWyHLA3OcAAF61ObAqMn0BPajndUlDgUM0VYw4A+i0i5SenhY3shGYJsd2hyMXiK0Rrnz/LgEw9LriBB/JazvkdQbSRwSi3fvZ6v0jOKRv7CMV1ZOeoVUiT7C3yn3OKfY10Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728100280; c=relaxed/simple;
	bh=LwpJjL/sAZamAjbREfwblRFe/pUWGWf4oudQBiz54rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TAaow6hHUbp3868aFBzzwM81biSAk/Lwc6G/E+uu+BWn93gw3Cf7tuBVzOHvvYPCcT5Xl2ZBwr0ROxNADdKGP5s8aOEsKV+1ZkIN5s91+90a5tugpc5Ayu7fmZ7NrI+8ZwJ4/+89neGy5rAMgrfKLYSs9Y+uau0A6lcYQJOlsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb/Ik5ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB33CC4CEC2;
	Sat,  5 Oct 2024 03:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728100279;
	bh=LwpJjL/sAZamAjbREfwblRFe/pUWGWf4oudQBiz54rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pb/Ik5ac1zGRheA15syfndYOOvy73c90bPQPVxm871bmWsMbGYDrjomhqi2AtbxIE
	 3nsrYWCJn7l+VIKNngJ0bxbREgXEv5BuJ2Q5z4y6hba1GWlTElttgb6nwxfmi8uZuc
	 SIVoAWPjaF8jE70V4EX/Fbiqoo5LUO+BX+EIBZn5CxRfI10qQQKL6OAZ4AmBfXg35H
	 Wp49z25WRy/1b95jcLtLvq3YcFA2IARpS/KtMzoUcBtw6K51CODQQcXDIGF+213Zwj
	 qUpf67QGvVTeO5mCeUKV1Ww5FyjrIozk/Cv38jTo5T02w033VxkIZ/EbLWN+iZuWdp
	 Fh4SjQetlVBlA==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Herve Codina <herve.codina@bootlin.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20241003122015.677681-1-herve.codina@bootlin.com>
References: <20241003122015.677681-1-herve.codina@bootlin.com>
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Remove the logging when
 parsing channels
Message-Id: <172810027430.832098.16999500333273178564.b4-ty@kernel.org>
Date: Sat, 05 Oct 2024 04:51:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 03 Oct 2024 14:20:15 +0200, Herve Codina wrote:
> On each channel parsing, a log message is issued. This log message is
> not needed and become annoying when many channels are used (up to 64
> channel supported).
> 
> Simply remove this unneeded log message.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fsl_qmc_audio: Remove the logging when parsing channels
      commit: c6e86e19e778553dbedab617aafb25b6bbaf4cd9

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


