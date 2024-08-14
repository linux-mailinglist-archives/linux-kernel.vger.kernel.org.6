Return-Path: <linux-kernel+bounces-287033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005199521E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296E81C22B27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E11BD501;
	Wed, 14 Aug 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVDIHWTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A14D8B7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659347; cv=none; b=sEw0YxDGlqIRFjJDD9yvA76ZB+2JQbKQdO36+XnCyT8n1T5usXIYxzpN9Sn8Q5eU71Uf49kU3U/bKSmdvA310IGreinjX/DF6oGc7EnB08sqiuPEZTAlnoz1OQDFpeBvL9He+Ei8p/d/oPMPwX+8+3SpUi8543H8gg/UFR/fjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659347; c=relaxed/simple;
	bh=IgmLLxdFrfOUorJmUDHd7eFcVGsHkaucJD9AIG6Y6+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y95Ckl6K/b3C4V5YbTE45yWC5p3HO6J6GbCcX1Lc4D/7YdO0ywFfKBkAx70+wbx8BHfrp44XGGu52+JosRBVCg4ip8w89TbKIBQ1v4NklzKEIvkeFz8y7gFdlsmBTynS1Uz7D968jzwEWwX2CNDklyUPfWAzy79U6nB/fsGgrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVDIHWTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723659344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VbxqRbUq0VJMDm70f2A7+YGMoi31xCukMW6txgMsyoc=;
	b=LVDIHWTwZcv8mmCgDTvuys0c0FO8TnX7ilq2aO5cc87V2lVDBUyXQjM6f9d/duLGoeI+cd
	VSgZGQ8vQbweEolXggNd8HcsJqh94lRHEj2dbFOCsCvbo6M3KkYgipl6ZqZVfQa1JDzYgy
	yWi6pP0HTOyaH1W5JAX/Ee8FbWzK0B8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-5B_GhA3-OXCWtx1sg5SHsw-1; Wed, 14 Aug 2024 14:15:38 -0400
X-MC-Unique: 5B_GhA3-OXCWtx1sg5SHsw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36b356a73fcso89965f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723659336; x=1724264136;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbxqRbUq0VJMDm70f2A7+YGMoi31xCukMW6txgMsyoc=;
        b=dlyqWJTG0IVy7I2OJdicLNwgO6iVb43E/JJRSm5GC4f2sed4uqD64b50yTJieXFwpa
         Wa8NFeif2/ib4WunkaybFk3YFSCg1rOip6DK31ThI6b/JyVJJDc54G8pRsh7EVxx7031
         SSp++mUZOGtVfT53xzmf1b+LJClbddF1MVdInTHlTynw7rRpCq/bgu8tTEDZQ2+IZMiN
         nyCNOeEkFAme0Tv/T72DoMEupEK4WILM2g9Ok0mrcElgQFkHgaFAOBbYh5l7QHJoLNWC
         8l/Cb1YQCB6s3OnEtwF5QoA2wreQPerUvH9iO7IqjgGriBNjM3T87kmow6BzVcGfluL3
         1TFw==
X-Forwarded-Encrypted: i=1; AJvYcCXFAzlcHWlKXZ2FcaaE4aeRJlth5h9U8Tv7rkKH1Ypt8C4Yfd2aflLJ99FavjYpc1e05BbgX5efa6wWbx1NOVKZQmkdGnKejvDn9Gc9
X-Gm-Message-State: AOJu0YxaqptZmvwpq4LuqOW/7+KrIvu7RpFwJ9XHFcfXIzJVs2KkLCWg
	RqANItaUXq36l0FqN1P4lNAv+Zac2sIh8pXJspWBTkmIhBmzrir0za8NkMxspqjfdzLeN4J9ZQh
	BGJo0lw74zWAxl8qZGdFyecuutbVqIrMdv2WJy40AHMKt2dPV0ZFkTF4hMS4F+g87eB6K/g==
X-Received: by 2002:a5d:4dca:0:b0:36d:2941:d530 with SMTP id ffacd0b85a97d-3717778273dmr2270320f8f.16.1723659335942;
        Wed, 14 Aug 2024 11:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPmi9UlYergIe2TMojdfzTaFYWbEmLXrrzMWK2H4N4faz/PQ8mb/afsqDM8paWTWEH9Vk4qg==
X-Received: by 2002:a5d:4dca:0:b0:36d:2941:d530 with SMTP id ffacd0b85a97d-3717778273dmr2270306f8f.16.1723659335537;
        Wed, 14 Aug 2024 11:15:35 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36e4c9385d3sm13523564f8f.42.2024.08.14.11.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 11:15:34 -0700 (PDT)
Message-ID: <ef4053c9-6bc8-4b08-af8b-6a4a51100283@redhat.com>
Date: Wed, 14 Aug 2024 20:15:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] KVM: Add arch hooks for enabling/disabling
 virtualization
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
References: <20240608000639.3295768-1-seanjc@google.com>
 <20240608000639.3295768-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240608000639.3295768-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/24 02:06, Sean Christopherson wrote:
> Add arch hooks that are invoked when KVM enables/disable virtualization.
> x86 will use the hooks to register an "emergency disable" callback, which
> is essentially an x86-specific shutdown notifier that is used when the
> kernel is doing an emergency reboot/shutdown/kexec.
> 
> Add comments for the declarations to help arch code understand exactly
> when the callbacks are invoked.  Alternatively, the APIs themselves could
> communicate most of the same info, but kvm_arch_pre_enable_virtualization()
> and kvm_arch_post_disable_virtualization() are a bit cumbersome, and make
> it a bit less obvious that they are intended to be implemented as a pair.
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/kvm_host.h | 14 ++++++++++++++
>   virt/kvm/kvm_main.c      | 14 ++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 96ad3e8b9ddb..12ef3beb4e47 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1514,6 +1514,20 @@ static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
>   #endif
>   
>   #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
> +/*
> + * kvm_arch_{enable,disable}_virtualization() are called on one CPU, under
> + * kvm_usage_lock, immediately after/before 0=>1 and 1=>0 transitions of
> + * kvm_usage_count, i.e. at the beginning of the generic hardware enabling
> + * sequence, and at the end of the generic hardware disabling sequence.
> + */
> +void kvm_arch_enable_virtualization(void);
> +void kvm_arch_disable_virtualization(void);
> +/*
> + * kvm_arch_hardware_{enable,disable}() are called on "every" CPU to do the
> + * actual twiddling of hardware bits.  The hooks are called all online CPUs
> + * when KVM enables/disabled virtualization.  Enabling/disabling is also done
> + * when a CPU is onlined/offlined (or Resumed/Suspended).
> + */
>   int kvm_arch_hardware_enable(void);
>   void kvm_arch_hardware_disable(void);

Since you are at it, rename these to 
kvm_arch_{enable,disable}_virtualization_cpu()?

Paolo

>   #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7bdd744e4821..e20189a89a64 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5505,6 +5505,16 @@ static DEFINE_PER_CPU(bool, hardware_enabled);
>   static DEFINE_MUTEX(kvm_usage_lock);
>   static int kvm_usage_count;
>   
> +__weak void kvm_arch_enable_virtualization(void)
> +{
> +
> +}
> +
> +__weak void kvm_arch_disable_virtualization(void)
> +{
> +
> +}
> +
>   static int __kvm_enable_virtualization(void)
>   {
>   	if (__this_cpu_read(hardware_enabled))
> @@ -5604,6 +5614,8 @@ static int kvm_enable_virtualization(void)
>   	if (kvm_usage_count++)
>   		return 0;
>   
> +	kvm_arch_enable_virtualization();
> +
>   	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
>   			      kvm_online_cpu, kvm_offline_cpu);
>   	if (r)
> @@ -5634,6 +5646,7 @@ static int kvm_enable_virtualization(void)
>   	unregister_syscore_ops(&kvm_syscore_ops);
>   	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
>   err_cpuhp:
> +	kvm_arch_disable_virtualization();
>   	--kvm_usage_count;
>   	return r;
>   }
> @@ -5647,6 +5660,7 @@ static void kvm_disable_virtualization(void)
>   
>   	unregister_syscore_ops(&kvm_syscore_ops);
>   	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
> +	kvm_arch_disable_virtualization();
>   }
>   
>   static int kvm_init_virtualization(void)


