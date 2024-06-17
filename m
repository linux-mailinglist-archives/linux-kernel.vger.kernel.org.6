Return-Path: <linux-kernel+bounces-218016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1990B811
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163B0B25C09
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A861741E8;
	Mon, 17 Jun 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/SZP+YM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DB16E88D;
	Mon, 17 Jun 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645206; cv=none; b=FsFquHWuzpIRujeQs9Sx6JOTRFwnrU4I1R7bf7C/G6aEyu4MtwESFv8vB+CGnt26l+3grO98OL9XIpUz7WHS8gUj3/NgB68UYXMkh4CdH0a3XjI6NPxfMtcdpK3kI5Bc0um3D4psbDi2fB+5BN025kDfvmZexYnHRkX4e4zZ8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645206; c=relaxed/simple;
	bh=FBswpofNDhR2w+Ns2wjNtFSb1eY3Syl7BNKymUDMFHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hklfWp4jqkNMKxOcPry4xOYyAOcwFiFuFreQd43lMnlp+pNOCd1pTER/vzanEjJZXI7FWU97ZyxUZEcWJrXddaItCWr2Ym64N6ZFdTCnk3qIbi5s2YpdZ0RFQ7QQgfKuOsH8WGnayT/LSHJ/wfXFks9G2qjinfwrX6MYsM5mXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/SZP+YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61D5C4AF49;
	Mon, 17 Jun 2024 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645206;
	bh=FBswpofNDhR2w+Ns2wjNtFSb1eY3Syl7BNKymUDMFHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z/SZP+YMKge+5VVdaq/KuGfnZutODrS+5+77su4siOcVqSbCJPowjJ4c2+kNfEbx9
	 5/yV9rVw8Ru6v0fr/xs9yETL0wJRc+4HR98/9BFv+rkDDqtrgn7/M8FuUUJnHRqiJb
	 GVkcPMgYhqRypbB4DCW+sx+V7vxUTNtbSzKOEFnxDLjsvebka0WEFsAsNl12Ri/YLO
	 4iTUfXWOmti6UHSUCU7OlEeSTfMHiWC6dsX54YuVcjcBpItSdWokzEy4p2L1TR2MYa
	 ohY40KJOphkP9qYwBpTzMX3UNffB0kBOezA5Dmd/2fGt6LWjW+mbIgqfjVyECjgsrB
	 6u7sRg6hF9JUA==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <a45d6b2b5ec040ea0fc78fca662c2dca3f13a49f.1718312321.git.christophe.jaillet@wanadoo.fr>
References: <a45d6b2b5ec040ea0fc78fca662c2dca3f13a49f.1718312321.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Constify struct mtk_adsp_ipc_ops
Message-Id: <171864520134.209755.7325176074699665944.b4-ty@kernel.org>
Date: Mon, 17 Jun 2024 18:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 13 Jun 2024 22:59:09 +0200, Christophe JAILLET wrote:
> 'struct mtk_adsp_ipc_ops' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> In order to do it, "struct mtk_adsp_ipc" also needs to be adjusted to this
> new const qualifier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Constify struct mtk_adsp_ipc_ops
      commit: 1c75adb22d49ca9389333ca5e6939052a7203111

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


