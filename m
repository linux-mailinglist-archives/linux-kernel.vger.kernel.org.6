Return-Path: <linux-kernel+bounces-539489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EEA4A4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84540170539
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8631DE2BE;
	Fri, 28 Feb 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLP4jZnC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1151D7E5F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777769; cv=none; b=nwg1hUfM/b9dNEImZpgxN8GbYd/Ewrr09koiqqJFutXetghsxQ7eA7WBpYR7goL+bcp/1B2SCSxWFidu4Bp6njYvgd1h7e743CUDwsOgVrMVLU9H4B3vEhOBCdNb709xmTHJ4GXUfJ3TlDctOxkHPx7plH0NKr01BCXgSBQAHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777769; c=relaxed/simple;
	bh=BdUt223lMdWOnXc6cIlvD1jJVADcQvHW7HwahCmqe1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sgUHLWAH43THgGphZBKMcw4cyWPp/hLKAANV0e5RiZMDsQY5rgFZMEy4yn0r+ms7Bm/TpguPYiTBnUiQ4/48VX2LY8oaBcstbCHP57Pt6prLyQZMMrtD1ay0ZxPzNGtpn/275VGYZN5w+M/cQYJ0jUSQcNbNjL0bE20LxzVMAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLP4jZnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE87FC4CEE5;
	Fri, 28 Feb 2025 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777769;
	bh=BdUt223lMdWOnXc6cIlvD1jJVADcQvHW7HwahCmqe1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lLP4jZnC8S7vyY7doJ9eOcblsw7RYWyaHJpo0DQO0ZLMF0SxAWFFJlKJP3NmYqUby
	 QNPbNFn972I8BBQZAQR1SMFaUXUEMurHpc1Y3CD7yl88Q1GDPHyH4EWAHSHlnYk9nq
	 UIbOJwnPmnrtmzBxYkBZhRONB7pr9PpTsqD6lrgaxItZAePS1bQI9QNJWGGZ3FCxe1
	 a/trBQC2GjOvYiODDnEQVOTrumjyzgDw0rdt6/yha15lwUuOln2jCaEys7dM4gOWec
	 wLm2gCwloXOszTwRpqNsPzNdWY9YCoFboS+PZ1QzCB362J/oWQuFr5EKBNl2K97qpI
	 HViFXwjKSpSbw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, bleung@chromium.org, groeck@chromium.org, 
 andriy.shevchenko@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250228072057.151436-1-raag.jadav@intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-Id: <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 21:22:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> This series converts regulator drivers to use the newly introduced[1]
> devm_kmemdup_array() helper. This depends on changes available on
> immutable tag[2].
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: devres: use devm_kmemdup_array()
      commit: 6ddd1159825c516b8f64fda83177c161434141f5
[2/2] regulator: cros-ec: use devm_kmemdup_array()
      commit: c5c4ce6612bb25ce6d6936d8ade96fcba635da54

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


