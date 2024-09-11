Return-Path: <linux-kernel+bounces-325353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68C975855
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087AB1C25D51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2361AE87D;
	Wed, 11 Sep 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHSRHY9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71181AB6C7;
	Wed, 11 Sep 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071908; cv=none; b=FQMunuUWEM+LO/ZdLqAmoHaqsjZQb9/MC4N9qN8c5nu2fmaEnOGfsQerWDdJsfjYpQtyF5tnQvdhOxLidUTHQV6BK04iOrBBNtQxT3o/y00rzotnJqxJvzvnYLYA1c0k9wtxs7H66O3IkWP7sN9on6GbY92+kcQ6L8D4nQuQpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071908; c=relaxed/simple;
	bh=XWHADCr8omiqP2wVZEhuJvFyNvK2LLZ7pwzQDUatkpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mfU1XOplimhWFoUN3dXeRvJvZMewfcBL7Bz2ygY4KeMWgHWuchnJsIg3Uaazfz0/7DmqKp3LKeizjIBDiiY0B+P0o2qZZQN3nGUMyPjidKmTWjPkzmy93m+P48Y91bDyi0R2NUaghPKlokhR/aHesowoy5liSTuAKumkLgoImC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHSRHY9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35997C4CECC;
	Wed, 11 Sep 2024 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726071908;
	bh=XWHADCr8omiqP2wVZEhuJvFyNvK2LLZ7pwzQDUatkpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RHSRHY9iV7Gz6JpCKm0cvhgC4Lv8KKCMsiPR/nDbrm8EPOaLET5UC+UKAO8MBs4bE
	 INUDc6A6BTGDoYEBsHyBB71MsKa3Yh1I1+yABdSobrIX1LKsI0kksC3ynkvjJke451
	 /0WdCFw1B+H7rMfG86t4aBtGaXsxzMJSI97LxmS68aar8nGPHyYCtnYmmisDmNXsrJ
	 SpLId4VZTeW5JwHXJgWoEyrnH3u7K3o0ZQq44sJX18p6EVkWLdsY8NU7zvj3Bx/TiE
	 p2aHuRH53bC9qyQAn2Rk+mCvnTsowK2DBr+cr9A9/OrrtiA8B57twdjx6gulDhiAMu
	 44VLuOpMcsdCg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, wenst@chromium.org, Wei Fang <wei.fang@nxp.com>
Cc: aisheng.dong@nxp.com, linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20240911120338.526384-1-wei.fang@nxp.com>
References: <20240911120338.526384-1-wei.fang@nxp.com>
Subject: Re: [PATCH] regulator: core: fix the broken behavior of
 regulator_dev_lookup()
Message-Id: <172607190695.111510.14458343975352541206.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 17:25:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 20:03:38 +0800, Wei Fang wrote:
> The behavior of regulator_dev_lookup() for non-DT way has been broken
> since the commit b8c325545714 ("regulator: Move OF-specific regulator
> lookup code to of_regulator.c").
> 
> Before the commit, of_get_regulator() was used to get the regulator,
> which returns NULL if the regulator is not found. So the regulator
> will be looked up through regulator_lookup_by_name() if no matching
> regulator is found in regulator_map_list.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix the broken behavior of regulator_dev_lookup()
      commit: a1d12410d9b1ecff87d39f80b0d1cec895012ffa

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


