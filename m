Return-Path: <linux-kernel+bounces-532691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD34A45107
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDE517F90F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A9235BE5;
	Tue, 25 Feb 2025 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWpgf11d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2458237168
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527263; cv=none; b=mKlVqpeHfBFrgqyaccvxWTppG3E6RnF2RXW0TpzVeMdEyFF25QGM7FOYKvOiPX24uSOzHCTtU70FPAaxq3HpijJoKexVqL2AuvFQ+m4wzsDJDUr4NzEp5K0O+R/brnbk3K4il0+zO/HNEzUct2gY9SgWSbQ7uDm5M+jdB7HCiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527263; c=relaxed/simple;
	bh=6gdTWoo4iKiGpYTU7tcySz9K2NdvD0doJkMV1DoKvZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD6jmsKDsXbaI00IZ6Enfpeh33H11YziO1PzkO9f/kd1XDomJOdH8OWL4RV9Vr9hDzYIWuaOdjoThajzmMEAmvYPxaIeP7c4yiwbuM2mSFrqePGWykt6TgPvZhGeX7PSbJjSSh68+/8t8oCokO3j9xMh5qbIezHpmKINt2LhEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWpgf11d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740527260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I+5VgZvS5RLhaGwFZILFRfiBrL6y7Ik6GC5bOnzJSKo=;
	b=fWpgf11dF3u6njmTeuoUM+8sZ0DwjiSZ2WkPxl3QnkS8sXS4mAruu8Uby6LZmjGkayaMRe
	s3hOTLUcybtE13FtfM1dbVZdt+wlaZd9zGegu/RcXM1KQh6suFYI9yLYnUPL+DqTRS90tW
	ZJmLUnrfYd2D6/m63bo3TbUfjEqvCyE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-H7HvHeQHNoezvsVPPa2SMg-1; Tue, 25 Feb 2025 18:47:38 -0500
X-MC-Unique: H7HvHeQHNoezvsVPPa2SMg-1
X-Mimecast-MFC-AGG-ID: H7HvHeQHNoezvsVPPa2SMg_1740527257
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d9fb24f87bso9906245a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740527257; x=1741132057;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+5VgZvS5RLhaGwFZILFRfiBrL6y7Ik6GC5bOnzJSKo=;
        b=e8510GXyif6/LpgNbszVqbP26kOOfhWIeW/8M1s/SA96zx/byGj5TaOsM5dOyhBRWP
         vghpI8hryvHW1rc4QexTIFC5E/rED0O3fkfWuP41r6FZEN0BulRkT3fhvpKOTXtLubva
         HBRHXmk/rolYjg0y6ETlBUHhrOm8aWN8+NprXXJmICCSSbgDhTeJcAXQ031Mg0KYkS5X
         6sPft62KUzgPh6L+ufpWXUxxFcALqAZEW0jPWZeTfeBhOowyZe5KmeMxPf29EOgLBE8v
         OxPLLTLpMiZzGG3QovxRLhv3MqZ+vGG18bmYm8V2WzLJ7z7qdCQxAGLGqM8r6JStu9gB
         EeOA==
X-Forwarded-Encrypted: i=1; AJvYcCVzFEacNZOibTI8zqRPEDFYqzP5lPOzxa2fsggK9jmaCNp437K+rWjCVDmJ52eVwH9CJR+FP9PjKsa4xpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUUSErcdvfLJuHbq5K8jGN0mRpv+zXPA8y4ErT0TIKCq8UpzO
	yZ9QNm4OyvYkb3lFswxrchGVQqJKsQUymSObM9IqzlNufkDwYwNVJSAK5ARg/LNvRFQV84Flva8
	nz8o3gBRVVZnhzrnWworeZYUWwxu2Pp6IHvxEhQLhm6xLi3RTjAEddWg9JzkJIg==
X-Gm-Gg: ASbGncuZO20p9zkUzbNnF9ZaJASKgB571OTzNP43kcGMXDwsi0R2IGwO4urWrHBXsnT
	l9QZVYQtNnbvwrRl+x2ySzaOw+ITAPoF63NWb1tWKLew1LCBtGHz7W8pFFRkV8CqLTiuFwEDTay
	PCu+wrum5n8yxPCEi7jR/9ImqiqUxFUAwSNRe2LP0wbyUiHIxAA2XLJTZhL7hyV9HIB/qtcTS0K
	7R/w19EeCiPqns1p9JiTEA+4lud1FP8sb3CIRB/gx/kKK2AqnqD/F9BC7S96fy0awuiAR3tfYQB
	1m6lFxfrTn9ocOKwEPxt
X-Received: by 2002:a05:6402:35d1:b0:5e0:750a:5c30 with SMTP id 4fb4d7f45d1cf-5e4a0dfc708mr1644335a12.20.1740527256956;
        Tue, 25 Feb 2025 15:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIdTNjyooRvOwtF86c7hT5C/AWZUuE2nxzDPKhqPyR/bEqM/yRWSn2G4IdfhjgLnOUUDk8gQ==
X-Received: by 2002:a05:6402:35d1:b0:5e0:750a:5c30 with SMTP id 4fb4d7f45d1cf-5e4a0dfc708mr1644299a12.20.1740527256453;
        Tue, 25 Feb 2025 15:47:36 -0800 (PST)
Received: from [192.168.10.81] ([176.206.102.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e460ff8629sm1891405a12.59.2025.02.25.15.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 15:47:35 -0800 (PST)
Message-ID: <6475f9c7-304a-4e0b-8000-3dc5c8e718e9@redhat.com>
Date: Wed, 26 Feb 2025 00:47:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] KVM: x86: Free vCPUs before freeing VM state
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao
 <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Aaron Lewis <aaronlewis@google.com>, Jim Mattson <jmattson@google.com>,
 Yan Zhao <yan.y.zhao@intel.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
References: <20250224235542.2562848-1-seanjc@google.com>
 <20250224235542.2562848-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250224235542.2562848-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 00:55, Sean Christopherson wrote:
> Free vCPUs before freeing any VM state, as both SVM and VMX may access
> VM state when "freeing" a vCPU that is currently "in" L2, i.e. that needs
> to be kicked out of nested guest mode.
> 
> Commit 6fcee03df6a1 ("KVM: x86: avoid loading a vCPU after .vm_destroy was
> called") partially fixed the issue, but for unknown reasons only moved the
> MMU unloading before VM destruction.  Complete the change, and free all
> vCPU state prior to destroying VM state, as nVMX accesses even more state
> than nSVM.

I applied this to kvm-coco-queue, I will place it in kvm/master too 
unless you shout.

Paolo

> In addition to the AVIC, KVM can hit a use-after-free on MSR filters:
> 
>    kvm_msr_allowed+0x4c/0xd0
>    __kvm_set_msr+0x12d/0x1e0
>    kvm_set_msr+0x19/0x40
>    load_vmcs12_host_state+0x2d8/0x6e0 [kvm_intel]
>    nested_vmx_vmexit+0x715/0xbd0 [kvm_intel]
>    nested_vmx_free_vcpu+0x33/0x50 [kvm_intel]
>    vmx_free_vcpu+0x54/0xc0 [kvm_intel]
>    kvm_arch_vcpu_destroy+0x28/0xf0
>    kvm_vcpu_destroy+0x12/0x50
>    kvm_arch_destroy_vm+0x12c/0x1c0
>    kvm_put_kvm+0x263/0x3c0
>    kvm_vm_release+0x21/0x30
> 
> and an upcoming fix to process injectable interrupts on nested VM-Exit
> will access the PIC:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000090
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    CPU: 23 UID: 1000 PID: 2658 Comm: kvm-nx-lpage-re
>    RIP: 0010:kvm_cpu_has_extint+0x2f/0x60 [kvm]
>    Call Trace:
>     <TASK>
>     kvm_cpu_has_injectable_intr+0xe/0x60 [kvm]
>     nested_vmx_vmexit+0x2d7/0xdf0 [kvm_intel]
>     nested_vmx_free_vcpu+0x40/0x50 [kvm_intel]
>     vmx_vcpu_free+0x2d/0x80 [kvm_intel]
>     kvm_arch_vcpu_destroy+0x2d/0x130 [kvm]
>     kvm_destroy_vcpus+0x8a/0x100 [kvm]
>     kvm_arch_destroy_vm+0xa7/0x1d0 [kvm]
>     kvm_destroy_vm+0x172/0x300 [kvm]
>     kvm_vcpu_release+0x31/0x50 [kvm]
> 
> Inarguably, both nSVM and nVMX need to be fixed, but punt on those
> cleanups for the moment.  Conceptually, vCPUs should be freed before VM
> state.  Assets like the I/O APIC and PIC _must_ be allocated before vCPUs
> are created, so it stands to reason that they must be freed _after_ vCPUs
> are destroyed.
> 
> Reported-by: Aaron Lewis <aaronlewis@google.com>
> Closes: https://lore.kernel.org/all/20240703175618.2304869-2-aaronlewis@google.com
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 58b82d6fd77c..045c61cc7e54 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12890,11 +12890,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>   		mutex_unlock(&kvm->slots_lock);
>   	}
>   	kvm_unload_vcpu_mmus(kvm);
> +	kvm_destroy_vcpus(kvm);
>   	kvm_x86_call(vm_destroy)(kvm);
>   	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
>   	kvm_pic_destroy(kvm);
>   	kvm_ioapic_destroy(kvm);
> -	kvm_destroy_vcpus(kvm);
>   	kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
>   	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
>   	kvm_mmu_uninit_vm(kvm);


