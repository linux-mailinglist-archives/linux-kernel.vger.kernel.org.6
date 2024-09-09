Return-Path: <linux-kernel+bounces-321687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C332971E05
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0811C21DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D204436A;
	Mon,  9 Sep 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHTR4Lmd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019C39AFD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895603; cv=none; b=uvbQI6nqFDWZENnTwhPphIPjtHPDDRcs4E22bidZ/zFH1VwtQnUBaRoThoxqaAsqgEFH72UDjE1VDsF+6gy2xWNsf+GQWsf2wh9ZkdokMMYkN4TTBC2NyoY1PvDqCYRbkOVAZwvJOkC/Z3ugelMJlX1lQn/ObLzdOtSUKlwhukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895603; c=relaxed/simple;
	bh=NUG0PSSz8Rv91JwF5cQIKuYA4ttk6wAG4mAjGXN998A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoLgc+uOuxuAk07U+WBN8+oP+Rsl1Fe6uBYTUOMmAFhW9BI1aInbKxoPLmhvV3zWk7jP3DJKgbzyslVhHkYWUXM4+1m9MBBhDDo+Scyfl8/9hOXJRS6AG+V67G9pH+/HnndFVxc8k4LRqmNcQrwPSTe2ZKzeZWxLuJDAG3nf4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHTR4Lmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725895601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=APXx3XEEpF/IuQLzqLnGqcXoeqKfQLMnvO98oeUB48c=;
	b=CHTR4LmdHatGO12Li02RmkAKXxSiKI9ZrlBLI+zXOJ3MSP0M/fDXciTmqwDjWotxtv4uvb
	HtvcTuiymSqS29VBmedBZpykCC3v4rLkVqHlzQlaXcvvuqWByXK41jcdOoyrWS0184aQX5
	C26gppUDGOIfaMyp90ITzL5P4ULc+Ok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-YSbIxJdSPTqDhE4yF5DEkg-1; Mon, 09 Sep 2024 11:26:40 -0400
X-MC-Unique: YSbIxJdSPTqDhE4yF5DEkg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cae209243so16107875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895599; x=1726500399;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APXx3XEEpF/IuQLzqLnGqcXoeqKfQLMnvO98oeUB48c=;
        b=jUjvzZrIGmhxfAW0r9829WQ/VqjAKjnc/HPwJE/m5OWw+nStUOadfw9RSMHh6yL4+8
         abVuYkTVlLRhpn0yRDArxAGL4mAU1heYDQV4UR1H+/obNtRaHGwPk9KGgLy8d4+B2HVg
         l6yoqUIDXMt3fXA6AJRUkgCKUbyc49XTfy0BAhr4PaeXiXyxRQAg2Uv+XA3v7LKPNK2W
         Zwkh7VioBTVw5EivOQOj1eEmozI/LNLXVsj30tArYxw+SEr4vo9SUtagKx/Cq6caVQXH
         QoRZEpoXOciDnp1Cr1lxQM1yR1M7qFWV3KIoTu5+oqW7ob1niLd1SycEAwGAX3nzD9DY
         tEyw==
X-Forwarded-Encrypted: i=1; AJvYcCU71eiNUFtMReob1G+uFVPycWwoHSucDKog+T0cAv+mnEjqeoVCj2BF9mBowcbzdnJBSI+eAE9az/Piz2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZC9PUncOiA9Ri6XcGtAKVMHbxknqU7MA20aFJJIQ659f7i2b
	ACMJtTcPPGUCgXhoAzOdMZm0Jq36MmBetffYnRf/++gPGMn/B5x7tlDbg75U3Ae5iP4MN+NKIdQ
	f17LCU2aj1U53BFVf2gcf70Eu6ayVNvaIaARL7MtkGOGZh21QIetqCxx0mSwGjA==
X-Received: by 2002:a05:600c:1d14:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42cae79d2c2mr54273245e9.34.1725895598649;
        Mon, 09 Sep 2024 08:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXJdQ9TSZ7t5t2o5mFgWlM9D92hoeUvlQx7IMNu1cHUcj1KOc62/jenLvnbFt3UlVVefGErw==
X-Received: by 2002:a05:600c:1d14:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42cae79d2c2mr54273085e9.34.1725895598155;
        Mon, 09 Sep 2024 08:26:38 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cb0642f99sm76357425e9.40.2024.09.09.08.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:26:37 -0700 (PDT)
Message-ID: <253707af-d535-4195-b353-579d37c4818a@redhat.com>
Date: Mon, 9 Sep 2024 17:26:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] KVM: TDX: Require TDP MMU and mmio caching for TDX
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-11-rick.p.edgecombe@intel.com>
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
In-Reply-To: <20240904030751.117579-11-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Disable TDX support when TDP MMU or mmio caching aren't supported.
> 
> As TDP MMU is becoming main stream than the legacy MMU, the legacy MMU
> support for TDX isn't implemented.
> 
> TDX requires KVM mmio caching. Without mmio caching, KVM will go to MMIO
> emulation without installing SPTEs for MMIOs. However, TDX guest is
> protected and KVM would meet errors when trying to emulate MMIOs for TDX
> guest during instruction decoding. So, TDX guest relies on SPTEs being
> installed for MMIOs, which are with no RWX bits and with VE suppress bit
> unset, to inject VE to TDX guest. The TDX guest would then issue TDVMCALL
> in the VE handler to perform instruction decoding and have host do MMIO
> emulation.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> TDX MMU part 2 v1:
>   - Addressed Binbin's comment by massaging Isaku's updated comments and
>     adding more explanations about instroducing mmio caching.
>   - Addressed Sean's comments of v19 according to Isaku's update but
>     kept the warning for MOVDIR64B.
>   - Move code change in tdx_hardware_setup() to __tdx_bringup() since the
>     former has been removed.
> ---
>   arch/x86/kvm/mmu/mmu.c  | 1 +
>   arch/x86/kvm/vmx/main.c | 1 +
>   arch/x86/kvm/vmx/tdx.c  | 8 +++-----
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 01808cdf8627..d26b235d8f84 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -110,6 +110,7 @@ static bool __ro_after_init tdp_mmu_allowed;
>   #ifdef CONFIG_X86_64
>   bool __read_mostly tdp_mmu_enabled = true;
>   module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
> +EXPORT_SYMBOL_GPL(tdp_mmu_enabled);
>   #endif
>   
>   static int max_huge_page_level __read_mostly;
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index c9dfa3aa866c..2cc29d0fc279 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -3,6 +3,7 @@
>   
>   #include "x86_ops.h"
>   #include "vmx.h"
> +#include "mmu.h"
>   #include "nested.h"
>   #include "pmu.h"
>   #include "posted_intr.h"
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 25c24901061b..0c08062ef99f 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1474,16 +1474,14 @@ static int __init __tdx_bringup(void)
>   	const struct tdx_sys_info_td_conf *td_conf;
>   	int r;
>   
> +	if (!tdp_mmu_enabled || !enable_mmio_caching)
> +		return -EOPNOTSUPP;
> +
>   	if (!cpu_feature_enabled(X86_FEATURE_MOVDIR64B)) {
>   		pr_warn("MOVDIR64B is reqiured for TDX\n");
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!enable_ept) {
> -		pr_err("Cannot enable TDX with EPT disabled.\n");
> -		return -EINVAL;
> -	}
> -
>   	/*
>   	 * Enabling TDX requires enabling hardware virtualization first,
>   	 * as making SEAMCALLs requires CPU being in post-VMXON state.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


