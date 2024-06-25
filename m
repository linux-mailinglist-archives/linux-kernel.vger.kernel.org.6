Return-Path: <linux-kernel+bounces-229560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804699170DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14002B222FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8317C7B4;
	Tue, 25 Jun 2024 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/2ILEFH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA017A932
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342415; cv=none; b=GuvYc6D3YdsFiYCH7tBPATBgryV3Hfmw4yrVtHnCEtDgNGnv4ajERQfBZITURUzh3Ai+3S9In6Wy5C99Mdf9tt1exv16hQJsg0zR8KRotyb/ARz/dCJs5nQlM5gBIb2bQ1ZRcqbNzhFATfab5U/aV1qUP7xV6p/KxbLG2qGmim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342415; c=relaxed/simple;
	bh=AHWWfCYDmzndrVYLTTk4fV2I6SjAMHEoPf5mWM7OBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9AijzmINihl7nz8mQIg3wVnTdlhyDRrfaVjUx7OrLFBCIwKd3SMdAL1wOwQEEIBEIQrJcOnNPIp6BgblIcQrk6/VQTksg/97ffC0+Bt9zesTS2FMTZqX81Sq3wXKCiKThNHgoqb2ZP7UbVyL7NdP4aWflda742EriJElWsLQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/2ILEFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36F1C32781;
	Tue, 25 Jun 2024 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719342414;
	bh=AHWWfCYDmzndrVYLTTk4fV2I6SjAMHEoPf5mWM7OBIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T/2ILEFH7tH6DgSQK/lxQl9l1a90deB4Fl20fqA4eL7pLfiyn7ozDSQvrP8etwEky
	 YUhf25LKYr3L/u/fetU3CQW3zM/7x4Pxeay5Ajro4CrlenTPWqiPhFfvLeiRcmABVx
	 VR9sf9CPP4Djem5I49zdxtK8+kSe4ipRjXFMg7KSUsRk06f0JLOBk4lsONJWjL4Eqf
	 dJvPKoJU2YeKNPne0FaP6fYfcLEmvM4kv4/juvtsNYNbsB7JvzDDGkR7P3mF2mpHFk
	 GcSIxVnBh+HkrzS+Ck8zXt/Qn9SDjw/fsLlrbnGYz7grd7d7nBculFl21Pl8hIzMmE
	 7lQZ7izR4W8/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01219CE0895; Tue, 25 Jun 2024 12:06:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:06:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Alexander Potapenko <glider@google.com>, elver@google.com,
	dvyukov@google.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT
 under KMSAN
Message-ID: <3748b5db-6f92-41f8-a86d-ed0e73221028@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240621094901.1360454-1-glider@google.com>
 <20240621094901.1360454-2-glider@google.com>
 <5a38bded-9723-4811-83b5-14e2312ee75d@intel.com>
 <ZnsRq7RNLMnZsr6S@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnsRq7RNLMnZsr6S@boqun-archlinux>

On Tue, Jun 25, 2024 at 11:51:23AM -0700, Boqun Feng wrote:
> On Fri, Jun 21, 2024 at 09:23:25AM -0700, Dave Hansen wrote:
> > On 6/21/24 02:49, Alexander Potapenko wrote:
> > >  config LOCK_DEBUGGING_SUPPORT
> > >  	bool
> > > -	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
> > > +	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT && !KMSAN
> > >  	default y
> > 
> > This kinda stinks.  Practically, it'll mean that anyone turning on KMSAN
> > will accidentally turn off lockdep.  That's really nasty, especially for
> > folks who are turning on debug options left and right to track down
> > nasty bugs.
> > 
> > I'd *MUCH* rather hide KMSAN:
> > 
> > config KMSAN
> >         bool "KMSAN: detector of uninitialized values use"
> >         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> >         depends on DEBUG_KERNEL && !KASAN && !KCSAN
> >         depends on !PREEMPT_RT
> > +	depends on !LOCKDEP
> > 
> > Because, frankly, lockdep is way more important than KMSAN.
> > 
> > But ideally, we'd allow them to coexist somehow.  Have we even discussed
> > the problem with the lockdep folks?  For instance, I'd much rather have
> > a relaxed lockdep with no checking in pfn_valid() than no lockdep at all.
> 
> The only locks used in pfn_valid() are rcu_read_lock_sched(), right? If
> so, could you try (don't tell Paul ;-)) replace rcu_read_lock_sched()
> with preempt_disable() and rcu_read_unlock_sched() with
> preempt_enable()? That would avoid calling into lockdep. If that works
> for KMSAN, we can either have a special rcu_read_lock_sched() or call
> lockdep_recursion_inc() in instrumented pfn_valid() to disable lockdep
> temporarily.
> 
> [Cc Paul]

Don't tell me what?  ;-)

An alternative is to use rcu_read_lock_sched_notrace() and
rcu_read_unlock_sched_notrace().  If you really want to use
preempt_disable() and preempt_enable() instead, you will likely want
the _notrace() variants.

							Thanx, Paul

