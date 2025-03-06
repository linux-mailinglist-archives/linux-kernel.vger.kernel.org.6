Return-Path: <linux-kernel+bounces-549281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8CA55043
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EF17187B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567882116F6;
	Thu,  6 Mar 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9lSzIaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8E211466
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277434; cv=none; b=bpAeLjc72GKcOaqPpHRQR0j+ZKjLjmMKOgFXp2oDRbr2ggsFSkig1GdYK42H06lGArWpiptPOObIaThSYmsZ1nLtKaSTuH6uFJX7o9IJEZU4XeczAFf2jZfmiOH5QcplNggqyiJ93oTEeR+62X5HQPSQeUJcw3tkda0EzI4NHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277434; c=relaxed/simple;
	bh=Pf13+liKVGmGVGNAfIkFF2enAZK28B5/LLR6a2JACXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mBdMv2zHQrWQkPJcKgfRSa21BprYwJI1k5RFVN6xGB76Ze1K4Evsbdi0//zcymHA5jNbBjNXRyzhZZZt2L+BsXWgDQvrE06BtJOc06pKkaSggqLrMxnlnSiPKwvj6aFCIi4V+nugw8RrfiYDtPyvx5zeyvlbWcwinLR1R5eN8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9lSzIaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60304C4CEEC;
	Thu,  6 Mar 2025 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277434;
	bh=Pf13+liKVGmGVGNAfIkFF2enAZK28B5/LLR6a2JACXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W9lSzIaJTN53uKsFgTARVc90ZFCjwz8h8X99qm+kOVfTChvlClfGgEhcLUS8nEU9P
	 1EdOv8+nouRP4qzehefAdp0dQHnpJk6n2HffzlsG4f3aWED7/Lzdyf8Ty3NMt8abHb
	 z/BKnP/3xjDpl4SpUGP0LlMocv5pyIsMib1UyAoC757AHj7MsGUQ/CWcGRIKofjVNw
	 9I0HhoWzxDqByo/lA2ijwkAwCX9vRAEiWUGs/1KzwiImGK61bdaRLBP/EGJdSVg4/J
	 jI8bmRaBuF9MznLzoo/4enakzXh+mb+BW9Yv08IkeQgp1iMTTi7TLwZhXlwfmLfvxZ
	 fYDaPyipwDh5Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 David Collins <quic_collinsd@quicinc.com>, 
 =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
Cc: linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20250305-regulator_lockdep_fix-v1-1-ab938b12e790@axis.com>
References: <20250305-regulator_lockdep_fix-v1-1-ab938b12e790@axis.com>
Subject: Re: [PATCH] regulator: core: Fix deadlock in create_regulator()
Message-Id: <174127743310.139067.18421528658328591081.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 16:10:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Mar 2025 17:05:04 +0100, Ludvig Pärsson wrote:
> Currently, we are unnecessarily holding a regulator_ww_class_mutex lock
> when creating debugfs entries for a newly created regulator. This was
> brought up as a concern in the discussion in commit cba6cfdc7c3f
> ("regulator: core: Avoid lockdep reports when resolving supplies").
> 
> This causes the following lockdep splat after executing
> `ls /sys/kernel/debug` on my platform:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix deadlock in create_regulator()
      commit: 1c81a8c78ae653f3a21cde0f37a91f1b22b7d2fb

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


