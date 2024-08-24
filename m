Return-Path: <linux-kernel+bounces-299993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7F95DD58
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EF01F221C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA715DBB3;
	Sat, 24 Aug 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLGHZ+RE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC928DB3;
	Sat, 24 Aug 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724494413; cv=none; b=lr+t2HTTqHDN6i14yE4HR30zwhZffRL4lCfOMj7wMz6MX7+JuHpMFVf4+Wg4a3QTGPGYO6gCrbY3p0Iowsjex52jkKlmw8vVlxfxFRmNyHRrd45NzvMEppr2ANp/4XBG5cnpEOf20pf+JZyPzt3TziiY47gb4AyaLQ8Z+ZvCM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724494413; c=relaxed/simple;
	bh=DHfBeB6VH0Vj/VVf//ne/Oe4kp09vPVca2xpKGtQfBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=koKgbEgcmxmxnOxKX+tHFYbh5r82TJ2y4o8cLfTMkSRP9r20tpkoVaVSqY+wDJ16Q7/YOHiRmimxNFKjzXqV38ZGxru4/7TFf8wFPgCNqWXX+a7FV+9Q0wEU9Vuta4x+YfBXLiSt2Oyt9+tWHHRKmPCCp/sV04C4nv/YLSOh0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLGHZ+RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F85C4AF09;
	Sat, 24 Aug 2024 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724494411;
	bh=DHfBeB6VH0Vj/VVf//ne/Oe4kp09vPVca2xpKGtQfBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hLGHZ+REqqbHGEW/qUWs1P9xob2+A88Mi228LTFNSu+A4GMjvMJh68lUP/SISnAHU
	 YyvML9gbMD1CeXdLagPtyeWvb0hYXsJT0tQh5k3caBqg2SW6e/60yXdCnniu3Yr3u8
	 26Pg3wCLzNooOBK4Z617us44d74dH8JiYZ22XFM5vV6cmMrA+o5YX+NKwBYbZy/WKz
	 xEJiLXCTNWvI9d4kZQpCUVd/ubQC/eLJ9LL0ayMx7iPkzkvSCtI8Gv6VImJ6KARPnm
	 3pvlv+H6pVa6as8lYyZ2To35H8y3eFv2HQoWGpXA6Zy9IfDThJnHnH33N2ZsaE0tku
	 Y2VToHX7zmkfA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, cristian.ciocaltea@collabora.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240823053739.465187-1-Vijendar.Mukunda@amd.com>
References: <20240823053739.465187-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/2] Add SOF support for ACP7.0 based platform
Message-Id: <172449440702.846858.10370645706025243690.b4-ty@kernel.org>
Date: Sat, 24 Aug 2024 11:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 23 Aug 2024 11:07:37 +0530, Vijendar Mukunda wrote:
> This patch series adds SOF support for ACP7.0 based platform.
> 
> Link: https://github.com/thesofproject/linux/pull/5139
> 
> Vijendar Mukunda (2):
>   ASoC: amd: Add acpi machine id for acp7.0 version based platform
>   ASoC: SOF: amd: add support for acp7.0 based platform
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Add acpi machine id for acp7.0 version based platform
      commit: e17de785850e3112b2ea6ba786016a61f195bb23
[2/2] ASoC: SOF: amd: add support for acp7.0 based platform
      commit: 490be7ba2a018093fbfa6c2dd80d7d0c190c4c98

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


