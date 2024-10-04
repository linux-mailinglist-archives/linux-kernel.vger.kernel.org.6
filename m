Return-Path: <linux-kernel+bounces-350059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B252E98FF38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A051C21608
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D793146588;
	Fri,  4 Oct 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiWfhPqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549D13A257
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032525; cv=none; b=GSkSB8TIlQAgStLniMAdeZKk05P0v+WBaM99nSAhdg3BqjgXGkvQMhXZR3q5+eHTSGHCK1aRqB4bqGneNhce7veqKt3E6ly9msMq57YV+9CZtJOGTMd0egxhMboAapDSp94xj7cnK4y3kLukGAq/PtdQ7Z3c6n5ar7mslvlipGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032525; c=relaxed/simple;
	bh=K6RjSowYDV8x8lw781oPwNYuDXn1WNFaXKuNUq8iXHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLebi+jdoOn60kbQaJYXNd5F4tR27hLaqyetWKAAL7Ak7WG+P+nArxq9iqijLn2PlsQIM88AcRATz2KuD2q+9jJVlFczyH5qYxVRz3ceZCTRpPkfXRaW21LlvMs2lhk2wf5ufoVTrCRfJbVwGblrjxpLptPlPuSFePoKhuSfMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiWfhPqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+3eo4iK9z7/n8Wmk//3sJ9t56oZ2LuK5IcguLduS5A=;
	b=GiWfhPqXxSkVFaUkAqbVIjybBFmqPM6ZK5d8VWRWUtBji+q3CkDFtfwOuqgTFbh1SJCQak
	B82iiJoXMqnae/pEnHyMK0jmYzkIT4XsJLVAb40kR2Xic48CyR3+/P7g53rJdbiZ3JrNvT
	QXUxTp/7KaH4BkDoAEhEAPXbtK9GiJY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-yWqidI3POuK0VIVKORT9Sw-1; Fri, 04 Oct 2024 05:02:00 -0400
X-MC-Unique: yWqidI3POuK0VIVKORT9Sw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so14504445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032519; x=1728637319;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+3eo4iK9z7/n8Wmk//3sJ9t56oZ2LuK5IcguLduS5A=;
        b=AJKUI7OTdG9g6PfMrb6+cuDsuh0fuS53fq2uRplWm609vXLlLzYjB2WzoC1LQz9/fq
         BEvyCYkRiLzwJ0HD6oeJ9saikfF7c6lE0xicXI5Xdv9QVIqXnFTLzrGlOvnKcfBoOYrf
         lpvXi2gCDL2Nt2zf4Gg6V8WiYrsRVmkZz4Iu9blDhKKXA/kD0y4qWedSLa5GjodD0GJb
         xykM3Xd+UWTFJ3QRj291byZrWLVe3Mz5POS8vDHAGoUVwlgy72n6kHtNDhlfkIOhm6A0
         //WISNYmkwlL5CoNqtUmi84mvb+aW1yssQoOap7AWYnIxagttebjyjYSMDA2YXOfJFNU
         FxyA==
X-Forwarded-Encrypted: i=1; AJvYcCWivhPNgbQFmncEiFo13ZL0qJ6dq2p4jBQArsPRw+RsEs4qTVszPGL14Uli206NG0LJGLLiBSo4HjF5zRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KHZm/BCt+4tNtIOAF1SnkgrEi10W0AJUDwEYXj1Y7LymIekV
	QIGfPQheR0kQQddI2WHYLBgfD4z1YRNBpAc7p5j3dh4YB1wGFTXJiPOlYDmlTV8FWUr/vnTL3Pg
	THeX3ilJPAPfB0Cqan/Uem1I+srNj/5//AdEj5RtgJzTLISRc4UrtunOOg9KAO9JpyKNA3P4hoX
	tXDT6Fg88pBu7ge06fae8s+emZNcpimoYJOkF9QK6we7F3xQ==
X-Received: by 2002:a05:600c:3b85:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42f85a70062mr14437735e9.2.1728032518665;
        Fri, 04 Oct 2024 02:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRonOhr++6qnkM35HJn1KTHsg8KzsNVLzBVT4yx85Do+FJx0SSL2WjQVeFN2IB7BmwcXR7w==
X-Received: by 2002:a05:600c:3b85:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42f85a70062mr14437415e9.2.1728032518178;
        Fri, 04 Oct 2024 02:01:58 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm2813849f8f.90.2024.10.04.02.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:01:57 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] KVM: selftests: Configure XCR0 to max supported
 value by default
In-Reply-To: <20241003234337.273364-6-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-6-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:01:56 +0200
Message-ID: <87v7y8i6m3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> To play nice with compilers generating AVX instructions, set CR4.OSXSAVE
> and configure XCR0 by default when creating selftests vCPUs.  Some distros
> have switched gcc to '-march=x86-64-v3' by default, and while it's hard to
> find a CPU which doesn't support AVX today, many KVM selftests fail with
>
>   ==== Test Assertion Failure ====
>     lib/x86_64/processor.c:570: Unhandled exception in guest
>     pid=72747 tid=72747 errno=4 - Interrupted system call
>     Unhandled exception '0x6' at guest RIP '0x4104f7'
>
> due to selftests not enabling AVX by default for the guest.  The failure
> is easy to reproduce elsewhere with:
>
>    $ make clean && CFLAGS='-march=x86-64-v3' make -j && ./x86_64/kvm_pv_test
>
> E.g. gcc-13 with -march=x86-64-v3 compiles this chunk from selftests'
> kvm_fixup_exception():
>
>         regs->rip = regs->r11;
>         regs->r9 = regs->vector;
>         regs->r10 = regs->error_code;
>
> into this monstronsity (which is clever, but oof):
>
>   405313:       c4 e1 f9 6e c8          vmovq  %rax,%xmm1
>   405318:       48 89 68 08             mov    %rbp,0x8(%rax)
>   40531c:       48 89 e8                mov    %rbp,%rax
>   40531f:       c4 c3 f1 22 c4 01       vpinsrq $0x1,%r12,%xmm1,%xmm0
>   405325:       49 89 6d 38             mov    %rbp,0x38(%r13)
>   405329:       c5 fa 7f 45 00          vmovdqu %xmm0,0x0(%rbp)
>
> Alternatively, KVM selftests could explicitly restrict the compiler to
> -march=x86-64-v2, but odds are very good that punting on AVX enabling will
> simply result in tests that "need" AVX doing their own thing, e.g. there
> are already three or so additional cleanups that can be done on top.

Ideally, we may still want to precisely pin the set of instructions
which are used to generete guest code in selftests as the environment
where this code runs is defined by us and it may not match the host. I
can easily imaging future CPU features leading to similar issues in case
they require explicit enablement. To achive this, we can probably
separate guest code from each test into its own compilation unit.

>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Closes: https://lore.kernel.org/all/20240920154422.2890096-1-vkuznets@redhat.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  |  5 ++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 24 +++++++++++++++++++
>  .../selftests/kvm/x86_64/xcr0_cpuid_test.c    |  6 ++---
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index e247f99e0473..645200e95f89 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1049,6 +1049,11 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
>  	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
>  }
>  
> +static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
> +{
> +	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
> +}
> +
>  void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
>  			     struct kvm_x86_cpu_property property,
>  			     uint32_t value);
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 974bcd2df6d7..636b29ba8985 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -506,6 +506,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  
>  	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
>  	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> +		sregs.cr4 |= X86_CR4_OSXSAVE;
>  	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
>  
>  	kvm_seg_set_unusable(&sregs.ldt);
> @@ -519,6 +521,20 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  	vcpu_sregs_set(vcpu, &sregs);
>  }
>  
> +static void vcpu_init_xcrs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_xcrs xcrs = {
> +		.nr_xcrs = 1,
> +		.xcrs[0].xcr = 0,
> +		.xcrs[0].value = kvm_cpu_supported_xcr0(),
> +	};
> +
> +	if (!kvm_cpu_has(X86_FEATURE_XSAVE))
> +		return;
> +
> +	vcpu_xcrs_set(vcpu, &xcrs);
> +}
> +
>  static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
>  			  int dpl, unsigned short selector)
>  {
> @@ -675,6 +691,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>  	vcpu_init_sregs(vm, vcpu);
> +	vcpu_init_xcrs(vm, vcpu);
>  
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
> @@ -686,6 +703,13 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  	mp_state.mp_state = 0;
>  	vcpu_mp_state_set(vcpu, &mp_state);
>  
> +	/*
> +	 * Refresh CPUID after setting SREGS and XCR0, so that KVM's "runtime"
> +	 * updates to guest CPUID, e.g. for OSXSAVE and XSAVE state size, are
> +	 * reflected into selftests' vCPU CPUID cache, i.e. so that the cache
> +	 * is consistent with vCPU state.
> +	 */
> +	vcpu_get_cpuid(vcpu);
>  	return vcpu;
>  }
>  
> diff --git a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> index 95ce192d0753..a4aecdc77da5 100644
> --- a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> @@ -48,16 +48,16 @@ do {									\
>  
>  static void guest_code(void)
>  {
> -	uint64_t xcr0_reset;
> +	uint64_t initial_xcr0;
>  	uint64_t supported_xcr0;
>  	int i, vector;
>  
>  	set_cr4(get_cr4() | X86_CR4_OSXSAVE);
>  
> -	xcr0_reset = xgetbv(0);
> +	initial_xcr0 = xgetbv(0);
>  	supported_xcr0 = this_cpu_supported_xcr0();
>  
> -	GUEST_ASSERT(xcr0_reset == XFEATURE_MASK_FP);
> +	GUEST_ASSERT(initial_xcr0 == supported_xcr0);
>  
>  	/* Check AVX */
>  	ASSERT_XFEATURE_DEPENDENCIES(supported_xcr0,

Reviewed-and-tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly


