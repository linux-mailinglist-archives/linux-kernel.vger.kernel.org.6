Return-Path: <linux-kernel+bounces-370043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED89A2685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F2F1F21A65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A21DED41;
	Thu, 17 Oct 2024 15:25:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC631DE2A4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178751; cv=none; b=WlDYRelDrJD/dtvlBWl0EFQWlmmnR7fLBrbhbkLvW2gp9cmnDRAlDYNq9NHmNSXcgAl+nPXbY67socRtfwZD9xBwNyVEpiAXCLMufoUjB4UcGAN3oLOhnsQ4nkYWj9GVQk6YqNZw5fNAVr3YC0BE3I4q6mxMQ+YE2i7q3zXDNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178751; c=relaxed/simple;
	bh=b+sTt6jmv1omdfsdsm5n4XWbqg/P0QPq7Dadh/gYozE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkAE+PzrbYYO8yR7YiCwCyLkLwHvfQ3jZPPMt5Ht8KLRL3rURLtRcLNaiD8vLsDvrBb0J44DWuVNTwcndW7fTgOf5UlqkA6PWzENFvi58dbhFwiUuJgm3oADriPJgBGdsx0iTb+H6OhBV5EqXf3OneuGok+2ekntNRqJWbhoCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F90FEC;
	Thu, 17 Oct 2024 08:26:18 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3A43F528;
	Thu, 17 Oct 2024 08:25:45 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:25:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, rostedt@goodmis.org,
	arnd@arndb.de, ardb@kernel.org, broonie@kernel.org,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629085601.470241-1-ruanjinjie@huawei.com>

Hi,

On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> to use the generic entry infrastructure from kernel/entry/*. The generic
> entry makes maintainers' work easier and codes more elegant, which aslo
> removed a lot of duplicate code.

>  arch/arm64/Kconfig                    |   1 +
>  arch/arm64/include/asm/entry-common.h | 172 ++++++++++++
>  arch/arm64/include/asm/ptrace.h       |   5 +
>  arch/arm64/include/asm/stacktrace.h   |   5 +-
>  arch/arm64/include/asm/syscall.h      |   6 +-
>  arch/arm64/include/asm/thread_info.h  |  23 +-
>  arch/arm64/kernel/entry-common.c      | 368 +++++---------------------
>  arch/arm64/kernel/ptrace.c            |  90 -------
>  arch/arm64/kernel/signal.c            |   3 +-
>  arch/arm64/kernel/syscall.c           |  18 +-
>  include/linux/entry-common.h          |  90 +++++++
>  include/linux/thread_info.h           |  13 +
>  kernel/entry/common.c                 |  37 +--
>  13 files changed, 395 insertions(+), 436 deletions(-)
>  create mode 100644 arch/arm64/include/asm/entry-common.h

Looking at this I have a few concerns, which I've tried to explain
below.

Firstly, this is difficult to review (and will be difficult to test,
queue. and debug in future) because lots of independent changes are made
all at once. I think that needs to be split out more.

It would be good if preparatory rework/cleanup could be split into a few
patches that we could consider queueing before the rest of the series,
or even if we decide to not pick the rest of the series. For example,
patch 2 should be split into:

* One patch that replaces arm64's interrupts_enabled() with
  regs_irqs_disabled(), removing interrupts_enabled() entirely rather
  than implementing regs_irqs_disabled() using interrupts_enabled().

  That'll require updating existing users, but the end result will be
  more consistent and have fewer lines of code.

* One patch that changes on_thread_stack() from a macro to a function.
  The commit message for patch 2 currently says:

  >  Make on_thread_stack() compatible with generic entry.   
 
  ... but it's not clear to me *what* that incompatibility is, and that
  should be explained in the commit message.

* One patch that splits report_syscall() into report_syscall_enter() and
  report_syscall_exit(). This should have no functional change.

Patch 3 in particular is very hard to follow because several unrelated
complex systems are updated simultaneously. It would be really nice if
we could move to the generic sycall code separately from moving the rest
of the entry code, as the sycall handling code is a particularly
important ABI concern, and it's difficult to see whether we're making
ABI changes (accidentaly or knowingly).

Can we split that up (e.g. splitting the generic code first into
separate entry and syscall files), or are those too tightly coupled for
that to be possible?

At the end of the series, pt_regs::{lockdep_hardirqs,exit_rcu} still
exist, though they're unused. It would be nicer if we could get rid of
those in a preparatory patch, e.g. have enter_from_kernel_mode() and
exit_to_kernel_mode() use an irqentry_state_t (or a temporary
arm64-specific version). That would make the subsequent changes clearer
since we'd already have the same structure.

In the end result, there's a lot of bouncing between noinstr functions
where things are inlined today. For example, el0_da() calls
irqentry_enter_from_user_mode(), which is an out-of-line noinstr wrapper
for enter_from_user_mode(), which is an __always_inline function in a
header. It would be nice to avoid unnecessary bouncing through
out-of-line functions. I see s390 and x86 use enter_from_user_mode()
directly.

There's also some indirection that I don't think is necessary *and*
hides important ordering concerns and results in mistakes. In
particular, note that before this series, enter_from_kernel_mode() calls
the (instrumentable) MTE checks *after* all the necessary lockdep+RCU
management is performed by __enter_from_kernel_mode():

	static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
	{
	        __enter_from_kernel_mode(regs);
		mte_check_tfsr_entry();
		mte_disable_tco_entry(current);
	}

... whereas after this series is applied, those MTE checks are placed in
arch_enter_from_kernel_mode(), which irqentry_enter() calls *before* the
necessary lockdep+RCU management. That is broken.

It would be better to keep that explicit in the arm64 entry code with
arm64-specific wrappers, e.g.

	static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
	{
		irqentry_state_t state = irqentry_enter(regs);
		mte_check_tfsr_entry();
		mte_disable_tco_entry(current);

		return state;
	}

... which would avoid the need for arch_enter_from_kernel_mode(), make
that ordering obvious, and would remove the need to modify all the
callers.

Likewise for the user entry/exit paths, which would avoid the visual
imbalance of:
	
	irqentry_enter_from_user_mode();
	...
	exit_to_user_mode_wrapper()

Thanks,
Mark.

