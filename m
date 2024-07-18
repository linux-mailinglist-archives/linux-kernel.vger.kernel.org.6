Return-Path: <linux-kernel+bounces-256581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F0E9350A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33CE1C21056
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30541B86D0;
	Thu, 18 Jul 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJnq1hme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161932F877;
	Thu, 18 Jul 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319930; cv=none; b=Z4WipwGnKVJ93Xy3/szrqcv0JCc6yRn/RfHLhwKZQz3bYegTeWNLeVi7zai3KeRuYtBYGO2esRjMOVzuvinL24zDPwp7KUQEO0OwddPsTQ4cbI4YvDr5fD6m/D+96D4vMvZuj//bO9OQfIsVLzlKbDMuKcDpjyNn3B69jfkFxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319930; c=relaxed/simple;
	bh=H/ADxr3vHE+JcJy9yACtsrqmVWnvBuv9XM8MmAbTYOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYAsC9ety5743eGgICgJcTyCe75QO9XzXl2ITisuJEDpVRouuLyvmW9kJbdtGUIvERjFDoFHOjrp+tusI9hPxT6OWqNBcU8DJawQefQw1atxDOBNcTBQKrMKVmbsRAoIhVQAD7jnTpf29ri+yChqj1mLF+pXLdSgTRnMwLAv0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJnq1hme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27731C116B1;
	Thu, 18 Jul 2024 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721319929;
	bh=H/ADxr3vHE+JcJy9yACtsrqmVWnvBuv9XM8MmAbTYOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJnq1hmeru3kVZ/BoHCZo0IekDBwIf70J8SWU/Yi32MEu/mz9XoWXz5J351TKYwVR
	 YmU4oHu0JJ8DaT0WkbfCHvBeV0IhddUBFzyxFf7NwP9a+wDbrAiBZvuSLg1SPJENS2
	 ZCVRq3DQYBFxDWCBjrT3nyuxmFWNHZgcR47zcuDnWbyQH+UEm5jZ6qO4zxpwKZI4qO
	 +WQENCEqvxTayl3mptrwwZ4mvB7PDTr7h+RUnqL9rI1d8DtfbufnAWDgQFlYvfm2Nh
	 TFNSgvCil4lnW+U2KicuZj0g0I677g2U966Xz/QA7lEpNbt0Nvd4Kl3h6QF1GxCRwj
	 GnPBEOfRBeYag==
Date: Thu, 18 Jul 2024 09:25:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: next-20240712: task_work.c:(.text+0xc2): undefined reference to
 `irq_work_queue'
Message-ID: <20240718162527.GA197917@thelio-3990X>
References: <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
 <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
 <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
 <6494316f-fcf9-4c19-9f3c-f8ad6f0810fa@app.fastmail.com>
 <20240712150333.GN27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712150333.GN27299@noisy.programming.kicks-ass.net>

On Fri, Jul 12, 2024 at 05:03:33PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 12, 2024 at 04:11:54PM +0200, Arnd Bergmann wrote:
> > On Fri, Jul 12, 2024, at 15:24, Peter Zijlstra wrote:
> > > On Fri, Jul 12, 2024 at 02:28:38PM +0200, Arnd Bergmann wrote:
> > >> On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
> > >
> > >> that we may have to always enable IRQ_WORK even on non-SMP
> > >> kernels now. In practice it is already enabled in most
> > >> configurations for one reason or another, the the cost is
> > >> likely very small.
> > >> 
> > >> Otherwise checking for CONFIG_HAVE_NMI in the new code might work.
> > >
> > > ARM seems to have HAVE_NMI while also being one of the architectures
> > > that is now failing.
> > 
> > Right, in this case we would also need
> > 
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -236,6 +236,7 @@ config HAVE_FUNCTION_ERROR_INJECTION
> >  
> >  config HAVE_NMI
> >         bool
> > +       select IRQ_WORK
> >  
> >  config HAVE_FUNCTION_DESCRIPTORS
> >         bool
> 
> Yeah, that works for me I suppose.

Was there any conclusion to this thread that I missed? The
configurations Naresh mentioned in the original post are now broken in
mainline because the pull request was sent without any solution to this
issue.

FWIW, that diff doesn't fix ARCH=powerpc tinyconfig, as it does not have
CONFIG_HAVE_NMI. kernel/task_work.c is unconditionally built so
shouldn't IRQ_WORK now be 'default y' (or just eliminated altogether)?

Cheers,
Nathan

