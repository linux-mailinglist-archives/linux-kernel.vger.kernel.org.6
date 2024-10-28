Return-Path: <linux-kernel+bounces-385464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5559B3780
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C09281239
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5E1DF272;
	Mon, 28 Oct 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUg8/wy6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493018BBB9;
	Mon, 28 Oct 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135902; cv=none; b=LzMYJRCM7E2Arx52sbgh9i1MGPiQrWiBdJarjEWsv/j3AgnwAxIATORbaHBTEui+FDDT+1WV/EItK8GW/LyeqEQSxYDZEwziRygfrGAkgJUorpwW9RxQCyDZIcIGNezGWE05iPqnOllVGOPe6cxuUp81GgA2fsOmGlvMAA9f4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135902; c=relaxed/simple;
	bh=D78PPQSl6ZzwXnAhQCZItv2ujy63Pn3+gWcO9Llqftc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYI0tw6a5m3eOam7P2wGz3F4NXAXTd+aRTf7okG5b7pS8nck9oQCXkjkOzR/wi79hyneNZKRQBcSMzE+8EVyxlct/G11C0yjQn0mr4yFVvDaXoedZH99/k+BOKEmXRMxyD7G2RE4M0CdAUUBE/AqOSLrf/0RHnra5UoeMM/ryt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUg8/wy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F475C4CEC7;
	Mon, 28 Oct 2024 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730135902;
	bh=D78PPQSl6ZzwXnAhQCZItv2ujy63Pn3+gWcO9Llqftc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CUg8/wy6zlkSPXz1YbgH6XBSNwTNj5zj6dBjSyToix+gZJxF7cCfC8odPKK++lv3A
	 +hmnOolUcMbaLvQLnPxCnQEv9amJq7vkXTWhXwG3oorpbvmgS/vUYmY1M5+2TmGxoM
	 1MVQpUDcwqhQ4N0Z4lB7Qz/Z8Xl3qu4KXBwhCGLcfQx2NI9EBcRWobEVmcJ9zQbx+N
	 3eZBhLytNyGIESiPBfpOdX0sOdLLJPtvZcNo2jjyzTzDsVb4eoDK+QOQ+X/tz32eoe
	 5BD0icvYVGKvC1hErUPnvLiQ05bnRCPeORFI8Dxr2CEt5pX3jMib8uQK/IPjKZTjoo
	 CCRs8sWmxfEbg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Olivier Moysan <olivier.moysan@st.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr>
References: <a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs42l51: Fix some error handling paths in
 cs42l51_probe()
Message-Id: <173013589929.106425.15659465055974056146.b4-ty@kernel.org>
Date: Mon, 28 Oct 2024 17:18:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 26 Oct 2024 22:46:34 +0200, Christophe JAILLET wrote:
> If devm_gpiod_get_optional() fails, we need to disable previously enabled
> regulators, as done in the other error handling path of the function.
> 
> Also, gpiod_set_value_cansleep(, 1) needs to be called to undo a
> potential gpiod_set_value_cansleep(, 0).
> If the "reset" gpio is not defined, this additional call is just a no-op.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()
      commit: d221b844ee79823ffc29b7badc4010bdb0960224

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


