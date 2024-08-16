Return-Path: <linux-kernel+bounces-289867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51E954C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F53288159
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20931BD01F;
	Fri, 16 Aug 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuUyvOcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28527191473;
	Fri, 16 Aug 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819335; cv=none; b=EroWNTwBkKCREE18V1JE83tsNgPu/lYRkRvEWBelcDc5e5CgcnT8HJwW9A3Sw5X4V1Fi2KSybzPHRf0i7woPn2ArQ+lv5+3wDiyrGPuPdFV1T+o7YETyFTMHYEzcPOGcZYx0JQZbSBSaVCSzKVZrnSeVuc0OEPQJtKCsuRV3cbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819335; c=relaxed/simple;
	bh=7TGuegKZbNzPtsJjymQhdPwGEn/Vab/BwE8qKh95Wgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R/jHyKLrlPWjNBJp7P6sfs9EGYSwsgdglWDRQlJSlDhmwf6cEuzavp8Ck0zEfQzGXujetwSSUCuZci4rT8cjufqFd1f+AB/UKQxEM2PwCcLtsChJLrf0+aVjKL8mNlHrnc8mzprnsA/75mANJUboC5UbwGZ0PXz8zNCy6o1xVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuUyvOcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B975EC32782;
	Fri, 16 Aug 2024 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723819334;
	bh=7TGuegKZbNzPtsJjymQhdPwGEn/Vab/BwE8qKh95Wgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MuUyvOcMDsHWUrm7QvhhQqvro+LQqyCCLtoq7e/dnIDNs7Ge4iNH4ULEHf0WqL9PP
	 O934GIwYW9fDE3Sn9MBNTIQLbOpQUcqdIxzUpXoEzgIjp35TyfizY4kWtPCyBr7QxH
	 C/dHz+7T9ViDG57XAee5lEsvnaY/UG/u7pXQ/L9urDWHfWxPHmdGrdn20JYE97yrmV
	 1Ry5gDafPO9GPQHEBBz897IPJfKF+3HlD2KGTl91fz/HYpAsdFgMDaea1vJUD4YSOJ
	 tmAgqtnuDjihRLcPRwGosNM2BMjg1IyRa4k8fKxK5D+oGSXhomvVOqgbzzYg9zr0Cp
	 vOqm2LAdFNk2g==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, cristian.ciocaltea@collabora.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816070328.610360-1-Vijendar.Mukunda@amd.com>
References: <20240816070328.610360-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix for acp init sequence
Message-Id: <172381933148.65490.13739657424123950336.b4-ty@kernel.org>
Date: Fri, 16 Aug 2024 15:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 16 Aug 2024 12:33:28 +0530, Vijendar Mukunda wrote:
> When ACP is not powered on by default, acp power on sequence explicitly
> invoked by programming pgfsm control mask. The existing implementation
> checks the same PGFSM status mask and programs the same PGFSM control mask
> in all ACP variants which breaks acp power on sequence for ACP6.0 and
> ACP6.3 variants. So to fix this issue, update ACP pgfsm control mask and
> status mask based on acp descriptor rev field, which will vary based on
> acp variant.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fix for acp init sequence
      commit: a42db293e5983aa1508d12644f23d73f0553b32c

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


