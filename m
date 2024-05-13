Return-Path: <linux-kernel+bounces-177855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670558C455B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D70B211B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79F1C6B4;
	Mon, 13 May 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WU1DPDcc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BF1B94F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619211; cv=none; b=KuLAEFP3lts94//s41lwZhcQY9JQNNC97434cXwgk3IeTaO5AFuLYSSY3XH/MvCglb/1nFvGrnjjI+Of/ybrk0SBqs73tCCZMC9zXXAzSPb0h+81iHI8tIwM1/4yA6GgUqKLSQS0VLmftQOigDI1Ayfg41P381+6PY5+Pt8BLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619211; c=relaxed/simple;
	bh=IxLC18AHi9bjSJPz3kIyZAD0NGejXkMXNyhTuLGYrho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9r8gOC5m3ZCVeDmBEC+tlHvDgZ8vuzJczi0ebYXmQupbK6n4fBbyOyP8sSHgm7XDQinuWrJeehGxxpGWtXH/2UBSHkpQRo6i6HMXSYHqz+0KMFcKAlFNRmxqmKHKzEjwU4kmsMyn/YdyNsj+AHodOi5p0lsjzrv3m/3TfwqmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WU1DPDcc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715619208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w65z3QUkvnVUSPJYuqVePLyrDjQGMnmdmlnjG/aeQjE=;
	b=WU1DPDcc8RpyppKi8uWrRLRWB0TdMfF+ms5Jrbxw4d3FJEz1DIw0K/JIe0VFA4771xWlA2
	7spBEewTM5VVML8I7DytvzsOrfGA3Wn6t5iG38PoYH5Edmi2UL7FTGTpHYtVwU5n7V2FpC
	fyofkM/lE/VVBDt67OAtASLRexmEDFc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-GT5tEQyRNHi-90qsvIRZtA-1; Mon, 13 May 2024 12:53:27 -0400
X-MC-Unique: GT5tEQyRNHi-90qsvIRZtA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a180153aeso300496966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619206; x=1716224006;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w65z3QUkvnVUSPJYuqVePLyrDjQGMnmdmlnjG/aeQjE=;
        b=v53DT/eerPQ9qUURoQ9ck5ZOKRxUaWy+yPTfeZ0J9p+7nuUFDWUuOulJSN4VxdDl4B
         Xy8rsuzVmS2dgmxaneN+KHIC5Me6CxZjowOw6O/wnOQSPfhdDOzD4AngYecZLMbPqcsj
         8X1P/QaABkX6LX/w7Tj8VQjT27Nsoih8mafW+ZDRQuxQFB2Na3+YRZO3U1Swa9pGbKsR
         jT81EkCwAj0Z9aGBE2jBm7jUELbRAHrhd3cajOD5KaXR3af7OyjtvqAgxUMOLm0ELgCh
         R66knDPF/a7QUlF0TZX3JpuHKMmm1dnMe4ULkO/EiqJWveJzOWB5GGbRII4G/lP04hIA
         7B2A==
X-Forwarded-Encrypted: i=1; AJvYcCXUwDStmnIzh3cbrUUCqvcGJLChsJDoHSFA3fLK6UlNTELoxykWbTnI0G9JRYDphiACz36UFilSGB4XV1pYWCw+JkZhv54rPcqcQFE/
X-Gm-Message-State: AOJu0YyjdpD+2drHCa0EPvMnIUOLrbtyhrFL88EgPU/tTUzwKwQcqdQJ
	Hn+Vvvbk5ZTI+TWhFBQER1/p+urikELNxFg6lUIIQ94c7NcSXU9/Ww7/f8IldjaiqfB+L893tBv
	tBO4xKXj8+OfJVM/OPeOpu5zI2VFZkZhVK7fuWYGbkurrxBBOQtno67h0lNouQQ==
X-Received: by 2002:a17:906:2bd3:b0:a58:f1f3:626e with SMTP id a640c23a62f3a-a5a2d64186fmr657044266b.56.1715619205890;
        Mon, 13 May 2024 09:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETfBS2WL7YI4cKOUq3eLlEG+Ly6vteJYfjGM6ThIIAx9nhhnrs9dd4rtC5LYNeW9CHdYtZkw==
X-Received: by 2002:a17:906:2bd3:b0:a58:f1f3:626e with SMTP id a640c23a62f3a-a5a2d64186fmr657042266b.56.1715619205519;
        Mon, 13 May 2024 09:53:25 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17894d35sm610455766b.81.2024.05.13.09.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:53:25 -0700 (PDT)
Message-ID: <0ceafce9-0e08-4d47-813d-6b3f52ac5fd6@redhat.com>
Date: Mon, 13 May 2024 18:53:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/19] KVM: SEV: Provide support for
 SNP_EXTENDED_GUEST_REQUEST NAE event
To: Nathan Chancellor <nathan@kernel.org>, Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, llvm@lists.linux.dev
References: <20240510211024.556136-1-michael.roth@amd.com>
 <20240510211024.556136-19-michael.roth@amd.com>
 <20240513151920.GA3061950@thelio-3990X>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20240513151920.GA3061950@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 17:19, Nathan Chancellor wrote:
>> +static int snp_begin_ext_guest_req(struct kvm_vcpu *vcpu)
>> +{
>> +	int vmm_ret = SNP_GUEST_VMM_ERR_GENERIC;
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	unsigned long data_npages;
>> +	sev_ret_code fw_err;
>> +	gpa_t data_gpa;
>> +
>> +	if (!sev_snp_guest(vcpu->kvm))
>> +		goto abort_request;
>> +
>> +	data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
>> +	data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
>> +
>> +	if (!IS_ALIGNED(data_gpa, PAGE_SIZE))
>> +		goto abort_request;
>
> [...]
>
>> +abort_request:
>> +	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(vmm_ret, fw_err));
>> +	return 1; /* resume guest */
>> +}
> 
> This patch is now in -next as commit 32fde9e18b3f ("KVM: SEV: Provide
> support for SNP_EXTENDED_GUEST_REQUEST NAE event"), where it causes a
> clang warning (or hard error when CONFIG_WERROR is enabled) [...]
> Seems legitimate to me. What was the intention here?

Mike, I think this should just be 0?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c7a0971149f2..affb4fb47f91 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3911,7 +3911,6 @@ static int snp_begin_ext_guest_req(struct kvm_vcpu *vcpu)
  	int vmm_ret = SNP_GUEST_VMM_ERR_GENERIC;
  	struct vcpu_svm *svm = to_svm(vcpu);
  	unsigned long data_npages;
-	sev_ret_code fw_err;
  	gpa_t data_gpa;
  
  	if (!sev_snp_guest(vcpu->kvm))
@@ -3938,7 +3937,7 @@ static int snp_begin_ext_guest_req(struct kvm_vcpu *vcpu)
  	return 0; /* forward request to userspace */
  
  abort_request:
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(vmm_ret, fw_err));
+	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(vmm_ret, 0));
  	return 1; /* resume guest */
  }
  
Paolo


