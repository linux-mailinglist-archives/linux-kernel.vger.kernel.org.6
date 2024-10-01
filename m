Return-Path: <linux-kernel+bounces-345756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C298BAC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75F31F22A29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C11C174E;
	Tue,  1 Oct 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Bvai3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E81C0DE8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781228; cv=none; b=FnrD06YD0vw1j91WfINNqNKHgpjdMuJyBcsM6pDbu0I8YK6BMtZdlIo5ygzOikGWvZ26e28g6yNDb7YPL2RZjWmvXEOtbFoeUlQ+dJ7AdoTxBbGk6PeBELA7UISlzUzw31gsUZm537smvbrSUV5lHw0Zjb0c3NuVhBhP8/xR+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781228; c=relaxed/simple;
	bh=HYE81naMyVYn5AQSvCHql+Gaqm8Wc7aaJD6+2dEoHF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mP0aYuPLJ8N7gWtcypoR372U30jpHiR3ToUSoPIPjqQv9CvAmGfVq/Dpt7X0nEotaIfINCDIaSCgGZonbO6dODHGE0adBcjlDRXkYgH2vJ1k1CXz4BBpe8jwOtG0pdyD6lpEnLYItTiCUDdz8tBwwIlZRqIQlObYpPY9/09/yxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Bvai3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01804C4CECD;
	Tue,  1 Oct 2024 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781228;
	bh=HYE81naMyVYn5AQSvCHql+Gaqm8Wc7aaJD6+2dEoHF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q7Bvai3mHsQmhAAv1LUAYAQLwalvtEzi7HSiwj0PmS3xecRssHq/06OFQJYBQ/B4B
	 2mtBbG4laCAnBAkJeqDXY43oMQx0Sef0pJBXTi/Jna5fM0D/zuiDc2bK8dawb7TSRt
	 LmdHf4tTq2JXMSn07LF4/xvnwaEhwgBOW9Z/rx51Yvf0ro+KN/S5b8J227APbUNw1p
	 QRcBHn4NinLCj2nsY5Srpll7yjiE3dQoSRZ83yrnhFgcrhjXJwaDTCfF0HVJn6s166
	 3Pas1Q7v/nZcd5Bk365ufqoE0nnH2Qhzd43nx/lVflasuz7wB//LIsOpONDsB0feVQ
	 c/QXwC62m3D+Q==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
In-Reply-To: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
References: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
Subject: Re: [PATCH] regcache: Store values more directly in maple trees
Message-Id: <172778122727.2280830.7832817289439741379.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 26 Sep 2024 12:18:41 +0200, Mark Brown wrote:
> Currently the regmap usage of the maple tree is a bit non-idomatic, rather
> than storing register values directly we allocate arrays of contiguous
> register values and store pointers to those arrays. This is all quite
> fiddly, especially around adding values (where we may need to combine a new
> allocation with adjacent ones) or dropping values (where we may have to
> keep parts of a contiguous block). One reason for doing this is that the
> maple tree wants to store pointers rather than integers, and in particular
> has some problems when we want to store 0 as a value.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regcache: Store values more directly in maple trees
      commit: 49a85851b14cf6630013d1b9bae2ac2345c9430b

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


