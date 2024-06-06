Return-Path: <linux-kernel+bounces-204718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573928FF2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E62288470
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490AC198A0C;
	Thu,  6 Jun 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q18oRny4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E01F171
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692214; cv=none; b=qbhMNhU+e4xI+UZWDgVPUOHikRP0/gWIbmp8gE41YrSmURZiV3gylZxVPkRbY2U+Ku6Nqajvn0UcV8RbKOsCShmmQWPkXsJIoTU05Gn9sFSD90c+2xKsFW6vZsjCsxFA23XgJcoRStkYgi7dcYcoQCCiu0QsL1SuuM75CRy6xTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692214; c=relaxed/simple;
	bh=1oniOnLptc3gNOE8n52NT3hP6NYZC4iFKrZWa7a+XPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PtZ9+YjoMtmWNBw7o1LkOPTpcyko+6mQo8V1+2hf/1ez3AKP10U83dd0rxGzBQTCAhyzm6jJfJ1ldSuVYSUNj7SgOEOxFmNNhwGGnX4PAutPQMLsXJJkrhpDu9M1SnXrhGWYrzB2CaIss+OX4Vb/B7OsNMon0SyhN13b+hLN5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q18oRny4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABA0C2BD10;
	Thu,  6 Jun 2024 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717692214;
	bh=1oniOnLptc3gNOE8n52NT3hP6NYZC4iFKrZWa7a+XPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q18oRny4pqscZBK+u1mBTDgvCN6Nuta0dbFiu6A9THz9YDe2YlUIPgnFSy9zzOug8
	 8gcfmSanI3T6Ep/66FeEi0pjnVSiHYwAzegRUZXaNCb/ix0Ntfwsu4xs2z2fHtD0M1
	 dW9Wf0wh8aCxNssDCFVjRDHPLc4gqStooMFT3fMrp93te0bAUJRIsJge8d1/zDKdqk
	 7L7QbSP7A7+Y4TpwqpgVA/xSC+Ad14Euji9SKZ83K3m0UGMVmcVs97xH17BXf2I9x4
	 gNYATcWRjt42B2ithwSmWrVOQJ51Xh5A/+DGIXckzP3z1UZqW7wFZGl/npUFPapKt+
	 B9/OtbkHjkDTg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240605205315.19132-1-andy.shevchenko@gmail.com>
References: <20240605205315.19132-1-andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] regmap: spi: Fix potential off-by-one when
 calculating reserved size
Message-Id: <171769221292.1599563.14121347074593824634.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 17:43:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 05 Jun 2024 23:53:15 +0300, Andy Shevchenko wrote:
> If we ever meet a hardware that uses weird register bits and padding,
> we may end up in off-by-one error since x/8 + y/8 might not be equal
> to (x + y)/8 in some cases.
> 
> bits    pad   x/8+y/8 (x+y)/8
> 4..7    0..3    0       0 // x + y from 4 up to 7
> 4..7    4..7    0       1 // x + y from 8 up to 11
> 4..7    8..11   1       1 // x + y from 12 up to 15
> 8..15   0..7    1       1 // x + y from 8 up to 15
> 8..15   8..15   2       2 // x + y from 16 up to 23
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] regmap: spi: Fix potential off-by-one when calculating reserved size
      commit: d4ea1d504d2701ba04412f98dc00d45a104c52ab

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


