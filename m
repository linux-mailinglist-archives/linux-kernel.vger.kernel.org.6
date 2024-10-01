Return-Path: <linux-kernel+bounces-346453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7398C4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2121D281510
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C42A1CC897;
	Tue,  1 Oct 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtTa7fc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADED1CDFC9;
	Tue,  1 Oct 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805207; cv=none; b=rC3B6WCS3AzhT+6pP8dt8/Q5tAYY38L1/DOrumXtu5rFBEu+boWyimn1n9zP5stKKD/aoyvCrUj2DoSe0mzLtYNQi8dm22ub6ynLvxp3HJxiolO0q5yrivaleHIVraldZ5xZA8h6OOho1mpEF0xGnyGSwfzsWB3Ehop9jU5fn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805207; c=relaxed/simple;
	bh=zFUAfX1xGLKWPqysQ2DsF4JQETrYOAYztxgnX54f+SU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jb6dQRTTG+ayfvJ07qw7xPlrMOwoGAQt+9wGQEKELC2Kn3/3OrnpaSnCFXBGgQYveOebTsEfzyCxz5+eAwSjEWtY4etH2H+VUvmThwOz67kWIk3phqoNvdQUnlLC1FgcERCbOL0NZHlLF0AZvSlX09+PxNvMzm7BOl6EUPPZEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtTa7fc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B9C4CECD;
	Tue,  1 Oct 2024 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805207;
	bh=zFUAfX1xGLKWPqysQ2DsF4JQETrYOAYztxgnX54f+SU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BtTa7fc5dYV7KmtWiwKcr/Gn5pqBlFp2RlGzO/sBQcWTRxSwnOL/1nFaQPu0bGQYa
	 fRyrtywXMXiY32M9yj5/ZJamVKXInQm3iPrSUPkzjDltkBUaxMkkG/jSesFL1c8Qqb
	 Au3Y9+9vqxi/1NkBe5jqUSmtJKKxUrs7pVsUCPAr5L6nGdgP5G0VQh7QUdu1dF/mQW
	 +KFOJhXVYWU5Am/F2QZSTwgh2goWTcLYZXJaq8BuPQCCwV9b5n7lQjLACvknMYEdJu
	 CO/9ssjkRPPcp09yrwntnriRrEcAymTysK0Ef3zqUnvLjs7jOZx6gpDoBpXWicNkjD
	 ejNW3L3AfbqaA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
References: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_micfil: fix and improvement
Message-Id: <172780520382.2298697.5976871562900019910.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 27 Sep 2024 16:00:28 +0800, Shengjiu Wang wrote:
> Fix the usage of regmap_write_bits().
> Move mclk clock enablement to late stage.
> Enable the micfil error interrupt.
> 
> Shengjiu Wang (3):
>   ASoC: fsl_micfil: fix regmap_write_bits usage
>   ASoC: fsl_micfil: Add mclk enable flag
>   ASoC: fsl_micfil: Enable micfil error interrupt
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_micfil: fix regmap_write_bits usage
      commit: 06df673d20230afb0e383e39235a4fa8b9a62464
[2/3] ASoC: fsl_micfil: Add mclk enable flag
      commit: b47024dc624bcffb89d238f4a5b490363cea2a1e
[3/3] ASoC: fsl_micfil: Enable micfil error interrupt
      commit: cc3ae21f360bfa375fc3539e24e7adb0e643a9d4

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


