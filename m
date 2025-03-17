Return-Path: <linux-kernel+bounces-563846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACEBA64992
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E61899D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFC23F39E;
	Mon, 17 Mar 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO73L1cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD3238169;
	Mon, 17 Mar 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206670; cv=none; b=dMB+21gawcitMM0bdh9nySzbeFbYfYptUvWDSCzcP7dcdjfXTCWityABjZbl2XlV9lB77PEtheDWJoD0/Po9GVvVNDg8nOyqfiUNIfSiNjILdQGnR7+cI1rhXAJpB8q/sR+zgrVdU5uwWnKLw5ylkjIpJ2I842DOQHYbVt7ItME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206670; c=relaxed/simple;
	bh=Zc1s02Paz9PewXxLMWtam4EKd2uwWCrlzwljHdP8Ztk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ltGkGIiNLVjZUCPPkerzj+7ddxz7UDCPCd5CspporHUzPlrynePdFLOC1sKDXir83cQsyaco9BY43UZab3Zh+jdEZEbl9IO0p4hV+JPFJgJz5c9JsIcBA7gQPW0w6APPmWPJf2IcVLPu494ZDmJdgOY55ep/xD1T3cpuwt6yiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO73L1cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A15EC4CEE3;
	Mon, 17 Mar 2025 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206669;
	bh=Zc1s02Paz9PewXxLMWtam4EKd2uwWCrlzwljHdP8Ztk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rO73L1cg3HvgBQiwOEen/BkKsKLD30Uts+s1MkWynyTRfW8akKez4qEtZNgPG2hDm
	 lgfahYgC6BIKcUNtCwZCXu/qM8b7N38JT3flKJELxQkUN91SMhqpqRNzqc4GDz5eDb
	 oA+CHwcFHA7nCOBfTKyINig+OInqvMIm5ytuqjQjYkbmLud6kMHLhiIqzn1BNpEsTe
	 NnW0cJrXVNkZffpXOrAsp5SDIbWu4bJLgG2pjk0EB/2LtFXemVYmc6RxN1ZFRVBQvH
	 OoV9kQxfZ6arhyl9W5CXvZshGSntCHL+9UrFoIHM+KQr/Lj3Im44yeRvdkWXvIIyF8
	 26DKS/VbalzBQ==
From: Mark Brown <broonie@kernel.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <3dad80cb-e177-45aa-97ac-df9c98a47d94@stanley.mountain>
References: <3dad80cb-e177-45aa-97ac-df9c98a47d94@stanley.mountain>
Subject: Re: [PATCH next] ASoC: amd: acp: Fix leak in acp_pci_probe()
Message-Id: <174220666776.86423.15767893414939503196.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 14 Mar 2025 13:11:43 +0300, Dan Carpenter wrote:
> There needs to be some cleanup on this error path.  We can't just
> return directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix leak in acp_pci_probe()
      commit: 02026aabaa8225bd7dfdcb8ae106453e002cb0a8

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


