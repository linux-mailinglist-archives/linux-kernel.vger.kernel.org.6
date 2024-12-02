Return-Path: <linux-kernel+bounces-427611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378C9E0371
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2192830D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9334202F7B;
	Mon,  2 Dec 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4dwS/GJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB31FF7DD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146233; cv=none; b=mjpVjY0nDuxh5vJYKcI6m+rTng7HVoVLT1prywVgJXs9FUukjr6gqxoP5tzpcBupVeMrSUZDY+duJVR8BMzSMO7iZlM5c71NpeTt0IXPqJ7N5InHSjqiAPd9prqD+K+mNvSTH1ZyKq9YNu5FtFy67PLtD5sgp9DDqW8MvOYd52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146233; c=relaxed/simple;
	bh=r/pTabNPaENzzFSQ4V8FIvsOQNcxS8HOD2dKNxu/Ifs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0Q5qgawdBuGo6ygOQkmLTLpGU0u4Q7ueSHbFhOjSgG5pFId+GWeZGtT0MlvXDNB6FbpNLRncWInF3YnpyoHIQlRmibcaeQwQaMJpmJuCXbyz+9VkTjDCuKFrwGjX6Mbhc4acwlh6GTm5blw+xuQqAOcZWstULs3R+BbU+INwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4dwS/GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C100EC4CED9;
	Mon,  2 Dec 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146232;
	bh=r/pTabNPaENzzFSQ4V8FIvsOQNcxS8HOD2dKNxu/Ifs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W4dwS/GJ+qS/pMKCl8ZYm1uzLZMQn0Awrt+q3Y0Zv+HLUW714UnPxQ4IpqsyHDjDG
	 vt/aLJwFnkTjLtRG7vxRtcI1j7RRWPqfl4Mhro0R+g3cQVoKAkM3YMUUP33KnZJCgm
	 Wr5gVdFBwTzLZE75B9TKmgs5hrXqYjg8dKSjE+BDq595mwzwSB7utlXzD3arJMY+T+
	 J1FKcaASliJtGImDaPllKTgKlVzygF1EPJxUWdtbhzvcs9JGBCj1jtlclW2Xc//CKu
	 Nx/+7uHyWQsrmZTjIB35y9BCcjC45v98EgSwVTUA5xLP9s08BdkGcJOagsYjHDMyiu
	 wkPfPsVWb4Sgg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20241121123433.4180133-1-andriy.shevchenko@linux.intel.com>
References: <20241121123433.4180133-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: cache: mapple: use kmalloc_array() to
 replace kmalloc()
Message-Id: <173314623150.54131.10108415771179350875.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 21 Nov 2024 14:34:33 +0200, Andy Shevchenko wrote:
> Use kmalloc_array() to replace kmalloc() with multiplication.
> kmalloc_array() has multiply overflow check, which will be safer.
> In once case change kcalloc() as we don't need to clear the memory
> since it's all being reinitialised just immediately after that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: cache: mapple: use kmalloc_array() to replace kmalloc()
      commit: 37c95f022a7a34823c123eeccdfe415b88562867

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


