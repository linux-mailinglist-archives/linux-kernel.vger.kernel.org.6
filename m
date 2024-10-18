Return-Path: <linux-kernel+bounces-372466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91269A48E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E101F24296
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BC190493;
	Fri, 18 Oct 2024 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbJ9I6Pe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654C19007D;
	Fri, 18 Oct 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287043; cv=none; b=tTHcGeA2XwODZCuH7ytSCcM4yyEj50sSlcB5tTSCieVvtZx29PE+0AebzZyQza7peRQg3feURCOCpEAs39A5oBRhlyRSVZ7oAHL88Vz35GFbvTJNq9aEvZSuBwJgHgA3mA2uwp6rsMztMQaUTG1FzFwXM4Bi4IsfExYzdOwnrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287043; c=relaxed/simple;
	bh=bd7zqGrKt29zOyO1cGYsr3FOMFt4VVqROBGt8oxJNRs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EtWPMPp1UYUlD8qc+eAqPAef+YJvDrjI2s3tTC/+pnOqgsOfOtlc01+WTk66ZUtAMvxpIG8wbdCFZQALUy/BRPvGHfTudPjR6r313qpBCXvMFUpmFDMHAqRerQu6b5r0lofz90Ry3PIOhj+tbdUszUfr1XYZfuo308Ph1BKJ9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbJ9I6Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AD2C4CED1;
	Fri, 18 Oct 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729287043;
	bh=bd7zqGrKt29zOyO1cGYsr3FOMFt4VVqROBGt8oxJNRs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VbJ9I6PeF8RQAviyGZQl6FnjRoFk86rwPMF7ceG5X5rap30uDjPmHrctjo8dQOs9A
	 ytr3HBuo833OgANJwKVsrSxsuWZzPnRY4Rzmm+2Eq43RkNDXHSonfrhWSIZj5XG8y/
	 9Rs/rktl6k24rnPSuXlQQAngwThTgqb7d8m1b+FZxACTOFk5noyIJFX/v4NauQkUNN
	 /UA4meQSQZ6j+Sesj5Q6UsywMOFwiDKtvzeSFBU0bqsi6zPP3XWQoFcJE2f0vSbtKD
	 jD/V+S45WTHPpJN6U4jNGl38Ap1B3xp3IIaDwav0eNf3OPyZx5NraptjV0qy+aAtQG
	 xxQk1RhLc+yiA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20241017071507.2577786-1-chancel.liu@nxp.com>
References: <20241017071507.2577786-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add a flag to distinguish with
 different volume control types
Message-Id: <172928704112.212383.3559380039082750889.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 22:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 16:15:07 +0900, Chancel Liu wrote:
> On i.MX8MM the register of volume control has positive and negative
> values. It is different from other platforms like i.MX8MP and i.MX93
> which only have positive values. Add a volume_sx flag to use SX_TLV
> volume control for this kind of platform. Use common TLV volume control
> for other platforms.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: Add a flag to distinguish with different volume control types
      commit: da95e891dd5d5de6c5ebc010bd028a2e028de093

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


