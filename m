Return-Path: <linux-kernel+bounces-267471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2539411E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DB21F21E39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0E19EEB8;
	Tue, 30 Jul 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r33BRLTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE218F2FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342579; cv=none; b=cnZ30AAcd0vzgBprOyDJaG+vppqHHzYs857QJ13pqwRjdjZXL9ZriBhyNwMvBsoFehjjjdedsqjW0Rc2s+UXbC89lt627OjvPoHHcfu+TIPm3RjFrhIlCkCBfADevvwCfAkEOZ+Eoa7S5povOsAdtQ/lifRoHb1FVckKcxIgegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342579; c=relaxed/simple;
	bh=V/nbNoqv4wBou6TF1sx+EObG/PtT6EvyCtHrdI+QisE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rEvVh/MfSRy2TNg2ZDXtIelAs3BQ8/W/D3uSWASoPtvfZz5FEv7dclIzZ7dieRq0UqVhjMTmnbXJELvqw6aEBdVPH9YnKeDqP3J8UCQ+KBSEDA4NgyyqhI9Ca7zzG96eKFaAV08yVbmXayHZoE0VcOOxFo0qnt99ULvAHN1ZuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r33BRLTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E704BC32782;
	Tue, 30 Jul 2024 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722342579;
	bh=V/nbNoqv4wBou6TF1sx+EObG/PtT6EvyCtHrdI+QisE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r33BRLTKwEekcwKuJ0gmmWPeTJtBAlNJGrvj+DcmfDGRZgS6G1wvRBCDXmwtwB8ZP
	 0AV+TOGFa3OyzQQDGlk1kiB0CMlvX61ccvMtOYXe10Ey9E0fX/HXZ4DlueXDlxbBce
	 J87JwnbFrt0RYvEIqNkH7dl5qsuVOD0csfQx2lK9kcATMQl8TmvGyT8TcyJYcqmutA
	 Bm2RApsIfwNsVhCQrU7HBv9uiwSPuUPYMEt++CxkgRfhgHbYmf2EVmAI5+QkTiax4l
	 oVq92rbMMlTI6DsYGi5k7g9Hd5ju00FgsLqyJbIR29ke/Z2KRE0P0ngdWBXrGMT68S
	 XaifEsuJ6K3kA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com, 
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com, 
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com, 
 yuhsuan@google.com, henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, 
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com, 
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com, 
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com, 
 darren.ye@mediatek.com, antheas.dk@gmail.com
In-Reply-To: <20240716064120.158-1-shenghao-ding@ti.com>
References: <20240716064120.158-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Add TAS2563 into the Header
Message-Id: <172234257365.30842.9603736031579487587.b4-ty@kernel.org>
Date: Tue, 30 Jul 2024 13:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 16 Jul 2024 14:41:17 +0800, Shenghao Ding wrote:
> Add TAS2563 into the Header in case of misunderstanding and add
> channel No information for error debug in tasdevice_dev_read.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Add TAS2563 into the Header
      commit: e620b496c78706bb71691502e0381eb344afeaea

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


