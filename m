Return-Path: <linux-kernel+bounces-287001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D919952170
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69B41F24B30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E361BC07C;
	Wed, 14 Aug 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ynw3hKVa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135811BC062
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657402; cv=none; b=O98Shh95ZOn1pwkXWHvhPhMeFMPRxEsRb9zkjoR4o/S9yj5pA90ajOaZaXSbz0u9BZ1irDs/37uaQvkICAQXNcTRAjOrI0JOwVyOt8d9sXcxe8+6E2/oE5xV5pNqFkwmZr1gxAOH+Y6uGcI05g3br48ewCXM1nov41r3WIVOBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657402; c=relaxed/simple;
	bh=noa03wV/oXdhDTuYg+AaYjDa94usXTjIFZw5YeFkKJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1FmI8SnTOqr3rAa29CgbD6RvkgR/+9mp5Cez5azZNjXMn0KQ8cy/+xp5lX8td2B91yzc9ykIUgIZknOaxzv7bhKMcYJe7jLS6MZ1BGWdxZujaG0GqK9Fujae3L6ORaahLhWBTyXsY+4PW28ihn0/QN9nj410YaT0k/uot8uKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ynw3hKVa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723657399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j/71b+464kGeYnqk6OdvPFkF1IUtn/BrzQ3xMGXg8/Y=;
	b=Ynw3hKVaYeYXI71z+vepZsQd7xWxPGn8nuO8X3pxo9T9DRBnVNfWioKRUnP9Z5hdU4U73T
	2ezbaEr3cTOlS4RCT6coXjmX52Ug97F0zsv0kNk8Mxzwp80Vo4mH+0X3d0AB6p1WJic1Jo
	wVRLO65vwsbux+GjdTbPrR1awWh6Y4Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-TOaKKc64NbGyQfnYW5iEJg-1; Wed, 14 Aug 2024 13:43:17 -0400
X-MC-Unique: TOaKKc64NbGyQfnYW5iEJg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so594335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657396; x=1724262196;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/71b+464kGeYnqk6OdvPFkF1IUtn/BrzQ3xMGXg8/Y=;
        b=jYsEk+ncYPhwv71M5FME0d9aQmXRv+aUCIv1HQBcXCaE+NAaQaI0nxj2LLnVAn2Akb
         MHDOI+ugWq7jG/yVf/y8Pcb1NFgGcnB0xT+9ZIXvvMkruTXRllfN+qicUMOlQWSH+Ulb
         gyyboQPPT6LI280U5loARfTk5dLAhGodm+Pr2cYoNg+QNows5lOQ3yxuJAsV/7e1u0Kb
         GBJMcHHo56OyxKUOyNHMAa5v5rTLznTN6WEM+9qfGkwSHFovTUMK3gg75gDCuGmg7Jx1
         YSRCWzccYWtCkselgenNU5+O9IvMyxXSvXZosmDHf8+QBLh/YMlKXTKjIxjhoss+Gd1p
         eeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU3HDxWiU5y5WR6sZYg1C6lkG168hzZ66ipQH7SixbU/l1F2kRlOEwfR2figLJsbnl9tMGg+v4qgQ9cRgmpdREu9CXk258qTwzi1hV
X-Gm-Message-State: AOJu0YzwllscvzNqVlE7Go19oYWZq36TIBP6SSX8F41atnllskY+rMHl
	SHglT/VzuQ1fLlhswQYUUE+OYGlAn6dJt3jhLPThVbOzBuQGUj5rBAAn7chX2ec8NQr3J4MjIyE
	uba0tMAFzcz8qKFiD/Mitug+4xVUeDTOsQ2ASNv8p2+E7VLOVpOCm9IhdEA+KLQ==
X-Received: by 2002:a05:600c:a08c:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-429e23a893amr3267675e9.17.1723657396128;
        Wed, 14 Aug 2024 10:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlAhTuHS23Fvaf+l2YoYSfxzfuYuITtRK+fBSlObGaU/Wqjzcwj9ZcM291AWST8X6KlhY3wQ==
X-Received: by 2002:a05:600c:a08c:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-429e23a893amr3267445e9.17.1723657395571;
        Wed, 14 Aug 2024 10:43:15 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded720eesm26371055e9.33.2024.08.14.10.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:43:14 -0700 (PDT)
Message-ID: <41d307b3-78d9-4be1-80f0-9a9652e7ee37@redhat.com>
Date: Wed, 14 Aug 2024 19:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] KVM: x86/mmu: Move event re-injection
 unprotect+retry into common path
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-16-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-16-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> Move the event re-injection unprotect+retry logic into
> kvm_mmu_write_protect_fault(), i.e. unprotect and retry if and only if
> the #PF actually hit a write-protected gfn.  Note, there is a small
> possibility that the gfn was unprotected by a different tasking between
> hitting the #PF and acquiring mmu_lock, but in that case, KVM will resume
> the guest immediately anyways because KVM will treat the fault as spurious.
> 
> As a bonus, unprotecting _after_ handling the page fault also addresses the
> case where the installing a SPTE to handle fault encounters a shadowed PTE,
> i.e. *creates* a read-only SPTE.
> 
> Opportunstically add a comment explaining what on earth the intent of the
> code is, as based on the changelog from commit 577bdc496614 ("KVM: Avoid
> instruction emulation when event delivery is pending").
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f64ad36ca9e0..d3c0220ff7ee 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2753,23 +2753,6 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
>   	return r;
>   }
>   
> -static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
> -{
> -	gpa_t gpa;
> -	int r;
> -
> -	if (vcpu->arch.mmu->root_role.direct)
> -		return 0;
> -
> -	gpa = kvm_mmu_gva_to_gpa_write(vcpu, gva, NULL);
> -	if (gpa == INVALID_GPA)
> -		return 0;
> -
> -	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa >> PAGE_SHIFT);
> -
> -	return r;
> -}
> -
>   static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
>   {
>   	trace_kvm_mmu_unsync_page(sp);
> @@ -4640,8 +4623,6 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
>   	if (!flags) {
>   		trace_kvm_page_fault(vcpu, fault_address, error_code);
>   
> -		if (kvm_event_needs_reinjection(vcpu))
> -			kvm_mmu_unprotect_page_virt(vcpu, fault_address);
>   		r = kvm_mmu_page_fault(vcpu, fault_address, error_code, insn,
>   				insn_len);
>   	} else if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
> @@ -6037,8 +6018,15 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>   	 * execute the instruction.  If no shadow pages were zapped, then the
>   	 * write-fault is due to something else entirely, i.e. KVM needs to
>   	 * emulate, as resuming the guest will put it into an infinite loop.
> +	 *
> +	 * For indirect MMUs, i.e. if KVM is shadowing the current MMU, try to
> +	 * unprotect the gfn and retry if an event is awaiting reinjection.  If
> +	 * KVM emulates multiple instructions before completing even injection,
> +	 * the event could be delayed beyond what is architecturally allowed,
> +	 * e.g. KVM could inject an IRQ after the TPR has been raised.

This paragraph should go before the description of
kvm_mmu_unprotect_gfn_and_retry:

	 * There are two cases in which we try to unprotect the page here
	 * preemptively, i.e. zap any shadow pages, before emulating the
	 * instruction.
	 *
	 * First, the access may be due to L1 accessing nested NPT/EPT entries
	 * used for L2, i.e. if the gfn being written is for gPTEs that KVM is
	 * shadowing and has write-protected.  In this case, because AMD CPUs
	 * walk nested page table using a write operation, walking NPT entries
	 * in L1 can trigger write faults even when L1 isn't modifying PTEs.
	 * KVM would then emulate an excessive number of L1 instructions
	 * without triggering KVM's write-flooding detection, i.e. without
	 * unprotecting the gfn.  This is detected as a RO violation while
	 * translating the guest page when the current MMU is direct.
	 *
	 * Second, for indirect MMUs, i.e. if KVM is shadowing the current MMU,
	 * unprotect the gfn and reenter the guest if an event is awaiting
	 * reinjection.  If KVM emulates multiple instructions before completing
	 * event injection, the event could be delayed beyond what is
	 * architecturally allowed, e.g. KVM could inject an IRQ after the
	 * TPR has been raised.
	 *
	 * In both cases, if one or more shadow pages were zapped, skip
	 * emulation and resume L1 to let it natively execute the instruction.
	 * If no shadow pages were zapped, then the write-fault is due to
	 * something else entirely and KVM needs to emulate, as resuming
	 * the guest will put it into an infinite loop.

Thanks,

Paolo

>   	 */
> -	if (direct && (is_write_to_guest_page_table(error_code)) &&
> +	if (((direct && is_write_to_guest_page_table(error_code)) ||
> +	     (!direct && kvm_event_needs_reinjection(vcpu))) &&
>   	    kvm_mmu_unprotect_gfn_and_retry(vcpu, cr2_or_gpa))
>   		return RET_PF_FIXED;
>   


