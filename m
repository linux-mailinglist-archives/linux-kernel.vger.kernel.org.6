Return-Path: <linux-kernel+bounces-226063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909A9139B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C8F1F220D4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB512EBCC;
	Sun, 23 Jun 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeUGK35/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DE376E5;
	Sun, 23 Jun 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719139839; cv=none; b=aJdHTeRwvWhop/zzs87hEf3oZk9cswaUq9sgGhaP30thxjLNVZ3ZWh+hhP2O+WL304je7K0YCoegttjDjLFUSIk+y1hbT7BFP8yWQm1UU2gfQl1KeblyD/ldNxeXUwGEBz+URshALgqZznvqxeOCo20yhlhhbczwaF/JQrk4w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719139839; c=relaxed/simple;
	bh=cmfbVSffDKX/hTp/1Fgv4j7OaTjSdDNqkQqngAJn0RM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IqmpxD9CvdBnm6TiIlA+L3yNo7mdUXrytMIwCWebYF5cWDHq73fhddA47ZBqe4DjszqxRiSt0CHOeaV7Myu05D3ubLUVizykz/06HRfTperyFAFvQrVbdarBgHzcb2iUktOCQy4hvBoyJ55oPLaYdnryzKZ0BS2aYmU5hZfQyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeUGK35/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EFFC2BD10;
	Sun, 23 Jun 2024 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719139839;
	bh=cmfbVSffDKX/hTp/1Fgv4j7OaTjSdDNqkQqngAJn0RM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BeUGK35/mq1InBYDivPHdjdIHQJ2Yy3LR7a6J5B2nrkovYtypxUctWXrFJZmPhuBc
	 8M9ZDLRCBQhcDLKpgH3b1hYZC2JCM9oq3czHWwwCITj7HoVTGcIseqzlajC3gQxlkL
	 wupIZDK9XcEvGBWO9R5F30XAeVUplnCeiiLNktluFqlPXSmBG3soPmqDIcLk6MZK20
	 /rRdpg2lRaoM2dJJUGdqjSK2Cz0XoLyOIu1kjj9lp766y3DBVGv0X/M0ioeNNXQa6A
	 XVR6zEPioxba2ddc3QFyBb3JuFpbhjElHGMIZH6H3WkkEJiZQiosbdmmIsRCJDrdBI
	 omo7y+tbuoUrg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
References: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/8] ASoC: amd: acp: add a null check for
 chip_pdev structure
Message-Id: <171913983658.13532.277643449449161401.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 11:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 12:58:34 +0530, Vijendar Mukunda wrote:
> When acp platform device creation is skipped, chip->chip_pdev value will
> remain NULL. Add NULL check for chip->chip_pdev structure in
> snd_acp_resume() function to avoid null pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[4/8] ASoC: amd: acp: remove acp_i2s_probe function
      commit: 75a08ec8c3a6aef914235c409a99046a3d29d1d4
[5/8] ASoC: amd: acp: remove unused variables from acp_resource structure
      commit: 50f1670145392398f4f2ffe9abe4599c86d11ec2
[6/8] ASoC: amd: acp: modify conditional check for programming i2s mclk
      commit: 5b162f60e7e051624e187e45b0fdc481c3573f17
[7/8] ASoC: amd: acp: move i2s clock generation sequence
      commit: d85695b01cbb2455a2f70528bb9e53f2463a39cf
[8/8] ASoC: amd: acp: add pcm constraints for buffer size and period size
      commit: 8978e1f7bc26655e0373c4a6b31e17fcdd497329

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


