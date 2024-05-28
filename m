Return-Path: <linux-kernel+bounces-192755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257468D21A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9215A1F25217
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04931E511;
	Tue, 28 May 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaShId9Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970231DA4C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913873; cv=none; b=MxLXsj38+OI+AYbXcNx/F7p/tN9oor8rgghYv2mZ4ZAgIHGogQbbIsYhCnrqe6GP1I2KT70iN+hasmT5gRFrgb3OaOh69uHPcUJdtad/tiW2hPuzjS1Dkof4kt8Kzzr7aoNHtLVXJia3F6adDyX0W5UQY8m/QAyo+KliLyH0xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913873; c=relaxed/simple;
	bh=Mz/StU4wUt+3b/KQuEZ6HR4Rd1ua4nPPdh3/iUwgfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k34+l5P94xm0N3g5tEuerHvtRWMPhkU65D1+E92CVBLmC9C3wmJRRmASpnY/7pLrhmsHIE6pJF4LzW64s9muwV+l+Oq89jX0vikTJmcUgB1dvtWRcmaV+3fAuypJK+8h9UPjZ39Z2dsZsskQkd8kO7fEpTxY+NAVDQDS2ECCJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaShId9Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716913866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KOijGqYwatsRHcZFWC3eapxDqv1fMEWcXNilAW1npbM=;
	b=YaShId9YNp5Hc+0jZ4eDJGaYPz/IZz9w1vbx61lSm54CFy1iWtw01uUr6lDJGicrVAqfTR
	ZXkE1a/84rHWgEaKUenaZ75WL6USu/ajLT6GFjPjwI4RBI+fM4SsigXrdKulMpxHDuogKW
	ZT1JU+QJaMHQKVkxQ828qB3sSuf98VI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-bC-7rhNAN9-tqtSlyxag9w-1; Tue, 28 May 2024 12:31:04 -0400
X-MC-Unique: bC-7rhNAN9-tqtSlyxag9w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5785b36c703so585643a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913863; x=1717518663;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOijGqYwatsRHcZFWC3eapxDqv1fMEWcXNilAW1npbM=;
        b=OPNhMdNes+t+8JsdZHmvtabVH3BjN0Ie3XN8EUCCfCldbaY7KxlkbFLmEtYcb8pG0d
         3UGVtcGoguhFTWbb6Yv8cPWTjryATjLZdJGnRIK551De4jHjlauaifiU5QSxnT3TCGEc
         uaRsHxyEruQNIg47OmAe2mJkpWMLBJso+gBvbHXgX6hfNwQlgKSZbSr8tEfRZByh3GAn
         BgAQIjm3eVx7MYBsLZoKTAC1DAA8Thi8Dl+zFuabEDrmN/l6/rNwG+xWrhMko0QlItvb
         VBPIBPL+Aaz4XG0ldq0R3jXfGs32p9uU5YJHfsC5mA5hYZNSQtLNW+ErdHRbbr8lLEWi
         //MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8aMiZlJA+DPxkFPNkw3ZHNSyhISECFSTFOa3zkRMpR1gNKBEZYuUo/ha0C0Ke14wwOCBzS3XesHBIWbRnTI00P/w/wOejrNh27Mp/
X-Gm-Message-State: AOJu0YyuJJdQnRkEfuzVlMlsTTw7TS9NgLqzwiWDb22X8GZnL0WM0RVI
	4lnwNIXooz9LTKrg4YB2VWCFkTfuN5EHSsi0pGYPquSSxl8mWZ3VDsm8+iIOrsPjvWWXPn1IBUE
	VuBjKv5l75Cdp54Ueh2ud2eFqp2JRQC9y8eCw4KjJq8isulliwqRaXtGz95iGJQ==
X-Received: by 2002:a50:cd9d:0:b0:579:1f36:603a with SMTP id 4fb4d7f45d1cf-5791f366111mr8898142a12.17.1716913863622;
        Tue, 28 May 2024 09:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlPv5GaFsn+dFXp7P++pq1zvNnUcp4Z3tgLurZbE/g/iCsp27FCIP84TPuqKbEVDkaL7lO3A==
X-Received: by 2002:a50:cd9d:0:b0:579:1f36:603a with SMTP id 4fb4d7f45d1cf-5791f366111mr8898107a12.17.1716913863205;
        Tue, 28 May 2024 09:31:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-579c73c771esm4166377a12.65.2024.05.28.09.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:31:02 -0700 (PDT)
Message-ID: <3eca1e7e-9ddc-47a2-b214-d8788a069222@redhat.com>
Date: Tue, 28 May 2024 18:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: SEV-ES: Prevent MSR access post VMSA
 encryption
To: Ravi Bangoria <ravi.bangoria@amd.com>, seanjc@google.com,
 nikunj.dadhania@amd.com
Cc: thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 michael.roth@amd.com, pankaj.gupta@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com
References: <20240523121828.808-1-ravi.bangoria@amd.com>
 <20240523121828.808-2-ravi.bangoria@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240523121828.808-2-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 14:18, Ravi Bangoria wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> KVM currently allows userspace to read/write MSRs even after the VMSA is
> encrypted. This can cause unintentional issues if MSR access has side-
> effects. For ex, while migrating a guest, userspace could attempt to
> migrate MSR_IA32_DEBUGCTLMSR and end up unintentionally disabling LBRV on
> the target. Fix this by preventing access to those MSRs which are context
> switched via the VMSA, once the VMSA is encrypted.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>   arch/x86/kvm/svm/svm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3d0549ca246f..489b0183f37d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2834,10 +2834,24 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
>   	return 0;
>   }
>   
> +static bool
> +sev_es_prevent_msr_access(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> +{
> +	return sev_es_guest(vcpu->kvm) &&
> +	       vcpu->arch.guest_state_protected &&
> +	       svm_msrpm_offset(msr_info->index) != MSR_INVALID &&
> +	       !msr_write_intercepted(vcpu, msr_info->index);
> +}
> +
>   static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   {
>   	struct vcpu_svm *svm = to_svm(vcpu);
>   
> +	if (sev_es_prevent_msr_access(vcpu, msr_info)) {
> +		msr_info->data = 0;
> +		return 0;

This should return -EINVAL, not 0.  Likewise below in svm_set_msr().

Paolo

> +	}
> +
>   	switch (msr_info->index) {
>   	case MSR_AMD64_TSC_RATIO:
>   		if (!msr_info->host_initiated &&
> @@ -2988,6 +3002,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>   
>   	u32 ecx = msr->index;
>   	u64 data = msr->data;
> +
> +	if (sev_es_prevent_msr_access(vcpu, msr))
> +		return 0;
> +
>   	switch (ecx) {
>   	case MSR_AMD64_TSC_RATIO:
>   


