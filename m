Return-Path: <linux-kernel+bounces-241789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A5927FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740AE1F216CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFD315EA2;
	Fri,  5 Jul 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y094xRz3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0F405F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142271; cv=none; b=DZ3V7uqMMztNKyBAXpB5b7X7XsfAtGX0sp2toq358h8LdDoTanYXty8cBbBQ17gvyLWWSau33QGt9GH+6syKwt27dms/sQHe4qVeq1BAuvXULS06LVWDVdSAcPoBtWUcM/JnDlPLnk5FNT92qbxUOkX8O/SKVe0RfyF4hjxfLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142271; c=relaxed/simple;
	bh=CSoUqM5CdE4URTrdg0/2CXOXP5HlDRhHWf02ErQyjVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3JJDz02o4GO9nR2fFwmQsuhZst+QJ1TpDjFH/jfNM1Ctj2S6OLV8j5M4cbNSeJg3s/vEwBw1iMywF3OmopzywFcmbQFzIq0d8p/sf6r0WcynuXG+pZEfPR6kq2sCdO8nG+4mc5Lyu4F0nFwyC5fy4S3HCmeJPM0uKCWwnxrXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y094xRz3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C57JsNfHDOwn1B/arEpnckvbaTqrN1W4Vlj4CWKNz/w=;
	b=Y094xRz35lkfynGA5e+l5P+SVk2AAhlJ7uvUzypQWipkOwGpH/RNCtHAZyAsZTUDaNj8Cv
	EKk/dlC15bkr/naHYwV3q0a72ZHVum0rzRdvUWIvWBBF4fIjlyVFuqqutPd0Xjf9d+LbOu
	5sAM/dsQYUEAOjCcHBvHLf1bDpa8QnE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-JcCHR7OcMRmX6SxTndjpKQ-1; Thu, 04 Jul 2024 21:17:46 -0400
X-MC-Unique: JcCHR7OcMRmX6SxTndjpKQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4ee1019ade3so276260e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142266; x=1720747066;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C57JsNfHDOwn1B/arEpnckvbaTqrN1W4Vlj4CWKNz/w=;
        b=WOf4IGZxF6CoGuiAbkhdTzLO6WjZL1FH+rLNkhbOR7cfA4OQKS16y74lxDd/0UbBza
         UNCjJThTYr7vKzo0rN+g1JwImpDba9UUaaVfR68SgUiI+8si8v1wO9F+sXTlAYM4bCOf
         40Cft5S/FmLbIkg3HOjjn3e0HofjrvtzBfjcZ64meftAX3XmBbgoDrLvEntDRonm0tPD
         00D057rXbVwPKGSx8BqUcaiBK8cApbuVFC9hYusOTnBRi/nnQ/gvpjcWCMhpIHRQb0U/
         IAyF+fRIJTSWsTSEnRAywqm+1sSQcIbUkGPY46C1Ym1jzK6y9GkLY7Jh02HHFTXUeEUz
         xexg==
X-Forwarded-Encrypted: i=1; AJvYcCXnViETxh/8e5CAHnFHqiF+qDJ1zWmr0zVc39p38mkAJMR3ilIbK4MjWoQR1H3W/nYW9d5I/+TKgo7n4J1rQ2DWQz/olVnZw8B+v62M
X-Gm-Message-State: AOJu0YwBKbru9Wib3O/kLwucaMMyhvT55KY2xFyY8zRUQFBY9s1LLbcK
	DBXBEoEMJCyxCDnAGmOx9AmH/5chdI6ubo+2fxXwOrnGTj5YhsuXheh6ewlbFyPDM7w4Y9JDRA8
	1fVHTPhAAldVkT2tmfxVumEeqkq9C5VnD/p9AcAo3A+STwq6+ShuX+LL8R1OiuA==
X-Received: by 2002:a05:6122:1693:b0:4f2:fc5c:b89 with SMTP id 71dfb90a1353d-4f2fc5c0e14mr1781524e0c.15.1720142265891;
        Thu, 04 Jul 2024 18:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsjVtfVQD65fX5PnK3vXNcKyNfEGugS6LTJD1/ZklFbF0Nwi9jlytNq9VNa2KuCl7P3V9z+A==
X-Received: by 2002:a05:6122:1693:b0:4f2:fc5c:b89 with SMTP id 71dfb90a1353d-4f2fc5c0e14mr1781506e0c.15.1720142265476;
        Thu, 04 Jul 2024 18:17:45 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513db848sm65140931cf.1.2024.07.04.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:17:45 -0700 (PDT)
Message-ID: <2c0cb572deeec525da8e265d64ba20c7a6367fb4.camel@redhat.com>
Subject: Re: [PATCH v2 16/49] KVM: x86: Don't update PV features caches when
 enabling enforcement capability
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:17:44 -0400
In-Reply-To: <20240517173926.965351-17-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-17-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Revert the chunk of commit 01b4f510b9f4 ("kvm: x86: ensure pv_cpuid.features
> is initialized when enabling cap") that forced a PV features cache refresh
> during KVM_CAP_ENFORCE_PV_FEATURE_CPUID, as whatever ioctl() ordering
> issue it alleged to have fixed never existed upstream, and likely never
> existed in any kernel.
> 
> At the time of the commit, there was a tangentially related ioctl()
> ordering issue, as toggling KVM_X86_DISABLE_EXITS_HLT after KVM_SET_CPUID2
> would have resulted in KVM potentially leaving KVM_FEATURE_PV_UNHALT set.
> But (a) that bug affected the entire guest CPUID, not just the cache, (b)
> commit 01b4f510b9f4 didn't address that bug, it only refreshed the cache
> (with the bad CPUID), and (c) setting KVM_X86_DISABLE_EXITS_HLT after vCPU
> creation is completely broken as KVM configures HLT-exiting only during
> vCPU creation, which is why KVM_CAP_X86_DISABLE_EXITS is now disallowed if
> vCPUs have been created.
> 
> Another tangentially related bug was KVM's failure to clear the cache when
> handling KVM_SET_CPUID2, but again commit 01b4f510b9f4 did nothing to fix
> that bug.
> 
> The most plausible explanation for the what commit 01b4f510b9f4 was trying
> to fix is a bug that existed in Google's internal kernel that was the
> source of commit 01b4f510b9f4.  At the time, Google's internal kernel had
> not yet picked up commit 0d3b2ba16ba68 ("KVM: X86: Go on updating other
> CPUID leaves when leaf 1 is absent"), i.e. KVM would not initialize the
> PV features cache if KVM_SET_CPUID2 was called without a CPUID.0x1 entry.
> 
> Of course, no sane real world VMM would omit CPUID.0x1, including the KVM
> selftest added by commit ac4a4d6de22e ("selftests: kvm: test enforcement
> of paravirtual cpuid features").  And the test didn't actually try to
> verify multiple orderings, nor did the selftest enter the guest without
> doing KVM_SET_CPUID2, so who knows what motivated the change.
> 
> Regardless of why commit 01b4f510b9f4 ("kvm: x86: ensure pv_cpuid.features
> is initialized when enabling cap") was added, refreshing the cache during
> KVM_CAP_ENFORCE_PV_FEATURE_CPUID isn't necessary.
> 
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  arch/x86/kvm/cpuid.h | 1 -
>  arch/x86/kvm/x86.c   | 3 ---
>  3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index be1c8f43e090..a51e48663f53 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -242,7 +242,7 @@ static struct kvm_cpuid_entry2 *kvm_find_kvm_cpuid_features(struct kvm_vcpu *vcp
>  					     vcpu->arch.cpuid_nent, base);
>  }
>  
> -void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
> +static void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpuid_entry2 *best = kvm_find_kvm_cpuid_features(vcpu);
>  
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 0a8b561b5434..7eb3d7318fc4 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -13,7 +13,6 @@ void kvm_set_cpu_caps(void);
>  
>  void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
>  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
> -void kvm_update_pv_runtime(struct kvm_vcpu *vcpu);
>  struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
>  						    u32 function, u32 index);
>  struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c729227c6501..7160c5ab8e3e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5849,9 +5849,6 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  
>  	case KVM_CAP_ENFORCE_PV_FEATURE_CPUID:
>  		vcpu->arch.pv_cpuid.enforce = cap->args[0];
> -		if (vcpu->arch.pv_cpuid.enforce)
> -			kvm_update_pv_runtime(vcpu);
> -
>  		return 0;
>  	default:
>  		return -EINVAL;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


