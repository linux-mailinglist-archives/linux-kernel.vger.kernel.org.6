Return-Path: <linux-kernel+bounces-171636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A171A8BE6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5606F28352D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8016133F;
	Tue,  7 May 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ8hFTSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01116078B;
	Tue,  7 May 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093910; cv=none; b=EhOMjUVk8MuRbd3IrC9QNB9ZwNaWvdP3I/JiqXFmxB/g5LT1n4kVH60XWP2JzWTYwSbHmsWDV/frJkaYqNDyKCdyhjPGinaRMAIVggPwxWBbY2eaLFT2nGkBz0xAeTKG7dlh9Tjjp7GM6EATNE/aJeK6cj/3UM2Bcydx3w8JH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093910; c=relaxed/simple;
	bh=LcHM3+qVcLH5nuxebh+JFQGeN3ugF3r3mXDF97hD8sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LbgMnTKuK92pDRgnaJ0JEzjLVRPNff0JVhjAEXc6ZKooeMXDxjjNctOQTz1oCRguLzy2vr38JylRam557gWLhp0IRIjAv3/AxrO7E2fIXeij9Rohg/YGXW3DuTAOBGVpaSbWJ+vkZKxtodiWW5MLVFQS5L7fZUH+45VodoFC40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ8hFTSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA117C2BBFC;
	Tue,  7 May 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093909;
	bh=LcHM3+qVcLH5nuxebh+JFQGeN3ugF3r3mXDF97hD8sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AZ8hFTSdhpSZFV07v+QLagy42rPEykgVfcH2J7Zbf+UujgCqnwDlTAeqS42G6pIj1
	 I/KEDwWXhc6tv0Z1XvWdwmQiwnZgRq78xbl1D/wA0gX35KelhTgXWssXI8eosIsj3t
	 46SFZCVaZU7x2QLI874PEx02LiLI03juBXX13a7mcZjSgxwr1zSI0yaHRh5j+c+Vxh
	 uSMx9jI/i5XR8IWioS1HDKp/XHt7Gtb26v99GmSXuLiV//iYPC1zIWi51KWifU2+0S
	 3fPmBTZCL/5XGzxiQpqZtr+oS3swLLoR/mAKXbYDAPkB0+nFAVXIPxvVl3ZIbb4Ye/
	 8MxZHgaHbW1+g==
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <5e039cd8fe415dd7ab3169948c08a5311db9fb9a.1715024007.git.christophe.jaillet@wanadoo.fr>
References: <5e039cd8fe415dd7ab3169948c08a5311db9fb9a.1715024007.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v1] regmap: Reorder fields in 'struct regmap_config' to
 save some memory
Message-Id: <171509390823.1990981.2169918651206303551.b4-ty@kernel.org>
Date: Tue, 07 May 2024 23:58:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 06 May 2024 21:33:33 +0200, Christophe JAILLET wrote:
> On x86_64 and allmodconfig, this shrinks the size of 'struct regmap_config'
> from 328 to 312 bytes.
> 
> This is usually a win, because this structure is used as a static global
> variable.
> 
> When moving the kerneldoc fields, I've tried to keep the layout as
> consistent as possible, which is not really easy!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Reorder fields in 'struct regmap_config' to save some memory
      commit: 9b1fe0510494c989ab6a131ce8b97cdd02a1c869

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


