Return-Path: <linux-kernel+bounces-206677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B0900C97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848D5B23631
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B613EFEC;
	Fri,  7 Jun 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAXrKNsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1E1CAB5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789632; cv=none; b=A4GIu/6kkFhjHIrgfhUvpJvTu3VLDsbgWxpYRjAKTVFRSsAcYZT9JBN0TuxYmkyRsITi77pHaUxGokEhj43AtiLnLcTssovYy3s6VVtqF6r05r409+nnF60obY3AbC5lAx1/lvpbc45WcP0M1v4Tbj71YUnPHv9rsaB5Fv/+EbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789632; c=relaxed/simple;
	bh=olwYB0bfF7tNa/B3LNrIicbe881usPIAMxRFbb3l2VM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I3GXgnTLdHrm9fjWOATJ4wleXm9siJkuf7DoEqKzOjShgdVcO180SvB/fTdfLlBOFcYzlOKnw3R96SOqehrPYDJz8oIMi3FtZMoZG+SgwH09rEransGnAMOARgTvF+/01f8eufYdgwoAj8hOfGDwKsGeZCy/F7QOkDdGt2aJaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAXrKNsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC17C2BBFC;
	Fri,  7 Jun 2024 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717789631;
	bh=olwYB0bfF7tNa/B3LNrIicbe881usPIAMxRFbb3l2VM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MAXrKNsDHRlGXS2FTyb7hoHtL/wibwNqNFkK/AoFteTkWqjB3TkpCnFeSmQXqW09W
	 5vH+wO+RWy3voiLbZExsDa1GcUjCwy68VaPzaEWWm7/bgCBlek3sw9Lab/4uQdAmnx
	 YF0wDBzuRUCpqcSCu3cXRqAGjK5xnvwHoPj06po6+VQm0y2J+ou5gfu/WSLCSccDt+
	 +vNFo5qV41HEKOrqe1YKdxGb0jngqccC7fXaB8r0WNtZhrDdIDNGoy3ecLihXk2V7p
	 nwmJghZw8zFoPs4P/1Y0ObzYNHfRuuE+m9a90oM1SQPX5gofImKv9Poc6WnwaBJB7x
	 x3SoTOLfVucTw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240606202102.3108729-1-andriy.shevchenko@linux.intel.com>
References: <20240606202102.3108729-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: kunit: Use array_size() and
 sizeof(*ptr) consistently
Message-Id: <171778963013.87562.14562841189265685482.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 20:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Thu, 06 Jun 2024 23:21:02 +0300, Andy Shevchenko wrote:
> Some of the allocations use explit sizeof(type) instead of sizeof(*ptr),
> which is fragile. In particular, stress_insert() allocates double
> of memory without obvious need for a test. Convert all allocations
> to use array_size() and sizeof(*ptr) to eliminate similar mistakes
> or wrong memory sizes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Use array_size() and sizeof(*ptr) consistently
      commit: f82ecf76cdd477c64b09f328aaa182c1dc64dd8b

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


