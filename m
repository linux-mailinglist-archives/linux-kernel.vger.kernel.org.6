Return-Path: <linux-kernel+bounces-439595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F50B9EB183
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FE6188CE48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8871AAE1B;
	Tue, 10 Dec 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVMWfMmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159251AAA38
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835638; cv=none; b=endrR3z1GkT69z4Ruyiek70j3Pdq9fRDIBGAol/AYpXq/s6kPjix1KkQHE91LEjiJYvAXPCyPVYihKLPIWYojhXKvu8hA8GqYuZdfGMTtH1f1OM1kpSGUnpxINqbls6/H1l4OsdW+4y6Q45Xy2yzwlgY+3FijNcipDbXUvK+6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835638; c=relaxed/simple;
	bh=ISBoTgWYIESA6GpXTxdGqDkx/HlisCHfZM19fTKF7rg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I2GhmMxhdCnAVX8gf8af+z7etpMyPUo7icWxXJhM51i0Gs8uQDsXpnjr5qYn9HKFOHYQaIgYvDrKtvoIIcCuctCkmLRWFV6lqP4Xlmp3e5ommAdp1fTbRwOz9YOWCME/fprRPNrjkAcf6IVrmOA6VcJgudUbtSAaR1TXzoKgBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVMWfMmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1D7C4CED6;
	Tue, 10 Dec 2024 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835637;
	bh=ISBoTgWYIESA6GpXTxdGqDkx/HlisCHfZM19fTKF7rg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GVMWfMmL4PHJ19DrINWTelqYgm/lNwYxpLsrt5eRT5SCTBdlRZpEDo//MogMgLgrW
	 H7EGshwWHQkNFZAWWIgkW6lfIFuFjAsTRdXzTwaCPs0r5M83F3WWkPw8jAqob3fcpZ
	 FUAnVDtnYxbb8kCUnu28svGeefq/Tv3kAjV/rjMzOsjgQwjqQX89T335uphHOIbm+U
	 u2ITQi9l5JC5Va9AMMHA02FZNev2GZseh3V8sbrYF0VYQzJizdnG7bcdhAFgf+j/8B
	 ZorvtwdTB88X2FhYLJWjmQvA/IXiIcVXnbaO3+3Bk2LzEEdnwxcoo4MgKZegzg8W2Q
	 x9MThWhjcLdOg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 linux-kernel@vger.kernel.org, Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20241206123751.981977-1-simons.philippe@gmail.com>
References: <20241206123751.981977-1-simons.philippe@gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
Message-Id: <173383563638.33920.11775072075614175705.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 06 Dec 2024 13:37:51 +0100, Philippe Simons wrote:
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.
> 
> Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> expand to AXP_DESC_RANGES_DELAY with ramp_delay = 0
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: axp20x: AXP717: set ramp_delay
      commit: f07ae52f5cf6a5584fdf7c8c652f027d90bc8b74

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


