Return-Path: <linux-kernel+bounces-344865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9D98AF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BC61F239ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7A1AD9E4;
	Mon, 30 Sep 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGsoWux2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989E1AD41D;
	Mon, 30 Sep 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731604; cv=none; b=EQwYU1z2xfSH4BoGz7c4SfKOGIC64/laILgubbSLtKkcSzj9tHp22KEDfvkXOZ4xTEruX2p5Mrq8YkVKJTgIyXNnq49XGUspQTUGb9Jif8wDBmhhGrwT8+ZeJqJ7ppAcHVTrm8LREvVlvPkKmiEIiiw9IGPZnVqlltHh5FZ3wcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731604; c=relaxed/simple;
	bh=MgjB+oPkrraGdFtQ84DycPATidkKPpg8TsOkUHOyuac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VseoIP+4I8ANIyfDdx88doAYE5sbsOnEXx1zoVxXSB28lv9Md9KMJTMJAqjH6DVI2szPyt+8iy+x5UHPerOd3oaRWz/jooEFI5RL2uf1EPrGqWjNcliHq48Yeqx542jKhcCDi2PnOnloPrLJ4BExma8YtIUUPmyodJCF5nCvzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGsoWux2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77BAC4CED0;
	Mon, 30 Sep 2024 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731604;
	bh=MgjB+oPkrraGdFtQ84DycPATidkKPpg8TsOkUHOyuac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kGsoWux2dFKmMPQF6JdyclQn90ly9/W/I3XxOwfEdZIF9Pa+okPU9daBlNoR5+3tp
	 dHZwEB+1Oj+u5eR1dqtTdHYrc4NqxXrJQ02e2xKs5IM2Gp2Fo8Q3XX9a5qQAWvTimL
	 G6hj5AyXPsTO6DdkejYXvBpC8gTSO7ipkFr8Shf0+2tu/sFfKw2XZLKOwEdZKVzacj
	 76F6s/L7pB/InNcg9YAlj9hSkZF9byuo5IWCkWE9XauXMjC3GoVCHIhax9FkkDL5OV
	 u8txv1JeZPLW2YlV8bGARH672R1mtBruYl2d0xQ8ckZ6rVaCjADLas2uY2kPY7WEOv
	 mQ11+3mqNO8iA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240924-asoc-bcm-maple-v1-1-9d221f4a0195@kernel.org>
References: <20240924-asoc-bcm-maple-v1-1-9d221f4a0195@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835-i2s: Use maple tree register cache
Message-Id: <172773160254.2197048.14270421051245642200.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 18:21:20 +0200, Mark Brown wrote:
> The bcm2835 I2S driver uses a rbtree register cache but has no clear need
> to do so. Since the maple tree cache uses a more modern data structure and
> makes implementation decisions more suitable for current systems switch the
> driver to use that instead. No functional changes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm2835-i2s: Use maple tree register cache
      commit: 9e3da79544de209c006b6b4c1514be52a48a2c1d

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


