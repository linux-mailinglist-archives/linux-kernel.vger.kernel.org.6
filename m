Return-Path: <linux-kernel+bounces-286402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C7951A89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01140B2224A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE81AE875;
	Wed, 14 Aug 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIbmEZ+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B813D51D;
	Wed, 14 Aug 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637135; cv=none; b=Eijss6wjSZ0XoTOQKIGx0DVU09S9nOyihyg7UHQ+BS2zXPte/6cD2H07gS4e1OH/iuivWqlODqaJa8+zo6z2E09OGIFpsz3dmDHdvILT4xFIXNDluFzPD9keu/CoLC/6uwnJm3B6ATK+rphWwyzJz7SzOjIxHziosceA1ymqw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637135; c=relaxed/simple;
	bh=Tt46dLTivc8ro1PclaaecN0IJCdF1hcNl8PaGQssZAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rAzTs35TzcPz9inQ7RE2KPGiu9nGGyx7QfsJULm5jaffF053d1Db3s+EGeIEtOvElDjbQLtvxsAgVUEeAefZAGVxr1a/MPrLCnYgsDUId68X7eZAtf8CA/EYO2ydhwuV9d1xAFYm37iMe0SlVjoE1tZpdTwkvCfErx5iCnssf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIbmEZ+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C53C32786;
	Wed, 14 Aug 2024 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637134;
	bh=Tt46dLTivc8ro1PclaaecN0IJCdF1hcNl8PaGQssZAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eIbmEZ+axeTJhSQW9d3VUCCmVSeahAi91uWQRIbKyHZ8xXIvkmMpI18KWX5kL1NDb
	 6wM3zeIS6FiOHrW+Li4YZr7qwVs9BnlQd6BPDeMdoKfX3LS8tF7xwyNBrCgEuhieUu
	 EPEIVVuZNtuab2nSrL2aCSIiJGk3I1KwmBioLHdlKx/rGribjazojeLltziaslWZOC
	 367Tw/PpFdfUYuCDO6MMwBFY6/CR58y3W9Qm3Zjwo48AZ0ev0UOozkerxgh93Gskvz
	 KmvAasXTprdah0Couo9zGZ+++wJ3vh6Fjn7vIYdF9wZ7Ir18Eog/HwsBxlw277W6Go
	 5fLRYcdnhBp/A==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Trevor Wu <trevor.wu@mediatek.com>, 
 =?utf-8?q?Albert_Jakie=C5=82a?= <jakiela@google.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240809135627.544429-1-jakiela@google.com>
References: <20240809135627.544429-1-jakiela@google.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Add missing board compatible
Message-Id: <172363713082.176839.8410056147508796370.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 13:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811

On Fri, 09 Aug 2024 13:56:27 +0000, Albert Jakieła wrote:
> Add Google Dojo compatible.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Add missing board compatible
      commit: c0196faaa927321a63e680427e075734ee656e42

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


