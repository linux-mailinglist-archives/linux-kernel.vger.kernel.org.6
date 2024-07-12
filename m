Return-Path: <linux-kernel+bounces-250813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F369692FD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F1D1F22BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309F172BC8;
	Fri, 12 Jul 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eUoVAnEX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24E1428E5;
	Fri, 12 Jul 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796619; cv=none; b=RdCQJE1FPWVQ8vrGZbjbiYI7ar8IdL3b6uhYTrZ18JtEnRIDWmrQd2az2DtdEAz+7RWFCraV6UYIS32DDTqNT3fo+EKw4li/G5scqR3TWniafTwK8NdenzrjWM4ZyLxNvKwrGfdstlAZ3/zIKRClrU9bpjyn5Zhj44arBKCSIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796619; c=relaxed/simple;
	bh=HidXYA2OQySfCV2kek+8tVfr7Bj16497NUugqI4M45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/2O3a0R5zicT6X87pnxzA9f0FMuMqEskyHUXZmNGgftlGaveGUwPc8+3cPqkZ8Jb4lvoCm1PWB88+XlriLXjWYF55pgCyu514dg2ph7sld+pTeZB1NJYABxdfHt5d9X/WSgS50zwobL/hkRJBCielRy505388ubHWUchOvgfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eUoVAnEX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r/fW1czx+FaanWqhzveYhmMzAQpgsshwQCiSKJKgzfg=; b=eUoVAnEXdxejMO2IE4utQ2lZ6B
	svtLANKLW1J/zKxOt4JLZjl2nG8DXGYMuhOk8Mp5Vcbv+kuFfPpj/+U7goMjEoCsGrz8qpDeY40E3
	oqZ3qmxPIr+RIbDa0fVR6Zfi6qwczsVdUnyZh0bj2ViX0Sl1/ZHP/qS40tt07HRgb6TMbK7feFLg8
	qjWz6YtS8+XRc9W+hYebvc89MS6kdQgbHsLxv9pE7ubdld35agdhVyc69zLa4WSOX95TY0KTPSgMo
	yUcBJpjGsuy8lZcsm6nprPB+nhXtbRP/uWkNJvUramZ12u1if0WbLXrnxPoYKjOr7o3kdRD/Nym+b
	tvEzQ0bQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHo6-0000000CaX5-1Qhl;
	Fri, 12 Jul 2024 15:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E182E30050D; Fri, 12 Jul 2024 17:03:33 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:03:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: next-20240712: task_work.c:(.text+0xc2): undefined reference to
 `irq_work_queue'
Message-ID: <20240712150333.GN27299@noisy.programming.kicks-ass.net>
References: <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
 <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
 <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
 <6494316f-fcf9-4c19-9f3c-f8ad6f0810fa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6494316f-fcf9-4c19-9f3c-f8ad6f0810fa@app.fastmail.com>

On Fri, Jul 12, 2024 at 04:11:54PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 12, 2024, at 15:24, Peter Zijlstra wrote:
> > On Fri, Jul 12, 2024 at 02:28:38PM +0200, Arnd Bergmann wrote:
> >> On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
> >
> >> that we may have to always enable IRQ_WORK even on non-SMP
> >> kernels now. In practice it is already enabled in most
> >> configurations for one reason or another, the the cost is
> >> likely very small.
> >> 
> >> Otherwise checking for CONFIG_HAVE_NMI in the new code might work.
> >
> > ARM seems to have HAVE_NMI while also being one of the architectures
> > that is now failing.
> 
> Right, in this case we would also need
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -236,6 +236,7 @@ config HAVE_FUNCTION_ERROR_INJECTION
>  
>  config HAVE_NMI
>         bool
> +       select IRQ_WORK
>  
>  config HAVE_FUNCTION_DESCRIPTORS
>         bool

Yeah, that works for me I suppose.

