Return-Path: <linux-kernel+bounces-560253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFCA60102
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBB719C166E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAB1F1521;
	Thu, 13 Mar 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIzT7BHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209518FDBD;
	Thu, 13 Mar 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893867; cv=none; b=SPr7txCQZCBSwyJL7f9ModCMTavo4sMcGqLkRH9iL5nUNuEAnN10Z6sDEVtJ3mytVbNAI2iHM/2s8yD7cDCYDs2pMz5O1pwvzvf+4QqPE3V5wwyNb31PzDxBmdxvXMVJDjG/18fzulArWdDpWTFQOBYMeRKYsI3o05QDIKkWRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893867; c=relaxed/simple;
	bh=Oi+QSQY/o+WOAGwbP4uzzDLoZ12NQRz2LrSANng7vaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cwKliizfAmFJvejSb/ivR2lLKe8ySUuDT6JE/x3Lk6hbQt7nLm9qJaz5auh0TEbOavvZfC70QsKvaO6HinJgjirzjZChrTnW7tmMqoJVVDj3T0PAeAeAo3PRNrdeV6Q5YuhuqPBL1KjSPC/TN4jYbbpCLBGEX66JgNKK4Sl113Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIzT7BHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560A9C4CEE3;
	Thu, 13 Mar 2025 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741893867;
	bh=Oi+QSQY/o+WOAGwbP4uzzDLoZ12NQRz2LrSANng7vaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HIzT7BHaAS0ftCR5OHDlgxGf7JQc5Gu96B6mp0Lv8he6Wg2ngPt6uJsbvgGB5m/7H
	 o59bq5gj+fv8wqQ7VOicb2ctBHwIv0PBPzfwgB1KdlZs5lSH9pZ1RzDHNb+5dJpo+I
	 29GAk9H1v6ADqhNs1eKSkJWppcDwmw7k+rYpiiQOpGmKKCVQo+BV2MTcb7pG7qH3D3
	 EtpXebbKpVjpf+fe/9+zDYhuUR23dSgntI4+ePjw5OcyxkyuzeUgXUQ9KkYFFaBlKJ
	 q4SyheRYfJ9gJr/iA4kMAPqptz7x8ny3EYxdI0fDqlOE5qKonzC42XSr09r4cs1IlK
	 MHNWaRgpC6LaA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
In-Reply-To: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
References: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: ipc4-topology: Allocate ref_params
 on stack
Message-Id: <174189386404.702483.10429797398965893983.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 19:24:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 18:05:16 +0200, Andy Shevchenko wrote:
> Currently the compiler (clang 19.1.7) is not happy about the size of
> the stack frame in sof_ipc4_prepare_copier_module:
> 
> sound/soc/sof/ipc4-topology.c:1800:1: error: stack frame size (1288) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
>  1800 | sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>       | ^
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Allocate ref_params on stack
      commit: a935b3f981809272d2649ad9c27a751685137846

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


