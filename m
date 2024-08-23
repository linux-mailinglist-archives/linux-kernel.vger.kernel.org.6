Return-Path: <linux-kernel+bounces-299733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5AB95D964
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114511F2310E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2721C8FD7;
	Fri, 23 Aug 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlkjijJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1083195
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453833; cv=none; b=ZYrIJ95i8vphyoT/+9LvHBJeRmNPJXlWis414b0ICZRMo1Ca7e4IfvuqQQF36Y2cxLD2x7e8rljrsqLfGn8r5Sb96Y3qZLNUayUvVYOs5WjV/GjzvBd+NJPd3GWBFjc3lpbWFekRWc/EPb41XYLOvH6/2D5QDSHg4HDBrd/cTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453833; c=relaxed/simple;
	bh=WGw6JUm1Y5hmOvtgjkIEwcbBD5ApOo8rwtxWsE1F5wQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uY2pF5JmtK+V1sahauPyKnDARpG2F3FqweEoy1hKLfy7eEsmgIJtWkCo0V9YJIxo2DcqPJgQAK5+SbRdjdw3TdVnZ/CDYxkP/pbMCcgMjPodP39KngHILgKtkn9qaAI+wvzzU+QsMnpi33E/ZqJtkAWSDfjzZ5ygFtsS5lfmdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlkjijJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD65C32786;
	Fri, 23 Aug 2024 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453833;
	bh=WGw6JUm1Y5hmOvtgjkIEwcbBD5ApOo8rwtxWsE1F5wQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XlkjijJQJ/RpkjEC34A9BX3PPwf58RcM4qt35rUiOphnmpA7qmgAoQw/sf3w8/YVV
	 z7ZdXpi0m56yccfYUEY7M2MP5eHKvRBbPkPZcdvDThhVf6jyEX2/uJ3dJ96A9l0Y+r
	 Fk4wIKPOQLC6rUyJUJWyoeZQY1H2aTyEW0CA00vrcv2up9Ab4fzOTggw3LJgnUM3Ie
	 i4s+m4mNpHeDGEL4PaMJR7QdLSzt2zFw5XGaYo1vbbv1fjfftPb4CVGJBCCT2gErng
	 bdgQJCuSdV8cH55bQSrtQgfT0XRJC0VXyp/cdJWE6w/gcx31zfkDJp37apWM+IdDY6
	 mwD/9CBjWoP+g==
From: Mark Brown <broonie@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
Subject: Re: (subset) [PATCH 0/5] regmap: Improve lock handling with maple
 tree
Message-Id: <172445383117.842265.10956767948362419603.b4-ty@kernel.org>
Date: Fri, 23 Aug 2024 23:57:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 20:13:34 +0100, Mark Brown wrote:
> The lockdep asserts in the maple tree code and the double locking that
> we're doing continue to cause issues, most recently some warnings
> reported by Cristian Ciocaltea due to dynamic cache allocations in
> interrupt context (which are an issue in themselves, but still).  Let's
> start trying to improve the situation by configuring the regmap lock as
> an external lock for maple tree, allowing it to do it's asserts without
> having a separate lock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[2/5] regmap: Hold the regmap lock when allocating and freeing the cache
      commit: fd4ebc07b4dff7e1abedf1b7fd477bc04b69ae55
[3/5] regmap: Use locking during kunit tests
      commit: 290d6e5d6498703accffc66849b7fb2d4d7503ff

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


