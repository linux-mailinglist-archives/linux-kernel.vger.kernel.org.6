Return-Path: <linux-kernel+bounces-285006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D7F950808
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA01F22DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91519E81F;
	Tue, 13 Aug 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi9lkKR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0119DF7B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560236; cv=none; b=IgWzUYHYH6E4u9L6chUryI3TDSzuamZ5I2L/XfrgnAsGT960O6y1jOLkz/Qadz1TL1BPM/0iUehT+9pabL/XoRV+lc5r3HSNEzLZKW7orMb5B2DhziO6ozjjO4BlnTTuZbmWerraxPEeow1Q8X0gVT/yGYwKJEeYIFU/YEe3yG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560236; c=relaxed/simple;
	bh=l92DpSo2C7PT4PTRh0Gd47GHy1fmn3ge34So7cjSvLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTXlnnGlnTzJdXLpUxMesMccE1txZFDQlPrNljTxyrHpLWjU9X06Byox2a1DDOsjkTtPjSx9Ce5YfpF2ZiR5+LmWrX64l02QamszyZoWQ9P/bQmx0wrG561KAuUn/aK4+v5gAaAuxzWLMrjR99v14dKxr1Y0z5OdUrRAmToLfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi9lkKR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A115C4AF09;
	Tue, 13 Aug 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560236;
	bh=l92DpSo2C7PT4PTRh0Gd47GHy1fmn3ge34So7cjSvLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pi9lkKR2+k/XOgNlIpO67yV8X20vQLRSJgesFuzF1eZBB6a8kht3H7et4PE1BVved
	 7jPcqWPqrGfM4dWqmswmu/BBINl8rwhRQul1gNxdflQh8qmoNgxzAXI58hV2NNlEKM
	 LJ8lsaZqKvhNvchHaK7jsD1pjqKKRsFSZcV0Eh2uHSvr/4wt9kZecgoKtW7vVEqXMP
	 QLrhB2Exy8LSZTvka1KV5OHPKcJNjCenFMJM6eOCuKhR+u0H6j3N7NVP9GLK0iZCNI
	 CxvLy+bKrJoyawp3xcPFCFEQl8oKDKKI9g2nzC6nfZJtW1n/lW7/5wLKEcvbYzJcP9
	 YdNT17KMqijxA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20240806102707.3825703-1-jbrunet@baylibre.com>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-Id: <172356023429.57695.4053614993109219592.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 15:43:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 06 Aug 2024 12:27:03 +0200, Jerome Brunet wrote:
> With PREEMPT_RT enabled, spinlocks become preemptible.
> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
> of a threaded irq handler won't be threaded and this causes scheduling
> problems if spinlocks are used in the upper half, like with regmap when
> '.fast_io' is set.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
      commit: 5003d0ce5c7da3a02c0aff771f516f99731e7390

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


