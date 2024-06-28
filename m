Return-Path: <linux-kernel+bounces-234265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0203F91C475
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC71F2247B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B91CCCCC;
	Fri, 28 Jun 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1JmjJZ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D741CCCB2;
	Fri, 28 Jun 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594416; cv=none; b=BNCwhtfCujLNbGWJaaK+aaU0Vvb+K+RdF/ZtQIVWNucgDGHe69UbsXX16I0xjVwds4IdoDq88NtBSLnbtMbSA8G3AyNgM7AosuxXvrwqxjKdWbYdpsbLAOwpTgOAb1NPmJ5wunDAqILO8ZZBJsORGFox0ASdDDUKcH+/LGJgd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594416; c=relaxed/simple;
	bh=NipbuEFQOXmh1XPQv1lun2kBsLcYT/IraYCf9aORrRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=atcqHzXep9uFOOdpw4pePmjoUw0pWisIzgaDfb4sexTn/GO2pZoMwvfzdrKARDOvCA1Nw5jmb0Ly0aURJ14mr9wNVLVWZs4AS7VMcsTMMr0l3P+S0CgbiD9iP/V7ptMdbc74dmqnZVKDi/ZWVcjEZwRGAaNUxuo4hEZSThO4jlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1JmjJZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481A3C2BD10;
	Fri, 28 Jun 2024 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594416;
	bh=NipbuEFQOXmh1XPQv1lun2kBsLcYT/IraYCf9aORrRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t1JmjJZ8jc0/9jZxPJhYb+VkhZ5zPDjVdVZ17aP0nQQZwBTXUd6bAImc1jLgE1XH5
	 6Fkk65V32m9ztTEp78k7N71KBe0/IVc+MPqoIVyb+lxnM8Atg9v402iIYYjZ49pAbI
	 /6VnCCQgr4E3Kll26jblUiMDJduBA2HiuDkR5C8iJ8c9AyPYwKffZRD6efUEU0PKDU
	 BzBeompADFkl+lbzGVwXMZYRtBflzXWxAeaAX2EClykBEz4M/q5RiEVQVsunULzTA5
	 hT+QDBHjRI8HkQ0IrX9dhjVajJBiXiX3XQIxVSjIuw5MMYBbFxCS7WVu1h2dV1qypt
	 IJ1HUq9XmAN9w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 m.felsch@pengutronix.de, trblinux@gmail.com, javier@osg.samsung.com, 
 afaerber@suse.de, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628080534.843815-1-nichen@iscas.ac.cn>
References: <20240628080534.843815-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: max98088: Check for clk_prepare_enable() error
Message-Id: <171959441401.130075.12388433087390815792.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 28 Jun 2024 16:05:34 +0800, Chen Ni wrote:
> clk_prepare_enable() may fail, so we should better check its return
> value and propagate it in the case of error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98088: Check for clk_prepare_enable() error
      commit: 1a70579723fde3624a72dfea6e79e55be6e36659

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


