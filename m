Return-Path: <linux-kernel+bounces-531530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197BA44196
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02F53B1054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA626B2C6;
	Tue, 25 Feb 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnt+4Bx2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D5269D13
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491721; cv=none; b=iA+1hUmDjHOQZdxYXRywBDFiSz3sRqSDuxUTp8Ic2XS6PH4bJfCXIH/rUlVAq25DrBlEJrduT54CgBa3B5ZO02msoOpPChWQfI5EUh+rHAhZcLYED8D2R4nGpyHKVBUS7owZe3qv90xoaHjvGiRvAOKNVaB0gnb+MG6deXDk/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491721; c=relaxed/simple;
	bh=aMgHzcriDb6BNUf1VDHnNTDYs/W8W7V87dqghsg8kn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9Pt9AQozTBZLpSgEys4XlKzXlxhsN+iLj9QobFwZnyeq8OMR08yTN1beor4h68+KUG6fcP2my/z3SBbX4ttniukHh+8jUwGXCAMPd7yNN5f0L075AlW8muWb+OeFf4HtJJm79wYVVKeHDuZ5MzXFS+MaHlbe6u0egvCBVFmXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnt+4Bx2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5452c29bacfso6109385e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491716; x=1741096516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LGvbcAdgByWH27emT1cG4w5howJ6mUfY8H+fRnaBPw=;
        b=tnt+4Bx2LJnJ0S7Q7PMtepnyTnkNqnsOFLoDhwuVSwaVD//M9DSTDx2bqn04s3m+iq
         4ZHzUQtSW2aon2mIDY4BLTPLeLTRKHAIj7gbiI/7elRgZ6UqDzpS7ba2xmE1m9x6sH0k
         jahU6TxZmqxf2WZig7FuGslwVNp0rrhLJSRap+Mwn7fWuMLRzuV8m8WX98fDjIM1cmjF
         fPP43cQGQNwczH2KF0c9/2sWMHqZwpc6qJzAq08s8FteSpEpsCvFYf1Qzw9Wy8ab6883
         CA0FI/GFwuoxXLmPAHagnpCSiE2FDdhRAqR0uuE1KJzWgt9QzgNfC+rDhL9ARiMo0Q0h
         i7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491716; x=1741096516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LGvbcAdgByWH27emT1cG4w5howJ6mUfY8H+fRnaBPw=;
        b=mD6xe7u+qAkfdQvOSLJbQt86glW9PWe0skwHRB23XBN/aQEgH+x2ccdWUCNKcD7wci
         v8GrkTtBQbkk1aAFTLC01XSV6ZzqX4aT2IfkO08sf6++OTpMDeH0Ki1zc9j1uqpRUk8g
         zeq5jK6c9b0Nl5k862+qSdg2hcT5HycGkCMMQW4MyoOxenMt93gec1OMUsBUEj46KLRz
         sQPtZXu6X3pepofcPv/3hpKwChFk9rIiLiw+jYUhG5qehORs6ivVAYXjsHgjvrF+ztBA
         4yf8lllOYJh/AqA2Yk/z5cySadpNYBgUWXwnSze6UUhuhvmH4uYkxq88wqUHIGCIIvFZ
         o/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVYYJ3csKxnhfF4I4spooEUwFG3cD7qHcefMM6f6IfcIopBrQcK3EnQLfUnUBQ82Xa7+LS8mxFWPe6W3gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTw5wbFu7zTRjT9HiQTmqWbPPQjIXOw5KrALjVctw8Q0Yy+YA
	LbgW0vY1FZMui66dyZUGKdAxV6i8V+Ic/49+jD2vyhHAzd1Y5BAR+xZ3YVJBz19cxMRn+fKvUbG
	3JB5osyyaokx6FhFITm7PAPJDQf7C6rJE6u6R
X-Gm-Gg: ASbGncsifBrHwkQIoMC3JiBNxvEOqXqbQk5nSeD5FQWoPYp3ZcGyGeydrQ7/KpiAg0B
	dIMHd300iebrmECzIxCqaAALxGS7+WXCik14GzusICExUVnMdeEDtpBNu6wjCBo8sCjx23uM1x3
	x7gU/jBVbOXsbyBTXvfyMIva+47P/S4W9Qy79RKZg+
X-Google-Smtp-Source: AGHT+IGwGbbIwR/sevu+31eywAgOrxwa9PIrh9YieongO7zxnw/eubJx/lngeppyUHku2aRaIEsJ9BBtLrXuwWe6KYA=
X-Received: by 2002:a05:6512:3ca5:b0:545:17d:f96b with SMTP id
 2adb3069b0e04-548391371c9mr6738092e87.14.1740491716307; Tue, 25 Feb 2025
 05:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com> <356f1e7b2c3c1dfee74f030bca603ffc9549ffb4.1740403209.git.dvyukov@google.com>
 <cc8b653e-29ad-4cfb-91c3-1e001a811c4c@efficios.com>
In-Reply-To: <cc8b653e-29ad-4cfb-91c3-1e001a811c4c@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 25 Feb 2025 14:55:04 +0100
X-Gm-Features: AQ5f1Jr5fCP3acggJwoIUIo9VIP85vAkBExI-5Xaj64cii6CiGJgjPpiz5tawzA
Message-ID: <CACT4Y+Z6BgdeSJjQ6uMrhJsVt72WzpFMU0TA6d5WzQs42gzPjw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/rseq: Add test for rseq+pkeys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:48, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-24 08:20, Dmitry Vyukov wrote:
> > Add a test that ensures that PKEY-protected struct rseq_cs
> > works and does not lead to process kills.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >
> > ---
> > Changes in v4:
> >   - Added Fixes tag
> >
> > Changes in v3:
> >   - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >   - rework the test to work when only pkey 0 is supported for rseq
> >
> > Changes in v2:
> >   - change test to install protected rseq_cs instead of rseq
> > ---
> >   tools/testing/selftests/rseq/Makefile    |  2 +-
> >   tools/testing/selftests/rseq/pkey_test.c | 99 ++++++++++++++++++++++++
> >   tools/testing/selftests/rseq/rseq.h      |  1 +
> >   3 files changed, 101 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> > index 5a3432fceb586..9111d25fea3af 100644
> > --- a/tools/testing/selftests/rseq/Makefile
> > +++ b/tools/testing/selftests/rseq/Makefile
> > @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
> >
> >   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
> >               param_test_benchmark param_test_compare_twice param_test_mm_cid \
> > -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> > +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
> >
> >   TEST_GEN_PROGS_EXTENDED = librseq.so
> >
> > diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> > new file mode 100644
> > index 0000000000000..8752ecea21ba8
> > --- /dev/null
> > +++ b/tools/testing/selftests/rseq/pkey_test.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: LGPL-2.1
> > +/*
> > + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <err.h>
> > +#include <errno.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +#include <ucontext.h>
> > +#include <unistd.h>
> > +
> > +#include "rseq.h"
> > +#include "rseq-abi.h"
> > +
> > +int pkey;
> > +ucontext_t ucp0, ucp1;
>
> Why use an external linkage entity rather than static ?

Done in v5.

> > +
> > +void coroutine(void)
> > +{
> > +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
> > +     /*
> > +      * When we disable access to pkey 0, globals and TLS become
> > +      * inaccessible too, so we need to tread carefully.
> > +      * Pkey is global so we need to copy it to onto stack.
>
> to onto -> onto the ?

Done in v5.

> > +      * If ts is not volatile, then compiler may try to init it
> > +      * by loading a global 16-byte value.
> > +      */
> > +     volatile int pk = pkey;
> > +     volatile struct timespec ts;
>
> I think you are looking for RSEQ_READ_ONCE() when loading from the
> global variables to prevent re-fetch. AFAIU the volatile on the stack
> variables are not what you are looking for.

Done in v5.

> > +
> > +     orig_pk0 = pkey_get(0);
> > +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
>
> AFAIU the pkey_set() call needs to act as a memory clobber. Therefore
> having RSEQ_READ_ONCE() before the clobber to copy the global variables
> onto the stack should be OK.

Done in v5.

> Thanks,
>
> Mathieu
>
>
> > +             err(1, "pkey_set failed");
> > +     old_pk0 = pkey_get(0);
> > +     old_pk1 = pkey_get(pk);
> > +
> > +     /*
> > +      * If the kernel misbehaves, context switches in the following loop
> > +      * will terminate the process with SIGSEGV.
> > +      */
> > +     ts.tv_sec = 0;
> > +     ts.tv_nsec = 10 * 1000;
> > +     /*
> > +      * Trigger preemption w/o accessing TLS.
> > +      * Note that glibc's usleep touches errno always.
> > +      */
> > +     for (i = 0; i < 10; i++)
> > +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
> > +
> > +     pk0 = pkey_get(0);
> > +     pk1 = pkey_get(pk);
> > +     if (pkey_set(0, orig_pk0))
> > +             err(1, "pkey_set failed");
> > +
> > +     /*
> > +      * Ensure that the kernel has restored the previous value of pkeys
> > +      * register after changing them.
> > +      */
> > +     if (old_pk0 != pk0)
> > +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
> > +     if (old_pk1 != pk1)
> > +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
> > +
> > +     swapcontext(&ucp1, &ucp0);
> > +     abort();
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     pkey = pkey_alloc(0, 0);
> > +     if (pkey == -1) {
> > +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> > +                     strerror(errno));
> > +             return 0;
> > +     }
> > +
> > +     if (rseq_register_current_thread())
> > +             err(1, "rseq_register_current_thread failed");
> > +
> > +     if (getcontext(&ucp1))
> > +             err(1, "getcontext failed");
> > +     ucp1.uc_stack.ss_size = getpagesize() * 4;
> > +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
> > +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> > +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
> > +             err(1, "mmap failed");
> > +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
> > +                     PROT_READ | PROT_WRITE, pkey))
> > +             err(1, "pkey_mprotect failed");
> > +     makecontext(&ucp1, coroutine, 0);
> > +     if (swapcontext(&ucp0, &ucp1))
> > +             err(1, "swapcontext failed");
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> > index ba424ce80a719..65da4a727c550 100644
> > --- a/tools/testing/selftests/rseq/rseq.h
> > +++ b/tools/testing/selftests/rseq/rseq.h
> > @@ -8,6 +8,7 @@
> >   #ifndef RSEQ_H
> >   #define RSEQ_H
> >
> > +#include <assert.h>
> >   #include <stdint.h>
> >   #include <stdbool.h>
> >   #include <pthread.h>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

