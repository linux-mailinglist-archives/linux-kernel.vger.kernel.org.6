Return-Path: <linux-kernel+bounces-209116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3348902D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F55FB2315A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCE18AEA;
	Tue, 11 Jun 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiLFzm4w"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895515A5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065324; cv=none; b=sw1voDzrcvk7SC3qN4icupexlLMmVM06OChdl+ZLCAKb6Q23J0+o2VOklYBhDcHWBOQN+sQNFP8toAklHmZFCFY/aH2Vuv7RhCUOgnFvuS8K30pFjXl6Sd1TyIMEas8mmm2609/g727Xu78S4o/1ZKc9MR57lLl+V7MdIXzVx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065324; c=relaxed/simple;
	bh=oS1Hvez5sA7LSPE446f6TZ4Jeo1f2nqSdvepYSaw6dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDxwnbO5NwGh+EyZmh3Icogfv6oatIBm4v5Dgrk8nfmTW+hiUcMm/bx2pmUE+/GaSDhmh5Eqf6OrRZOjaASK/QUdIvgebsbXJKG53sYQVziD0yOUkleXoDkryW2BNR6MIleDUH3PVJ8u0kw+7v0M1N6jxD6W3zaIJx156aZA5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiLFzm4w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa77d54cd2so8093831276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718065321; x=1718670121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSfrTQEO+boV0tcg4fzpJ40AhwinPFP7IWz6IBIfER8=;
        b=CiLFzm4wROzC65YN0NiJocwCsp1VYlHntyCc4188A8ghF48vngND7ohMXBPQnM64q7
         LgJ0k3F62HMHUc0C7VDp3nwF0IR/UYTaPJXYLYJdAGnenSfmwbkrrTlIr1+8BAXYJB1Q
         zKq8AA2IN8+hwWfnSL3YwaI7+gVM1wZ1i7w/3tfaRFWI6JbPZYL8k9ObrLufrVU6qrYz
         xd6Sa85Nl4Cb9JGybe9nk8mgzYrTsI71ZeqOoTxk1fNtCS7xBB3+KXEHEV4FuiYebGPY
         lS4EIlw/dSfEqvupO93RwU+bddvGPkCVh7affQPTYLzyV/O6d3q7Jff0lQ0E9JkN492+
         zjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718065321; x=1718670121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSfrTQEO+boV0tcg4fzpJ40AhwinPFP7IWz6IBIfER8=;
        b=FD3KeXc3myAqO6MtlQ/4cKqyu58LROrg8T98KidouS8VF5WjEtHJurnroFZx6gtsem
         EL264PXQXqgvF+OADkpxPAwRoZtB2V03X2oA0aznxYEtkQ3GDPW4xIJ48Uz0nU0zkrW2
         AF3bcjzPI30JJpYU1ZS782TYtwucTH+WwXMjyALDn0l5XgFq1PkSE83tklc7rq54WouS
         NPMhE/+8Ne9ShW4Nfdr0ZMWU89L7rkS2ZRHIxNTngI/yP6mGadus2AJdof2TMdtx3bM7
         vyQPGmyiRZg5oB1lhQ/f+t8Om9tUk/qgSHu/8rhxxMIMgljU/mbGK+dz4mj9OPnMukGF
         Ur5w==
X-Forwarded-Encrypted: i=1; AJvYcCVShrxs0oxfHmKg0F8zqtXZzKZI95/nAjrSmvR4EiFULD53nBGaZV6/6m6Hjxq9h5RHkYFsjvFvFuezMB9a8TdAQS7qmQsYJZvyeKqG
X-Gm-Message-State: AOJu0YxSX/vNaklEDsCwCqbPpUQXIfjGr/Ps1dItw0u3SZbJ1dn6AzfV
	wVLTf9I6krwC2UfL5uUbzC8bIgC7cE54HKvWgd+0+C/l30VnWe49jwfVzUkVgzW2+qe/hiBXEdF
	UQA==
X-Google-Smtp-Source: AGHT+IGQJBJFkotW2vsOmbzwfrFZdll5ruBgmE5Wy0gcHaY5UPMHPJLdSb7fePIylsTHu3oFBkLPivwSMf0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b13:b0:dfa:b47e:b99f with SMTP id
 3f1490d57ef6-dfb1c346c78mr644443276.2.1718065320730; Mon, 10 Jun 2024
 17:22:00 -0700 (PDT)
Date: Mon, 10 Jun 2024 17:21:59 -0700
In-Reply-To: <ad03cb58323158c1ea14f485f834c5dfb7bf9063.1718043121.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718043121.git.reinette.chatre@intel.com> <ad03cb58323158c1ea14f485f834c5dfb7bf9063.1718043121.git.reinette.chatre@intel.com>
Message-ID: <ZmeYp8Sornz36ZkO@google.com>
Subject: Re: [PATCH V8 1/2] KVM: selftests: Add x86_64 guest udelay() utility
From: Sean Christopherson <seanjc@google.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, jmattson@google.com, 
	mlevitsk@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, yuan.yao@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 10, 2024, Reinette Chatre wrote:
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 8eb57de0b587..b473f210ba6c 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -23,6 +23,7 @@
>  
>  extern bool host_cpu_is_intel;
>  extern bool host_cpu_is_amd;
> +extern unsigned int tsc_khz;
>  
>  /* Forced emulation prefix, used to invoke the emulator unconditionally. */
>  #define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
> @@ -815,6 +816,20 @@ static inline void cpu_relax(void)
>  	asm volatile("rep; nop" ::: "memory");
>  }
>  
> +static inline void udelay(unsigned long usec)

uint64_t instead of unsigned long?  Practically speaking it doesn't change anything,
but I don't see any reason to mix "unsigned long" and "uint64_t", e.g. the max
delay isn't a property of the address space.

> +{
> +	unsigned long cycles = tsc_khz / 1000 * usec;
> +	uint64_t start, now;
> +
> +	start = rdtsc();
> +	for (;;) {
> +		now = rdtsc();
> +		if (now - start >= cycles)
> +			break;
> +		cpu_relax();
> +	}
> +}
> +
>  #define ud2()			\
>  	__asm__ __volatile__(	\
>  		"ud2\n"	\
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index c664e446136b..ff579674032f 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -25,6 +25,7 @@ vm_vaddr_t exception_handlers;
>  bool host_cpu_is_amd;
>  bool host_cpu_is_intel;
>  bool is_forced_emulation_enabled;
> +unsigned int tsc_khz;

Slight preference for uint32_t, mostly because KVM stores its version as a u32.

>  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
>  {
> @@ -616,6 +617,8 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vm_post_create(struct kvm_vm *vm)
>  {
> +	int r;
> +
>  	vm_create_irqchip(vm);
>  	vm_init_descriptor_tables(vm);
>  
> @@ -628,6 +631,15 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
>  
>  		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>  	}
> +
> +	if (kvm_has_cap(KVM_CAP_GET_TSC_KHZ)) {

I think we should make this a TEST_REQUIRE(), or maybe even a TEST_ASSERT().
Support for KVM_GET_TSC_KHZ predates KVM selftests by 7+ years.

> +		r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
> +		if (r < 0)

Heh, the docs are stale.  KVM hasn't returned an error since commit cc578287e322
("KVM: Infrastructure for software and hardware based TSC rate scaling"), which
again predates selftests by many years (6+ in this case).  To make our lives
much simpler, I think we should assert that KVM_GET_TSC_KHZ succeeds, and maybe
throw in a GUEST_ASSERT(thz_khz) in udelay()?

E.g. as is, if KVM_GET_TSC_KHZ is allowed to fail, then we risk having to deal
with weird failures due to udelay() unexpectedly doing nothing.


> +			tsc_khz = 0;
> +		else
> +			tsc_khz = r;
> +		sync_global_to_guest(vm, tsc_khz);
> +	}
>  }
>  
>  void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
> -- 
> 2.34.1
> 

