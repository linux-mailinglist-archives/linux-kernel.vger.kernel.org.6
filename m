Return-Path: <linux-kernel+bounces-387107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C29B4BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8D31F2389E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90496206E9C;
	Tue, 29 Oct 2024 14:19:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC79206E81
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211587; cv=none; b=hkwz+H5FwcIGYh1K0gBt+Br+1Xu4F4rx25v+TCQujnb65TY9EN0MfP+OjLss9XUmKkIcH4JGrR6DETKdYTkZglvAxnwOJNnTTtaK9QsJ+hQ4RlVchAp/iC6kGn1wthv1NkGC7nH1IKzF3KN0Do2RtqZvA5Os1FfJCYSrqlLhZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211587; c=relaxed/simple;
	bh=i7YYYcNZqK5aXJzjjI0UK7nqYwBPydQCLICny9945wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdFnJG3rUWn3D4PSyJIYCMuWcI99q4YoK5HnSe/dmEGXYtaVJ9XLBJpKQ/6GTbTdVdNnu+pqPckayntYLve42SrUVOA6bEw5GrqhyGZnv9NOSClaqm30AcSgBgAjc+b+wC9i6ogqoEGC2S+PxnFtQxAH4G8IXoVwF3MVEiQXTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 110D71713;
	Tue, 29 Oct 2024 07:20:14 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6EF73F528;
	Tue, 29 Oct 2024 07:19:35 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:19:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, linux@armlinux.org.uk, will@kernel.org,
	catalin.marinas@arm.com, sstabellini@kernel.org, maz@kernel.org,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, akpm@linux-foundation.org,
	samitolvanen@google.com, arnd@arndb.de, ojeda@kernel.org,
	rppt@kernel.org, hca@linux.ibm.com, aliceryhl@google.com,
	samuel.holland@sifive.com, paulmck@kernel.org, aquini@redhat.com,
	petr.pavlu@suse.com, viro@zeniv.linux.org.uk,
	rmk+kernel@armlinux.org.uk, ardb@kernel.org,
	wangkefeng.wang@huawei.com, surenb@google.com,
	linus.walleij@linaro.org, yangyj.ee@gmail.com, broonie@kernel.org,
	mbenes@suse.cz, puranjay@kernel.org, pcc@google.com,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	Jonathan.Cameron@huawei.com, prarit@redhat.com, liuwei09@cestc.cn,
	dwmw@amazon.co.uk, oliver.upton@linux.dev,
	kristina.martsenko@arm.com, ptosi@google.com, frederic@kernel.org,
	vschneid@redhat.com, thiago.bauermann@linaro.org,
	joey.gouly@arm.com, liuyuntao12@huawei.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v4 01/19] arm64: ptrace: Replace
 interrupts_enabled() with regs_irqs_disabled()
Message-ID: <ZyDu9XHNmxMHBMSI@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-2-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:42PM +0800, Jinjie Ruan wrote:
> Implement regs_irqs_disabled(), and replace interrupts_enabled() macro
> with regs_irqs_disabled() all over the place.
> 
> No functional changes.
> 

Please say why, e.g.

| The generic entry code expects architecture code to provide
| regs_irqs_disabled(regs), but arm64 does not have this and provides
| interrupts_enabled(regs), which has the opposite polarity.
| 
| In preparation for moving arm64 over to the generic entry code,
| replace arm64's interrupts_enabled() with regs_irqs_disabled() and
| update its callers under arch/arm64.
|
| For the moment, a definition of interrupts_enabled() is provided for
| the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
| can be removed.

> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

[...]

>  arch/arm/include/asm/ptrace.h       | 4 ++--
>  arch/arm/kernel/hw_breakpoint.c     | 2 +-
>  arch/arm/kernel/process.c           | 2 +-
>  arch/arm/mm/alignment.c             | 2 +-
>  arch/arm/mm/fault.c                 | 2 +-

>  drivers/irqchip/irq-gic-v3.c        | 2 +-

I hadn't realised that the GICv3 driver was using this and hence we'd
need to update a few places in arch/arm at the same time. Please update
just the arch/arm64 bits, and add:

| /* 
|  * Used by the GICv3 driver, can be removed once arch/arm implements
|  * regs_irqs_disabled() directly.
|  */
| #define interrupts_enabled(regs)	(!regs_irqs_disabled(regs))

... and then once 32-bit arm implements this we can update the GIC
driver and remove the architecture definitions.

That way we avoid the risk of conflicts with 32-bit arm.

Mark.

