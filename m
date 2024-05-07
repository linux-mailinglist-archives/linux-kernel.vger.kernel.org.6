Return-Path: <linux-kernel+bounces-171238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D368BE1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096071F22200
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A20156F31;
	Tue,  7 May 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ui43uHGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8w0y+dl6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1776136E2D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083523; cv=none; b=EXrGQ7YVxGDnO+uhzTCsRgUBxPQoKluJNxGDUvr3t7ft3Ax1yUTuzfPfhpjctS6R2gWO3krPQK0o3KLa+zLvbd9n9whQqB8hkmlCyziLt+2ycPymgo+JnDSm4sblBGVVZ9UFo737WWaSThD8+bUS0vDMCzHhQLwtoxv3Hlih5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083523; c=relaxed/simple;
	bh=evoM9HlQylj/rDbf0qwmbUPfPsTLEivtg+tdPZK1vo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ll9PsZb1KAFnQW+QAMM1RBjOpWLAfSmZz9zZ+K43tTmq4pBnYJLSX5JxgDEHy+e4UqhIoLzfiOS3PWbLNgzb7aAmbvyi2xUsxTJzo83riFX6+NRMGr9M6+xJv/s46ELf8sTr1GXEZLHS4CmHJDGfcJPLOtTp2329CN7eYhW2Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ui43uHGL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8w0y+dl6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715083517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UnPCWk4i2wn0TymzaPNuxSfIYvJI91hTpddeSSjiCc=;
	b=ui43uHGLb5gr7sLC9i2K7/E++pot2RqhzpaikOCcUZyAzVJ99n0INmxYFHfOTTz+aJ4zE/
	XwpvD91cWLJh2uxHYMRopYljyO0ESflunAwMW9yufxzJr6fQlwqOnOjF6NSBNawjuO7l27
	TT5+3q0FlLJTD1XYnIxsQ+KeNoBVDnxZhSMd7cfJll6Wcv9v72eIhgXkwgCe9du/YSrA1w
	2aZFizSbu1VuaEhCRUPq0NHndZ6lLCmt0A0y3pcjLPESc/S5rjGIQ2mllXXfesTBqXVS1p
	i8UahD+v2/8yQ6ZJsOP8Rqjcgc378e7sv+EAkw8hmtWppT+ab6yTfPATc1bo4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715083517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UnPCWk4i2wn0TymzaPNuxSfIYvJI91hTpddeSSjiCc=;
	b=8w0y+dl6LXvvzYP/ipzyifHTwc4ec3x/eUXn8EYgBa4Ac2BGHMYrqLFZAFWYbmMESEcZrT
	zp49egnbexw5jrCQ==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
In-Reply-To: <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
Date: Tue, 07 May 2024 14:05:17 +0200
Message-ID: <875xvprfnm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:
> This commit adds a few new tests to exercise the signal handler flow,

"This commit" is equally useless as "This patch". See
Documentation/process/ and grep for "This patch".

> especially with pkey 0 disabled.
>
> Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   2 +
>  tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
>  .../selftests/mm/pkey_sighandler_tests.c      | 315 ++++++++++++++++++
>  tools/testing/selftests/mm/protection_keys.c  |  10 -
>  4 files changed, 327 insertions(+), 11 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index eb5f39a2668b..2f90344ad11e 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -82,6 +82,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
>  CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
>  
>  VMTARGETS := protection_keys
> +VMTARGETS := pkey_sighandler_tests
>  BINARIES_32 := $(VMTARGETS:%=%_32)
>  BINARIES_64 := $(VMTARGETS:%=%_64)
>  
> @@ -100,6 +101,7 @@ else
>  
>  ifneq (,$(findstring $(ARCH),ppc64))
>  TEST_GEN_FILES += protection_keys
> +TEST_GEN_FILES += pkey_sighandler_tests
>  endif
>  
>  endif
> diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
> index 1af3156a9db8..a0766e3d9ab6 100644
> --- a/tools/testing/selftests/mm/pkey-helpers.h
> +++ b/tools/testing/selftests/mm/pkey-helpers.h
> @@ -79,7 +79,16 @@ extern void abort_hooks(void);
>  	}					\
>  } while (0)
>  
> -__attribute__((noinline)) int read_ptr(int *ptr);
> +#define barrier() __asm__ __volatile__("": : :"memory")

#include <linux/compiler.h>

> +__attribute__((noinline)) int read_ptr(int *ptr)
> +{
> +	        /*
> +		 *          * Keep GCC from optimizing this away somehow
> +		 *                   */

That comment is completely malformatted.

> +	        barrier();
> +		        return *ptr;

White space damage.

> +
> +static inline __attribute__((always_inline)) long
> +syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
> +{

What for? syscall(2) provides exactly what you want, no?

> +	unsigned long ret;
> +	register long r10 asm("r10") = a4;
> +	register long r8 asm("r8") = a5;
> +	register long r9 asm("r9") = a6;
> +	asm volatile ("syscall"
> +		      : "=a"(ret)
> +		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
> +		      : "rcx", "r11", "memory");

Aside of that this breaks on 32-bit builds.

> +	return ret;
> +}
> +

> +static void *thread_segv_with_pkey0_disabled(void *ptr)
> +{
> +	/* Disable MPK 0 (and all others too) */
> +	__write_pkey_reg(0x55555555);
> +
> +        /* Segfault (with SEGV_MAPERR) */

Please use tabs for indentation. (All over the place)

> +	*(int *) (0x1) = 1;
> +	return NULL;
> +}
> +
> +/*
> + * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
> + * Note that the new thread stack and the alternate signal stack is
> + * protected by MPK 0.
> + */
> +static void test_sigsegv_handler_with_pkey0_disabled(void)
> +{
> +	struct sigaction sa;
> +
> +	sa.sa_flags = SA_SIGINFO;
> +
> +	sa.sa_sigaction = sigsegv_handler;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
> +		perror("sigaction");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(&siginfo, 0, sizeof(siginfo));
> +
> +	pthread_t thr;
> +	pthread_attr_t attr;
> +	pthread_attr_init(&attr);
> +	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> +
> +	pthread_create(&thr, &attr, thread_segv_with_pkey0_disabled, NULL);
> +
> +	pthread_mutex_lock(&mutex);
> +	while(siginfo.si_signo == 0)
> +		pthread_cond_wait(&cond, &mutex);
> +	pthread_mutex_unlock(&mutex);
> +
> +	assert(siginfo.si_signo == SIGSEGV);
> +	assert(siginfo.si_code == SEGV_MAPERR);
> +	assert(siginfo.si_addr == (void *)1);

This should not use assert(). This wants to use proper kselftest result
and exit mechanisms all over the place.

> +	printf("%s passed!\n", __func__);

Ditto for printf().

> +}
> +/*
> + * Verify that the sigsegv handler that uses an alternate signal stack
> + * is correctly invoked for a thread which uses a non-zero MPK to protect
> + * its own stack, and disables all other MPKs (including 0).
> + */
> +static void test_sigsegv_handler_with_different_pkey_for_stack(void)
> +{
> +	struct sigaction sa;
> +	static stack_t sigstack;
> +        void *stack;
> +	int pkey;
> +	int parentPid = 0;
> +	int childPid = 0;

No camel case please

> +int main(int argc, char *argv[])
> +{
> +	size_t i;

size_t? What's wrong with int?

> +
> +	for (i = 0; i < sizeof(pkey_tests)/sizeof(pkey_tests[0]); i++) {

                        ARRAY_SIZE() ?

> +		(*pkey_tests[i])();
> +	}

Pointless brackets.

Thanks,

        tglx

