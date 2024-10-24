Return-Path: <linux-kernel+bounces-379490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6A9ADF45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CE1F235ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B31B0F05;
	Thu, 24 Oct 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSzTjmm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlRrIyfv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24621ABEC7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758878; cv=none; b=axb3Ia6r3WoAevXB/X1EaGYzGNRJ+peGNJMFfpobLqQASbd63toofOtu6uR3dYd+1Th6T8CEdtLULaaP0cjScmo3MYSo7E0VZRyN5JTd4QNjzKQAlXbl9c8qd52PIR+TBnFyWO/jF1Dkzl1mbI/AIqRu4Z9XhoRlvHQGBm99jWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758878; c=relaxed/simple;
	bh=X9Jkxh6uG1luTqkpdaD5om7U2Rf+Qye6n2Q56V5ag14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsTEqwbWY+LoNXlzTrifjWiz3VQp01rZvN5Au7tKgJW+R1PE8fVVXNa1xCQwgDuw+5ATirfocRJ1yua5BENsm128ti2L3Icst2yTDgp8OrPdKArbCnqmyzkgIja1Rm/uDknKvtnsUkz1j/X6sO9RZZCE1/pJKWqE/LhoOFCMF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSzTjmm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlRrIyfv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729758874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXlj7e+Et2pkRfippkcwQmR4kja9Q20tCQ/MF6t8KQ=;
	b=zSzTjmm9RL3YOoVxvpIVliLXcHhJspDIJdWyez0fD+jXtAFYkAZzH9kCUetYa/30/x5cJr
	DEcnO5U+LQfeDaOuzYEDD18VQa4y/ogETUTPfXGQuBJaPCxSl0kUD34mlQhPshK6NJJKXo
	qsRCrhAvbdLcpmYyeUH+Xdqo72CDUow10Txt+cbDXbmljQeDKRxxgBDyhdqMgxNJf5KcBj
	mF1a0pcJMkNdEKU6wfWxGTVTwdFRhq5Ygy72nWrrdn1is99MrPrs3UwvTK7WEnof4L4FMI
	7k3GBdtg6cMyyTefzLpK8dCllI78iiPNWH+8yB+Ji+I6eQl1cvpV7wDSjkwsiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729758874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXlj7e+Et2pkRfippkcwQmR4kja9Q20tCQ/MF6t8KQ=;
	b=tlRrIyfvDQ4e3v3wQ1jCW7wX33Xw7kXPDVKYXGd1jarGosJWpWgqvEY3PL1UtPIrAshthP
	41wrEsMqZCIyL5DQ==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 00/10] clockevents: Rearrange cpuhotplug operations
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
Date: Thu, 24 Oct 2024 10:34:34 +0200
Message-ID: <87wmhx6grp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 17 2024 at 18:50, Frederic Weisbecker wrote:
> Some recent RCU issues triggered with offline ticks uncovered
> hotplug behaviour differences between oneshot and periodic ticks.
> The former is disabled on the dying CPU but not the latter. Also
> the clockevents hotplug code is quite chaotic. This is a proposal to
> fix the situation.

I like it very much!

> Frederic Weisbecker (10):
>   clockevents: Improve clockevents_notify_released() comment
>   clockevents: Shutdown and unregister current clockevents at
>     CPUHP_AP_TICK_DYING

This has a build fail.

>   tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
>   arm/twd: Remove clockevents shutdown call on offlining

The ARM prefix preference is:

    ARM: smp_twd:

>   clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call
>     on offlining
>   clocksource/driver/arm_global_timer: Remove clockevents shutdown call
>     on offlining
>   drivers/clocksource/exynos_mct: Remove clockevents shutdown call on
>     offlining
>   clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on
>     offlining
>   clocksource/drivers/qcom: Remove clockevents shutdown call on
>     offlining
>   drivers/clocksource/timer-tegra: Remove clockevents shutdown call on
>     offlining

Can you please make the subsystem prefixes for the clocksource drivers
consistent 'clocksource/drivers/foo:' ?

Thanks,

        tglx

