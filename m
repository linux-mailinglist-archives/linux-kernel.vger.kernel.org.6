Return-Path: <linux-kernel+bounces-325204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43397564D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68ED5B2CF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2241A7AC6;
	Wed, 11 Sep 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQOjXIaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6E191F9F;
	Wed, 11 Sep 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066431; cv=none; b=Ax71Id3YP/uGfJw0EwygUpE46avEJoRxE183Fkk+p/Ax95e+GBDZ+Mre/ircJRojvb5zRBeZhjEmvV+ggLbxD+Ts8qPlgL9zhrft7NZB4Ouhj2VsNVw7tDMI2fugCaTMO/CBq4MDZI9ol2v4lUtktg2e+8MuY1kgN43EHp5XDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066431; c=relaxed/simple;
	bh=7RDEy6UcPUI2lIh8YWVdPWHQFVty7qu6W3Bb5hVMBMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FF+K1tYyBM98cPyhyRYmYBuTCHr7uU0jFfOfZ1q2NxmdeCeBtZIyb6S9zjQmEUS6UO6o6JBRKTCrkQUYRooodxQ+rOczWEcJnq8h9ywHlftBOJn5n+Z76BaCzypCRD4rP3TApjFOwtCJHmo2gblU8XaNv4MjnaNyP/SyRXgzD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQOjXIaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D250C4CEC0;
	Wed, 11 Sep 2024 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066430;
	bh=7RDEy6UcPUI2lIh8YWVdPWHQFVty7qu6W3Bb5hVMBMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iQOjXIaWD5f5+aUoneGJwYOVvaM2Dbkd7hCXqAfhjSGOP6Z6jyUiJ/UU/mjMw5fF+
	 xEllrvDgOIbWkgd9QYvRci0QHLLKZ4Q7m62StDrDqlBRNPlh3pa34VRRRynIyl4Rrw
	 m4vkRRIOWBDVvdGeTXU/ujw+NSIC2fyyZLu0lcoNvBgUtq+WP8cVCB5cwScU67kHRo
	 YheXuGksQk2rcMXjGV8bcQuTQlNR2khchJ3pXuq3fkXFRPJfdhFHExnfm3kaL9WdKj
	 CJkCmRMWQjAwiANKHSTfFvKvrLKqXlO4gFU8O2vhICnlULdD67S/DkyD+AVZTCTqj1
	 cth2V+352kidQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240911111317.4072349-1-usama.anjum@collabora.com>
References: <20240911111317.4072349-1-usama.anjum@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8365: check validity before usage of
 i2s_data
Message-Id: <172606642824.81433.11338479643338212337.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 15:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 16:13:07 +0500, Muhammad Usama Anjum wrote:
> There may be a case where i2s_data may not get initialized by the for
> loop which will cause the kernel crash. Initialize the i2s_data to NULL
> and abort execute if it isn't found.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8365: check validity before usage of i2s_data
      commit: 5c4e15e63216e7268bb2f1132ee8fad0ec46bbb7

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


