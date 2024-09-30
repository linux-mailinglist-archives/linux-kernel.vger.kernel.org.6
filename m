Return-Path: <linux-kernel+bounces-344856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5658198AEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0895B1F2386A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6741A304E;
	Mon, 30 Sep 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTCtfsfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADD1A3032;
	Mon, 30 Sep 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731594; cv=none; b=Xi3+BT6In+rVq0YiD9HkcZeZb1lp19SvuCnAKvOkV/S5y2vkkBQDPYQCCI8TOxbI6c4lgBPqMn6IovGrDJEhu8DBpkb1cy84vW50XGGaOblj4mHpwwZ1GpT+YtGjjGABqeBUhdVMHDKQpkoabo30GCPG/xLb2cdSlDXSaOcKVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731594; c=relaxed/simple;
	bh=RfVPHxKFXcGvZ0OmSWbuVCPPPo2Dn19eVh+WgxOgr5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oELNkygvG63HFDxvA+AlGbPFO/WVVdeysNptIAXU+ahPc8ogD/JAz+RmA+I/LxVEGm3v69iTFKLH3GeBASNjtvVkTqQJFSy1+/vKMwI8QaeqGX0Iwcs6VW+wxQjPwglaLPDvaLihwlFqzDCJNI+sZwLYYYsx2KQ1Sk2b6I6VaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTCtfsfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE488C4CEDE;
	Mon, 30 Sep 2024 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731594;
	bh=RfVPHxKFXcGvZ0OmSWbuVCPPPo2Dn19eVh+WgxOgr5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KTCtfsfva7qEn4KXuuQtdLFVv+fbd8igFX/p4rdQvlCo8d/k0UXzhknY8VNuy/56O
	 GyZ2TbIeck30bYpzQX/8vdLR/cdb4oQcgOnixUY9IoHAn91Y0H34zSq+Hbg3kX1XQ0
	 3nySRqYCZhRaedxIOYbqEwMpnJAZIspSbXi2iO9/zh9lJYzZGxCJ86fmifUO5vbi0l
	 5pG14Ffrk9XxJJv3aclv/oAVImlh+/NoyZyG0Hev0uZsTnjp+MY5UR892LpdLBAP2c
	 Vf2TFbN6QU2wV4Mcqj5YW24/fjwtG1TX2ghW+rStfpkf6OOXTLVqSWbxmlZ1jSGVzT
	 yxkCTsF9sCJnA==
From: Mark Brown <broonie@kernel.org>
To: shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240914072352.2997-1-tangbin@cmss.chinamobile.com>
References: <20240914072352.2997-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: tas2781: Fix redundant parameter assignment
Message-Id: <172773159263.2197048.9891700729426809736.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sat, 14 Sep 2024 15:23:52 +0800, Tang Bin wrote:
> In these functions, the variable 'rc' is redundant,
> thus remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix redundant parameter assignment
      commit: ecdaf9140528bc2ef37f2d663fbaf690a64bb125

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


