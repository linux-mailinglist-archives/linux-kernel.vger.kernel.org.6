Return-Path: <linux-kernel+bounces-361211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5999A517
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19CE287F42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73921219C92;
	Fri, 11 Oct 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPqs1Bpc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66812194B0;
	Fri, 11 Oct 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653479; cv=none; b=bO+CmjKLkVNRdMoMgxS8RIiewIM5fk9+TS9Ov6pgCberqjJlWoJLs7JdTeyc7l4x8N2WJ12uBLAv+iF2lHt2ro3tjbc9Yzc59CXrVXTbE4zuQ2oSlrMkYDChTSeuVn2lFrkFyMWkr3tgJK2/hNUOwG9KEdHd+jcz/9WCn4CUpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653479; c=relaxed/simple;
	bh=axgDJJd0Yci/0Oz/SEuK3Q+Z9vXkPa5HPiC8NPVOvCE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A1BMlhg6N6Ca9/5riJg0gAZ8H+pYhxBC+fU7k30THVmVRBrTmoMhPfvPoSvvlcrshinSBDVMRYO1WpvES2qGtoIdtLYOyQRKtQEvw/v9xB6WKC1Fstumv/OML0oJiEJWinPc3TdGDD57wZVLHfG8t9a5ERi7Pe0oo+VdsVQ8AJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPqs1Bpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4B3C4CEC3;
	Fri, 11 Oct 2024 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728653479;
	bh=axgDJJd0Yci/0Oz/SEuK3Q+Z9vXkPa5HPiC8NPVOvCE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NPqs1BpcLzfSPkyANaoRtIQtuBTavtjxHEfX1aKGu3aJEs05CTp/25tDozWGoyMAC
	 n0Qp0O24/CJFN7fX8wEZGEj1HABa5mQ8ZBbXm1nfSz+Y5CDY3kgeQ2jIuxTPq9fdNa
	 sYOYq/ESC+2XNiHopx4g0+wnvaTq3djNI1eXa9NIANAOQJBNoZth+QLEyqsBeTon1N
	 WFbefM+N9QzMTbwfdzr8PfXekEqffkdZmFtn+qF2sIiPYOBjFxOrNIcpayvCprmIgf
	 8kHNnoN8fFT34wXBHHWbq3pkhHazo6eZ6TWPS7Mu1PaJ/Xn/9SAGuSBR1p4mpyT2uJ
	 X0kNpm9IxqBLw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: change dev_warn to dev_dbg in irq
 handler
Message-Id: <172865347670.3898502.17710275321530341071.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 14:31:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 11 Oct 2024 12:53:53 +0800, Shengjiu Wang wrote:
> Irq handler need to be executed as fast as possible, so
> the log in irq handler is better to use dev_dbg which needs
> to be enabled when debugging.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
      commit: 54c805c1eb264c839fa3027d0073bb7f323b0722

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


