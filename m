Return-Path: <linux-kernel+bounces-309224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7B9667BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA243B25E64
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F61BA288;
	Fri, 30 Aug 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6zMiyEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E076135417;
	Fri, 30 Aug 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038055; cv=none; b=oQJZyR5P2PWd6n7scFJBX0mjsmbi/hEcZwPLMLkf457ywh4WVEgzIg39FnLaTU8OMotOj9mzMgfmpN4gP6UUQM3lXVLomKNCSs9dBXEKyku0pFPRUunc3hDolcxUaZqgEHX1ZFULAoTsG9EWkHnjtgG59Rz/3hKuouzAetW0Nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038055; c=relaxed/simple;
	bh=GBtmt9Z9AJod1bR39pvhQzsBcCcZge0uznnylrYCgD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VBNurVZZoqZK88+3gbAlJj1hBsV6lwbxeSdlyqzrPRBbfOV4jv8tRlu6AdiPxPbONoE0+KF0Drin0u0X/l7djUHNlKlMpUqMMdIsKalSknC8h+gXijWBCB4prfXkhFVETtQsx4jwaduCki1C3RYz6QdAdXnFma3OiyYrQt3TLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6zMiyEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D280C4CEC5;
	Fri, 30 Aug 2024 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725038055;
	bh=GBtmt9Z9AJod1bR39pvhQzsBcCcZge0uznnylrYCgD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P6zMiyEHsTK1RAXsR9tsiHFTVD9b3sVFHzWMVe49LJqaZPDiHBQsl6oZ+dbiJmLZH
	 dXQbrzyHV4k5O75XwU/ZjZohLpE2TOjw1ktNFXAdGmftMAht8yl0PFvgv7Z2MfVZag
	 JnIQspdQyXf48kG3HWFhiLh72AukMWfR02XytmcGO+2iyFb5md+BxcxV8S6GxKtVD0
	 3UFpuIPQy9FxYs4pg/6a3yGQDPABh+yHp3K9ceFzec2uwUXFRbBbwykuEL8phVpzmq
	 1m1iHm6swcDTkGWvLa/n4WRuXKyg5PyHdjukJOgbzV6WtrdbKFxg4IRC5xPjIc8v9v
	 LRzvRm6K8Nn/w==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240830144819.118362-1-rf@opensource.cirrus.com>
References: <20240830144819.118362-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib: Add KUnit test case for empty
 calibration entries
Message-Id: <172503805409.196534.11009418066889155786.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 18:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 30 Aug 2024 15:48:19 +0100, Richard Fitzgerald wrote:
> Add a test case for commit bb4485562f59 ("ASoC: cs-amp-lib: Ignore
> empty UEFI calibration entries").
> 
> Any entries in the calibration blob that have calTime==0 are empty
> entries. So they must not be returned by a lookup.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Add KUnit test case for empty calibration entries
      commit: 99c9767c0444098a806529204c7a2556f89d0c04

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


