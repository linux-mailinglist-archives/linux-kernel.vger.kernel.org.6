Return-Path: <linux-kernel+bounces-571769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80FA6C1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DA37A9776
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61222F3BD;
	Fri, 21 Mar 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsLyLp9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D522F17C;
	Fri, 21 Mar 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579698; cv=none; b=nVgR/YjU8apOMdzOstNxedj+ISRAXjAIkcEVc7igNRwVWBNoQRniIldlO2AvCeU9UbjR1Nqx0yHgJcKNqxbo9VV6MHZp+CZvg8r4OtEVKIQ2l5U2Aj/wZ/xqMA5oMmc72qh6S5K+ZozH+0dxNmo7MEGeEyNRTRtB+0CERla8Js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579698; c=relaxed/simple;
	bh=NXaFuX3ptVobTfhJBeyU3sSoVf15FcX64TEdbnDiA1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gWy2rHezdq9hZOX1qjkUNm7nyge6zVZWdxfGqCayFJuKvR28N+wndg7OlzNqkwHgtbLhAa0FzFnYjxpav5iSRZYoWX1K9zI3W5ZufKzBlF9YGQrq6FHlivE673Mu21V+ygFu4/9IpUoiUr9mGy1BDdSGKxKQvhJ1rku2gXmPkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsLyLp9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8684CC4CEE8;
	Fri, 21 Mar 2025 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742579698;
	bh=NXaFuX3ptVobTfhJBeyU3sSoVf15FcX64TEdbnDiA1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MsLyLp9eiMPrcGMYSsD1DwjU5jz6Xy4jFSxzlBvgC0+JH8OlKlSZGorLAXkJVaN+q
	 dDtkjdjwv5JkNTyNegyye+JKe7jc/DCJJHP0t8etX96Uxn3GhvuA5U0t49km2wDPiQ
	 cdL2g0+M+CtKyhZ4IPViVIpXmYx2JNCp3SXE98IwN+I3aoZk3agpLIvxkedSfZkC2l
	 DU2u1DW6shkzb06bF4VWn8+Z3UpbcujTXBFxkJqe1LgakXVJdcQd/Bs6M+d8JRtBo6
	 4RNwbDl+zJD3TwOvc9+LfmKsq96x0SCV9vgWElpNtWgnbNFqiZEJmBEduKDWrHbOx1
	 FtN77Hx/YIS8Q==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev, 
 yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250321135324.380237-1-ckeepax@opensource.cirrus.com>
References: <20250321135324.380237-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: Correct handling of selected mode DisCo
 property
Message-Id: <174257969630.2379177.11985602739030119975.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 17:54:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Fri, 21 Mar 2025 13:53:24 +0000, Charles Keepax wrote:
> mipi-sdca-ge-selectedmode-controls-affected is actually required by the
> specification so the code should return an error if it is missing.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SDCA: Correct handling of selected mode DisCo property
      commit: 9ef52d529bb75071e03cf85078f724d69c4abe89

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


