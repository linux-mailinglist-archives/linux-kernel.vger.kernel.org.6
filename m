Return-Path: <linux-kernel+bounces-269314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F66943166
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8791B21B41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAAE1B29C6;
	Wed, 31 Jul 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsCfmhZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6BA1A7F7F;
	Wed, 31 Jul 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434007; cv=none; b=JZzMsXcGkglm8PLSJ0JInZUWO/9ROH/TtDglD2J6oYJ7XNeVXzcDCTfYFwPhgz2pj484ecobWw5KPoInX+/KgBxVmYJt+DuM5TzFYDgpCnPBUasf60mflGkt7r6CdWJrcQu3QUbmPGaJvYwaPNIl3tnra8gjTqdD33Fz9FoBp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434007; c=relaxed/simple;
	bh=h4jkxfwJQEcLEg45LO0JMK3kGyr4gy5FVoR95arp49E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rhdlhzDlOrinUZmkhiuWVDz1KiPxkxd4KG5z4owJo+PvY3ee+cSvFXXk0Mi7MjxQK2JHlY0mK/pmtbxPzVjcL0v0S8ZAdH4H+ci4EbOnU71OZMpJKZl2TRDMLVAEotsZ6lmjNglVaRA6WYWTJxY54a20uToO+P0LgSYuHPyjcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsCfmhZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D1EC116B1;
	Wed, 31 Jul 2024 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722434006;
	bh=h4jkxfwJQEcLEg45LO0JMK3kGyr4gy5FVoR95arp49E=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fsCfmhZSDqAoNxS7TL+g2Cyvt+P/djSELkOmXa7C+3x69n/p7AFXQLdp2LZdv1Uva
	 N6idLgS1d45bF4NwpxbF4ai0HmK61KoO0CBvLcOAIr0a3XT/+daWBl+E7Y9Htsof+3
	 6oeBJt5ZvQyZjPAH6gUD4Nd0+7yFubIJL3QzbOAaAwo/Efb/XaE28ORi0xDqbbYIYi
	 Zw8l179LS9wrWRqCetYFm+GD9YWwsPEgYBC84TU5FxTr0Zyq2D/2s7dJva9X0yRnIj
	 Ks4BYMr873zY+q6Hx/Rk8GzroKrJpVeSA5K2DQOSPzzuvxBgXm3h7d6UJK4iav9xQ8
	 0uEV4bU/px5XA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_micfil: Check the difference for i.MX8
 and i.MX9
Message-Id: <172243400439.75630.6636735348572180704.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 14:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 25 Jul 2024 16:54:52 +0800, Shengjiu Wang wrote:
> There are some register difference for i.MX8 and i.MX9
> REG_MICFIL_FIFO_CTRL definition is updated.
> REG_MICFIL_FSYNC_CTRL, REG_MICFIL_VERID, REG_MICFIL_PARAM are added from
> i.MX9
> 
> Shengjiu Wang (2):
>   ASoC: fsl_micfil: Expand the range of FIFO watermark mask
>   ASoC: fsl_micfil: Differentiate register access permission for
>     platforms
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_micfil: Expand the range of FIFO watermark mask
      commit: 4ddd51ccff911a2e9e961307692532a325f6c78a
[2/2] ASoC: fsl_micfil: Differentiate register access permission for platforms
      commit: aa4f76ef09a993efa9b5fab6ddf5d6d324baaea3

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


