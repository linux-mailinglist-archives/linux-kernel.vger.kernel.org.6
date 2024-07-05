Return-Path: <linux-kernel+bounces-241856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25AA928059
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187EF1C234F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4A22083;
	Fri,  5 Jul 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg0i/0HV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644F208A7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146143; cv=none; b=LLVOyB2xW09/ze56NIGL6+WyXxb7cjMa9zBDcd4fBIGBP1vA/WjFEA2cISd65BceHp0cvhrUUEhStzwkiOtJRoFgcSsWxkWBKb7or/dDcVds43kGEQEdVPsJI4RBC5aGn+rcEJ7vVnY0/q8ti0rtxdliHaa1HBTO+7Xz5FDEeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146143; c=relaxed/simple;
	bh=8Vz+Assp9w3AUUjoHHaXG5VrBL9gUGzXKaRrcaJt9OQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnTabTF525cVtq77BWP+H0mS9414OSTL5BbgEbPBKC/uyELQk5RSDUjZlkhxPxdEzKx7EVmeugLsQhMyE8i+fUA3JqElrbJ47/DK59VmJlgtk5KZLrv+M52r4wUClFsdYi9LmzstS6jmYWbR9Yge1KZLO2SOygGCJK/6OyT9jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg0i/0HV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720146141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOGlJ22KOnjJQkplUEx2665OYsRQf3zb4enF9GB5qFA=;
	b=Xg0i/0HVNkx7q5tkP23x8kvJvdv6Q4QBkyeWEL8Xm2W17XuwQz9G4xyIDL5+FvzgC7kPaB
	cftGnzPu6+rqkd+iHeqUJxw+XtKr8ne194cNT24Kw1R9cKWo5B44CNUrLIuD0Q4qUzluZR
	olrAvOj9z+yheXBDGmRPSga0cZ9KLjM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-cCrTRglxNUSEpfwXbD__HA-1; Thu, 04 Jul 2024 22:22:19 -0400
X-MC-Unique: cCrTRglxNUSEpfwXbD__HA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5e0f00d63so14881446d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146139; x=1720750939;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOGlJ22KOnjJQkplUEx2665OYsRQf3zb4enF9GB5qFA=;
        b=r6gkf+THgeu0bZNdLvYU3SiKwnTXcbwLs/AGun/4WkbeTPKXQmQcDS+jv4wdlOiXsw
         DoEBt0p0UUXnmsXYDhjGD/T0sOJhIjqmHMfFjnDrApt1ie8EF+bCPArlxlVGoUM3qFJQ
         3tAyBQuoKqOqzx6j0I8VyociW7P1g/ucjT1srqlCcGFbOKpLOgy+Hunu9QpXdInqi5TM
         bxWbopOcmHXkWR1d/BJ4WUJRo5c36M8SSPB/uzMXIqhDzVMFrrYanRnP17OIHou2n0mu
         noRPBQ+ghWnqSql3CCf33VbpVazfc+QB+SLDbhKrnS05b1boV+bOTHHRkQP8jVAtfZkp
         gJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkbaVNLrQqMD2IxZPesO4dbwIRpLzFnW63ofVzW80KrhBLA5Jn6jm6eauoUwTt+ASsQhbRPYajiICHQ6jH61uI8yfJVwpps2QIkJl
X-Gm-Message-State: AOJu0YzyM5y1yutQbzfdmJ5TNrjZ6hVu3DBKRHEwTJroZuWkfcm89Y1q
	hM/IJ8ZEEPaYU8aTjfuOkk493C0LVOTA1G7uT+Ap39HAJQ+gyd57IomJa/tg+yDsQvpplrLS9V8
	3QiQEtdO+gN57r6T94d/YD+IxhoaeBros2CZLxnJoNuBfzPt33Txebd32wqx29A==
X-Received: by 2002:a05:6214:2247:b0:6b0:820f:b833 with SMTP id 6a1803df08f44-6b5ed03479fmr50302346d6.46.1720146139245;
        Thu, 04 Jul 2024 19:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIXLooJKok0ZLoGzEO5CWhQzjtKD412s48JN9yDy9jnZEJ8/XP8rVUlQy5nHVM6ecImPZiHQ==
X-Received: by 2002:a05:6214:2247:b0:6b0:820f:b833 with SMTP id 6a1803df08f44-6b5ed03479fmr50302086d6.46.1720146138923;
        Thu, 04 Jul 2024 19:22:18 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e6228b7sm69174026d6.126.2024.07.04.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:22:18 -0700 (PDT)
Message-ID: <a52a25faeb180f29a43aa69ad96e46a891d8f288.camel@redhat.com>
Subject: Re: [PATCH v2 41/49] KVM: x86: Avoid double CPUID lookup when
 updating MWAIT at runtime
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:22:17 -0400
In-Reply-To: <20240517173926.965351-42-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-42-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> Move the handling of X86_FEATURE_MWAIT during CPUID runtime updates to
> utilize the lookup done for other CPUID.0x1 features.
> 
> No functional change intended.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8ada1cac8fcb..258c5fce87fc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -343,6 +343,11 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  
>  		cpuid_entry_change(best, X86_FEATURE_APIC,
>  			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> +
> +		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> +			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> +					   vcpu->arch.ia32_misc_enable_msr &
> +					   MSR_IA32_MISC_ENABLE_MWAIT);
>  	}
>  
>  	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
> @@ -358,14 +363,6 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
>  		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
>  		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
> -
> -	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
> -		best = kvm_find_cpuid_entry(vcpu, 0x1);
> -		if (best)
> -			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> -					   vcpu->arch.ia32_misc_enable_msr &
> -					   MSR_IA32_MISC_ENABLE_MWAIT);
> -	}
>  }
>  EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


