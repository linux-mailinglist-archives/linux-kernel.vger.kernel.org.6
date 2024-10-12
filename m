Return-Path: <linux-kernel+bounces-361985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E199AFAB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4238B22499
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B5A92D;
	Sat, 12 Oct 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqqkBGVz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE104C80
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728692511; cv=none; b=pPnI28EVNL7AHQOuvwReox6Sv6KCkgtklhV8b0CSoALrlEDf2agsrdqSWUkG/kNvcEDJb8QBjF5cZ0ZRScOZyvU1ENniIoAN40b2tZnh/4kqGcdOHl+S4M179kH8z95IBkwujjXqmVNT8SNcJUmkrTd801f90bUC+63VvPO2dW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728692511; c=relaxed/simple;
	bh=DQ+hL4n7ns/jcpxR+c9OE6/V7v4D7xpS5MVAdpJyYck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNUZdvHxXYVTDsDMkXBmkbQtENlc4qLMpDFN0l6ia3AmlCD74KxjOz4iYfgvxdckQVQ/4wdwlHTsK04D2jtygLiSFzzJ7nayXk5jUrJ6jxoJuu1w4P5QA20Tb7vo9a4EaVxHPvRS/g88NRpxfPswOFfifCXjFf/GLcpxFCgbRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqqkBGVz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3705b2883so202037b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728692508; x=1729297308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=80TYEvDINN/ZhWp27g0pSsVe8yEUOU5CnuEFxk9tjSI=;
        b=YqqkBGVz0hUOc73PsfKna1WygeWXA87XyedKiQTg3r8v7lSE7ythGqmzqLsWavwDHL
         RqfQLRAVduhXX0WtbKd1HNCiPH4ZFdSpXZY54mkc47tMV+ZYH9Tk2X2V/5xjQ09KVwt6
         u+snJ7Q4Iq6VG9qmYfH3v2any6LR7W5HhjdXpv1/pzGCVKYVdPNtBTZ77NpUJiftW7pn
         2sfnLKFuIsk53GYrG0yqkC4mVn+HetN3HR2V01Ue5ncodhS8WPae4/6e+i6YZo+UyGbW
         smcgpXZ3tkevSe/HfS0jYsKkr/ahO+LoBCuCnMNT4cevCRLGQWxabEA8j0Kby7KQ+SVE
         gJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728692508; x=1729297308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80TYEvDINN/ZhWp27g0pSsVe8yEUOU5CnuEFxk9tjSI=;
        b=PdL7B1sDBZ2aQRZnH8d0DY3DHUy6foXU/ZLpINNZiq+XbdGsPQBK+9GvmvIZBIKcdl
         84UJ6tly89aBE8sbwk3sYc9VwRHV0Bvq75Z1zwCr9inZZ4+IS7MwHh6mawDiN/4VVk21
         K8sBsSNfm14NlNyqEGkC6HRvQv5JErNxMI4sqQHvmq49qH35TXfnWpVNG0WpEtuikPum
         uL2tMAgGYkhq1UiqRqP+61YyWJC4Rlrrs/VS+b8e/0wioAv2QX2xJrBAWAeLrKkvGE7S
         4s5NfvhcsMuaCaeH189gnHtvtvm70j7B1u+usGkVSHOjI4FImVwsiHztZ+HLa8pqLQ9H
         UObQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/lWdhY+xRzXwvR/SYctg0IYf0v2VRzdbP6heArPjS0Vde0nyEad5EE9+Tvt8NRixc5hdlipnf/vRW8QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGjbN6Zcmc9DI+nakYSCZsb1yANW3EH8WdH/BpkWtYyQB344R
	XDU+aKkNFmHnJJYKEiO+kQwQB72BLKgO5fOaED+8zrPWWEaA96TC9U5ceyBOX/kGN1FuHw8xgoE
	/GA==
X-Google-Smtp-Source: AGHT+IE8twxV/hbdB3uHbG/bVu0SKqde502fj8APO5J/UtbrdZWgVevUlaIfsNjN+xe1tgDO/X2eQBAwzOk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:748e:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e2919fe7a06mr2445276.8.1728692507770; Fri, 11 Oct 2024 17:21:47
 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:21:46 -0700
In-Reply-To: <20240927161657.68110-4-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-4-iorlov@amazon.com>
Message-ID: <ZwnBGtdbvmKHc4in@google.com>
Subject: Re: [PATCH 3/3] selftests: KVM: Add test case for MMIO during event delivery
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 27, 2024, Ivan Orlov wrote:
> Extend the 'set_memory_region_test' with a test case which covers the
> MMIO during event delivery error handling. The test case
> 
> 1) Tries to set an IDT descriptor base to point to an MMIO address
> 2) Generates a #GP
> 3) Verifies that we got a correct exit reason (KVM_EXIT_INTERNAL_ERROR)
>    and suberror code (KVM_INTERNAL_ERROR_DELIVERY_EV)
> 4) Verifies that we got a corrent "faulty" GPA in internal.data[3]
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
>  .../selftests/kvm/set_memory_region_test.c    | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index a8267628e9ed..e9e97346edf1 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -553,6 +553,51 @@ static void test_add_overlapping_private_memory_regions(void)
>  	close(memfd);
>  	kvm_vm_free(vm);
>  }
> +
> +static const struct desc_ptr faulty_idt_desc = {
> +	.address = MEM_REGION_GPA,
> +	.size = 0xFFF,
> +};

There's no reason this needs to be global, i.e. declare it in the function, on
the stack.

> +
> +static void guest_code_faulty_idt_desc(void)
> +{
> +	__asm__ __volatile__("lidt %0"::"m"(faulty_idt_desc));

It's not "faulty".  It specifically points at MMIO.  That is _very_ different
than a "faulty" address, because an actual fault when vectoring an event would
lead to triple fault shutdown.  And a benefit of declaring the descriptor locally
is that you don't need to come up with a descriptive name :-) E.g.

	const struct desc_ptr idt_desc = {
		.address = MEM_REGION_GPA,
		.size = 0xfff,
	};

And it's probably worth adding a lidt() helper in processor.h (in a separate
commit, because there's two other users that can be converted when it's added).

> +
> +	/* Generate a #GP by dereferencing a non-canonical address */
> +	*((uint8_t *)0xDEADBEEFDEADBEEFULL) = 0x1;

Hmm, I could have sworn KVM-Unit-Tests' NONCANONICAL got pulled into selftests.
Please do that as part of the test, e.g. add this to processor.h

#define NONCANONICAL	0xaaaaaaaaaaaaaaaaull

> +
> +	/* We should never reach this point */

No pronouns.  Yes, it's nitpicky, but "we" gets _very_ ambiguous when "we" could
mean the admin, the user, the VMM, KVM, the guest, etc.

> +	GUEST_ASSERT(0);
> +}
> +
> +/*
> + * This test tries to point the IDT descriptor base to an MMIO address.

There is no try.  Do, or do not :-)

Translation: just state what the code does, don't hedge.

> This action

Wrap at 89.

> + * should cause a KVM internal error, so the VMM could handle such situations gracefully.

Heh, don't editorialize what a VMM might do in comments.  For changelogs it's
often helpful, as it provides justification and context for _why_ that is the
behavior.  But for a selftest, just state what KVM's ABI is.  E.g. I guarantee
there are plenty of VMMs that don't handle this situation gracefully :-)

> + */
> +static void test_faulty_idt_desc(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	pr_info("Testing a faulty IDT descriptor pointing to an MMIO address\n");
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code_faulty_idt_desc);
> +	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 1);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
> +	TEST_ASSERT(vcpu->run->internal.suberror == KVM_INTERNAL_ERROR_DELIVERY_EV,
> +		    "Unexpected suberror = %d", vcpu->run->internal.suberror);
> +	TEST_ASSERT(vcpu->run->internal.ndata > 4, "Unexpected internal error data array size = %d",
> +		    vcpu->run->internal.ndata);

Capture "run", or maybe event "internal" in a local variable.  Doing so will
shorten these lines and make the code easier to read.  I'd probably vote for
grabbing "internal" since TEST_ASSERT_KVM_EXIT_REASON() takes care of asserting
on the bits outside of "internal".

> +	/* The "faulty" GPA address should be = IDT base + offset of the GP vector */

GPA address is redundant.  GPA is Guest Physical Address.

Again, avoid "faulty".  "reported" works nicely.  And try not to mix code with
human language (though it's ok for math, e.g. the '+' is totally fine and
preferred).  The '=' is hard to read because it looks like a typo.  And in this
case, there's no need to actually say "equal to".  And similar to writing changelogs
for humans instead of giving a play-by-play of the code, do the same for comments, e.g.

	/* The reported GPA should be the address of the #GP entry in the IDT. */

> +	TEST_ASSERT(vcpu->run->internal.data[3] == MEM_REGION_GPA +
> +		    GP_VECTOR * sizeof(struct idt_entry),

Put the math on one line, i.e.

		    vcpu->run->internal.data[3] ==
		    MEM_REGION_GPA + GP_VECTOR * sizeof(struct idt_entry),

> +		    "Unexpected GPA = %llx", vcpu->run->internal.data[3]);

Print what GPA was expected, so that the user doesn't have to manually figure
that out.

> +
> +	kvm_vm_free(vm);
> +}
>  #endif
>  
>  int main(int argc, char *argv[])
> @@ -568,6 +613,7 @@ int main(int argc, char *argv[])
>  	 * KVM_RUN fails with ENOEXEC or EFAULT.
>  	 */
>  	test_zero_memory_regions();
> +	test_faulty_idt_desc();
>  #endif
>  
>  	test_invalid_memory_region_flags();
> -- 
> 2.43.0
> 

