Return-Path: <linux-kernel+bounces-576033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA8A70A26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8280F16B424
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE01AE876;
	Tue, 25 Mar 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPbGLGyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C319ABD8;
	Tue, 25 Mar 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930390; cv=none; b=C9EWB4+wdSmDwSrVBjJoHPaVXxLxY0yssN8sI+SL0aeJx0EgDthrdDHqm/0tbja/03UZtNgSKeP0/hJhzcjGYFVgN/7PZBj2iGlfzEU/eprM1CN21RlnD+kVwodLkuEcnq58H7eCusEuzIWgiOTF2+BC/UE2hPzSrbMUI7YQgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930390; c=relaxed/simple;
	bh=wafZEi25K9c1JaTWa6sefMLZsC4dbteHbRRbzmLF/cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnL4opMhVONEhFFJ1gwhj/DGgcOR0Y6Lf/rnYEWWt/UVnkJ/GnNAboOVyMV4adZG6VxgekX8p2E0GeXOMR72kWs3ihOPXuHcryYSePpZsTthELRopOeYVC1toRiYPpaxOo03QYQ4cIBRg7lPbfdDZvinrF0yLQwPtz/UTYo4D7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPbGLGyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95819C4CEE4;
	Tue, 25 Mar 2025 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742930390;
	bh=wafZEi25K9c1JaTWa6sefMLZsC4dbteHbRRbzmLF/cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPbGLGyBiB1SvRfjtdKDPGZo2ETHpmtg4qXxmT/GsGNeAR+CaOgpCSQkLho6C5cyc
	 BeFl650l1ufdKyeIojv+r6tvos6q1QYTea+agnc7gVeN//anBFAS8jHYiYDVjzt75S
	 s4ZzhkBDnUKxoUSQebcAdRQCh05nh9CfvgA1nGA7rbw2k4oclzJMZbHrxqVlBm48wb
	 Z621YrYZ+JHXHsHghbHMhKcOrjvBF8Y03gX03F9+y0ZGfKdZwqTAliB69pFxnQnTxA
	 /WTgRa7IozzmoX/kArbLGdEvNkKtPUwcd3I8f3yvhQKyd+ycRUqXs6b97otN3YzUpL
	 HwRTkHR1eqHGg==
Date: Tue, 25 Mar 2025 15:19:44 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z-MB0Cj4tM6QgOAg@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com>
 <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>

On Mon, Mar 24, 2025 at 11:40:43AM -0700, Frank van der Linden wrote:
> On Wed, Mar 19, 2025 at 6:56 PM Changyuan Lyu <changyuanl@google.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> > HandOver is a mechanism that allows Linux to preserve state - arbitrary
> > properties as well as memory locations - across kexec.
> >
> > It does so using 2 concepts:
> >
> >   1) State Tree - Every KHO kexec carries a state tree that describes the
> >      state of the system. The state tree is represented as hash-tables.
> >      Device drivers can add/remove their data into/from the state tree at
> >      system runtime. On kexec, the tree is converted to FDT (flattened
> >      device tree).
> >
> >   2) Scratch Regions - CMA regions that we allocate in the first kernel.
> >      CMA gives us the guarantee that no handover pages land in those
> >      regions, because handover pages must be at a static physical memory
> >      location. We use these regions as the place to load future kexec
> >      images so that they won't collide with any handover data.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  MAINTAINERS                    |   2 +-
> >  include/linux/kexec_handover.h | 109 +++++
> >  kernel/Makefile                |   1 +
> >  kernel/kexec_handover.c        | 865 +++++++++++++++++++++++++++++++++
> >  mm/mm_init.c                   |   8 +
> >  5 files changed, 984 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/kexec_handover.h
> >  create mode 100644 kernel/kexec_handover.c
> [...]
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 04441c258b05..757659b7a26b 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/execmem.h>
> >  #include <linux/vmstat.h>
> > +#include <linux/kexec_handover.h>
> >  #include "internal.h"
> >  #include "slab.h"
> >  #include "shuffle.h"
> > @@ -2661,6 +2662,13 @@ void __init mm_core_init(void)
> >         report_meminit();
> >         kmsan_init_shadow();
> >         stack_depot_early_init();
> > +
> > +       /*
> > +        * KHO memory setup must happen while memblock is still active, but
> > +        * as close as possible to buddy initialization
> > +        */
> > +       kho_memory_init();
> > +
> >         mem_init();
> >         kmem_cache_init();
> >         /*
> 
> 
> Thanks for the work on this.
> 
> Obviously it needs to happen while memblock is still active - but why
> as close as possible to buddy initialization?

One reason is to have all memblock allocations done to autoscale the
scratch area. Another reason is to keep memblock structures small as long
as possible as memblock_reserve()ing the preserved memory would quite
inflate them.

And it's overall simpler if memblock only allocates from scratch rather
than doing some of early allocations from scratch and some elsewhere and
still making sure they avoid the preserved ranges.
 
> Ordering is always a sticky issue when it comes to doing things during
> boot, of course. In this case, I can see scenarios where code that
> runs a little earlier may want to use some preserved memory. The

Can you elaborate about such scenarios?

> current requirement in the patch set seems to be "after sparse/page
> init", but I'm not sure why it needs to be as close as possibly to
> buddy init.

Why would you say that sparse/page init would be a requirement here?
 
> - Frank

-- 
Sincerely yours,
Mike.

