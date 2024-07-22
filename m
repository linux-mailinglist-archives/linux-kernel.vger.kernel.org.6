Return-Path: <linux-kernel+bounces-259301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A749393B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145A11C216EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE217108E;
	Mon, 22 Jul 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjiZUOpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A54172BBA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673705; cv=none; b=lZkcwyTnCIiZ+Vecv+kDn+VV3K0aVs+4KgFD/YOPq9ja2YEhWTTvpDawvsZTPnJjCv8DAM559cqUWyYWwEXBCaxsDIavR+cRv53Ls5oImuXdv9PQ3osegLOGanbmUZxA/xDyBt4TglaiV98EwR+J5TsT2vqCKbf66GkOXSfR9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673705; c=relaxed/simple;
	bh=M31lVqcuqHAfnb8LRMLu+NZexgficSPDthhPOKvCY04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLi5bnNmW+gJABrZPBGNJOsFQ8luh8lcZDG4e4NXCN85p4ZjQupuYxILW51gVG7yRM94BuCv0CZilrG2xwMikKtYoHVp+ud2HuHOUuUPUd/4gwAdvgjQDygaRoJMdRuxM7K1t3YHrQHqIjvKqSaiy8kMY5omh+nn1P9pyRiKEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjiZUOpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E8BC4AF0B;
	Mon, 22 Jul 2024 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673704;
	bh=M31lVqcuqHAfnb8LRMLu+NZexgficSPDthhPOKvCY04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DjiZUOptDO0itr+Cn5lf8lR0BH5h2vQQ89hP4Nx0UHStyU4fdCIVX9Abx7vkbK5s5
	 uUkPRti6B0gkLeb2URo5m5yGBq34dLQR/4HGo+lbeZyrAyW/kk5IYtjIQ2/S44fPey
	 FLCJbQSaCnvpAl7jXQDvdxZOEsztbKAzLuuIhpC1pk2VG0i+3e2h1rj/ZvfVU4nvof
	 ueyhL28YC/mi9wUbICebVKOQVm1A/sCakLQBLxZJFbSHwX34zmiAwozLz6REPhFvCM
	 ka8k6/GjHMukwOp9n3NXxVLUkE7oTBN0pRu+uEZPc4+mUys727FfL0txpqXi28EYXS
	 qxi65R7nCF7cw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Guenter Roeck <linux@roeck-us.net>, Colin Ian King <colin.i.king@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240719104030.1382465-1-arnd@kernel.org>
References: <20240719104030.1382465-1-arnd@kernel.org>
Subject: Re: [PATCH] regmap: maple: work around gcc-14.1 false-positive
 warning
Message-Id: <172167370279.77740.16466974603431770496.b4-ty@kernel.org>
Date: Mon, 22 Jul 2024 19:41:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 19 Jul 2024 12:40:24 +0200, Arnd Bergmann wrote:
> With gcc-14.1, there is a false-postive -Wuninitialized warning in
> regcache_maple_drop:
> 
> drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
> drivers/base/regmap/regcache-maple.c:113:23: error: 'lower_index' is used uninitialized [-Werror=uninitialized]
>   113 |         unsigned long lower_index, lower_last;
>       |                       ^~~~~~~~~~~
> drivers/base/regmap/regcache-maple.c:113:36: error: 'lower_last' is used uninitialized [-Werror=uninitialized]
>   113 |         unsigned long lower_index, lower_last;
>       |                                    ^~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: work around gcc-14.1 false-positive warning
      commit: 542440fd7b30983cae23e32bd22f69a076ec7ef4

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


