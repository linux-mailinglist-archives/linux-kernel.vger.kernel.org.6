Return-Path: <linux-kernel+bounces-544389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C46A4E0B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742F2189E817
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E833205AAA;
	Tue,  4 Mar 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqCdb9cl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDD1FF7BF;
	Tue,  4 Mar 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098049; cv=none; b=VCqUyQcMM/3XKOsBNfcKtWURvmNCs6L7/4E0zUmri32hyDw10ZABr5XUtv5f4n9bJyHB0lbMbIW5vV1+CoriCIm7YCXwxWFXquD4n5nrLlDP5Ehq5OiWorDF9qilBVDv2OK8bNMt7/KQ9g6jO8kSmYLUTBdMHOGPGiWn5Tcgr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098049; c=relaxed/simple;
	bh=WsLsXCtD+Dlf0AZ4MInt08fRHGyplcvRXe4mxn6hA9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=keJv7JOq+Zc+rTAJEHpgNg4qNL+ax3bon1RbBRuCYjCGJ5dfz+NrcNSSw66SeTtsodmXMS6oO6wdPq7jC4XYMIxWfHejiqlM0K+FbRl+arZ6MroIifOqKQPCrJBXHPwda4DQUGfgU1rq/lEqonRpMglNXZ6XS/SRAV4iREP5Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqCdb9cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE699C4CEE5;
	Tue,  4 Mar 2025 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098049;
	bh=WsLsXCtD+Dlf0AZ4MInt08fRHGyplcvRXe4mxn6hA9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YqCdb9clAq+xJVXfnR8BdKp4nNTMz1YJWpKQM463sXS1cw2Cj6suON0yS3QpsRSKZ
	 uJayxcXLLRMx1UCjUwG386QaFW4cXyX+TqicMkGmjeBFy8t/9IxMhRgr8oeZLYSwvW
	 asiDUJc9sFP5VP6y6AmfikTBb8/j4zmIdKCZo0CF5O7RiiVxmxk+Mh+yJxPDZWcKm3
	 talKqXDCol4K8TgB1y3125eLg1OT86kBfzVM8iIy3guvuhfNrKBdi7tY13xJd+IJQO
	 NqBsvE19xDMGkgfq9EmPdDO427ig7L6ZFh1Ouui61OUYEFwVUBjge+jK+ROA57MoRR
	 AeCog20VFuaGQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20250228-mt6359-fix-probe-failed-v1-1-64941d387b2c@collabora.com>
References: <20250228-mt6359-fix-probe-failed-v1-1-64941d387b2c@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt6359: Fix DT parse error due to
 wrong child node name
Message-Id: <174109804670.69310.9373110369182366922.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 14:20:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 28 Feb 2025 11:32:19 +0100, Louis-Alexis Eyraud wrote:
> A recent dtbs_check error fix in mt6359.dtsi file changed a node name
> (from "mt6359codec" to "audio-codec") without modifying the mt6539
> codec code that uses it.
> It leads to a probe failure after devicetree parsing returns in error:
> ```
> [    1.354025] mt6359-sound mt6359-sound: mt6359_platform_driver_probe() failed to parse dts
> [    1.355066] mt6359-sound mt6359-sound: probe with driver mt6359-sound failed with error -22
> ```
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt6359: Fix DT parse error due to wrong child node name
      commit: 79c080c75cdd0a5ba38be039f6f9bb66ec53b0c4

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


