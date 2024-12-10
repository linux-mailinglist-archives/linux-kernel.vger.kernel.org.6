Return-Path: <linux-kernel+bounces-439794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B939EB3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0772831E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04B1A9B25;
	Tue, 10 Dec 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzFaYQwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0720326;
	Tue, 10 Dec 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842281; cv=none; b=q8vVqZXjw6AHHfh/062mR3UIVMoNKV56d7hY3rzhmDAGCCJCJ0Ugz3GsdERo5dcRKhqPI+k1vJSy4DQiNi49g/exGazSl32ZUgQm6yNXpl7bBQTTHDAj8OfNIfZsab/xWX+rTn4QVH9UzmAwyjiXM9NKYPS53LIwXjjh8Rn3pYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842281; c=relaxed/simple;
	bh=bjEOgH1mGFSKaUDSOmFLt5GSuoXBCE4SC0dZzXTngqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2WkGyhbpSB3JUA9BC97VYm1pWq4jZUFE15lWMtTPbQlIsiClPGigga2NE9OaTWSTl5ssjjsE7GI4JhoKv3cRQWJ8/hvNzsGhd2v5rQRkKGjaJgmgUt2/aBp7Bq2EyXKRrEu6oGfc0gCb3D25GvQEthvaTVEZr71b3S+5ETAk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzFaYQwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF58C4CEDE;
	Tue, 10 Dec 2024 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842281;
	bh=bjEOgH1mGFSKaUDSOmFLt5GSuoXBCE4SC0dZzXTngqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tzFaYQwNuZYa6Uk6LIVcxB4y1YyKNj19103LVaDIcJe3B6YAS9EiX3w/B7YOYQ1ze
	 NIyR+qyM4V/RjbxWm8Zl1tHqzZhrh8E26pEbsQhMtXRczg4MD6yM+Zf8+92JdMlz4t
	 kGpLEQNnKgs23rW/09sTBsdV79EXbHFdZTumYZbtMBXCcFtRiXvKMi6y/9Py/xE3nL
	 AiXAH4MzDESBRozie8AWVQ8ZXNlDmv48ZXeXCu0GVeU9uxfd3UzWLVsGvH7WtAqrjU
	 O2EAoGWp1y7xF0XL++57vrJLFhKS/gxWmQSE7kVy9gLsjDlyPV4lAy/F8bAPGl5MDd
	 VZkFswjWR8v8g==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
References: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix the wrong return value
Message-Id: <173384227739.64342.4224280961659037340.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 14:51:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 09 Dec 2024 15:43:17 +0530, Venkata Prasad Potturu wrote:
> With the current implementation, when ACP driver fails to read
> ACPI _WOV entry then the DMI overrides code won't invoke,
> may cause regressions for some BIOS versions.
> 
> Add a condition check to jump to check the DMI entries
> incase of ACP driver fail to read ACPI _WOV method.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix the wrong return value
      commit: 984795e76def5c903724b8d6a8228e356bbdf2af

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


