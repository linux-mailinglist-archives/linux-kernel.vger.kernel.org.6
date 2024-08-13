Return-Path: <linux-kernel+bounces-285071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA669508D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718B41F25191
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F331A2C17;
	Tue, 13 Aug 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6BjmZTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85391A2C09;
	Tue, 13 Aug 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562378; cv=none; b=c5qZ2580Jtzr9utTRdKOwvUTbW29JgqQnJH+OBrE/cTjE7fXMUzKJ7lrTKjUy0YNtI7lqm9Y9/j2OD91cy2PWv2quvtqd824Or3QXskGt920BCkH+SijimGJI2e1gT8vHcSthHihmIFeGboeL5J2JO7TjM0p6HlBQAJI9E/19qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562378; c=relaxed/simple;
	bh=OXIfz+3/CpD9ukTb2nLxZ0KSKbyRZuPP5xJxuFIIpQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ViPYErR9s1qMLPFACN0MHCmE80CDgezbseEJifqRBWTCTimM7l8dgEardRUchK2CjDAMM/IY2tgYtpoV8Oi7Hqh82BejwHTS8nQzCPLHjKqSJzNDGwvhLYCQBjtq9fIFpcr0HR6IV7uW/tghf9au/UjAwhaUe+/J51edI6H0MGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6BjmZTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D8FC4AF09;
	Tue, 13 Aug 2024 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562378;
	bh=OXIfz+3/CpD9ukTb2nLxZ0KSKbyRZuPP5xJxuFIIpQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W6BjmZTw4pJtnRk2eaXRu1hAS5kTOHX+Cg37tID1nw7hjNr5lcH+89sjfLtYLLCN9
	 mT0Jds4yqUbcnck+MAlMjPrETYPHWLgjONdnhgNYVmsxPTufywZiMZ4wtXKGU4+XMB
	 bMJS4ucv3zEZNYMkaddUENRKGQdxhMh5y5coGYG9eUw3oeZY9MXzWxYP8hCL+1BA3w
	 SyIZ2VDPuA+v08OqmnHLLIb0uU8eSe0PxB0D4hWtlNi/ZKt+sRub0TVuxndME4d2Qu
	 tWxNzHudvG48ZWFPiWldyF7k+PFVDIqNZmTitNmbXL3V5VpPeJWj+Nu65un2t/FWGK
	 4Je1MtPrIjMDA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240812100429.2594745-1-Vijendar.Mukunda@amd.com>
References: <20240812100429.2594745-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Convert comma to semicolon
Message-Id: <172356237561.72636.9236127890451321157.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:19:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 12 Aug 2024 15:34:22 +0530, Vijendar Mukunda wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Convert comma to semicolon
      commit: 6024b86b4a618b6973cf6fc5ed3fa21280e395b9

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


