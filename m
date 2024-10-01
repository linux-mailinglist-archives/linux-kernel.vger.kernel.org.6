Return-Path: <linux-kernel+bounces-345751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986498BAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7FE1C21F84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEB1BF80B;
	Tue,  1 Oct 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiCbGyoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF51BF7FC;
	Tue,  1 Oct 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781222; cv=none; b=NhqjnDPNQdGr2AyT2XCAyCHvP84EqPM17OdmCVsHrHrapiLt3IRXdJP/D5CCcDpIu7hfCIImxn30Yqkw1NlFQxZ1BZ1fEDCF0TyX0or8sQJnDzlRD73HBerSna4wPMNp14BQLtD+vM6dyQV0taBrrm3+aqfft5GhU39j/ZDxm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781222; c=relaxed/simple;
	bh=uzylzzEuT8st5r1GDFGho8NGlqZCts0HU6U/XLuQMR8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U0gc3feUtbm3LYg0dcybsRjt8wTp3avUW37U5uI/QS6j343gsprQidS2t7AAtESex+NROaF2q7+DCkypDwCVFJBYBP+YRYc5dBwoooopp4P31hpXCJngA6RIyjvm07lzW0IQpimcHyHdd13Dyafuv8KA57NbHbwxIpm4SzTvtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiCbGyoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D7C4CED2;
	Tue,  1 Oct 2024 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781222;
	bh=uzylzzEuT8st5r1GDFGho8NGlqZCts0HU6U/XLuQMR8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jiCbGyoLA/AwlO5tcvz+hWeVL91xgjw+Jv5wABi6oRclBCAnwfxAm3gxrshOY2SJC
	 zK67yNlOoa3lu8gxuxL3d1QODvZjRAMTtz47vNNfXjY5T6ci9gRoDqoTcxK7WSeWDM
	 q831zSyCnXrw983Juyz9MLqlIO4xpNR9dGAeaOdnmaOE1VFSEjY/UHUkosDLqnFuC2
	 T+CSEuNZaIhzv3R6btsjP/rKge9TdCj2WH32Y9z98PKBZymkYeTKDfYQec0vQByJHF
	 HbxLYcz+bsciC2fUZjdjACem+C+23D3t/N/TigYeEl93gc33/fKvj/5VNXddMY6kI7
	 uNleuFTBa+fGg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com>
References: <1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT
 bit
Message-Id: <172778121960.2280749.6663720660194136965.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 30 Sep 2024 14:08:28 +0800, Shengjiu Wang wrote:
> FCONT=1 means On FIFO error, the SAI will continue from the
> same word that caused the FIFO error to set after the FIFO
> warning flag has been cleared.
> 
> Set FCONT bit in control register to avoid the channel swap
> issue after SAI xrun.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit
      commit: 72455e33173c1a00c0ce93d2b0198eb45d5f4195

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


