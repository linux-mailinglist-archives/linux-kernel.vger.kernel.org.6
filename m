Return-Path: <linux-kernel+bounces-377101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738639AB9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2CE1F24211
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376471CDFBF;
	Tue, 22 Oct 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT5h2N+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754D19993B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638246; cv=none; b=Zy1OLR7n2Q25DFtZd3E4TS5334mxemw/DjsY+IZ7M3ajBnPCHyR8B1Y8x8v+1EwuPlFMS1O9MeGwQoZB/0qjVC0j70Ds7ckIbW+qxPcZU1ym0DiHyZXKUIeo/f9Pm7W25AnTdfdGDVWSu5kORBo7Y/ri2rGOBtHDRcBg/dreoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638246; c=relaxed/simple;
	bh=i8IddBBNVX+CJpzNmo0oeAOmwvuicOUsztsNo3u9M1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mFzVQ+R3BrSh5qvWM+tgLz5c6rB2FHwEfl52uNj65entbD98GsnBvqfCkudCORq4Q/jSOjwxD3NkO/FKtBXi5zNHsQDsyWKTo2tAZShrSZEQFeuRNtCxmQDYfgnVXsidHUMysIRySeIgUC2vDC9CqKv82mEK9g6p4PXXa6EvdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT5h2N+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377DDC4CEC3;
	Tue, 22 Oct 2024 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638246;
	bh=i8IddBBNVX+CJpzNmo0oeAOmwvuicOUsztsNo3u9M1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oT5h2N+FninsBWorrSvMYTxn2Z5Cm50lD5i7OnrdOjasZGB/vAKZDTxkLvaWu7CXv
	 Q91sZgQEHYWYhnWLuKMRN9jNpzXJJuMCVzHkYuYyX87a9N8epQukFa/Sy4rYIwpy2k
	 fDqelUw6wDzVfKe3GvHWgLDJbyObO+ZQuHKtNuf60kkcdrM6bsXHc1aWjtwlGilpN2
	 g71RuDTuEZ53W4V1AGTyLed6aUzKZbZyhtr0m0m3fQNmQFYr/rwGzLV8kFe56zGkgF
	 ppCAPRXIcw/+hPcHxlPTmgw5bHP6SPqOdAFiX4X7Ol5txPO5GJoYe+sgcGRhWMBY2G
	 f+cnghu94oxyw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
References: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
Subject: Re: [PATCH v2 0/3] regulator: init_data handling update
Message-Id: <172963824495.326511.4469889963370006870.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 00:04:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 08 Oct 2024 18:07:00 +0200, Jerome Brunet wrote:
> This patchset groups the regulator patches around the init_data topic
> discussed on pmbus write protect patchset [1]
> 
> [1]: https://lore.kernel.org/r/20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: core: do not silently ignore provided init_data
      commit: cd7a38c40b231350a3cd0fd774f4e6bb68c4b411
[2/3] regulator: core: add callback to perform runtime init
      commit: cfcdf395c21eeac4543d2b8fef9d29ae9e4559e9
[3/3] regulator: core: remove machine init callback from config
      commit: 602ff58ae4fe4289b0ca71cba9fb82f7de92cd64

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


