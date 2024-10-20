Return-Path: <linux-kernel+bounces-373194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B259A53A2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D221F21FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19D18EFF8;
	Sun, 20 Oct 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJaDOBZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8B746E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422485; cv=none; b=k/xKvXWdcqPYP7gADvpRHgrwQhVr4fpGU8T8gS+M0W/OQmsvBejZtgRPAf640EIgc157oZV1JILlytT0whm0tnT9G2JJaXjICG6NvuepVAliXeFhPp6UVsTXhT/2RlyOcTMzVETxMCpHIUKCBaYQDKkEUdGrJhiyFYCzFiIMX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422485; c=relaxed/simple;
	bh=pnoaH/D3cCMPRABE1ddRXd+O7HPLjEps5yMAW+nT+xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZgsG5ZBZa9UyxFx/4Umd+iX3AIijQT+EMgtx70DinVcO6dbNAiTAX6ux+ZIw+y5JaaJai1AH2+H6Pt58gs/ba0PR+GDiXsG2PcVcixpD+N+AXDZiUXR6cIKNlbzAnkXO5dLfYIbazszD0xh++h23zE0hjY9dTeUyy6jmEOtfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJaDOBZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729422482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BjDEEjCClx/NLF9Zh+baN3JQectupLgFjS5ojSwRVCA=;
	b=NJaDOBZrrKscP7ohWRyn5792pyynFykEWw4i1n3HPjRAUYFtxixi0+0GTxdI69gPzTSDqU
	bxhRq9+1GvW+mntgpIcBudlAsARlEXv+uOb+xVq2wund5WGYBpA+2ld9JD2hE/RSTIdn3i
	scL4CXMtCYDVJTcKwJBM5gXsNjvWR4c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Tc_SYk8WOfyKZBQyEYYTgw-1; Sun, 20 Oct 2024 07:08:00 -0400
X-MC-Unique: Tc_SYk8WOfyKZBQyEYYTgw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d504759d0so2180671f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422480; x=1730027280;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjDEEjCClx/NLF9Zh+baN3JQectupLgFjS5ojSwRVCA=;
        b=jnRh79broXqL1CJB8lQXmetPkF6VEyWxFzPNodIweDUdc+WMY1M6uImoJSflLO+aCq
         naozpzhxy+6xBnUH30T8cvBGCJNAd2oor8Za2vfbb9K+uhuyFWRuuXPF6toACnkq9w6+
         jPBRKx82fY4jJMLyjVgUUUp84HhELKJ6EFDvQZP7oEjTAY1ZckYCa6tTbJQyh+LuvJ18
         AI382FJdMUb/wrNOFHzorMXao0SXnS0g9ShetcWbXUChV6X3FbRAoJSedaeUNHQ8uLlF
         1Knv1NtCIbZzkmuuKMKZDMq24fkfjZITet5D0WvVVfDA1OYm/4/Q/HaeeVkHTfrW4iZy
         JaHg==
X-Forwarded-Encrypted: i=1; AJvYcCUh4E2qdnZkMsLCP3SbmSkvXfcUNgkjkxBkEvHLZ/hTXAyfnnQQCDWPjwTTSioLBNNZWYrLSXPsjtZv0Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jR63lZPBAV7LB/okYk6p+dHnz22l3HoqWwOZlD32efhiGdYC
	KZgNSdlOgFCHqg1tLyewMBs/V9DRZ3SYTRilvoNCkz9FtNEPwCNYGZuURoszglBeqwM08IQ8Tmy
	RUfeA7F3TmOvanIVrbZ2ZOQxuckButVBAOTZc3ktfFNNpqCHQ7VpOH0PmLgrSKA==
X-Received: by 2002:adf:fd0b:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-37e9573e1e6mr7065652f8f.0.1729422479672;
        Sun, 20 Oct 2024 04:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7IdJyrkxZ/C7eTqTghCqBNkzXy3RhN0ErsHT94yxTUnBUuu/304G2ABCaA6vfA9QDo5yDTg==
X-Received: by 2002:adf:fd0b:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-37e9573e1e6mr7065624f8f.0.1729422479207;
        Sun, 20 Oct 2024 04:07:59 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a64daasm1524098f8f.64.2024.10.20.04.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 04:07:57 -0700 (PDT)
Message-ID: <e12a40f6-3323-41bb-867b-ebb37ec57388@redhat.com>
Date: Sun, 20 Oct 2024 13:07:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm: Override default caching mode for SEV-SNP and
 TDX
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Binbin Wu <binbin.wu@intel.com>, Juergen Gross <jgross@suse.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20241015095818.357915-1-kirill.shutemov@linux.intel.com>
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
In-Reply-To: <20241015095818.357915-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 11:58, Kirill A. Shutemov wrote:
> AMD SEV-SNP and Intel TDX have limited access to MTRR: either it is not
> advertised in CPUID or it cannot be programmed (on TDX, due to #VE on
> CR0.CD clear).
> 
> This results in guests using uncached mappings where it shouldn't and
> pmd/pud_set_huge() failures due to non-uniform memory type reported by
> mtrr_type_lookup().
> 
> Override MTRR state, making it WB by default as the kernel does for
> Hyper-V guests.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Binbin Wu <binbin.wu@intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

Queued, thanks.  I'll leave the follow up to the owners of the tip tree.

Paolo

> ---
>   arch/x86/kernel/kvm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 263f8aed4e2c..21e9e4845354 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -37,6 +37,7 @@
>   #include <asm/apic.h>
>   #include <asm/apicdef.h>
>   #include <asm/hypervisor.h>
> +#include <asm/mtrr.h>
>   #include <asm/tlb.h>
>   #include <asm/cpuidle_haltpoll.h>
>   #include <asm/ptrace.h>
> @@ -980,6 +981,9 @@ static void __init kvm_init_platform(void)
>   	}
>   	kvmclock_init();
>   	x86_platform.apic_post_init = kvm_apic_init;
> +
> +	/* Set WB as the default cache mode for SEV-SNP and TDX */
> +	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
>   }
>   
>   #if defined(CONFIG_AMD_MEM_ENCRYPT)


