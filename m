Return-Path: <linux-kernel+bounces-554658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD07A59B09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6397B3A8C33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3621D3F7;
	Mon, 10 Mar 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6W+o3O6"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD81E519
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624294; cv=none; b=g9rhnR+HwxMW6WhKoaeM7Fw8Q6SDVJvW2XX+B0bmVaXTWdS7DZkjglgmf5qL6AqzBp4qkr7pqC3C1PjUHXG4YYKz3f+0+nrWE9VFPN9j6at9xY97NkSjVHOcKct80iIj2TZTEIiw5ZFbPTqp60Kui95r/UqUSuV+fPCZeL2ogBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624294; c=relaxed/simple;
	bh=haAZfR/LdRqtneTUaG1eryf05n233fNsdLw9bnRughM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AylRSN9eceUesDRJrl7U8ppVmoLRo/Kw+vtOS3I7LsXIhvYUkP419qTcpT2XcETLSoNc97ANIjR2WdyKPVOML6CVl5gxe0f+/2OxguQWrpD7Wphndkghc9KOPT7pdl0a1aIORXetHhwyKjIPUPXrXsd55NDaEj389kDwjwmtAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6W+o3O6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a59so50232631fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741624290; x=1742229090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/97Uwq5DKKx0KFCL6yeTDndlS2gQbEpvHiCnSZ80p5M=;
        b=o6W+o3O62aQaCC6A0yDN7qQFlRgV13J9+yX/PlKQbiS3738Fq3iA+aTDvJvMkzXumB
         YcG9isbm5+sLZ8loSjzZDVLltXd1Gzf6ur94NX4TfbaIWNNCBsYO3LwS6+es+pJ4u0FF
         b58+mHN1FS2iPuU2XzHDCK1j1Kvl05NALgTz8UvJCeUTcknFBYtgvChoQCBUr1Gg6NuF
         aaCUWpdZjUTtFd4vaPOGfMpNL/+xRj5m/kmNMB3043uGZX6qcfRy+Mdrkf7M/HlBHMD/
         ceqEhKiQ+/2eILVBjE5CAyqgsQpJApGTABzuxcDLRkMHFDT4ebeJar8c8YIt3OAp51P8
         dnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624290; x=1742229090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/97Uwq5DKKx0KFCL6yeTDndlS2gQbEpvHiCnSZ80p5M=;
        b=CKcoJAiy/zFDBkguQBQ31V5ANWby6KAITrzYPRe3nzuhyhTBd6mjoHeltldVnTI9LT
         SM3l6OoNfVh/wo1YP4IXytLjMsb8HouBbep6q6Emm3o78qfYrfpqVzlBZ2i79UydMbbk
         Y9V1mW+ktKBV17PquA2MNUJJhYR7F0Zue+BnIXU3JA+2j4fz3HhQrR33iNPSSNXI60P0
         c/ut4BLH6VZYjYoD+8uIL0E9kspgaoCkcOkEPTtGwRFLhgMIQ8Bnx/ZVaYvvoF9mofPf
         jABmMwgjz3tGQvvjX0i1wq6UykTUouMxKKDRGUuxeViHS4LKmdSL8L/H5xU9d7WAcoe+
         Q/qA==
X-Forwarded-Encrypted: i=1; AJvYcCU09O7g7nxwLkqjkQKaenZNukfBqhCGwtv+MjmjGkc9GF5oberEyORY9fPi4S+vikxAXD/C/enTShJs+mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAESSj4NNWCz2zQilTBx9sMkTfiKhzuluTIb+Q9eRCaVxiGBE3
	Growvx7lKbVjx92M2oshHrvcChbfcT2jzZzFXfAbTTsGA5V2mjQKRK6rq+Wu9D/J5HyogsUcfyS
	Nr4BUgscsx5X+h3fDaVWqHjVhwAA3+w6pYVur
X-Gm-Gg: ASbGncuRuIvMAUL9lfbhA/W/ba7dfI1NytJewCWlVn8hh2ZpXU1S1u0X4jkYdj9re6S
	dEFCbQlyXzZVlImMAiiCe1b/i1XQJRla86Lu/yba92u+1UfguLl9xjYwqnv3PyVqsS7gGmc/Txl
	DZWZ3C0xkUdvHs6dI/CVARHQHO
X-Google-Smtp-Source: AGHT+IHmuGWkGjBkIkBnodVoY6wALKW8QhUew9NmGg6ee4YInHF0/4Hgop4vVxf5qMyGhrscBDD8yRf/Ebl2b6DEv4Q=
X-Received: by 2002:a2e:bcd0:0:b0:30c:12b8:fb9e with SMTP id
 38308e7fff4ca-30c12b9034emr16614131fa.37.1741624288302; Mon, 10 Mar 2025
 09:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com> <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
 <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com> <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
 <c3781655-b667-4477-9337-445d8250fb4e@efficios.com> <CACT4Y+YpnCfm6xjdwnUJ-3ND_YPNdAqReffueF1dWGfxmJLWEQ@mail.gmail.com>
 <3c45a374-804f-4a9f-8885-5ef1bfc8676f@efficios.com>
In-Reply-To: <3c45a374-804f-4a9f-8885-5ef1bfc8676f@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 10 Mar 2025 17:31:13 +0100
X-Gm-Features: AQ5f1Jpaq5u1pKxA1dVg9X5WdhSG1JE8cb_lr4C4Lpw9IQhJej26e2sPXdwp02k
Message-ID: <CACT4Y+Y1Hgw9xmqhcCqPmgspOKLqvm6c54yxZus4uXd==PJxuQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 16:41, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-03-10 10:43, Dmitry Vyukov wrote:
> > On Mon, 10 Mar 2025 at 15:38, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2025-03-10 10:36, Dmitry Vyukov wrote:
> >>> On Mon, 10 Mar 2025 at 15:30, Mathieu Desnoyers
> >>> <mathieu.desnoyers@efficios.com> wrote:
> >>>>
> >>>> On 2025-02-27 09:03, Dmitry Vyukov wrote:
> >>>>> Add a test that ensures that PKEY-protected struct rseq_cs
> >>>>> works and does not lead to process kills.
> >>>>>
> >>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>>> Cc: Ingo Molnar <mingo@redhat.com>
> >>>>> Cc: Borislav Petkov <bp@alien8.de>
> >>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >>>>> Cc: x86@kernel.org
> >>>>> Cc: linux-kernel@vger.kernel.org
> >>>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >>>>>
> >>>>> ---
> >>>>> Changes in v5:
> >>>>>     - Use static for variables/functions
> >>>>>     - Use RSEQ_READ/WRITE_ONCE instead of volatile
> >>>>>
> >>>>> Changes in v4:
> >>>>>     - Added Fixes tag
> >>>>>
> >>>>> Changes in v3:
> >>>>>     - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>>>     - rework the test to work when only pkey 0 is supported for rseq
> >>>>>
> >>>>> Changes in v2:
> >>>>>     - change test to install protected rseq_cs instead of rseq
> >>>>> ---
> >>>>>     tools/testing/selftests/rseq/Makefile    |  2 +-
> >>>>>     tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
> >>>>>     tools/testing/selftests/rseq/rseq.h      |  1 +
> >>>>>     3 files changed, 100 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> >>>>> index 5a3432fceb586..9111d25fea3af 100644
> >>>>> --- a/tools/testing/selftests/rseq/Makefile
> >>>>> +++ b/tools/testing/selftests/rseq/Makefile
> >>>>> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
> >>>>>
> >>>>>     TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
> >>>>>                 param_test_benchmark param_test_compare_twice param_test_mm_cid \
> >>>>> -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> >>>>> +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
> >>>>>
> >>>>>     TEST_GEN_PROGS_EXTENDED = librseq.so
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> >>>>> new file mode 100644
> >>>>> index 0000000000000..cc4dd98190942
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/rseq/pkey_test.c
> >>>>> @@ -0,0 +1,98 @@
> >>>>> +// SPDX-License-Identifier: LGPL-2.1
> >>>>> +/*
> >>>>> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
> >>>>> + */
> >>>>> +
> >>>>> +#define _GNU_SOURCE
> >>>>> +#include <err.h>
> >>>>> +#include <errno.h>
> >>>>> +#include <stdio.h>
> >>>>> +#include <stdlib.h>
> >>>>> +#include <string.h>
> >>>>> +#include <sys/mman.h>
> >>>>> +#include <sys/syscall.h>
> >>>>> +#include <ucontext.h>
> >>>>> +#include <unistd.h>
> >>>>> +
> >>>>> +#include "rseq.h"
> >>>>> +#include "rseq-abi.h"
> >>>>> +
> >>>>> +static int pkey;
> >>>>> +static ucontext_t ucp0, ucp1;
> >>>>> +
> >>>>> +static void coroutine(void)
> >>>>> +{
> >>>>> +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
> >>>>> +     /*
> >>>>> +      * When we disable access to pkey 0, globals and TLS become
> >>>>> +      * inaccessible too, so we need to tread carefully.
> >>>>> +      * Pkey is global so we need to copy it onto the stack.
> >>>>> +      */
> >>>>> +     int pk = RSEQ_READ_ONCE(pkey);
> >>>>> +     struct timespec ts;
> >>>>> +
> >>>>> +     orig_pk0 = pkey_get(0);
> >>>>> +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
> >>>>> +             err(1, "pkey_set failed");
> >>>>> +     old_pk0 = pkey_get(0);
> >>>>> +     old_pk1 = pkey_get(pk);
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Prevent compiler from initializing it by loading a 16-global.
> >>>>> +      */
> >>>>> +     RSEQ_WRITE_ONCE(ts.tv_sec, 0);
> >>>>> +     RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
> >>>>> +     /*
> >>>>> +      * If the kernel misbehaves, context switches in the following loop
> >>>>> +      * will terminate the process with SIGSEGV.
> >>>>> +      * Trigger preemption w/o accessing TLS.
> >>>>> +      * Note that glibc's usleep touches errno always.
> >>>>> +      */
> >>>>> +     for (i = 0; i < 10; i++)
> >>>>> +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
> >>>>> +
> >>>>> +     pk0 = pkey_get(0);
> >>>>> +     pk1 = pkey_get(pk);
> >>>>> +     if (pkey_set(0, orig_pk0))
> >>>>> +             err(1, "pkey_set failed");
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Ensure that the kernel has restored the previous value of pkeys
> >>>>> +      * register after changing them.
> >>>>> +      */
> >>>>> +     if (old_pk0 != pk0)
> >>>>> +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
> >>>>> +     if (old_pk1 != pk1)
> >>>>> +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
> >>>>> +
> >>>>> +     swapcontext(&ucp1, &ucp0);
> >>>>> +     abort();
> >>>>> +}
> >>>>> +
> >>>>> +int main(int argc, char **argv)
> >>>>> +{
> >>>>> +     pkey = pkey_alloc(0, 0);
> >>>>> +     if (pkey == -1) {
> >>>>> +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> >>>>> +                     strerror(errno));
> >>>>> +             return 0;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (rseq_register_current_thread())
> >>>>> +             err(1, "rseq_register_current_thread failed");
> >>>>> +
> >>>>> +     if (getcontext(&ucp1))
> >>>>> +             err(1, "getcontext failed");
> >>>>> +     ucp1.uc_stack.ss_size = getpagesize() * 4;
> >>>>> +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
> >>>>> +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> >>>>> +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
> >>>>> +             err(1, "mmap failed");
> >>>>> +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
> >>>>> +                     PROT_READ | PROT_WRITE, pkey))
> >>>>> +             err(1, "pkey_mprotect failed");
> >>>>> +     makecontext(&ucp1, coroutine, 0);
> >>>>> +     if (swapcontext(&ucp0, &ucp1))
> >>>>> +             err(1, "swapcontext failed");
> >>>>
> >>>> Should the rseq register be paired with a rseq unregister here ?
> >>>
> >>> I dunno. It's necessary for this test and in general. Tcmalloc won't
> >>> unregister on thread exit. Even for a libc it may be a bad idea due to
> >>> signals.
> >>
> >> The rseq register/unregister is only for the case where libc does not
> >> support rseq. But if you want to use rseq_register_current_thread(),
> >> then you'll want to pair it with unregister.
> >
> > Why? Isn't it better to have tests more realitic?
>
> If you use rseq.c rseq_register_current_thread without
> rseq_unregister_current_thread, then you rely on implicit
> unregistration done by the kernel at thread exit.
>
> Then you need to ensure your userspace runtime keep the TLS
> that holds the rseq area allocated for the entire execution
> of the thread until it exits in the kernel. Note that
> disabling signals is not sufficient to prevent the kernel
> from accessing the rseq area.
>
> GNU libc gets away with automatic unregistration at
> thread exit because it completely controls the lifetime
> of the registered rseq area, keeping it allocated for as
> long as the thread is executing.
>
> So in order to minimize the dependency on specific libc
> behavior in the kernel sefltests, the selftests rseq.h
> requires explicit registration *and* unregistration.

If libc registers rseq (!rseq_ownership), then
rseq_unregister_current_thread is a no-op. And if libc has not
registered rseq, then we are not relying on any libc behavior. I don't
see how calling rseq_unregister_current_thread helps to rely less on
libc. Am I missing something?




> Thanks,
>
> Mathieu
>
>
> >
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>>
> >>>> Thanks,
> >>>>
> >>>> Mathieu
> >>>>
> >>>>> +     return 0;
> >>>>> +}
> >>>>> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> >>>>> index ba424ce80a719..65da4a727c550 100644
> >>>>> --- a/tools/testing/selftests/rseq/rseq.h
> >>>>> +++ b/tools/testing/selftests/rseq/rseq.h
> >>>>> @@ -8,6 +8,7 @@
> >>>>>     #ifndef RSEQ_H
> >>>>>     #define RSEQ_H
> >>>>>
> >>>>> +#include <assert.h>
> >>>>>     #include <stdint.h>
> >>>>>     #include <stdbool.h>
> >>>>>     #include <pthread.h>
> >>>>
> >>>>
> >>>> --
> >>>> Mathieu Desnoyers
> >>>> EfficiOS Inc.
> >>>> https://www.efficios.com
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

