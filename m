Return-Path: <linux-kernel+bounces-250695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB30A92FB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EEF1F21E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B116F85C;
	Fri, 12 Jul 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ayX18Nb6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7213CFB0;
	Fri, 12 Jul 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790674; cv=none; b=KL48yJS635L9Yo+XZiXJzx9OJbzQD/1gNK5MAmACiCogymB+VkuE+4KqjVop9Me6QCBg1+iZ0xEEV8WGKEM1D9H1pd3uKDioi0qXNJUkLPRqDpTEjekrBkDppo+5mV9J/HD4Nx/+lV/3LIo7uohtaVCpj+B+FCabk0J93JNMbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790674; c=relaxed/simple;
	bh=Ms4/VdauvJ2o9F0Vstk/RWolp62CQIUlz7Z8RKTuaN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUOR1lYlegP4rT0Iwdac+TjKnU5IZVIe08fK25P4oGOXFK0Y85tSxQIAH/pZcXSfUPc4dPQdOXkQYAZBHxFOKvDA3ZWl4uVi64Om6jwHPSp0y7LiZK3Ash7oXtb6nAZ8JJbdPVGAe50OAZuq0M48lFHGXX9YZerJG/tmkl3pl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ayX18Nb6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=khhH7O9qoqZ53M4xcspaIIlSf1+Vi7hAzvc5E+wsfVM=; b=ayX18Nb6RdZ0UQuqRIW6xk2u1O
	Aj9E4j5d0eoywdrwCk/J+baXDDx8MS0enBn1VwLJbqvQCcv4Gteywu7rolH98bPvES9dZ+JXUeoZv
	5fxQY4JSVGkoONfB4pXgFRlwPkY6/XAJsUw8u5UD9bJGD+QN0AQxDyJxe3A9+vhK5aH0/E2MC24Cz
	upMu5N71WBJtGlWj+gM/YrILXHL5V13cVMnEU8f/zo+Ez8NKNKb1wIV0ynSiN5THXhFaGPsLuAsgZ
	y+vXTEHG8bNQz7ldDr3ex2yu4OsSsQpXW+N/WJNiKOhkONfFB244Zf2TYf7aNAXPA4xpT8VXE2oFv
	LpxtfVaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSGGC-00000001J6Z-0LnE;
	Fri, 12 Jul 2024 13:24:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4250930050D; Fri, 12 Jul 2024 15:24:27 +0200 (CEST)
Date: Fri, 12 Jul 2024 15:24:27 +0200
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
Message-ID: <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
References: <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
 <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>

On Fri, Jul 12, 2024 at 02:28:38PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
> > The 32-bit arm, mips and powerpc the tinyconfig builds failed on today's
> > Linux next-20240712 tag with gcc and clang builds.
> > The defconfig builds pass.
> >
> >   GOOD: next-20240711
> >   BAD:  next-20240712
> >
> > Build error:
> > ------
> > arm-linux-gnueabihf-ld: kernel/task_work.o: in function `task_work_add':
> > task_work.c:(.text+0xc2): undefined reference to `irq_work_queue'
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> The call to this function was added in 466e4d801cd4 ("task_work:
> Add TWA_NMI_CURRENT as an additional notify mode.").  It's possible

Thanks, that initial report was mostly useless without that sha. I do
wonder why 0day build robot didn't complain to me about this. It seems
something it should definitely find.

> that we may have to always enable IRQ_WORK even on non-SMP
> kernels now. In practice it is already enabled in most
> configurations for one reason or another, the the cost is
> likely very small.
> 
> Otherwise checking for CONFIG_HAVE_NMI in the new code might work.

ARM seems to have HAVE_NMI while also being one of the architectures
that is now failing.

I'm a bit confused though, perf is already depending on irq_work (and
perf is the user of TWA_NMI_CURRENT). So I'm not exactly sure what
config fail is leading to all this.

I suppose we can do something like the below.. it'll end up in a runtime
fail for whoever manages to use TWA_NMI_CURRENT without also having
irq_work enabled, but that should currently be nobody.

---
 kernel/task_work.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5c2daa7ad3f9..276e245b7e7e 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -81,9 +81,11 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
+#ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
+#endif
 	default:
 		WARN_ON_ONCE(1);
 		break;

