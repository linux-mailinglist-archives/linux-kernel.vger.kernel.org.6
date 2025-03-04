Return-Path: <linux-kernel+bounces-543218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28407A4D2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5D1705C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547561EB5D4;
	Tue,  4 Mar 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JztPOzYt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98D1DC985
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065355; cv=none; b=sm/osVNatFxAT0GgNUehfDL+iS7eHvuSRLvHlbkBxjZvt5QXvdOXD3scgL5DE7FCThnyzAxuMNVvMqPPk9Q/7jOOcWgGI2IYshSEEDrMEyYW5Tvpimeuti5MQL/+SjThba7H8ZT1pjBNTVQq7pfuaDylxE/kfo1HkowiaElnEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065355; c=relaxed/simple;
	bh=I70BjEXqWMzdLTvepT7oYU6oxEIcfIfhUlrieGGjjJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCT6TkH8Pg7rimuwyWRSB4crR89OOGMYrNhG9FGdL7Z8kglg5MMim5xUXDp5XFduIu2O80fMF/4O9JbETw2vXHgp8g6SibzMrbCCxmLB2J9kxumnKNUgM2/CIdmilWWFmCbRXy7ELP+rjlN7BLErCLWciX1dPsZ31v0yc9IS+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JztPOzYt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741065352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHp7c8083IblnSkSElkO4q8Pyi74C3j+q7Rd++XFOzQ=;
	b=JztPOzYtUHWYLO9ohq5fWF7BnZYZ6IankibFULHA5cS1QlmDEFman6uEtfBbFsGMEkLAbA
	i2yZpEi0wwv/gvb28aTZysgvQuBtltsfnjX5KivVTAircivAVDHjxAz5h5LaObEpw5piNu
	LapNCRtp0GD5vCtxlETskVmNgzB7cGE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-XKCTJ7ijMxq3xE5zjAyU0g-1; Tue, 04 Mar 2025 00:15:40 -0500
X-MC-Unique: XKCTJ7ijMxq3xE5zjAyU0g-1
X-Mimecast-MFC-AGG-ID: XKCTJ7ijMxq3xE5zjAyU0g_1741065339
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22350e4b7baso91810795ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741065339; x=1741670139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHp7c8083IblnSkSElkO4q8Pyi74C3j+q7Rd++XFOzQ=;
        b=ActgI31Y0PShlscIlNC7MW+eTHX6cutec4GXy8wjEbQ84s9KC/wg+SmRfKvgQcmi2I
         /pj1WdlC8Xv2aZhfn1CPA7K0azukW6TzIyiBBGOrN2SlnYsQAsl9HmbsmKHsOwK6F0Jp
         B58WLl+ITzzXN+cih+trKL4y2GJY+HJOKMzHIQQNL9rq0k8rrjXI15uk/8QEVsTp2soL
         3kYbSObVT0/l867yyVXE6WWMU3mrJLDVfshxdDovFeZsVwvy/HiyCnqJEi7q6tjPNFlR
         w1KEyfVM5tcDCnx/0ttFC7BjrxNL6KPk1VtY1Ua/qSwf/jvcVg4QpkrnhDCcFbwR9JCk
         39aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6niqgY2hcxqMcxotazzDCIcQydmB5fpCL71E0U16cfkBpFIYyIUgvksjCYqnSuZrHNNBhU3LD5E5rhxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8F1Q/2AYNmnnTSQyqNjDkiq33U9QEttC43d+POsP5ZBZq2JP
	VDQdvRYQEr8ixw8oaCDKIRDeADEqd7bsBxHsAa0RgyteNMhqt98+lIgnLVfr6iJOYF0wJAVEtgk
	ja20IkFcBALXp9YPuD+7Yr7+Z6WdxrEHUyDm4rYA1S9PYWdwlyJIVkDNZ7Fev8Q==
X-Gm-Gg: ASbGncu2RTGIeQE+gqdaOj0A0SCxAgmVZReSqBsP4ResJikjqeUsLoXjccBoG4FvhXk
	uHUt39IHSesFuPbisIUqbmNiBrD7wBGlDVaAraqu5Eo1A8bB5oEwe/6wpfHi/lBK3TLmXQx8Mg+
	5G7OLlV+UP/MUo44m7Tcstq51+SqXkdF6Ei5AhgmsAnU17l/LSDxe3/s9H9C0CEA5S0nE+g/uk2
	47FrZBDD5O0kTD2oUE9HVsIAUfxuVG/pMT9XAddlEEfp7dc8yqoSqBJkoHy1ICTAm0d/ys889FF
	J/nDOEkXaqq1PtpsEw==
X-Received: by 2002:a17:903:244d:b0:215:9470:7e82 with SMTP id d9443c01a7336-22368f71b7amr213249415ad.4.1741065339566;
        Mon, 03 Mar 2025 21:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwYeNz4BZ5M1mONF0+zOWTYRV5h3Fu8fVqk+GofZ0hdvm3v9bSMtAm5K07jzNGKbCercWDMg==
X-Received: by 2002:a17:903:244d:b0:215:9470:7e82 with SMTP id d9443c01a7336-22368f71b7amr213249125ad.4.1741065339283;
        Mon, 03 Mar 2025 21:15:39 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a99a7sm13451855a91.6.2025.03.03.21.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:15:38 -0800 (PST)
Message-ID: <eb8ea5a0-fe6c-4b96-92da-f9ec0355b4dd@redhat.com>
Date: Tue, 4 Mar 2025 15:15:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/45] KVM: arm64: Handle realm VCPU load
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-23-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-23-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> When loading a realm VCPU much of the work is handled by the RMM so only
> some of the actions are required. Rearrange kvm_arch_vcpu_load()
> slightly so we can bail out early for a realm guest.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 

One nitpick below:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 49ad633c5ca5..3e13e3d87ed9 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -633,10 +633,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   	kvm_vgic_load(vcpu);
>   	kvm_timer_vcpu_load(vcpu);
>   	kvm_vcpu_load_debug(vcpu);
> -	if (has_vhe())
> -		kvm_vcpu_load_vhe(vcpu);
> -	kvm_arch_vcpu_load_fp(vcpu);
> -	kvm_vcpu_pmu_restore_guest(vcpu);
>   	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
>   		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
>   
> @@ -659,6 +655,14 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   		kvm_call_hyp(__vgic_v3_restore_vmcr_aprs,
>   			     &vcpu->arch.vgic_cpu.vgic_v3);
>   	}

A spare line is needed here.

> +	/* No additional state needs to be loaded on Realmed VMs */
> +	if (vcpu_is_rec(vcpu))
> +		return;
> +
> +	if (has_vhe())
> +		kvm_vcpu_load_vhe(vcpu);
> +	kvm_arch_vcpu_load_fp(vcpu);
> +	kvm_vcpu_pmu_restore_guest(vcpu);
>   
>   	if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
>   		vcpu_set_on_unsupported_cpu(vcpu);

Thanks,
Gavin


