Return-Path: <linux-kernel+bounces-183770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F48C9DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DBD1C204D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24C135A5B;
	Mon, 20 May 2024 13:02:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7AC13440A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210126; cv=none; b=utORLYszwIYxdK78ZsIABC/huICm4ooxNoiaX+SbjO2mngEFEFEbdnEVa/w6bE9+oo6Z4EhHJEvQjFVEhntZdl6l1O6q7o9hR+B8MTyS17v8JFjHe58KoDps9+a6fduat12G9MAtVuPYIRK4kyoe1P3lg8o6XOB6XMI4Oo2cguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210126; c=relaxed/simple;
	bh=j3WyJaRMY8UAEuzhzoAYZCFcOGx2ubNCfBzbhVA+GDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neUjpXwTyQvbxR/bb0su5+5Lliaezyg3QHqdo5ABmLcybJDWHtjyo91F1vzZhEz/cVBsppOjzFPUbFlp3qpUQ3G/ZBizMuvY9iKqHeO7v77kKh5/bBOfGJjZRcuRN0tXSb+4CET8TqriwHpBBHxRErAkmmlAUglWjuPZrZeXpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83505DA7;
	Mon, 20 May 2024 06:02:25 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F67A3F641;
	Mon, 20 May 2024 06:01:59 -0700 (PDT)
Date: Mon, 20 May 2024 14:01:50 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: Jiangfeng Xiao <xiaojiangfeng@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, Dave.Martin@arm.com, xieyuanbin1@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nixiaoming@huawei.com, wangbing6@huawei.com, douzhaolei@huawei.com,
	liaohua4@huawei.com, lijiahuan5@huawei.com,
	wangfangpeng1@huawei.com, "zhangjianhua (E)" <chris.zjh@huawei.com>
Subject: Re: [PATCH] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
Message-ID: <ZktJtlIThiLpK0Na@J2N7QTR9R3.cambridge.arm.com>
References: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZksnARrLkKHcX4C_@J2N7QTR9R3>
 <20d70835-9411-9a08-c567-56d7040e01dd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d70835-9411-9a08-c567-56d7040e01dd@huawei.com>

On Mon, May 20, 2024 at 08:05:25PM +0800, Li Zetao wrote:
> On 2024/5/20 18:33, Mark Rutland wrote:
> > On Fri, May 17, 2024 at 10:13:28PM +0800, Jiangfeng Xiao wrote:

> > > diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
> > > index c762038..6e73809 100644
> > > --- a/arch/arm64/include/asm/asm-bug.h
> > > +++ b/arch/arm64/include/asm/asm-bug.h
> > > @@ -28,6 +28,7 @@
> > >   	14470:	.long 14471f - .;			\
> > >   _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
> > >   		.short flags; 				\
> > > +		.align 2;				\
> The use of .align 2 here is based on the assumption that struct bug_entry is
> 4-byte aligned. Currently, there is no problem with this assumption, but for
> compatibility reasons, refer to the riscv architecture and refactor the
> implementation of __BUG_FLAGS:
> 
> #define __BUG_FLAGS(flags)					\
> do {								\
> 	__asm__ __volatile__ (					\
> 		"1:\n\t"					\
> 			"ebreak\n"				\
> 			".pushsection __bug_table,\"aw\"\n\t"	\
> 		"2:\n\t"					\
> 			__BUG_ENTRY "\n\t"			\
> 			".org 2b + %3\n\t"                      \
> 			".popsection"				\
> 		:						\
> 		: "i" (__FILE__), "i" (__LINE__),		\
> 		  "i" (flags),					\
> 		  "i" (sizeof(struct bug_entry)));              \
> } while (0)
> 
> Align the real size of struct bug_entry through .org. What do you think?

I can see why that appears nice, but we can't do that in asm-bug.h
without something in asm-offets.h, and I suspect that's going to lead to
pain with circular header dependencies.

Regardless, if things change we'll need to make other changes here, so I
don't think we gain much.

I think it's preferable to have the explicit .align for now.

Mark.

