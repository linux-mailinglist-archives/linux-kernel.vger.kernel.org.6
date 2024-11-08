Return-Path: <linux-kernel+bounces-402284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39D9C25DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BCB1F22072
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C121AA1F8;
	Fri,  8 Nov 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT7Kd7+x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932A1AA1D3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095401; cv=none; b=YHKNIFbCWFs+tpl4xPms7IH7kjmOK1fSuK+VhfsN8G1e6g9xwPF+KlWEGb/L3LEc+95vOXVaWdTPVFoj49DVzaCixLygeP0vRprOTHfuOIXdA1WYwoPT45hS+oAmapyvR8sHMPFbMN2SJhLvfY7ZWGxx11lmZl4Ga5Eb/gKr+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095401; c=relaxed/simple;
	bh=8tSaY0r7/LT+zRXrTDKjHR+lJR7bgaR8lmPhV06Or8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AZRZWSJNvvKLPUPGQvl8Es8xS1Ox00KWRU0VeFeiPlatHpmQmx55hZDyaUSypZL2fzhJ2Vz76azeTQWVoptI+1jMt93h7rgNUpng21PQPSf1QtfU/VB2+UUCcAX7FRtv9JF3GRiczXrDupW1btykfe1lAeAvz8pMKNmsCVQtdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT7Kd7+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6C4C4CECD;
	Fri,  8 Nov 2024 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095400;
	bh=8tSaY0r7/LT+zRXrTDKjHR+lJR7bgaR8lmPhV06Or8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HT7Kd7+xAWoLkTAqPhn/1nzG3jdWWLx9k9bYAmhDgy+bi4tPlH6ScvfrIyiWGnsBq
	 d/gbCs5wuOdBQarRyvNLlGzXefnGCdlyMxqV+c81oDaJdnLlt1hXUOR9GModmg1XhS
	 5NUMRGzyurcRyFfreMdSChAj6fNPJOeheUaMI6b5iVWWtkJijvsR4GnzsxZBG5FVLa
	 TtQu5hdWIWRFXgBBEMnlY9fmSicHFp6p1NxWzDury/hDX7e8O6xIX76jGiF21rd2Vt
	 BI3iHGGrT+aTlZbbgomNFdjGrgtmm/bewnXXp3/7ZIOt365pGIRXPLvofTkou1PGaL
	 P/BLhd0p9T2vA==
From: Mark Brown <broonie@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20241108-assign-bits-v1-1-382790562d99@ideasonboard.com>
References: <20241108-assign-bits-v1-1-382790562d99@ideasonboard.com>
Subject: Re: [PATCH] regmap: provide regmap_assign_bits()
Message-Id: <173109539905.106281.951145382367462586.b4-ty@kernel.org>
Date: Fri, 08 Nov 2024 19:49:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 08 Nov 2024 16:07:37 +0200, Tomi Valkeinen wrote:
> Add another bits helper to regmap API: this one sets given bits if value
> is true and clears them if it's false.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: provide regmap_assign_bits()
      commit: d1f4390dd28ba110f232615dc4610ac1bb2f39f2

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


