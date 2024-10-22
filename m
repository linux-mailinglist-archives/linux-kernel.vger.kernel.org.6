Return-Path: <linux-kernel+bounces-376960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 717159AB81C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C681C230E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AF1C9EBD;
	Tue, 22 Oct 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF3kPAPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B0188599;
	Tue, 22 Oct 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630828; cv=none; b=lVpdpVygs5z165hslONU5hwk/5bDVKI71OZlDeIkkhuRUP+Td+zLU0PHzglpCi17PMWtp8asafa7ClYxEaOLlNP7ZJ/SxMycplOnPBP0sb47Ww0P0h5mOHMbC7n3u30GfDHbG2kW0nCxlexMjYiFzQcqxqVCW3Uf7KuBSI1J89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630828; c=relaxed/simple;
	bh=gPLFmUbd/s1xG1U0lhSkTgFdqgBBXgJWtCXko/8udOY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B2+S/OHaesC2uzbRSNbVIPd1QnTVHSe4DSYvc6Rw6cs7O0Ej7zvsyuoLA5MK+Er1ECWy1zVz+R2LQ3oTUJJfuw9wpX93I3S2eMIjowlRrmMpBxoLVHxhm6jzhFZpfIbuHEaWhgFLcjB4LkI94k25PM75M6SiR3uHYz103hKI14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF3kPAPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD627C4CEC7;
	Tue, 22 Oct 2024 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630828;
	bh=gPLFmUbd/s1xG1U0lhSkTgFdqgBBXgJWtCXko/8udOY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=bF3kPAPsTJRgfQID5/10+n24ujJRtJlC4eEp7qOzfLgmJECivgijTTted45XGIOqT
	 gYe+OIII3QChKjIcJ4/+lyKCpBcbbd8DPkYdWg+uadMXNk7M08WJg202plQH9VQo5Q
	 /+hF5W/SqAmOyAGEK4wAO1N4ilP5twLW03Qe4IdiXQe4c3J/epCy/3DIepuJwqJlv1
	 KaK4PasoRafzpJKSMB9TOPCQBKxYVobp2GLtoRbWG0bcaNQX4dNdj2geIvLARvuQo+
	 dXeemevA1ffmdKEo+4NdD3ixLVzKYEyqzhIWMW4T2ZLHUGSdhkG7xu+v+cK/9qLGGX
	 FIsQ7iTo/4y9Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1728884313-6778-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728884313-6778-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add sample rate constraint
Message-Id: <172963082563.164184.10497538395371277879.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 22:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 14 Oct 2024 13:38:33 +0800, Shengjiu Wang wrote:
> On some platforms, for example i.MX93, there is only one
> audio PLL source, so some sample rate can't be supported.
> If the PLL source is used for 8kHz series rates, then 11kHz
> series rates can't be supported.
> 
> So add constraints according to the frequency of available
> clock sources, then alsa-lib will help to convert the
> unsupported rate for the driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: Add sample rate constraint
      commit: b9a8ecf81066e01e8a3de35517481bc5aa0439e5

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


