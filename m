Return-Path: <linux-kernel+bounces-280159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A132E94C673
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A6C1C2215C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752D15FCEB;
	Thu,  8 Aug 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGm1kxPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843F15B561
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153627; cv=none; b=Jcwy6DXg7SbB0R8lmwl7yL31q6T+HJNLj4ZLtdjaslSvxEln/FzobK3iYUtZOhN/Moaj9tk891mA/OjA+iEIQcPYLChqPGSZVpdq+KJOEhH8kcvGjtJ7w8pqJRXftnlyasOdYF+j7fWTL1f6pIokwjLUWklkvr8cJUY58xDJNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153627; c=relaxed/simple;
	bh=U55zr8nmJOAbnMqspv1F23aPrgO2gDK8goya8/ZMJb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GAQj9qPzyULLT+i6hEVgXMOGtiyMpvjv4ZSvGwoXv1nMn07I/Hg09/fqELQtfsHuieuOpBQ6ilBN8g8E0BGZySrk4S8aM9rkSeOy7u5yQLlbESwbr1+JTlIdjpqiwtb4t7U56D9gF4+2NrLFr9PDTl7p1GrpMHixK/3jKBKOrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGm1kxPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB115C4AF12;
	Thu,  8 Aug 2024 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723153626;
	bh=U55zr8nmJOAbnMqspv1F23aPrgO2gDK8goya8/ZMJb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KGm1kxPNo9FWiD+NdC9BHLIxg3omvTRrbd5okPmbZyrqZKpxgtKS9DuFOjKkus7sq
	 eTCmr5Vd2pdquUsV6/N+BZwDd01ac3jp9fXy3xf7WKVn52y25Algdz58SH/qSG6w9W
	 Mn/OGN86xhD3laejbCwPjG2B5K/x9v+EkDGYVG3NSoRl7M6PuGOJpbWlySLF3nHWzr
	 ndxbEoMDRKf7Ppr34bhxznfcV23yr8ToT0FVPiKQqNBnmlocoTI6VialKiyBVtG0xW
	 OAP8B5QzrBLMgDI+t6dnYJuaBIjfUA5VXqvvMbppBuibK2dwxWOvUOGurPJV1X9ELB
	 mWYWszTXEDGPA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20240807162705.4024136-1-jbrunet@baylibre.com>
References: <20240807162705.4024136-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v2] ASoC: meson: axg-fifo: fix irq scheduling issue
 with PREEMPT_RT
Message-Id: <172315362437.480667.7263502304351371986.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 22:47:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 18:27:03 +0200, Jerome Brunet wrote:
> With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.
> 
> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the primary
> handler won't be force-threaded and runs always in hardirq context. This is
> a problem because spinlock_t requires a preemptible context on PREEMPT_RT.
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


