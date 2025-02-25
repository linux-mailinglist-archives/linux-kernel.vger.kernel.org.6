Return-Path: <linux-kernel+bounces-532088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2748A44864
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569621894F77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45320C46B;
	Tue, 25 Feb 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlX4c6Un"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E520B7F7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504505; cv=none; b=GQXFn3Seq8Tya5okcJHxsFNJK/373d+gRgwePdITjgzfzgShOJzkPpd/0YoDdrj8GuGaWCwBUcjJahUpIcXVQQi0av0z/zROchgXjyfOKOPOj5Wt9k4ihBovewNjuR4TFfUiEZ2TqtJ0ZulfWJVn4oPtu4v0JbmxN52yEjdOFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504505; c=relaxed/simple;
	bh=TwNBTbeaZXRzk6dvNCNMyG6G92zO+aMRpQMKLbv3vA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkO20dETF1OqyH+T9xHi1G1FTXN913SpA8qogoZJ7LqECYc0g6cN0ms/Ccocl9WgrbMEAfupDzGcUM9jyK7eiWliJXopHk7fwXGI8fvFbotHpCVGhYJ7lfazBkaLO5a4L2rtD7hgLZv8iVgYFpJvENEhqyU6Jjgo7MkwTFB88Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlX4c6Un; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740504502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eziit+CHKGEVpULfuZZ7ZmPQfBeobpqp8Dhu1DWzh5w=;
	b=MlX4c6Unh++X4Gd0wZT6zHMIkdYfJUBN7aHpUFNiPHKbZNaZRyRR2Ij3s2g0r8pIaUu3kH
	W9QUXECpwfboWNMM2Zo3i3ULQqomWqzVprG3GUw3GEuHovMf7WgGd6UTzCBPujqdf1qky9
	hyb5FIIe3ftmNqrKzJyHWAnwxjL0Emw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-gtxjVgnPNMqr195cUpJ-Og-1; Tue, 25 Feb 2025 12:28:19 -0500
X-MC-Unique: gtxjVgnPNMqr195cUpJ-Og-1
X-Mimecast-MFC-AGG-ID: gtxjVgnPNMqr195cUpJ-Og_1740504498
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbaa560224so567336066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504498; x=1741109298;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eziit+CHKGEVpULfuZZ7ZmPQfBeobpqp8Dhu1DWzh5w=;
        b=s6e2ayYDYLysBkhxe4aq9UqMjh4tED2WpGcP9n2sXRYwSMNw8s/j7H2PeGDK5bgACB
         geUlDLWl0erznIKf46FxPgykpLnloy3W3GZ1oKzoQglgWSoNHJLIyPnXWJiKIW41GcN4
         ONizApHuylYPsaEWRBgGldwwmm8R3y3szVb8vlRiPXpRBjgiendvgwQ2EoHJ/yN2Gm0T
         0s+xy5aCbXzvxnGRQy/Crn57xIwN1QYvOP0/xwSYd9YHUK0LZH85lq3+QZ1/WcrJATPz
         IqjpdA9WJ31fFyOIvk8pxpA+uiav7BSiNWmAjBkua94z0E/+8hXq0cFGbt260KuQ3xLu
         dE2w==
X-Forwarded-Encrypted: i=1; AJvYcCUCwIKD7gKZGuJe0WvAzonKoNaTsm+4z4/ilXqoCNqy3/Gt8ul1ITOQr1PqqWYGR/LLg2zWBHKbZnT8Gj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1NI9oEcWJFUBq7rgaQXCZ1NwPE3XgbmKkT2J8dcL0+pAA2LF
	nACmc/ZL063Tb8njkmNOy+SVyOQVWuSF5uYtrs9nEJQmtyWG/pSIaOaDQjKqDsdHrIGHV0hCZ1r
	/Be4GqH1+1GlQE/XiDC/qOsmoARtL9p+njcaxGUKzgF2gHJJREwZg5RUUt4Zp8g==
X-Gm-Gg: ASbGncvQfNqlp3viGUK5lsBWeMkHwWTeLp0QaTqj1FDy7ht4YS//tStLdgSb09ETagH
	ykkDYaKsuwbFzElM1WhThuTdClCb/yqNswKzeXCd37ljJsgohl5SF4ub/uhpZWgC2IffXGvMNgG
	Ddc3za9bHFrQyg0J9I0FFevu1AJ8nOreSwccK6xUjFMOOTpv+uEN9FyK6Lqj+CzZkgeqH9mwSS5
	EI8G+2t+5cPGGSqAwom14qPCz/GyX0NU5TRe/ny2H974SCeTPlb0A3dXQawHWQaqteeiGaezwy/
	0cC0alY2fh7f8LI+r38ttA4uBc6SVTVyeC2ePRFYsU6SXTPSD9k6XA==
X-Received: by 2002:a17:906:80d8:b0:abe:c8ed:6a69 with SMTP id a640c23a62f3a-abec8ed7952mr571337566b.36.1740504498274;
        Tue, 25 Feb 2025 09:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGemtPLpJtOLML0pDb9LOTUvQDs5Ny5xiRFbYmxxDuxQDobg8vDQqhYs4s6cODGlEBzHFMbEQ==
X-Received: by 2002:a17:906:80d8:b0:abe:c8ed:6a69 with SMTP id a640c23a62f3a-abec8ed7952mr571335366b.36.1740504497908;
        Tue, 25 Feb 2025 09:28:17 -0800 (PST)
Received: from [192.168.159.123] (93-33-51-199.ip43.fastwebnet.it. [93.33.51.199])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abed1cdbdfesm172300766b.3.2025.02.25.09.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:28:17 -0800 (PST)
Message-ID: <ae3eb42e-295f-420e-9857-013629d55aa6@redhat.com>
Date: Tue, 25 Feb 2025 18:28:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/30] KVM: TDX: initialize VM with TDX specific
 parameters
To: Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, Yan Zhao <yan.y.zhao@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20250220170604.2279312-1-pbonzini@redhat.com>
 <20250220170604.2279312-24-pbonzini@redhat.com>
 <1a959b69-5256-4c6e-8287-d36bf2b9339c@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1a959b69-5256-4c6e-8287-d36bf2b9339c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/25 03:31, Xiaoyao Li wrote:
> On 2/21/2025 1:05 AM, Paolo Bonzini wrote:
> 
> ...
> 
>> @@ -403,8 +412,9 @@ int tdx_vm_init(struct kvm *kvm)
>>        */
>>       kvm->max_vcpus = min_t(int, kvm->max_vcpus, num_present_cpus());
>> -    /* Place holder for TDX specific logic. */
>> -    return __tdx_td_init(kvm);
> 
> it moves __tdx_td_init() from KVM_CRAETE_VM->tdx_vm_init() to ...
> 
>> +    kvm_tdx->state = TD_STATE_UNINITIALIZED;
>> +
>> +    return 0;
>>   }
> 
>> +static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>> +{

...

>> +    ret = setup_tdparams(kvm, td_params, init_vm);
>> +    if (ret)
>> +        goto out;
>> +
>> +    ret = __tdx_td_init(kvm, td_params, &cmd->hw_error);
> 
> ... KVM_TDX_INIT_VM, which moves the keyid allocation, TDR/TDCS page 
> allocation and other works from KVM_CREATE_VM to KVM_TDX_INIT_VM as well.
> 
> I'm not sure if it is intentional, or by accident. There is no 
> mentioning and justfication of it.

Until this patch there was no KVM_TDX_INIT_VM ioctl, so there was no 
separation between uninitialized and initialized TDs - the TD was 
already initialized right after KVM_CREATE_VM.

I can adjust a bit the commit message.

Paolo

>> +    if (ret)
>> +        goto out;
>> +
>> +    kvm_tdx->tsc_offset = td_tdcs_exec_read64(kvm_tdx, 
>> TD_TDCS_EXEC_TSC_OFFSET);
>> +    kvm_tdx->attributes = td_params->attributes;
>> +    kvm_tdx->xfam = td_params->xfam;
>> +
>> +    kvm_tdx->state = TD_STATE_INITIALIZED;
>> +out:
>> +    /* kfree() accepts NULL. */
>> +    kfree(init_vm);
>> +    kfree(td_params);
>> +
>> +    return ret;
>> +}
>> +
>>   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
>>   {
>>       struct kvm_tdx_cmd tdx_cmd;
>> @@ -647,6 +882,9 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
>>       case KVM_TDX_CAPABILITIES:
>>           r = tdx_get_capabilities(&tdx_cmd);
>>           break;
>> +    case KVM_TDX_INIT_VM:
>> +        r = tdx_td_init(kvm, &tdx_cmd);
>> +        break;
>>       default:
>>           r = -EINVAL;
>>           goto out;
> 
> 


