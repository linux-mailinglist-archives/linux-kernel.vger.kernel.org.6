Return-Path: <linux-kernel+bounces-221092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42290ECCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A815D2827C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177F145FEF;
	Wed, 19 Jun 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfHxSLFd"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6A1422B8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802666; cv=none; b=NjAuHPw2rdskV6MJAfQxTHt0ZVNuHBDjBCoch9b/q8cQDJKKNtt5ez7yr0E9oyiqh2rqnuAc+doKKDVnL91/iUiF1A5eMBRy7tyPbdogvlJ9EU9jMTwR2jWAekwlkuDQzoncjdpsIjwYOZcfHYM1RhURoZ2ySah4rRwTNZaqo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802666; c=relaxed/simple;
	bh=9K76lprh6pvu2jSAQY9uUDJnkbW6HhMzxw9Q2zjBmh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB4jvsmYJcGPCzWdDES2EsvHlZt8M+hXYoCIsQE2Ybc9fzS0s2LQfw6keoM9WPLNMTY3XL0fTzHioVcEbFIMQiqPBFiaaXpNnpfXudE2pmQJtYJsO+n57a6RgIMDEov9hUvi0cFa0QL4EI801NFxbx0Oryp7SM2/gwFM79trkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfHxSLFd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so13573a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718802663; x=1719407463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asgcPGsA/aAToz5jObQgKMZ2tGHthnJUmRkCSkIEjh4=;
        b=pfHxSLFdzBxFOT32PqM80eSDpqeQmsyx/Af800sy8qPmHISpqjYZp7fE87uJCammFA
         aEAFmtUJtr3jqMrPc61bVnJeomd5FSIpQf6xszunLg9jv+i2ww98C2XZiIyYWaxFPyoy
         2l7vFLfJUQunPX7FtDl6K2AVchVLqAAl3+fSePBIA0ZP2ijwj5J8xGr5Vak2oGZKvdic
         MwJyBpiGyPGf4nB2KMtotpwkjOgPZTk41A7i7r9mQcpWyze1nYxYEgPf7sYrPIm+WHI8
         Gje7b1awjkAWYGJxLajHjpnp/sg16qgM+wj9dMf3rGYGC1wQTHkdrC6Neb0EG3jQBuY7
         y3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802663; x=1719407463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asgcPGsA/aAToz5jObQgKMZ2tGHthnJUmRkCSkIEjh4=;
        b=p8F0C6/M7KmGdR2so9UPymKlhGTQiv1RP/X2CYnOy/23GJnNDH1S9a7RtCbkgmbYEw
         HLawIU9r8Ep3kwQLoXglFH8B2fK03VDYSgMu0zb1BkCZa6nPdnMN5bDzrJ5XqA/cfMQZ
         DXVbY9XcCBqGgqKCHBtlgFRt7xD9ps8A/RNbLEfj8G1gsPY8MGNShisB6PkBoc0n/R72
         oqvXK4/RfnGkNQqiY72VLqYcJZYocpO2rce8grWWovn3fV4mg4GzZS8ooPNa+s6p/CAc
         VR3NN3xNMVphrMM78aDHP5VG50SmqWOMnZX7d34LLr1OxKxvI++u9C5YA1/uXoDlUCpr
         KSAA==
X-Forwarded-Encrypted: i=1; AJvYcCXH+lWdQSv73ZgBMJea0Die5+u+Yky19LpZTL4XYJZ2w8BkyHPt/+0wmifkDlj+T88/qoCEGU9HPAkxQTeSvnvmJbddvdcZRoiNOuXP
X-Gm-Message-State: AOJu0Yz1KCDF2b5gVG2ZPz8INX+TlrtoZc2aB1le6L756ObNlPtUmt7Y
	AzXj4OrQ/sb9GR1hO94sAKC4tJdP7GS2JTFSr8Zl1W+nNZY78Z5bddlktCW0uiR7q+573ZxiEHW
	whLV0uhdCxmcgVAx5prKpzgbDzYFxcp7qdXxv
X-Google-Smtp-Source: AGHT+IHsGAv9xsDPy5GSneKlyGJaHcfAwFiExrmsb+x1hiL/oRQ9U109V0B0Dj71ZS3bv9BInDVlSQqS8eFL4ozmAZg=
X-Received: by 2002:a05:6402:35d5:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-57d0ec44f62mr147438a12.1.1718802663097; Wed, 19 Jun 2024
 06:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
 <20240619112332.GL31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240619112332.GL31592@noisy.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 19 Jun 2024 15:10:51 +0200
Message-ID: <CACT4Y+ZXdiSxHHe2VAQ1Ma0XDxFPX6q4zF6KFRYkt-at6Svqfg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86: Ignore stack unwinding in KCOV
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 11, 2024 at 09:50:33AM +0200, Dmitry Vyukov wrote:
> > Stack unwinding produces large amounts of uninteresting coverage.
> > It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
> > It's not particularly useful and is not a function of system call args.
> > Ignore that code.
>
> This stems from KCOV's purpose being guiding syzkaller as opposed to it
> being a more general coverage tool, right?
>
> Is that spelled out anywhere?

It may be used for other similar purposes as well, e.g. collecting
unit test coverage (not the whole kernel, but a single specific test
provided that even other tests can run and collect their own coverage
in parallel).

It's spelled explicitly in the docs:

https://elixir.bootlin.com/linux/latest/source/Documentation/dev-tools/kcov.rst

"""
KCOV collects and exposes kernel code coverage information in a form suitable
for coverage-guided fuzzing .... Coverage collection is enabled on a
task basis, and
thus KCOV can capture precise coverage of a single system call.

Note that KCOV does not aim to collect as much coverage as possible. It aims
to collect more or less stable coverage that is a function of syscall inputs.
To achieve this goal, it does not collect coverage in soft/hard interrupts...
"""



> Anyway,
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for your reviews, Peter!


> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: syzkaller@googlegroups.com
> > ---
> >  arch/x86/kernel/Makefile | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 20a0dd51700a..cd49ebfae984 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o                                       := n
> >  # first second.
> >  KCOV_INSTRUMENT_head$(BITS).o                                := n
> >  KCOV_INSTRUMENT_sev.o                                        := n
> > +# These are called from save_stack_trace() on debug paths,
> > +# and produce large amounts of uninteresting coverage.
> > +KCOV_INSTRUMENT_stacktrace.o                         := n
> > +KCOV_INSTRUMENT_dumpstack.o                          := n
> > +KCOV_INSTRUMENT_dumpstack_$(BITS).o                  := n
> > +KCOV_INSTRUMENT_unwind_orc.o                         := n
> > +KCOV_INSTRUMENT_unwind_frame.o                               := n
> > +KCOV_INSTRUMENT_unwind_guess.o                               := n
> >
> >  CFLAGS_irq.o := -I $(src)/../include/asm/trace
> >
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20240619112332.GL31592%40noisy.programming.kicks-ass.net.

