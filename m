Return-Path: <linux-kernel+bounces-428102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542399E0A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F62B8268F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDB1DD889;
	Mon,  2 Dec 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q447Qxob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3881D9694;
	Mon,  2 Dec 2024 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160993; cv=none; b=dRlepnoW+AFCbMyevbLTdplQ6dF8GqOFm43VH5MFTDUk1JlAK0MiU+iT/MFMLu6ZdD+kmx+ZFWGaZZKy7QUjNnqRfvCcP7KMB6WKllZt0tQubJk/UX+26GQoctkn2/Rg4HLtX3+1ENlG36UCwIFxueFNGSDLxuDHN8XcsxMmQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160993; c=relaxed/simple;
	bh=5am5/7HJ+XN0E+xl7eqOs1PXl2QfSg12UUxGtMd6/sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A8d27dhnssjvZZwGCtTT6ATsCXM8hfWAR4DOtt+rpSObZ+rDifTFrEKCht10BDYdVpHVBXFyQ6e+/ZVKLhaDY8ky8z6k/RmAsDJHxi41ITnSFQlK/77yYorgItFDKLT4+jyh8kS/avpp8T2LovOW+MS9gK7S5yxaYNqB4ohBnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q447Qxob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7473C4CED2;
	Mon,  2 Dec 2024 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160992;
	bh=5am5/7HJ+XN0E+xl7eqOs1PXl2QfSg12UUxGtMd6/sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q447Qxobt+kLUELjmEYyYmFYb9cDkUE6mYIsva27z+lKcQiAA9BipaOn1u+lFN0Dy
	 bbiCrHphqjQzaSiVmjTLE7VkVB3F9s9d8fVV2P5CReg/cJJ4aeeWg92i2JgIIz9bOl
	 C3NpPShaRTqAZwtT9RSIN7FOH1dGNhbXzyy0hhZM4FBIF1Rd9OqcuLXVu4H/n21NOP
	 rEkKQm8pLKpyPSgHHcIwi3XWH5InB4jL7Yl3iDxQRvuhBIGy6Jz69f8jQoAuHmIZ1G
	 475Cq+NwjEThlCrta81YSi4NjhfQtdwBzpxu7sXoNhTwSLX21gUi1e2Sx41uR5Ry8r
	 66r5fhucqsYyA==
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
In-Reply-To: <20241121105838.4073659-1-andriy.shevchenko@linux.intel.com>
References: <20241121105838.4073659-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] regmap: Cleanup and microoptimization
Message-Id: <173316099054.156347.17424661167771006214.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:36:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 21 Nov 2024 12:57:20 +0200, Andy Shevchenko wrote:
> Two patches move the code to use BITS_TO_BYTES(), while the last
> one otpimizes the code generation on x86 (32- and 64-bit on different
> compilers).
> 
> Andy Shevchenko (3):
>   regmap: cache: Use BITS_TO_BYTES()
>   regmap: Use BITS_TO_BYTES()
>   regmap: place foo / 8 and foo % 8 closer to each other
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: cache: Use BITS_TO_BYTES()
      commit: 4a3aafe01f6c628932a402c21e58101173c8dab3
[2/3] regmap: Use BITS_TO_BYTES()
      commit: a4a7d86bc1a59839ad0dffbefa473135b342dd0b
[3/3] regmap: place foo / 8 and foo % 8 closer to each other
      commit: 9b3cd5c7099fe7710356dd76ecf9910dc8c32548

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


