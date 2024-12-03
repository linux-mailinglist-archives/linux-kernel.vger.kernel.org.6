Return-Path: <linux-kernel+bounces-429975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85ED9E29FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95503286C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796371FC7EC;
	Tue,  3 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZaKw8/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8E1FC0FD;
	Tue,  3 Dec 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248259; cv=none; b=jJEFyW4eGWMQNGIwyCHW/Rs/wEg97FCoqBv9Rze8Ib/n5dpjeU1yrMlSWpkYX0/2+hsOQ1+F7vRXLd5mv4b2HCA7CTKD7qaDP2WKWj7cA5I7Znb8GVDTAFF/HqFho1q0GAswJe/+3r1+yBMUFpEJDCJbDuGIu6uSv4oTWrLMbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248259; c=relaxed/simple;
	bh=YJ511IzmxEx1Uc7jnWrD+86VGyWywPsi35FQg9sTMLc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rIl3FXBF1NBrHA9EsSWtKEWBbGmby+1f2nhrZP1F0Bf5LOy7LOYSsd1gZyh+q2EsTv+ra/igvwk0ScrR6ugMbSS/FmLVN/cLIjQzcTeAnoYkHTwUD2RwrNDCXwT39IoGxSQcGvWJCn9EVsNI5S4euTjXy/Lj1Wa4znVkVrjnks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZaKw8/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B243C4CED6;
	Tue,  3 Dec 2024 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733248259;
	bh=YJ511IzmxEx1Uc7jnWrD+86VGyWywPsi35FQg9sTMLc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OZaKw8/c/LLTsLjErPsytZFVwE8X0k6XxNzWOecHfhy+t9iG2KINkTGUERrTTuQaB
	 SWwBoziIoXBgUc4vpDzQ4QmbmXdLcCFMb2sQokqI97O61SiaHW4ryNaeP3P9GfVe/T
	 tGipqSL9o8n1bPal9rXw2R7/2p688An+8bOCUn1m0jfCu5YO4V0ldwYulfzTLwmoZl
	 biTGFB99Jd3HYXRmzOFEhPiikcwRWJ8zqPSHMaBA0Ww7STuhmcnPpNIP/wNnIBnP2p
	 XvNmCc82b6tV8ajw3Hz0uPrj1+kUJ7uOX32Bdw8Kg3e0bRjR31v4dwPpo/I3caCo7u
	 tBP/G4+nQU23Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241127030035.649219-1-shengjiu.wang@nxp.com>
References: <20241127030035.649219-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_xcvr: Add suspend and resume support
Message-Id: <173324825736.459040.7211694275678808457.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 17:50:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 11:00:33 +0800, Shengjiu Wang wrote:
> Define regmap for PHY and PLL registers, the PHY and PLL
> registers are accessed by AI interface in controller.
> Then  driver can use regcache to recover registers
> after suspend and resume.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_xcvr: Use regmap for PHY and PLL registers
>   ASoC: fsl_xcvr: Add suspend and resume support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: Use regmap for PHY and PLL registers
      commit: 5a8b4785cddabfad348a96ca38eb0c3d735202df
[2/2] ASoC: fsl_xcvr: Add suspend and resume support
      commit: 297711ba0282abef38824b1e08c0ad6dcb6c4a53

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


