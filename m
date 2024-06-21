Return-Path: <linux-kernel+bounces-225140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18806912C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369771F24AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060C1607AD;
	Fri, 21 Jun 2024 17:26:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3115D1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990796; cv=none; b=fzi5dyQXlfukkT2OjUWJdpNMlORZUj17CrD9P/+24amXBXL8NQBsIHw0Ghd14UpcPPF79uGF/Hfgj2Xqq/sFQXWdWQX/bDMe8STttINTeqUiqriYaPYQYKyRo5OdzLICRDfr3WxbZtzyu0zE7hfWLd4DwXkdjYuB9YuJeAoEA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990796; c=relaxed/simple;
	bh=y7coo5INBJIcSNSGAY0IhgZLOGxxXbSXPxUeKEqLd0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lToYVTapyc+wDMKPOKQ0GWbyvstGGibdhomZXm5eU+EILfBptAorov/eIpZNN5GuoAsDGUAY2IKQhDChOyZ2ShHuKPEaUfB1/mriZ8f/bHYsB7Vc+1nlRFm0xqyUtiLBZ9jxyg3GJlk1Yg8dp7+CaCYuRxGCGkzvq6UiR7jvkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C6FC2BBFC;
	Fri, 21 Jun 2024 17:26:34 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:26:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	maz@kernel.org
Subject: Re: [PATCH v2 0/5] arm64: irqchip/gic-v3: Use compiletime constant
 PMR values
Message-ID: <ZnW3yAjsxutJAEih@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617111841.2529370-1-mark.rutland@arm.com>

Hi Thomas,

On Mon, Jun 17, 2024 at 12:18:36PM +0100, Mark Rutland wrote:
> Mark Rutland (5):
>   wordpart.h: Add REPEAT_BYTE_U32()
>   irqchip/gic-common: Remove sync_access callback
>   irqchip/gic-v3: Make distributor priorities variables
>   irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
>   arm64: irqchip/gic-v3: Select priorities at boot time
> 
>  arch/arm64/include/asm/arch_gicv3.h     |  15 --
>  arch/arm64/include/asm/ptrace.h         |  35 +---
>  arch/arm64/kernel/image-vars.h          |   5 -
>  drivers/irqchip/irq-gic-common.c        |  22 +--
>  drivers/irqchip/irq-gic-common.h        |   7 +-
>  drivers/irqchip/irq-gic-v3-its.c        |  11 +-
>  drivers/irqchip/irq-gic-v3.c            | 225 ++++++++++++------------
>  drivers/irqchip/irq-gic.c               |  10 +-
>  drivers/irqchip/irq-hip04.c             |   6 +-
>  include/linux/irqchip/arm-gic-common.h  |   4 -
>  include/linux/irqchip/arm-gic-v3-prio.h |  52 ++++++
>  include/linux/irqchip/arm-gic-v3.h      |   2 +-
>  include/linux/wordpart.h                |   8 +
>  13 files changed, 201 insertions(+), 201 deletions(-)
>  create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h

Are you ok for these patches to go through the arm64 tree (I can put
them on a stable branch) or you'd rather get them through the irqchip
tree? Either way, I don't expect (major) conflicts with the arm64 tree.

Thanks.

-- 
Catalin

