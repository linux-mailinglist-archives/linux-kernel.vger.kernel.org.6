Return-Path: <linux-kernel+bounces-409201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F09C88B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A0282103
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391361F9403;
	Thu, 14 Nov 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ2vgGfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E9187FFE;
	Thu, 14 Nov 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583155; cv=none; b=sefxY5hPIzGqxLLu5WK+pUqlsv9WL8to8YOBVN6D+PGsPFa9MgJXLs+6rOBsnuNP3W6yLi4mHFlggnIsdQs5k7Gqy6Kl8Ggm5SUlmqzUEJdTkZrDSGxwQNz6F8rUAVyxV7xFdie9JE7q9YdkV/sMy5CFKad2mRPAw+bqG2CHALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583155; c=relaxed/simple;
	bh=f5h6OebFA0gfrJRGvvhRI1P3cIw/5VT8qihjL+O3EgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kughKX5r+xX3nUg3opdCrQ9sbJM5O8A4Zm6VoIJctaz1dO27GCRTbs3lhV0R1fEBoA4+Eqw+cX4iWZfoE9r/D9XFBk62t1J165YC1V/5OchTnu4THIBal4LJ28I2ouLkui9UVsICMATIdYPPpXo2EY/6u4c1lOkFIVPjSCGdhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ2vgGfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24082C4CECD;
	Thu, 14 Nov 2024 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583155;
	bh=f5h6OebFA0gfrJRGvvhRI1P3cIw/5VT8qihjL+O3EgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SJ2vgGfvJal0/MyyVDSCLnWqP7ocSOizaHwv2g/w07mI3U5iCQlDNLy9A99y8vzdD
	 xjpbJqVrWnFiRRrBkD6gKSbe/Tbd8+QkZINS+XisTcVXd3gNshYhaGo89z8RqZ+jdK
	 4aSkafXyCUzzcpd/yOK3iGTHX9OCWQCkj8XQfZifEFqV6Cfaj+HE0moOTEtb+xL5cE
	 aiPsj3AGnFgEWxQ2RS6MsE99XJCsphQL1otMJdYRl9pLwyzHF1XCHiDhJBvipRMLBv
	 nf/gRRXgdCkhkATWrQdlC/2iobrl11B8mp/wMxD8XyVQ6z+aY0xj9rFcCrVXkeoNnL
	 R7HIPgWoelKGQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241113130807.1386754-1-colin.i.king@gmail.com>
References: <20241113130807.1386754-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: remove redundant
 assignment to variable ret
Message-Id: <173158315092.477396.12845871424910069875.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 11:19:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Wed, 13 Nov 2024 13:08:07 +0000, Colin Ian King wrote:
> The variable ret is being assigned a zero value however the value is
> never read because ret is being re-assigned later after the end of
> the switch statement. The assignment is redundant and can be removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: remove redundant assignment to variable ret
      commit: fb5e67c9d03b4a65fd43acc18cbafffff15bd8f9

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


