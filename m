Return-Path: <linux-kernel+bounces-227776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15205915670
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB195283599
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDD1A01BE;
	Mon, 24 Jun 2024 18:22:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D871A01B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253346; cv=none; b=BDbDnhTPh9i5McAoMeq+v+jDiO2vLd5wMT4uqFvdQpAxPKFdovyyl+r3CnBS7UHdSE00BnHipAi0Si2jkXDwyf3RhAil0/uUJ9O0OD2CpdyBTAlRZSCkYdhDvav/CBxP2+bdJwENmakPPJoq/pmt9TJPD77OXko9yyonAjnOH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253346; c=relaxed/simple;
	bh=yK6640YGx1vwLwhoIVfX1IsWcIznZJ8/7MF8b7UeipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz2JmwfhR9Ml/bhDTnL1q4+0/G1z4aRZukwv/xHV/XyVeHWtmee42hTDOSu/L7c0Qo9Fv9dGEU91ABMy58Mx1vFKAksPmrUq4uqD0bvSsOpZGc78MCnOuVSgvJSj5UrRJYnj79pOe9bwJJJhQGVYmV73CuJ5G5CNg0LTSaf8HPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEF7C2BBFC;
	Mon, 24 Jun 2024 18:22:24 +0000 (UTC)
Date: Mon, 24 Jun 2024 19:22:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	maz@kernel.org
Subject: Re: [PATCH v2 0/5] arm64: irqchip/gic-v3: Use compiletime constant
 PMR values
Message-ID: <Znm5XlOSwPqSyTNZ@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
 <ZnW3yAjsxutJAEih@arm.com>
 <87h6dkzmwh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6dkzmwh.ffs@tglx>

On Sat, Jun 22, 2024 at 11:29:50PM +0200, Thomas Gleixner wrote:
> On Fri, Jun 21 2024 at 18:26, Catalin Marinas wrote:
> > On Mon, Jun 17, 2024 at 12:18:36PM +0100, Mark Rutland wrote:
> >> Mark Rutland (5):
> >>   wordpart.h: Add REPEAT_BYTE_U32()
> >>   irqchip/gic-common: Remove sync_access callback
> >>   irqchip/gic-v3: Make distributor priorities variables
> >>   irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
> >>   arm64: irqchip/gic-v3: Select priorities at boot time
> >> 
> >>  arch/arm64/include/asm/arch_gicv3.h     |  15 --
> >>  arch/arm64/include/asm/ptrace.h         |  35 +---
> >>  arch/arm64/kernel/image-vars.h          |   5 -
> >>  drivers/irqchip/irq-gic-common.c        |  22 +--
> >>  drivers/irqchip/irq-gic-common.h        |   7 +-
> >>  drivers/irqchip/irq-gic-v3-its.c        |  11 +-
> >>  drivers/irqchip/irq-gic-v3.c            | 225 ++++++++++++------------
> >>  drivers/irqchip/irq-gic.c               |  10 +-
> >>  drivers/irqchip/irq-hip04.c             |   6 +-
> >>  include/linux/irqchip/arm-gic-common.h  |   4 -
> >>  include/linux/irqchip/arm-gic-v3-prio.h |  52 ++++++
> >>  include/linux/irqchip/arm-gic-v3.h      |   2 +-
> >>  include/linux/wordpart.h                |   8 +
> >>  13 files changed, 201 insertions(+), 201 deletions(-)
> >>  create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h
> >
> > Are you ok for these patches to go through the arm64 tree (I can put
> > them on a stable branch) or you'd rather get them through the irqchip
> > tree? Either way, I don't expect (major) conflicts with the arm64 tree.
> 
> Take them through your tree with my Acked-by. Yes a branch would be
> appreciated just in case.

Thanks. I added them to the arm64 for-next/gic-v3-pmr branch (on
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git).

> There is also
> 
>       https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com
> 
> which fiddles with the GIC but most of this is not irqchip code. No idea
> how that is supposed to find it's way into the tree.

I tried to avoid this series so far ;). I'll poke James Morse tomorrow
to see whether he has any outstanding comments (since he started the
work initially). If not, I'll queue them through the arm64 tree (same as
above, on a stable branch in case of conflicts).

Thanks.

-- 
Catalin

