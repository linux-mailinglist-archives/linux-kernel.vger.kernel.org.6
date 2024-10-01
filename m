Return-Path: <linux-kernel+bounces-345753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6798BAB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202901F21882
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286719CD08;
	Tue,  1 Oct 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soVC4RkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DD1BF339
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781226; cv=none; b=p+fiX9WJQqnQc6fxqub8DT3wPJyaYfyZANaaHKXXiJPwZVNf75CBMhSbe47uxMfj9VaftyvKZr6LjxQ2pq7MYntl2VkhmxX9KQ6smik6oBGtg9tWNEJYfu+YtGzF71NRJJ6H42Jifb2agcojtl09OJle+Wm4wxCkAOyfzILTGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781226; c=relaxed/simple;
	bh=TXNok+/MQKGBTIsFnKX2QVJ9G8ZhbwNfIY0v4f1ycH4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A5sl9TiHg4H/3J+YTViU1QqNA/bBXju6H+Tq3WktuIpfDt+uHHT/OiNdKlvJt54k4Iv2RuIPkfeiNIFfgAYKhwQt1KkxnCDCbk7Cg+N69CNGIHyLslKSjMX13O+bsxTqogT/+S0BQACIftUzq0ql6xsHTqnNakOikXnNBvCTUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soVC4RkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F18C4CEC6;
	Tue,  1 Oct 2024 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781226;
	bh=TXNok+/MQKGBTIsFnKX2QVJ9G8ZhbwNfIY0v4f1ycH4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=soVC4RkKBcrFlfhQdb3RSvRcKxdogb2f18Btc79Wk5aMemxVIaYzy43hVpVedLUSB
	 2gstRo4MUMOjVSxAWIz+THkzEZ/W5StzwHqCRRJQnPyd3QMRTCy2t62U1Dl1n5OPqb
	 JV0C78EIxPtKvIj7+O2fLO+w8pnd4w3cDBJJ6v2KPoaH08N8Sk4CMMQ7N2tVZQSDlk
	 1xcQLvgdwdCtk+irMDw+Xh+2HfQx4GxUUSSsCLPe77Ss/8jz3Ahah3lVQU5nA39J/R
	 +pwg4P8wCA5K8nZ0pmwknv0FHGqw2cR+DnLL8N59KKE33MvpXjTYUvST5fdcaZU3RN
	 ck2TDe4StS5hg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240924-regcache-zero-value-v1-1-8a1224214b52@kernel.org>
References: <20240924-regcache-zero-value-v1-1-8a1224214b52@kernel.org>
Subject: Re: [PATCH] regmap: Specifically test writing 0 as a value to
 sparse caches
Message-Id: <172778122508.2280830.5293404233468986289.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 12:08:53 +0200, Mark Brown wrote:
> Since 0 can look a lot like a NULL pointer when used in a cache some clever
> data structures might potentially introduce bugs specific to handling it.
> Add some explicit testing of storing 0 as a value in a sparse cache, at the
> minute there are no issues and this will stop any appearing in the future.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Specifically test writing 0 as a value to sparse caches
      commit: 42afe80caff040525252af6e9601287777d144fe

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


