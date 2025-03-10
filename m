Return-Path: <linux-kernel+bounces-554458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4FA597F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BF3166D79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D622576A;
	Mon, 10 Mar 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvQWOmaa"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB417C91
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617810; cv=none; b=QdAU+0KInu7OfBSR4aAOAKFxWRxCxygj7CtoEZkX2tZ1EzH3391/nV+eMoBm7PaoYnFoQ6V7rex6FxznRcISQHovY/qi2IWPVPLHDfyXguyrTDF3YwsuHWvr+FTy8ANiKNGvir21KTcXzDWCu+IJQTfYEdySKYp/6p6XOn2FR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617810; c=relaxed/simple;
	bh=+HjiWo11FRe8GEI9rs4hLxe40CZzp84cHOL8c95P6Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Djw/A1073F5v6/u71iW9TAvwrskbVnCznGJBqqZbTxTRMijKjWChbUFPi33IykVvKjYopy6WqfmAjtymEii0BZHNBl84j3kEdi9l4AMlhExSKebdVbD/nBKXq9eRDTSYzsby6q8uh1znbZyt+fxa2DYR+02xYl0O7Nu6ZFbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvQWOmaa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so23884321fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741617807; x=1742222607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcTqGsurrRcFLMZFB8JKOfNLXC187uymZAmaTkFx7TI=;
        b=TvQWOmaaaw9KKgFmd9JZi25ktInxL+vzfODFPkj+zwaSbiVYczEB13GJDfg0dUNpDG
         V8f6aQpnpCTHOsBPP9a8zDQLSfB7GdR4j8WnJJngkQIPMaEfLB8/wcltM2yS7KiPcHbl
         wJ1NV0ybRxmJtSVdEtjsa53rqbB6/wdgMIoXxdWvkD7oVjiyNCoySSi6pgn/pPLZEaOj
         NVvygmynGZNRelPU6DVe7SlH4fxra7RwnoT2oFsmb5LctdqOqnNH+8Bv/P36E4H0E3U3
         79Rkkdi6/YqbJrf6WPGnIzxzyxxdeHzgRpPkKES4iLTX5eyJVwzuhnbHL1DvrWKczYAk
         BxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617807; x=1742222607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcTqGsurrRcFLMZFB8JKOfNLXC187uymZAmaTkFx7TI=;
        b=qVyVO+oDh0HDionXmABR733i4JcPtriD0TYLsHVa540cgJCkt8rVj+GG64Rf3FXMMv
         mHaU8SBNvO2Y9kSMwRy+gJlJjHIshg6sw9B9OASXRjWu3sY0h677okjwa6UWcz1I8XrJ
         LEDiCGPQSYSot6wV1cRctH+HKUwDGtCjxdezJwJNY1vSfra+edGr1MRaCzHipkkWlULD
         ZPklzzh6s98O74EjZCV2vyxDWDRK8iWU3HF4bV8Cugy7Vs9bNor+1YzvcD+QAY3wpPt0
         XTEOnZMtv0ixpVY+DUDvqQ38sTy6HywnoLKeFU13y+WpR1KdRRKA0rfrZZKJWWOjQ6m8
         AKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGQPp8DFlrk34/txLbJDq5hs47SSJlmyXc36Ldd06aa04xfHLf2i2/WdRWSbFCPx4/FeaCo1o0XByl1jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LQ6OZj7yJwh08Cj8Vcwx29wTU7WjaC3u7k2+Pum4vhZ3YOXr
	+a/S7FkoMgo9JmwJwHrqfUJt1pmPN0qeoRxDuUNFqIo42ynQSMtT2uoAVTEpIcJLU1WK47MoUEW
	F/zp+rItd5Ff1+7n9M/njhxogVNZOKzw1UQKk
X-Gm-Gg: ASbGncubyuJNvtf0DNIRXg/ubMRPbnfotr3eEXiMPN4zZnESRVtlBgPLFNs7sTMQpad
	quBMfobRT1qQQgFvTDAkm9xpKiRkNj+DTMU1sXunwOZ3pz9oTuf+kE3IDsUR3EC63Kx7/l+h5Hs
	pps6Y0tvJrup2j2RjX17R1CGLB
X-Google-Smtp-Source: AGHT+IG+0KmYffvqeac4Cv8aErSPWnUmTawqSkKpe+vtboFBS8pIqWuvMJdZGrwKVU77BbeiFB2gnuFrQqOX8ddQO3g=
X-Received: by 2002:a2e:9891:0:b0:30b:ff47:e589 with SMTP id
 38308e7fff4ca-30bff48a389mr28387531fa.13.1741617806676; Mon, 10 Mar 2025
 07:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com> <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
 <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com> <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
 <c3781655-b667-4477-9337-445d8250fb4e@efficios.com>
In-Reply-To: <c3781655-b667-4477-9337-445d8250fb4e@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 10 Mar 2025 15:43:14 +0100
X-Gm-Features: AQ5f1JqHUm5x2X-Hg6VRpz1yP_3K-pHjgJjU2LdaRZuKlxkg35yBzQUGIdISTKc
Message-ID: <CACT4Y+YpnCfm6xjdwnUJ-3ND_YPNdAqReffueF1dWGfxmJLWEQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 15:38, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-03-10 10:36, Dmitry Vyukov wrote:
> > On Mon, 10 Mar 2025 at 15:30, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2025-02-27 09:03, Dmitry Vyukov wrote:
> >>> Add a test that ensures that PKEY-protected struct rseq_cs
> >>> works and does not lead to process kills.
> >>>
> >>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >>> Cc: x86@kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >>>
> >>> ---
> >>> Changes in v5:
> >>>    - Use static for variables/functions
> >>>    - Use RSEQ_READ/WRITE_ONCE instead of volatile
> >>>
> >>> Changes in v4:
> >>>    - Added Fixes tag
> >>>
> >>> Changes in v3:
> >>>    - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>    - rework the test to work when only pkey 0 is supported for rseq
> >>>
> >>> Changes in v2:
> >>>    - change test to install protected rseq_cs instead of rseq
> >>> ---
> >>>    tools/testing/selftests/rseq/Makefile    |  2 +-
> >>>    tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
> >>>    tools/testing/selftests/rseq/rseq.h      |  1 +
> >>>    3 files changed, 100 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> >>> index 5a3432fceb586..9111d25fea3af 100644
> >>> --- a/tools/testing/selftests/rseq/Makefile
> >>> +++ b/tools/testing/selftests/rseq/Makefile
> >>> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
> >>>
> >>>    TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
> >>>                param_test_benchmark param_test_compare_twice param_test_mm_cid \
> >>> -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> >>> +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
> >>>
> >>>    TEST_GEN_PROGS_EXTENDED = librseq.so
> >>>
> >>> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> >>> new file mode 100644
> >>> index 0000000000000..cc4dd98190942
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/rseq/pkey_test.c
> >>> @@ -0,0 +1,98 @@
> >>> +// SPDX-License-Identifier: LGPL-2.1
> >>> +/*
> >>> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
> >>> + */
> >>> +
> >>> +#define _GNU_SOURCE
> >>> +#include <err.h>
> >>> +#include <errno.h>
> >>> +#include <stdio.h>
> >>> +#include <stdlib.h>
> >>> +#include <string.h>
> >>> +#include <sys/mman.h>
> >>> +#include <sys/syscall.h>
> >>> +#include <ucontext.h>
> >>> +#include <unistd.h>
> >>> +
> >>> +#include "rseq.h"
> >>> +#include "rseq-abi.h"
> >>> +
> >>> +static int pkey;
> >>> +static ucontext_t ucp0, ucp1;
> >>> +
> >>> +static void coroutine(void)
> >>> +{
> >>> +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
> >>> +     /*
> >>> +      * When we disable access to pkey 0, globals and TLS become
> >>> +      * inaccessible too, so we need to tread carefully.
> >>> +      * Pkey is global so we need to copy it onto the stack.
> >>> +      */
> >>> +     int pk = RSEQ_READ_ONCE(pkey);
> >>> +     struct timespec ts;
> >>> +
> >>> +     orig_pk0 = pkey_get(0);
> >>> +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
> >>> +             err(1, "pkey_set failed");
> >>> +     old_pk0 = pkey_get(0);
> >>> +     old_pk1 = pkey_get(pk);
> >>> +
> >>> +     /*
> >>> +      * Prevent compiler from initializing it by loading a 16-global.
> >>> +      */
> >>> +     RSEQ_WRITE_ONCE(ts.tv_sec, 0);
> >>> +     RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
> >>> +     /*
> >>> +      * If the kernel misbehaves, context switches in the following loop
> >>> +      * will terminate the process with SIGSEGV.
> >>> +      * Trigger preemption w/o accessing TLS.
> >>> +      * Note that glibc's usleep touches errno always.
> >>> +      */
> >>> +     for (i = 0; i < 10; i++)
> >>> +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
> >>> +
> >>> +     pk0 = pkey_get(0);
> >>> +     pk1 = pkey_get(pk);
> >>> +     if (pkey_set(0, orig_pk0))
> >>> +             err(1, "pkey_set failed");
> >>> +
> >>> +     /*
> >>> +      * Ensure that the kernel has restored the previous value of pkeys
> >>> +      * register after changing them.
> >>> +      */
> >>> +     if (old_pk0 != pk0)
> >>> +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
> >>> +     if (old_pk1 != pk1)
> >>> +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
> >>> +
> >>> +     swapcontext(&ucp1, &ucp0);
> >>> +     abort();
> >>> +}
> >>> +
> >>> +int main(int argc, char **argv)
> >>> +{
> >>> +     pkey = pkey_alloc(0, 0);
> >>> +     if (pkey == -1) {
> >>> +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> >>> +                     strerror(errno));
> >>> +             return 0;
> >>> +     }
> >>> +
> >>> +     if (rseq_register_current_thread())
> >>> +             err(1, "rseq_register_current_thread failed");
> >>> +
> >>> +     if (getcontext(&ucp1))
> >>> +             err(1, "getcontext failed");
> >>> +     ucp1.uc_stack.ss_size = getpagesize() * 4;
> >>> +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
> >>> +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> >>> +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
> >>> +             err(1, "mmap failed");
> >>> +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
> >>> +                     PROT_READ | PROT_WRITE, pkey))
> >>> +             err(1, "pkey_mprotect failed");
> >>> +     makecontext(&ucp1, coroutine, 0);
> >>> +     if (swapcontext(&ucp0, &ucp1))
> >>> +             err(1, "swapcontext failed");
> >>
> >> Should the rseq register be paired with a rseq unregister here ?
> >
> > I dunno. It's necessary for this test and in general. Tcmalloc won't
> > unregister on thread exit. Even for a libc it may be a bad idea due to
> > signals.
>
> The rseq register/unregister is only for the case where libc does not
> support rseq. But if you want to use rseq_register_current_thread(),
> then you'll want to pair it with unregister.

Why? Isn't it better to have tests more realitic?


> Thanks,
>
> Mathieu
>
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>> +     return 0;
> >>> +}
> >>> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> >>> index ba424ce80a719..65da4a727c550 100644
> >>> --- a/tools/testing/selftests/rseq/rseq.h
> >>> +++ b/tools/testing/selftests/rseq/rseq.h
> >>> @@ -8,6 +8,7 @@
> >>>    #ifndef RSEQ_H
> >>>    #define RSEQ_H
> >>>
> >>> +#include <assert.h>
> >>>    #include <stdint.h>
> >>>    #include <stdbool.h>
> >>>    #include <pthread.h>
> >>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

