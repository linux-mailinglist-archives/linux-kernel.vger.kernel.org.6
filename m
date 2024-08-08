Return-Path: <linux-kernel+bounces-278944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F9194B6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD19C1C21C01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75262187862;
	Thu,  8 Aug 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Si76o8jX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKkJproI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36955228
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099605; cv=none; b=ZnQFKyOfi4jrE39ZKDCo5GM3TgWrgVzwV+MTG9oCS95XqvE3NS6EcUKpj+/hvbboemFvInHamWFKz17OMjAuqYlPwdpvUF4SbSVEIh8p77IlKdnERym3nu9mc68BYF/nRtj2zfFIiU3Rjn5CzymcdLNl2saKUGpNm9EHuSMoxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099605; c=relaxed/simple;
	bh=F1GfsLtw3XII5FmnMgQ8kSFwottDn8Xd2rABzSEFXmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsRpgTHmhcsFwnvGvnVQAxen4+jvbDZ7f/94UmNAMWd2vZp+pVRX0z4wQFvWQP9zpezZ4kDUdrabSTpC5kkTwe2C+HemCqaRnHrLyblJk42M+YboWAhm/WyAm13NQLrHWOMUtHOtYa7wTwpARqxRaznMi2SS0hDrt7sC3BBIblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Si76o8jX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKkJproI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 8 Aug 2024 08:46:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723099601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvNh43nfSO4d+UD/c8WTug/9ZdIpYcc6hAsJkEvDjdM=;
	b=Si76o8jXOQPnoEKdHE8e+UndNId1Pf6tz3u+ArpvSRpnP4loGQXnRQDp1XrNDaLFQkrse0
	FuKQtJsFYDWBGcnV27A4t/VvxJskqA5r3tIbiHbrXXJN/CXg9XZ7SJtQijrLoKQ9wHWh1C
	prlF+ME+LHYgS3ENiWwm2r+dTq6JK1/9BvVlxpS80ASjePnw/DGLo1A5pYseopa13wwqG7
	jWSyvWy0MCAnvhDQPvoJLkYSSdYPFC0HsZjeRxBHho+Ccz4WWLoG1PXXUnv9S5MXpR98uN
	iesbFdD5kKegVDRzmode/8Ku8KGC515x+sf7hkc+PFNlXY8IpOg3OXaHuSZA8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723099601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvNh43nfSO4d+UD/c8WTug/9ZdIpYcc6hAsJkEvDjdM=;
	b=oKkJproIdztfQMIkb/RIwu+VvJMo85xqKUJsCSYhOVOhY2q7JdtZxHvBItv8qAbRhhAkxD
	PEV+PlHo0KG62YAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH v2] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-ID: <20240808064640.8-BmbtlX@linutronix.de>
References: <20240807162705.4024136-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807162705.4024136-1-jbrunet@baylibre.com>

On 2024-08-07 18:27:03 [+0200], Jerome Brunet wrote:
> With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.
> 
> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the primary
> handler won't be force-threaded and runs always in hardirq context. This is
> a problem because spinlock_t requires a preemptible context on PREEMPT_RT.
> 
> In this particular instance, regmap mmio uses spinlock_t to protect the
> register access and IRQF_ONESHOT is set on the IRQ. In this case, it is
> actually better to do everything in threaded handler and it solves the
> problem with PREEMPT_RT.
> 
> Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-avkrasnov@salutedevices.com
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check periods")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

