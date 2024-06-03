Return-Path: <linux-kernel+bounces-199506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB018D87DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AFF285402
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B42136E39;
	Mon,  3 Jun 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+6qR2EH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D978283
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435507; cv=none; b=sRVYo/kUGWMdUnstq6/gwaTjbKUD96/zKqJei6ZmDfzqXMQyX0H8mM+up7+WfWqA5uPSg4ylIcCWpcAgC6nhaNs8YYPhAz1NxlOLQ5i9oCZeU6pgtMoW5lk+cHWWmTiNGUEMJsjXF/bcEtSsj+/2TPAznpayTgSHsnF20XZiQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435507; c=relaxed/simple;
	bh=NfQFmHLQ9shxbIA7d2arj8pts8fHfOHHhoWHnlN8OD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2YAcetApMwy4RCqQjBDtf6NjcP9aU3rJryfwoer9n7Ks+ygcOo9JfkxR9CDhLbfbU1foXLacAilmH3hJQfT+2POTZRgQK2uZpxoi3+k4f5MI0zTKKjiC0dr/iYjaP0Vn+T5KrFGMmwEA5MgQ62fGrxr/JlVl9YkbZ/fyok5h7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+6qR2EH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a27e501d4so2927037b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717435505; x=1718040305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJyUAlqpuYEaJF6Nwe4vJ3fr4OIvEC2ccjgFqYcQri8=;
        b=J+6qR2EHBZPQ8JEgRDYR/TcyUBiZR3B9UZzeUjwl50Ibh3w6zf5hZK5HI1gtaPCkWl
         Y2TL/AgxhRfSsaAi8rFYLYIjbh5j6Cpwpe9ivh9tDaawnzQC0YsSNLT43Yfz6fTySKD5
         jN7aXjitpaD4xRZLZgXREDi8DQ8fLlt5225l2GvRJqNPuRG2lWclZ2FklSmpHteS9AGX
         tQuQIDjwuEPyUMoeI0lpnOGWwJhKcp7AR+m1F+TyKp3BTjwelg3En7RyE0r8NbPMBHWo
         A/qPX/Z4Xbo4a8j6f1pMqFWkGsr/e2ibKismdPHxXDjQeeKCqlrEkUGjDFGABKzSLD4p
         0DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717435505; x=1718040305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJyUAlqpuYEaJF6Nwe4vJ3fr4OIvEC2ccjgFqYcQri8=;
        b=KFFYCLTzDXTcoQwh6qm47PKb2wc/Y/+09XVbN8bS4fKCg/2V2fklQq9izhq4shesqX
         qFhnvIym5+uZFecACi7RroOhtNxzIahrCBowKs4wqVudIbCw2P9sqEEskiaztkhza2ij
         slpy3ZMfVNIclYsUpWooQpiQ4r8OL4QbIOH1pbpyjFVDDLXxDPXZoOR5JPbEuYdTtcek
         IMyvkTz2FM7X65BpehAxuppTccWKI1VADfJCCy4btkUW4ktNvO1owAwgGGPJnyPX6i/q
         qLGY/zlIb4bGYThPIf8sPFyz3muB5FeOaDjQ90Gsw79NBR4SvmHkfERzO3b6XQAZ4Vvn
         uwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv9wyIz9fW9q5WcCJjsmqnIO9928rXNH3722gA5gVN8zW9KOyXz50COG2l+vhM6f228Hux9khHgG7Btg6hJrWcKkMtrRfipbxyR2MB
X-Gm-Message-State: AOJu0Ywhjcs467EDdfu1LUT1JaXVGDToDeZX3fFbt9+XpDKyi1o2ZU6F
	BjK7jDl52bJxLBZIQER4jJfOSY91i/moov+weFuVUfw1i4eUV89zv36PzhCnJV8m/4+aNAbk+0R
	j3w==
X-Google-Smtp-Source: AGHT+IHIe8ga2jAqd0hP2AuciJDwxJhPSKiPkQ/wlXrjkIvtZ7H/rei4YEFUJU2Gm1PaTMlcVIF5dUcNj2E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:708:b0:df7:9609:4ce2 with SMTP id
 3f1490d57ef6-dfa73d8da89mr726894276.8.1717435505040; Mon, 03 Jun 2024
 10:25:05 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:25:03 -0700
In-Reply-To: <eac8c5e0431529282e7887aad0ba66506df28e9e.1714081726.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1714081725.git.reinette.chatre@intel.com> <eac8c5e0431529282e7887aad0ba66506df28e9e.1714081726.git.reinette.chatre@intel.com>
Message-ID: <Zl38b3lxLpoBj7pZ@google.com>
Subject: Re: [PATCH V5 4/4] KVM: selftests: Add test for configure of x86 APIC
 bus frequency
From: Sean Christopherson <seanjc@google.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, jmattson@google.com, 
	mlevitsk@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 25, 2024, Reinette Chatre wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Test if the APIC bus clock frequency is the expected configured value.

This is one of the cases where explicitly calling out "code" by name is extremely
valuable.  E.g.

    Test if KVM emulates the APIC bus clock at the expected frequency when
    userspace configures the frequency via KVM_CAP_X86_APIC_BUS_CYCLES_NS.
    
    Set APIC timer's initial count to the maximum value and busy wait for 100
    msec (largely arbitrary) using the TSC. Read the APIC timer's "current
    count" to calculate the actual APIC bus clock frequency based on TSC
    frequency.

> Set APIC timer's initial count to the maximum value and busy wait for 100
> msec (any value is okay) with TSC value. Read the APIC timer's "current
> count" to calculate the actual APIC bus clock frequency based on TSC
> frequency.
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> new file mode 100644
> index 000000000000..5100b28228af
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test configure of APIC bus frequency.
> + *
> + * Copyright (c) 2024 Intel Corporation
> + *
> + * To verify if the APIC bus frequency can be configured this test starts
> + * by setting the TSC frequency in KVM, and then:
> + * For every APIC timer frequency supported:
> + * * In the guest:
> + * * * Start the APIC timer by programming the APIC TMICT (initial count
> + *       register) to the largest value possible to guarantee that it will
> + *       not expire during the test,
> + * * * Wait for a known duration based on previously set TSC frequency,
> + * * * Stop the timer and read the APIC TMCCT (current count) register to
> + *       determine the count at that time (TMCCT is loaded from TMICT when
> + *       TMICT is programmed and then starts counting down).
> + * * In the host:
> + * * * Determine if the APIC counts close to configured APIC bus frequency
> + *     while taking into account how the APIC timer frequency was modified
> + *     using the APIC TDCR (divide configuration register).

I find the asterisks super hard to parse.  And I honestly wouldn't bother breaking
things down by guest vs. host.  History has shown that file comments that are *too*
specific eventually become stale, often sooner than later.  E.g. it's entirely
feasible to do the checking in the guest, not the host.

How about this?

/*
 * Copyright (c) 2024 Intel Corporation
 *
 * Verify KVM correctly emulates the APIC bus frequency when the VMM configures
 * the frequency via KVM_CAP_X86_APIC_BUS_CYCLES_NS.  Start the APIC timer by
 * programming TMICT (timer initial count) to the largest value possible (so
 * that the timer will not expire during the test).  Then, after an arbitrary
 * amount of time has elapsed, verify TMCCT (timer current count) is within 1%
 * of the expected value based on the time elapsed, the APIC bus frequency, and
 * the programmed TDCR (timer divide configuration register).
 */

> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */

This can now be dropped.

> +#include "apic.h"
> +#include "test_util.h"
> +
> +/*
> + * Pick one convenient value, 1.5GHz. No special meaning and different from
> + * the default value, 1GHz.

I have no idea where the 1GHz comes from.  KVM doesn't force a default TSC, KVM
uses the underlying CPU's frequency.  Peeking further ahead, I don't understand
why this test sets KVM_SET_TSC_KHZ.  That brings in a whole different set of
behavior, and that behavior is already verified by tsc_scaling_sync.c.

I suspect/assume this test forces a frequency so that it can hardcode the math,
but (a) that's odd and (b) x86 selftests really should provide a udelay() so that
goofy stuff like this doesn't end up in random tests.

> + */
> +#define TSC_HZ			(1500 * 1000 * 1000ULL)

Definitely do not call this TSC_HZ.  Yeah, it's local to this file, but defining
generic macros like this is just asking for conflicts, and the value itself has
nothing to do with the TSC (it's a raw value).  E.g. _if_ we need to keep this,
something like

  #define FREQ_1_5_GHZ		(1500 * 1000 * 1000ULL)

> +
> +/* Wait for 100 msec, not too long, not too short value. */
> +#define LOOP_MSEC		100ULL
> +#define TSC_WAIT_DELTA		(TSC_HZ / 1000 * LOOP_MSEC)

These shouldn't exist.


> +
> +/*
> + * Pick a typical value, 25MHz. Different enough from the default value, 1GHz.
> + */
> +#define APIC_BUS_CLOCK_FREQ	(25 * 1000 * 1000ULL)

Rather than hardcode a single frequency, use 25MHz as the default value but let
the user override it via command line.

> +	asm volatile("cli");

Unless I'm misremembering, the timer still counts when the LVT entry is masked
so just mask the IRQ in the LVT. Or rather, keep the entry masked in the LVT.

FWIW, you _could_ simply leave APIC_LVT0 at its default value to verify KVM
correctly emulates that reset value (masked, one-shot).  That'd be mildly amusing,
but possibly a net negative from readability, so

> +
> +	xapic_enable();

What about x2APIC?  Arguably that's _more_ interesting since it's required for
TDX.

> +	/*
> +	 * Setup one-shot timer.  The vector does not matter because the
> +	 * interrupt does not fire.

_should_ not fire.

> +	 */
> +	xapic_write_reg(APIC_LVT0, APIC_LVT_TIMER_ONESHOT);
> +
> +	for (i = 0; i < ARRAY_SIZE(tdcrs); i++) {
> +		xapic_write_reg(APIC_TDCR, tdcrs[i].tdcr);
> +
> +		/* Set the largest value to not trigger the interrupt. */
> +		tmict = ~0;
> +		xapic_write_reg(APIC_TMICT, tmict);
> +
> +		/* Busy wait for LOOP_MSEC */
> +		tsc0 = rdtsc();
> +		tsc1 = tsc0;
> +		while (tsc1 - tsc0 < TSC_WAIT_DELTA)
> +			tsc1 = rdtsc();
> +
> +		/* Read APIC timer and TSC */
> +		tmcct = xapic_read_reg(APIC_TMCCT);
> +		tsc1 = rdtsc();
> +
> +		/* Stop timer */
> +		xapic_write_reg(APIC_TMICT, 0);
> +
> +		/* Report it. */
> +		GUEST_SYNC_ARGS(tdcrs[i].divide_count, tmict - tmcct,
> +				tsc1 - tsc0, 0, 0);

Why punt to the host?  I don't see any reason why GUEST_ASSERT() wouldn't work
here.

> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +void test_apic_bus_clock(struct kvm_vcpu *vcpu)
> +{
> +	bool done = false;
> +	struct ucall uc;
> +
> +	while (!done) {
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			done = true;
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		case UCALL_SYNC: {
> +			u32 divide_counter = uc.args[1];
> +			u32 apic_cycles = uc.args[2];
> +			u64 tsc_cycles = uc.args[3];
> +			u64 freq;
> +
> +			TEST_ASSERT(tsc_cycles > 0,
> +				    "TSC cycles must not be zero.");
> +
> +			/* Allow 1% slack. */
> +			freq = apic_cycles * divide_counter * TSC_HZ / tsc_cycles;
> +			TEST_ASSERT(freq < APIC_BUS_CLOCK_FREQ * 101 / 100,
> +				    "APIC bus clock frequency is too large");
> +			TEST_ASSERT(freq > APIC_BUS_CLOCK_FREQ * 99 / 100,
> +				    "APIC bus clock frequency is too small");
> +			break;
> +		}
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +			break;
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_APIC_BUS_CYCLES_NS));
> +
> +	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
> +	vm_ioctl(vm, KVM_SET_TSC_KHZ, (void *)(TSC_HZ / 1000));
> +	/*
> +	 * KVM_CAP_X86_APIC_BUS_CYCLES_NS expects APIC bus clock rate in
> +	 * nanoseconds and requires that no vCPU is created.

Meh, I'd drop this comment.  It should be quite obvious that the rate is in
nanoseconds.  And instead of adding a comment for the vCPU creation, do
__vm_enable_cap() again _after_ creating a vCPU and verify it fails with -EINVAL.

> +	 */
> +	vm_enable_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS,
> +		      NSEC_PER_SEC / APIC_BUS_CLOCK_FREQ);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> +
> +	test_apic_bus_clock(vcpu);
> +	kvm_vm_free(vm);
> +}
> -- 
> 2.34.1
> 

