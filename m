Return-Path: <linux-kernel+bounces-372167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A739A4532
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE41F24D37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9F205E16;
	Fri, 18 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWFIokuZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E52040BA;
	Fri, 18 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273436; cv=none; b=q+mYJOKs/XmL3PAQaIz4kGqzu6htHhf7QFA0lE6JVnRKPlvpnzTefMAunb835P7GuFYckK2nV4/xBDL67we6txoHEa9y/qMoDadyr7+hdVtyCSNrCitKyY+ablADDN2j/tB/FeNwiXK+suntnrNQaUghFiTUmZe0IDj1mlCYTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273436; c=relaxed/simple;
	bh=+QTrwqGEJr1YsaJFpBsMGkz+TbSki+wDf6EtvAvzOUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHD/xeeHcQiCw/xR0q5pPfjKkGnA56hMkNdZbsOh5VhojFfO1q49I+/6pFdp1vMcf4m8YBL2kaWsGOnohLKOrTvJMprFAz6T98AqkKDwLwmArJkNHmdNHdaXdt+xwtYmQQpChIlEHnszoex2jxbim6qJji0GracOrN+yKYcgv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWFIokuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3379AC4CED4;
	Fri, 18 Oct 2024 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273436;
	bh=+QTrwqGEJr1YsaJFpBsMGkz+TbSki+wDf6EtvAvzOUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TWFIokuZxwvhsET/aF5SSx6MVUmoKEiA7tpx9opA6WoJDRyrgm6Wd+T8YAEkXdCJo
	 rXFNuAcAHu7ekLJhw4YNN85PLSrkWFLZuNndcMXGfZFMNCww3cFiXvrXEN25LLCai5
	 qrG1tGq6dKet+cv+DE7wnrsdlD9d5SwabZdAtQzfAFL0DagEtfdi8Xj6AIfnL+Kvgx
	 pJJglQWSQRWTo1ll59IXZzYBGTNfuXFqVuPa2LXQ4eIevh9UphhO0vuBWxVtzXqKCl
	 wyxCHsYeshcHt4vw7aePY5yZrlBnmds6/BIbMW77cxyTLj9QjdcWk/MWeo+PpDnAEk
	 SUbHYI+2A0p7Q==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Cc: lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com, 
 kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org, 
 Anne Onciulescu <anne.onciulescu@gmail.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Chao Song <chao.song@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20241017110313.1423258-1-daniel.baluta@nxp.com>
References: <20241017110313.1423258-1-daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: sof-of-dev: add parameter to override
 tplg/fw_filename
Message-Id: <172927343394.163659.7634673510798036454.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 14:03:13 +0300, Daniel Baluta wrote:
> Add support to override topology and firmware filename,
> using module parameters. This is helpful for development
> and also for testing various scenarios.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-of-dev: add parameter to override tplg/fw_filename
      commit: 9cb86a9cf12504c8dd60b40a6a200856852c1813

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


