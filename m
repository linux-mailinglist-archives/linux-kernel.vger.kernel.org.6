Return-Path: <linux-kernel+bounces-305374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96E962DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247461F24C49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A61A38E0;
	Wed, 28 Aug 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNSHqZzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791251A257A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862779; cv=none; b=nl7vNIKIU+pj8ImGC05CUAKmEW8xtX2PThaTpT3IS2v6vDiUhhWnKLcjCpKKhDaShvDXnj67BmHkaY+TA1nHC8Id5lB2uhn6zcvCxXC5fpDLQh0e5CV2sJ45Lv8SUKhcQb7zQt6CHwHDntYt/tY9/7rNrZN2MYN0nTuBovXIML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862779; c=relaxed/simple;
	bh=kz+r2Hsc49yq/dUJy7mZpouNnMyfxG7/i4cvVNxngvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bERda1YvqQViMc6qG1V4VSMsYmLXiNP2/2ksHUhDptu2qaZRLWv+CU/zOJDHXoGUUjOHO5W+5JNwXi3it2r7GoVIG0pX3vRVkXXZjfygZjHKtraAHkcQoqyotAg7DEcJTuS9KsdBs2VLAcJ98s64fI2JgmNLwohPYG8MkQEyNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNSHqZzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C06C4CEDA;
	Wed, 28 Aug 2024 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862778;
	bh=kz+r2Hsc49yq/dUJy7mZpouNnMyfxG7/i4cvVNxngvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qNSHqZzW4JLcXoGnEKgUdLJBZI9556wWD+epWA7n9BYD0+Pt4ZifO6vss8wJcjsGf
	 F7srsM55JJzuTuSPjQJiwjx0AXZOw/NggVa9KxbzMAoNS86hyWacZlNNiL8H2EPScy
	 1ERZo+S/S7+aR14G7pfDroH82w3RARx/OCmYQhS+a8rgqiMpGfEz6qQdbC/5rV/8zH
	 s76OsqtsgNOY2cRLVXj8l8vQzb2R85t8Oj/isrCi63kIETPG+r/B93uj81hzN6//4h
	 rHA+ABB52uvukfc+EEsiY8IMzPLpXRqIjMCeQ9BLUsxtnoPqgU0OXo10s80GHVU6yG
	 7evYPOw6Y2uOw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
In-Reply-To: <20240828122834.3778031-1-m.szyprowski@samsung.com>
References: <CGME20240828122850eucas1p27f050ad5fb011796b89bb90be353c417@eucas1p2.samsung.com>
 <20240828122834.3778031-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] regcache: use map->alloc_flags also for allocating
 cache
Message-Id: <172486277725.96345.493504524354404211.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 17:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 28 Aug 2024 14:28:34 +0200, Marek Szyprowski wrote:
> Commit fd4ebc07b4df ("regmap: Hold the regmap lock when allocating and
> freeing the cache") introduced a locking around the allocating and
> freeing a regmap cache, so adjust the memory allocation flags to the ones
> given in the regmap configuration instead of the hardcoded GFP_KERNEL.
> 
> This fixes the "BUG: sleeping function called from invalid context"
> introduced by the mentioned commit.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regcache: use map->alloc_flags also for allocating cache
      commit: ae0acef3822ed8908e83cd24f337891e6be64eba

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


