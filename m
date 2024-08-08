Return-Path: <linux-kernel+bounces-280120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BD94C60B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45A9289CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266215B111;
	Thu,  8 Aug 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLZH+0Br"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7411494CF;
	Thu,  8 Aug 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150588; cv=none; b=GrUqQC/eHqGe/DbvdF2XBEKfxIP/SJkaVIVb2u4I5z7mpOhIu3UXdN1uJCbtqUs6wxBXUJDE0xEYrW7jZuXg5BJzzCQ2Z2O9RiGu5aXALUu0xPFOkonH9z1HOt2ccZSqupOxqJM8rvqPrwdw/10uoF7yRvWMyyzv6W0k0YKLAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150588; c=relaxed/simple;
	bh=6d3cWqVCdJO0OpAjDetmkYiZ9As4WBJyrx0zuxN2k+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pON5pDrPb7CRCAztytDGhKDNkGtyTC8QrVer5+O5VlKpNR7Fn77GMY4+k2ZXekkSHwaj//CMiD2/4pt5Dtql0QTtfgRhLGaNyVVoPvQiLWGHw78UUB8n14/rPm9DD6D3+fqzv9IA0PbF3hLjJi2M6bX7LbuPBeMGhUiBMdI6m4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLZH+0Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75058C32782;
	Thu,  8 Aug 2024 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150587;
	bh=6d3cWqVCdJO0OpAjDetmkYiZ9As4WBJyrx0zuxN2k+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RLZH+0BrYEX8+NwfuPPkQOYJDmsWVbSjFDJwM8AB+vpzzKH6OTLaucifTi/8W5uK4
	 obr+VKnBrJlivSVXeeMbEu9Ng1yAdvO4AgfrKf+FHIXOiPkhAIlUGVHqPzlhccJZrZ
	 VCYwDA0RIXOz5dDFQSGG3HElLp5MFLk0dxzw8Bg7ZVlrRFkFc8q3WzmjOZ18zzWT0Q
	 s6hZcEq59cUWjcKdKIz26ACxS4Pg71VMR2t+nXrMewPzxZLZxBB8z8flerJuTmZLAK
	 O0fZETGPoErof4OBIXXvbSKYOqalrPcv0UaxIpkmBaVXThWzayCTzyfMcBrAOs2Uiu
	 nZia1eftxWpyg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, krzk@kernel.org, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240807050846.1616725-1-Vijendar.Mukunda@amd.com>
References: <20240807050846.1616725-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: remove MODULE_ALIAS for SoundWire
 machine driver
Message-Id: <172315057813.475406.17002949847981977222.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 10:38:39 +0530, Vijendar Mukunda wrote:
> As module device table added for AMD SoundWire machine driver MODULE_ALIAS
> is not required. Remove MODULE_ALIAS for AMD SoundWire machine driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: remove MODULE_ALIAS for SoundWire machine driver
      commit: 20288905e1ee33af82570b79adee3f15018030d4

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


