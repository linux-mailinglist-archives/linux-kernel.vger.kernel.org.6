Return-Path: <linux-kernel+bounces-563841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BAA64986
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3358D3B7FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A423716E;
	Mon, 17 Mar 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVGdZK3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D407236458;
	Mon, 17 Mar 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206658; cv=none; b=HZvv0TO9Z2/8/UjtzLcYdAFz4zJfS2FwEO7y0tmkTgZROIBXqjt+60Sfrv5/VnbX8Qrx6zNlVOkEjd4h9L3K6ZxyTl69W9YMhNhtd+d46mY0wlLrLhVt3k9EezHsNR8fYnSkwaWy/0kPv47ZjBMWFisr4XPvAsYyASt90pmcGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206658; c=relaxed/simple;
	bh=eyRCebnpuJdJjz/Gb5jPmvRmhkaTiJIYnE8mEPJjm6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iKhaWAWcX9uFhnHNRZiXxehgm+vC80O+RdxKJ2XW9Mkpb2dq+yqHkUdkpFFisIVVxAgaqb51Lm21FIQDNGe73qcFRH/BI1N3nekT9DklLrPUlmGC4Laoah5rcs/4rw43pI7Qb+Z3F2qHaUBoyxWdCwZZuwUn7BZjwiuJADgR7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVGdZK3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E88CC4CEE9;
	Mon, 17 Mar 2025 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206657;
	bh=eyRCebnpuJdJjz/Gb5jPmvRmhkaTiJIYnE8mEPJjm6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MVGdZK3/2qUwbXYnj0z4E3uEMvqmpp2IrxXgAkYwDyEMZSB1xUWBe9KVY+Y5eBHWp
	 SwB4c5sd0Kqm7ygr+e2G7ympSSWy/Cxp6Pi5GL6nmnvOYDCh9m2/m+dFVrHBPNv0I1
	 TDhyP2aGCuaCRjT3jtZHkbHACchaHUes+PP7k4II9LaMfB3Rgo9EGZh/zXlHk4EOU9
	 UyXH9r9XWi/YPV8veebb5BY4rLzIMzezt+zTwZEaaMT7E1UzMFdZB719WbRx8je6li
	 wzWB12slwIONF7NBLLzHtlN6v8sRSb2ndmaEweLFpRZMT3oWQaWZQnAGwtkj4ychTC
	 kZXhggGN0UcRg==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250312033509.1235268-1-nichen@iscas.ac.cn>
References: <20250312033509.1235268-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: ti: davinci-i2s: remove unnecessary NULL check
 before clk_disable_unprepare()
Message-Id: <174220665624.86423.1563198973624161954.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 11:35:09 +0800, Chen Ni wrote:
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for dev->ext_clk here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-i2s: remove unnecessary NULL check before clk_disable_unprepare()
      commit: 1458fae110c85d98d356496e4eb120f6de0e3a7e

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


