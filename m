Return-Path: <linux-kernel+bounces-220938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B090E962
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C94E286242
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26013B583;
	Wed, 19 Jun 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMadrCHp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557F139578
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796394; cv=none; b=WV82SfuAKfsA3bJgQXG82hNxouQhsPrlKDd7eeOM1YJ7qxNUmC80UZx4N1r5y0ODaKNGXisOvnwUYmYFn1SEFEMreBLhop8j2X5muBo8GwoQYP3yz8tL17+E4zz/DalXy+h+5Df1JuyQg1e1RDkfXLiwrA12R4V4fJ0UqRvak6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796394; c=relaxed/simple;
	bh=4HJJvOCanSvFasaOJXhHHOeNLQyWe9AWCzHMzWVELsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlTmT9Lpo7Ro0FdVZmlGqdeUSuZnMVnIRm/WSkO/mQAE8cl7scdUuyt7DlW5WIhuT8yOCcnz9v0fGj/FvGRo7PITVAIPzk8OYEOhvavASUDSCpTPP+tUZcAWW7J4nMMGJsBgriHr3athl5IsPAWUw+4IxBFkR7dgxPteqEAlRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cMadrCHp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CMEsgmEvGJ4Hj7lSuiue76188D0A06Hsho4VAEhEX9Q=; b=cMadrCHp2suTdL2rwtC2k9456C
	C+ehshrabzylFoJFgCa4tPsHADIu5x5S2wi4rRWEJn/ySS5ZQhLfrDgxeY1zAbeNOV9t/edruttXF
	3jK8k+Z9GYWyZ+p2Ho07HXwE5ZUDcmTV4XCP5QpR2Wo3uUNe21Yf8UhA5MTok2eOh48fpjGGB+gc/
	YPZGi9TvAmth353IdENZMmQJEKRslFQiFAvc36iPi+i7Umrag4QC26Tn5reEOli48i6ITygKB8BoY
	pIro9KaQkd5wnNvGkyw897Stiq/QmJu7z0luiyE4cahvR8VXPT73C56nIKKl+lshCCOX1pHdslNKv
	qk9HUbww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtSM-00000004ct8-1l1D;
	Wed, 19 Jun 2024 11:26:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11E2E300561; Wed, 19 Jun 2024 13:26:26 +0200 (CEST)
Date: Wed, 19 Jun 2024 13:26:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	elver@google.com, glider@google.com, nogikh@google.com,
	tarasmadan@google.com
Subject: Re: [PATCH v2 2/4] kcov: add interrupt handling self test
Message-ID: <20240619112625.GM31592@noisy.programming.kicks-ass.net>
References: <cover.1718092070.git.dvyukov@google.com>
 <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
 <20240619111309.GJ31592@noisy.programming.kicks-ass.net>
 <CACT4Y+bUPsrGpbakLE-yJN8aKE3ODgB7oWHu+cHW2XSoFvJd_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bUPsrGpbakLE-yJN8aKE3ODgB7oWHu+cHW2XSoFvJd_g@mail.gmail.com>

On Wed, Jun 19, 2024 at 01:18:52PM +0200, Dmitry Vyukov wrote:
> On Wed, 19 Jun 2024 at 13:13, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 11, 2024 at 09:50:31AM +0200, Dmitry Vyukov wrote:
> > > Add a boot self test that can catch sprious coverage from interrupts.
> > > The coverage callback filters out interrupt code, but only after the
> > > handler updates preempt count. Some code periodically leaks out
> > > of that section and leads to spurious coverage.
> > > Add a best-effort (but simple) test that is likely to catch such bugs.
> > > If the test is enabled on CI systems that use KCOV, they should catch
> > > any issues fast.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Reviewed-by: Alexander Potapenko <glider@google.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: syzkaller@googlegroups.com
> > >
> > > ---
> > >
> > > Changed since v1:
> > >  - renamed KCOV_TEST to KCOV_SELFTEST
> > >  - improved the config description
> > >  - loop for exactly 300ms in the test
> > >
> > > In my local testing w/o the previous fix,
> > > it immidiatly produced the following splat:
> > >
> > > kcov: running selftest
> > > BUG: TASK stack guard page was hit at ffffc90000147ff8
> > > Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> > > ...
> > >  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
> > >  sysvec_call_function+0x15/0xb0
> > >  asm_sysvec_call_function+0x1a/0x20
> > >  kcov_init+0xe4/0x130
> > >  do_one_initcall+0xbc/0x470
> > >  kernel_init_freeable+0x4fc/0x930
> > >  kernel_init+0x1c/0x2b0
> >
> > So I'm not entirely sure how the above BUG comes about, nor how this
> > selftest tickles it. Could you elaborate?
> >
> > I've found check_kcov_mode() which has this !in_task() clause, but I'm
> > not entirely sure how failing that leads to the above mentioned failure.
> 
> I've tried to explain it in the test comment, maybe I need to improve it:
> 
> +        * We set kcov_mode to enable tracing, but don't setup the area,
> +        * so any attempt to trace will crash. Note: we must not call any
> +        * potentially traced functions in this region.

Ah, I'm just slow today.. did not connect the dots. No this is fine.

> Basically, we setup current task kcov in a way that any attempt to
> trace in __sanitizer_cov_trace_pc() will crash, and then just loop
> waiting for interrupts.
> 
> A more legit way to achieve the same would be to properly setup kcov
> for tracing from within the kernel, then call outermost interrupt
> entry function, then check we traced nothing. But that would require a
> non-trivial amount of new complex code, and e.g. the top-most
> interrupt entry function is not exported and is arch-specific.

Yeah, polling jiffies should be fine I suppose.

