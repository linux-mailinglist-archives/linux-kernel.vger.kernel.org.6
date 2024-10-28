Return-Path: <linux-kernel+bounces-385966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9739B3D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D14E1C21573
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819C1E0B63;
	Mon, 28 Oct 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d41UngeY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wR1HSGmQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05219007E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153747; cv=none; b=oh1jpkFafZ5XvZyddVQWWm8BJD8AJK2xlUrcf8Ai1wY1xKrmyRVYzRD7HDRd7UmP9EWXuzosd5IsMr8ACOJC9YeXJp+xJkscWb/NvB+dC5zulY4ajOV2cMtIy83CTeCfWrvjW7nvWWD7TbyQj4hLgKos0xPljEtnVSkBiZmbZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153747; c=relaxed/simple;
	bh=OXLXjG3If5CcSeiHkrMTF+68QO68zjSJWqc8xnj+2jY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3rz6s8b4qbbYFcnPAyIa0JHbSNlR+9p0OAyClA/E6oJuhwC2/pTtQJ6s0uN1dTn98gl/jS5N/hfyH1FVijkl2irPae2gNi9V3RHRMk7hCqLK1zgkAwIw9ZL4sIxMr/W3+saw9Rxg/4tuwKQ0XLmc8VvKMEk3vo3AHbFV1q6NPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d41UngeY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wR1HSGmQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730153738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CID8ZNB+XW4905MFNNwwhdwsOvxIuKrRJow3yEUZR2M=;
	b=d41UngeYz5kER1EmDTxcS/ndP+AEFZH9wWnaxZ4kUrb3kxWZLZUq/WHP5QaWdnuu5J/Tam
	/VkVd3cc17DOLwgGnm+gZTNYDCNCXgOziCH6Td9C+8gUDK2Hotp4v7+Vgztx3/EmubKZwD
	UFzbWOV3Cd99PFsSjKGo8Pq7F90XpD1uQ/6zrhxoiaiqsWdNCCTngiEF8I9Ihj3inOaglf
	RjTBMos/RukkoSrg2EKNOmu07Q7yRIDvnLrAIOJnBdtDslss/aCgiUcTYzPj5DYlM5LXWg
	CvQ6npJ+14+sa1MYAQUNHwxwl3zl31tRTT3h9pU2jlxBaOD3q5H8RoN+bkN5NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730153738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CID8ZNB+XW4905MFNNwwhdwsOvxIuKrRJow3yEUZR2M=;
	b=wR1HSGmQVZ3JXxfsxQSjeC60IAJwd1sYdzE83rfEv03vpiuXr3H3+j7Gn14HZC/X6/DPTC
	vpGMpx82nBQxAHCg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
 linux@armlinux.org.uk, will@kernel.org, mark.rutland@arm.com,
 catalin.marinas@arm.com, sstabellini@kernel.org, maz@kernel.org,
 peterz@infradead.org, luto@kernel.org, kees@kernel.org, wad@chromium.org,
 akpm@linux-foundation.org, samitolvanen@google.com, arnd@arndb.de,
 ojeda@kernel.org, rppt@kernel.org, hca@linux.ibm.com,
 aliceryhl@google.com, samuel.holland@sifive.com, paulmck@kernel.org,
 aquini@redhat.com, petr.pavlu@suse.com, ruanjinjie@huawei.com,
 viro@zeniv.linux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
 wangkefeng.wang@huawei.com, surenb@google.com, linus.walleij@linaro.org,
 yangyj.ee@gmail.com, broonie@kernel.org, mbenes@suse.cz,
 puranjay@kernel.org, pcc@google.com, guohanjun@huawei.com,
 sudeep.holla@arm.com, Jonathan.Cameron@huawei.com, prarit@redhat.com,
 liuwei09@cestc.cn, dwmw@amazon.co.uk, oliver.upton@linux.dev,
 kristina.martsenko@arm.com, ptosi@google.com, frederic@kernel.org,
 vschneid@redhat.com, thiago.bauermann@linaro.org, joey.gouly@arm.com,
 liuyuntao12@huawei.com, leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v4 15/19] entry: Add arch
 irqentry_exit_need_resched() for arm64
In-Reply-To: <878qu82je2.ffs@tglx>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-16-ruanjinjie@huawei.com> <878qu82je2.ffs@tglx>
Date: Mon, 28 Oct 2024 23:15:37 +0100
Message-ID: <87ldy727sm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 19:05, Thomas Gleixner wrote:

> On Fri, Oct 25 2024 at 18:06, Jinjie Ruan wrote:
>
>> As the front patch 6 ~ 13 did, the arm64_preempt_schedule_irq() is
>
> Once this series is applied nobody knows what 'front patch 6 ~ 13' did.
>
>> same with the irq preempt schedule code of generic entry besides those
>> architecture-related logic called arm64_irqentry_exit_need_resched().
>>
>> So add arch irqentry_exit_need_resched() to support architecture-related
>> need_resched() check logic, which do not affect existing architectures
>> that use generic entry, but support arm64 to use generic irq entry.
>
> Simply say:
>
>  ARM64 requires an additional whether to reschedule on return from

  ARM64 requires an additional check whether to reschedule on return from

obviously...

>  interrupt.
>
>  Add arch_irqentry_exit_need_resched() as the default NOOP
>  implementation and hook it up into the need_resched() condition in
>  raw_irqentry_exit_cond_resched().
>
>  This allows ARM64 to implement the architecture specific version for
>  switchting over to the generic entry code.
>
> That explains things completely independently. Hmm?
>
> Thanks,
>
>         tglx

