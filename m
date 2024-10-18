Return-Path: <linux-kernel+bounces-372351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2719A478A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A71B2428F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769B206046;
	Fri, 18 Oct 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN/4k2CE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A47205ABC;
	Fri, 18 Oct 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281687; cv=none; b=DZv7jO5l8kGoSCTsXN579srN9ZLeQMEj3yG/lotRlQcOTkP5hHK26iZ9fMUOO09YH9FDRvcdnczF1PdED0NyvaUYmHsRl998ZN7V149izyNm68ft/DPa+az9nx+ly3b/YMUqyB+nWFyTSjb5oavwMBG081nmq/kxjqrxmwDfjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281687; c=relaxed/simple;
	bh=Hvhks8tnqLdiS5aqzSNad6B/dGIU3GwYRrHIZhBBIAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Chk3f3WGJFn25LG7BLa8Qn/SBAKmUjVWgJ5DLmst+Z6KixOumcdWgbVRSiGU+3WXufGMM170XqGHlHFCkR1kskZ+GFm+FNgAN9n4ug8qxZ9qkcYIkpJlC2qIt1nnJB+XM0tDlirf4+B5U/16LC7jV5PocpNrvfgczz6C5d+qBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN/4k2CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA55C4CEC5;
	Fri, 18 Oct 2024 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729281686;
	bh=Hvhks8tnqLdiS5aqzSNad6B/dGIU3GwYRrHIZhBBIAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mN/4k2CEGIISzGLY3qjS3MMepoUaz+GOfZfUPNxMmPVYgHxI7242GfmlIIgqJxHqw
	 /Xt4C5L8WgMUQg11iRQ2zSkd/9NYO8Nj2fzTa50w/INx+V1ynOU5SJy27ku3eGr+Em
	 EvrmnqkPnL9DQM//S7OJYZbFxkQlB18MXsFrp1bxAWNy/7v/wN/O+BGhjgbRyznfZL
	 RftBYmw7HbwSib3CR0fOlXrfTXCACKNtqrAZnFcf4wwkmwzCgTczuKaKG780Zmr/EM
	 ggknPXTW1pfJrqUlCJWx/V7c1VUUtgv8NQQd6DihJ6t1XFlS7nL/Fbd5/IVbjsYVSE
	 ZT6CCW6vgij+A==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Mario Limonciello <superm1@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241017210952.3586713-1-superm1@kernel.org>
References: <20241017210952.3586713-1-superm1@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Add stream name to ACP PDM DMIC
 devices
Message-Id: <172928168468.188041.1137360050259879498.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 21:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 16:09:52 -0500, Mario Limonciello wrote:
> Add for sof and legacy dai links to dummy DMIC codec.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add stream name to ACP PDM DMIC devices
      commit: b2385de2ae11bdd34855276e0a254109469227eb

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


