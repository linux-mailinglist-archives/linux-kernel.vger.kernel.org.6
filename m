Return-Path: <linux-kernel+bounces-321714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC48971E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5981F1C22F09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4A56766;
	Mon,  9 Sep 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyKuSPXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB55588F;
	Mon,  9 Sep 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896922; cv=none; b=ndUkhk3aMq0Jmm6GQ/ixPQisaGiSzDf4OvwbcEzhxR9DBgr4rc229/n6EJnSAOSaiqQJpCVbINOo1dOB1na9Yh6XDlgOJs1Hrf3PW07whYlVKd2kgTZwfPblAJ/Cot+42A6riKjIsQkzMTycvf7U/qgZ56mZbZxga0zD35ZNypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896922; c=relaxed/simple;
	bh=qfF7BKhca1F+Onm/J8eJruSRocelnXBb7AnYSAEGGaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyZMFBreaykFjEe2qlYXuFcbYYAyIfvfB+TwlDeDVzay8gHeMNvYuXPLTCFVnEHQ3WHigW1pHdY0zFVgGpDXkw6vT9XCIKj3djg6vkp436hf0kBVCwTUfVpQQYrw1NTxVq7P7ufciy3uaM9u9sf9/T7+O4g/StxhDttv9s3JZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyKuSPXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB4C4CEC7;
	Mon,  9 Sep 2024 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725896922;
	bh=qfF7BKhca1F+Onm/J8eJruSRocelnXBb7AnYSAEGGaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyKuSPXOPYkkj+DggQ50Xf1c3S2H6Zk2LBlEGt6YzrWZWoxcUEPYL2xP1VjzcSotm
	 qB+c4mj5YmhFZnITiT1SqtHX0mBxWt/TWjIw3l+QC7L5J1q8+6vZVYYbzEsWsaluAr
	 XYn57CW/oBUbNWVovYhPEQnJG39d4qogu5A5mURt9vu8iLTK7Wpy9fp6qkrm4DZoDH
	 vwJDINfHktHCa07Vk5tSalYnVwmQR6bLEYoDBabhzawZTyoGAhDXcyVZVd50Eav62u
	 B2Dgp/L+4oNN9rA5tUWhsN4W1JTB4f4pT2ZiboCzDBdb96JWWtIBW8j0vAt7YDDIi+
	 MXgfttRIOcQ5A==
Date: Mon, 9 Sep 2024 08:48:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/7] ASoC: mt8365: Fix -Werror builds
Message-ID: <20240909154839.GA59917@thelio-3990X>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>

On Sat, Sep 07, 2024 at 01:53:25AM +0100, Mark Brown wrote:
> Nathan reported that the newly added mt8365 drivers were causing a
> number of warnings which break -Werror builds, these were only visible
> on arm64 since the drivers did not have COMPILE_TEST enabled.  Fix this
> and some other minor stuff I noticed while doing so.
> ---
> Mark Brown (7):
>       ASoC: mt8365: Open code BIT() to avoid spurious warnings
>       ASoC: mt8365: Remove spurious unsigned long casts
>       ASoC: mt8365: Remove unused prototype for mt8365_afe_clk_group_48k()
>       ASoC: mt8365: Make non-exported functions static
>       ASoC: mt8365: Remove unused variables
>       ASoC: mt8365: Remove unused DMIC IIR coefficient configuration
>       ASoC: mt8365: Allow build coverage

Thanks for this. It appears to resolve all the issues from a build of
allmodconfig for arm, arm64, and x86.

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

Cheers,
Nathan

