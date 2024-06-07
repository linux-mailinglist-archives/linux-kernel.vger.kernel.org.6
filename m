Return-Path: <linux-kernel+bounces-206789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D775900DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FA01F23B77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DF71552F5;
	Fri,  7 Jun 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG+nkk5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA644C8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797489; cv=none; b=Qa/h6vMjlfyT31s5V7CDeiXiNJwegiToKBzmtu/DMdd3WDv9SCmbOm0GdnPzVWVr0Sy414aROnxWk81d6NxjW2xyglAhdLoCFpQLFDuHq4rXKaQBrzGIukewBeTh+8iOtA1UpHWdLiM6rvqLRl0mvNCy7enI4jPXatiWsut8YAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797489; c=relaxed/simple;
	bh=yPc/mjrMxj7RsK5QqW45Eask2P+8u1DO9R3moqOcCKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KmgmtMTJoRi/LEMHAB670lAEj0taIQ2JpRT20p75uQlzpHzlHSJxrwKCTX0MFiuHwmHui4xPUx+V6TJg2TOAGK4x/HxzV1Q3B+1/tj7HJdakB6aEn+M7Blh4feEeC/X8BsTlkaSAAzEiUKQo64f3N3YsVrqrCai9VWS8JE2dzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG+nkk5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3639C2BBFC;
	Fri,  7 Jun 2024 21:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717797488;
	bh=yPc/mjrMxj7RsK5QqW45Eask2P+8u1DO9R3moqOcCKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nG+nkk5Wm7UH9q91x2OrhEZQSV7HxrqUrZ7g6g1yzKKALB4XQpyHvMPwpGOtY04E0
	 whjcNV2bGDW7wriaFcQGWzLnQbLY2PhUAA3su9XJgTqH5QPZFEpT/F+u6yKG7STux9
	 8muaWFTK/wVtIluAJa4jYbAFeUb/Z0ux61HYMhug9bOrIqMUQPEp0BQ7zJoc19a3WU
	 kizpynpQMRBlbLOOpussiI0uLYgEkbfLOjJ3h5mYgLhqZOj4i9suitYEHlIKCRXCQD
	 z7AHsNOBj+4K47pIMjBR+kzPnt2K+OkQFURAf4G5IbXpUdqzROKPaxe9puaTwKi9xz
	 O4YEfW3jxlv6Q==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
References: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] regmap: Switch to use kmemdup_array()
Message-Id: <171779748729.90702.10518297985774954502.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 22:58:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Thu, 06 Jun 2024 19:46:21 +0300, Andy Shevchenko wrote:
> Replace open coded kmemdup_array(), which does an additional
> overflow check.
> 
> While at it, fix one minor issue in regcache.c.
> 
> Andy Shevchenko (4):
>   regmap: Switch to use kmemdup_array()
>   regmap: cache: Use correct type of the rb_for_each() parameter
>   regmap: cache: Switch to use kmemdup_array()
>   regmap: maple: Switch to use kmemdup_array()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/4] regmap: Switch to use kmemdup_array()
      commit: 540c53d158d947db1249614d47437c660ba0b959
[2/4] regmap: cache: Use correct type of the rb_for_each() parameter
      commit: 354662dc66f264b26c3e094162e0fad8715d009f
[3/4] regmap: cache: Switch to use kmemdup_array()
      commit: f755d6955338bc704168629f70b380658a4918df
[4/4] regmap: maple: Switch to use kmemdup_array()
      commit: bce843065804f770ac469d32a3d455b9a997b55f

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


