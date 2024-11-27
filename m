Return-Path: <linux-kernel+bounces-423450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889B9DA77D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74739162403
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C271FBC9F;
	Wed, 27 Nov 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eai+IyX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06D1FBC80;
	Wed, 27 Nov 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709603; cv=none; b=H9pY9ubSIgGl4q5UwUOFo8Z2eBKZbS6Sgi2qZ3d9C/qje3eplnukoBhvv/s1OXiTC6lx+ee8LgTm2AFxmbuaZfUZt3J3Agw9Z+29LCQIxp8k8N9S2BG5vcfnVl1QL4djNyfQPR5hpnT5NImxXiTfcI6ci+5g6NgZEBCvOR1RsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709603; c=relaxed/simple;
	bh=VoLkH65bL3SCOolWXPTIPl3bQkL5q34kt5m/3L5PBvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E04g5Fx3w0CanF9TeTS7lSBR69aguLqKXN/+FeDP39x2L93I77g2mkB9iax+us+iiqfHTKr4IeVf7KIkIxK9mWuw9PdA9cOidsFxw8pfb2I5HFoog/ifYyDqufgR2igKKQO/ztlFDE7+592kdvPoqGPLzD0EVw/tnb6lTimG9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eai+IyX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C632C4CED2;
	Wed, 27 Nov 2024 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709602;
	bh=VoLkH65bL3SCOolWXPTIPl3bQkL5q34kt5m/3L5PBvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eai+IyX2DHv87NXUhGl5Th2caqMIBIpxVJOrR8c1aFjoeQNCTmBD51LLFMkO+R5ns
	 Nn7fYNhEWkmKjG9mm6WAEJOqceJmADIRtmbQuszuISP9ytmlJ3Dt3ZURtd4C40f+/g
	 jYvcoB/sof8oksETHdCT+hak+YCgehTgmAaHcZbw5awtLoWn7lPq7yY5ufdoliBlcX
	 SlEa3NBpQ3M14MoxixNOQlUDHuWTK3kOCKMU66r9Xsbh/oYJZtARN3iUP+8YSIw8Zc
	 rAENWa3Pnv8tQtMP7VUWPFsO4ZL9thlAGpq+Q04avat5+34r9wAtyMivjOACi0FXgT
	 xHFJ6tCgtr4SA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
References: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
Message-Id: <173270960024.162310.7545183344614439367.b4-ty@kernel.org>
Date: Wed, 27 Nov 2024 12:13:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 26 Nov 2024 15:09:43 -0500, Nícolas F. R. A. Prado wrote:
> Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
> Component via COMP_DUMMY()"), COMP_DUMMY() became an array with zero
> length, and only gets populated with the dummy struct after the card is
> registered. Since the sound card driver's probe happens before the card
> registration, accessing any of the members of a dummy component during
> probe will result in undefined behavior.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Check num_codecs is not zero to avoid panic during probe
      commit: 2f2020327cc8561d7c520d2f2d9acea84fa7b3a3

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


