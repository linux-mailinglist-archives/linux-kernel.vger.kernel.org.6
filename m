Return-Path: <linux-kernel+bounces-318912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED596F504
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4BB286A29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5761CDFA4;
	Fri,  6 Sep 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHFw4NTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A601C8FC0;
	Fri,  6 Sep 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627964; cv=none; b=UIRPfIYOP3ET0afVh26d5NhQntAv0ziikF9lHpNr2B8tKMAvTo8q/7ODH2lXeB+gSjYWuiRVQ8klVnvGSMW+Dm6ttwwkK0Zk+jlamQUjf3ajN1FT74wBVgArMKDUpNnyhXhrXoaV+uuH0kLCoxKN4OlCxoirnczd/t6LJ+CX8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627964; c=relaxed/simple;
	bh=RYJJbOQXt62dm97cvJD59ImzcJyUqEKWBR7cFIVesn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MpgsF0hQU/wd4xJt2XHqByO6kCON9fH1agl/7cHDI4lRA2wR9O0IpVSvnDMDtLbjKOjABIwAjgrjgRl4BpOZw1VAIKJSOIcrZkfrn6FPm8V1DRoC/YW5zAm2oGpZB51tuRD2TdqSq5qYP2XdOn4/AIaBlxcT6LPxuSSoh0Bc1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHFw4NTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58FEC4CEC4;
	Fri,  6 Sep 2024 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725627964;
	bh=RYJJbOQXt62dm97cvJD59ImzcJyUqEKWBR7cFIVesn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aHFw4NTRxCXG49yT0tB4Lw5J5ZPONWLYVQCqzAeKq/ESOg+HI93JFmmvkgGa6fv7C
	 3bSy/y+hmQK0FBX7x8Ya4oQ7rBmMI8icsenF9XGdAjkzGACi/CWvAXAxirMMZFT9Z6
	 nIcGIxrgCz6L0e9OMyubOAb7GeFJ8vc5Kp42w8tC8ixL5gyE/O+wPbNXasgZbRGUIc
	 lDykuqun6r4mxeIzjkBm0XuWr2tPZ19UmTWCOYz9rieWjRZJ0hOF7WfMVmXy6CBpzA
	 Ec7LiaflDQ9hcbs1XxqymHmUgG9vpnTpvhb2qEO+rmPq3Aw/O+/w6unAzblSb/asEv
	 L0l8Q9lsS23kg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906103727.222749-1-usama.anjum@collabora.com>
References: <20240906103727.222749-1-usama.anjum@collabora.com>
Subject: Re: [PATCH] ASoC: amd: acp: Return in-case of error
Message-Id: <172562795750.927452.5890611265241212761.b4-ty@kernel.org>
Date: Fri, 06 Sep 2024 14:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 15:37:24 +0500, Muhammad Usama Anjum wrote:
> Return when error occurs instead of proceeding to for loop which will
> use val uninitialized.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Return in-case of error
      commit: 3c5a18a10a8c6fab27739e6e7bd0e4c0aa854d92

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


