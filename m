Return-Path: <linux-kernel+bounces-333629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86897CB99
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD51F251D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F4219FA8C;
	Thu, 19 Sep 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxE0OShW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495119FA72;
	Thu, 19 Sep 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759557; cv=none; b=ZlEM1lAZldno639H5R3mKmjz0BqAkGLntJb7C1PtRh+jAsgjeR1DdYuV6HB+pE/G3j9rA7zKF46o1o0ICsBLOd5D3S3zkhPUh4k9Yxoc8XKZVj4g6s5ZPxciZHNNe5d3+mLS0NTEx/5CDes1JhBeLxGAr4pgD/FcNLK73xkgC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759557; c=relaxed/simple;
	bh=U2AFCm0xgmrmeAuX0Ch0GWnnjnSPaBVCc3gN4b/1GmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kc8bYJaQHyDRCDvYv4tzY/JDj/NPsxpXIV5xrG1E3tJmKxKIuKjF1qubL+BZTemE+aSsYZn280DK2/juackSQPq8hpw/v3HyH7U6/K4uZScr3d22hxd2FYwr70Q5FxJLj30WUFV3XnT4jRbFiw9JxRlu1ndc4GeiUQ9sDRSz0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxE0OShW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E96FC4CEC4;
	Thu, 19 Sep 2024 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726759557;
	bh=U2AFCm0xgmrmeAuX0Ch0GWnnjnSPaBVCc3gN4b/1GmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IxE0OShWchhmVNzn8dZinyY6AcNl+aG4mHaVA4GoOIXz86hwO8wNqRGPFZEDqZPYN
	 NQh+kRWUfFBSDQmjAFZCh4uIjY52eKNjpuVhBonzfuiwacs4sNqiQQtrKacTOGgwT8
	 +in5GHXfNgdWQgLwzBfClxoC2+CmqTuXnE3+YzeRLC7uVMG5nH6G09CZWf/f0T3/zT
	 0pEwLgJ53w5cc8tW3CLV/qnvtnZ9M+FHUh5nxDhIHFcJAZwi9Txypt89CzCK7z/QRC
	 1xltKOICRJ7Pq2FPMKahhH+cQcMyZVPuR05IqVR7snewVnPAHo/JFrOH0qhPJhXtgf
	 ekGQSOAooa1NA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240914081608.3514-1-tangbin@cmss.chinamobile.com>
References: <20240914081608.3514-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: topology: Fix incorrect addressing assignments
Message-Id: <172675955522.1842725.17347774552974803458.b4-ty@kernel.org>
Date: Thu, 19 Sep 2024 17:25:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sat, 14 Sep 2024 16:16:08 +0800, Tang Bin wrote:
> The variable 'kc' is handled in the function
> soc_tplg_control_dbytes_create(), and 'kc->private_value'
> is assigned to 'sbe', so In the function soc_tplg_dbytes_create(),
> the right 'sbe' should be 'kc.private_value', the same logical error
> in the function soc_tplg_dmixer_create(), thus fix them.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix incorrect addressing assignments
      commit: 85109780543b5100aba1d0842b6a7c3142be74d2

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


