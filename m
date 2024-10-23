Return-Path: <linux-kernel+bounces-377976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857599AC96B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA71F224B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15441AB505;
	Wed, 23 Oct 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B52nSJJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4249652;
	Wed, 23 Oct 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684316; cv=none; b=NISrycBcZ+ikWbclePycV2uSRYjlVDbTLTkJ13jgOylWWfG2pkYBwwWiGhq9hYpm35UrMJHefvtahn3InhahZVRNLZLOcmlrSuZIWo/9a3gZTpn2hgALVJyWmsCg7/I2MK0u0j/pQoMw47la2IJivR2SIFmeDABWJ9cmGYh0YDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684316; c=relaxed/simple;
	bh=/Q04rYD6s7mKlKohcnk5dUrsgTRIpLrVCMnNLencu9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ag1HplslxKrYNkvRgOPxHakbPcCT4Gi7x9ywC2qHsbb1ShODFjf5NhfKqKZw3OpOh5uT8PaH421Sz/ZWmbluj1ghj176nezehQeMOZ0RlJRPy2t1QJ2oM4Yp1oEcxzvJkIr2yL77JqKP0wZnIcsZa8NC5Ct+8keOk5C4CZcHblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B52nSJJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19307C4CEC6;
	Wed, 23 Oct 2024 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684315;
	bh=/Q04rYD6s7mKlKohcnk5dUrsgTRIpLrVCMnNLencu9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B52nSJJvrk1x+Gm0WVd0QtrTt/kQAvg/gTJ5WwFkgpFnvCqXP5vXAa9xWfhJRb2+4
	 ppDiNnThGGu6LXR6bTNjcn5bH2C8Kq3wGB6QmUZ0QdISGv6CQrOR6y7X21kY6E9zJa
	 9vwrkUKckGRCLSchL3a5y6cDW2TNeYoTIQE0aWjIGeXRlzKhrvc+kXlYhAPuj0JDwz
	 qhw55fAMdhqHsZ6URpq3buwIcdr2m1Shl1xm3G9qYbZ8zFlYgzIRQuHkxW4kSLROxn
	 6qKqFa2Oz8NydKeOPgDa/pEWFF8sJ1/ELLBaBrVy05NynUER+qvuA/ufPiyhtHwppd
	 e+0BeWtVyKong==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, hayashi.kunihiko@socionext.com, 
 mhiramat@kernel.org, 
 =?utf-8?q?=28=ED=95=99=EC=83=9D=29_=EC=9E=A5=EC=9D=B8=EA=B7=9C_=28=EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EA=B3=BC=29?= <ingyujang25@unist.ac.kr>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <SE1P216MB2287962B462AE91B26248D19FD7E2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
References: <SE1P216MB2287962B462AE91B26248D19FD7E2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] ASoc: uniphier: Handle regmap_write errors in
 aio_iecout_set_enable()
Message-Id: <172968431380.31331.15335444902728869740.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 12:51:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 08 Oct 2024 05:20:30 +0000, (학생) 장인규 (컴퓨터공학과) wrote:
> The aio_oport_set_stream_type() function did not previously check the
> return values of regmap_write().
> If these functions fail, it could lead to silent failures when
> configuring the audio playback port, causing improper behavior in audio
> stream output via S/PDIF without any indication of an error.
> 
> This patch modifies aio_oport_set_stream_type() to check the return
> values of regmap_write().
> If regmap_write() fails, the error code is propagated back to the caller
> to ensure proper error handling.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: uniphier: Handle regmap_write errors in aio_iecout_set_enable()
      commit: 9b0c65115acdcb6fd6bbeb360c1f4f7b14c9a610

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


