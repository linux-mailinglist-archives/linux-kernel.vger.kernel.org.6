Return-Path: <linux-kernel+bounces-441718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBA9ED303
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E6B188B668
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9681DDC00;
	Wed, 11 Dec 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyvMZCPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CF1D90AC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936559; cv=none; b=IN9hKi04eNG8oruaxQHysC9ibFeBuKne3R21QODXeRQex5EUUDDz5UKxfyzc79Vgy1XPPZc3D3saZIfrsQWM8WX/6ItW/lbGnD7FLZt7RgWaSw+cujlbZl8aco3tD63kXjS6xv7n/7IgCB7ery2QnzFD5qciPqhtHO3QuLE/3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936559; c=relaxed/simple;
	bh=36gnEpfDrioD/V0+iPsv47agMkaRn3A9ZW37XyV8FYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l1tfQjnypWW53fxkpvsEfcsjyLQ9Wfvh0uu4g2QrwQwd5OwP8caczuLiZe8E3TFfvAZUVsf5I/aWgT4yo6c2ew/IVHGM8pin9t3lbGHkY+b7DfmL0Wcqar8gm2s7MpTcrMnYh1Lwf8fI+tQth+r6G2o+7uiSd4pbNP//60ZEa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyvMZCPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD23C4CED2;
	Wed, 11 Dec 2024 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936559;
	bh=36gnEpfDrioD/V0+iPsv47agMkaRn3A9ZW37XyV8FYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eyvMZCPxXLUhZ2Dvd2urOuVKlk7eW5YJMBFGiR7BX6wtZZIsNOfsaCyeJ8bRGajpd
	 xN6HWoFVRBXpUO7aeu3H+mh/eUeAL9zH+ybNHnZdWMPwNpUeRbVsEsSa8jWc52zfP6
	 8p5cAYrvL0U2gdGjk9Fc+8jkba9h3xaO+8ZE7aSSjPvpQwRhOcuGwv1KvrzRzYWRj8
	 ChfHsxx6n0qHheO3nyDUrV+3OzYQgUR/i9tVTkXe/L26Ot+oVhbTxpINMTq26IMBae
	 kciKADP6gt+mQMJ+89R5CRbdUDM6oHnh7AbaeqZ+PXm7UB/fyN/mg8Q08J31kkrcMw
	 fEwAXnSUMNZag==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20241211133558.884669-1-rf@opensource.cirrus.com>
References: <20241211133558.884669-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: regmap_multi_reg_read(): make register list
 const
Message-Id: <173393655818.519837.3526009062975748002.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 17:02:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 11 Dec 2024 13:35:58 +0000, Richard Fitzgerald wrote:
> Mark the list of registers passed into regmap_multi_reg_read() as a
> pointer to const. This allows the caller to define the register list
> as const data.
> 
> This requires making the same change to _regmap_bulk_read(), which is
> called by regmap_multi_reg_read().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: regmap_multi_reg_read(): make register list const
      commit: eb708cd631a8dca17ff004ccc39bbeb096c1db22

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


