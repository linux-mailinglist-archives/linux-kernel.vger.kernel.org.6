Return-Path: <linux-kernel+bounces-322658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AAD972BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BCE1C2454D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420E187854;
	Tue, 10 Sep 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFoCjuDg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35418755F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956195; cv=none; b=qwG6vlhcIxaX2QXCWdsA+ioy1JZkU/wD1De/FQSHNVeMbokBWVBoVf4nQgLJo9OkWFEiUdXVZSHFXph0RWUXa005eowKKaLUM4cO2kLi8+qaJDIOfFLNc7b/5J24Gbfzz5huS36woFR5nxOFVAN3Ns/sPupq4dq/SeSf8u9Mw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956195; c=relaxed/simple;
	bh=1cP/A0KxfoX+tNfZ/0kldrN3vRzU0dU83KFJQJkaPVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Poxdro3LLKzGpyLrW66Dyg73VN17VIzYncKfXB3ozVRh0WrfRci+oIzT/SZ93bV6bih7lZexny3+2p3S1jcK94FIzXKKcrLlaGd10litVdxNma5tatj8Y4YQNxR9eifeIChQBkQB1zgnXCNnXX3BrRCtveSrpEGq1jmyeJhfazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFoCjuDg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725956192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7T8hGkEiRUE85g8dfge0UQzCTu3abH89aAk2D2zpZ1U=;
	b=ZFoCjuDgrKqWgBmmyOOO1j+T4ioIkDGhe3DHGQNVyoihaDN6Ap5nOAkOT5+z9q9UWAAnvE
	efLUQEwC692mCcb394J2pYrnZQ7Pc4l0YBGdxIwJV2jkQZjqRfHQkkateDMmdhr74Qe7/s
	FkJypBge9GZWpG9pWVXjzrzhcrHxMZs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Nu7_aWiLOUWQFBbqNt5J7w-1; Tue, 10 Sep 2024 04:16:31 -0400
X-MC-Unique: Nu7_aWiLOUWQFBbqNt5J7w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f760dce28bso17862021fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956189; x=1726560989;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T8hGkEiRUE85g8dfge0UQzCTu3abH89aAk2D2zpZ1U=;
        b=tTbubw2ZA1r5AuLZftLwo29HVfWkrNvzGTEagwi+tgog7exRCgcSKLXDjOI9bKrvT2
         cTORMhsH3Ezn8bsAkHSdFe6FlVCzg17OmZQIVFv9wb9Z/G9K+FM9hoZdQ/n3XfR3IZbj
         7WOFcv8/cIN+B8p7KOjdlaRqWIo/VG9DtWlKXKUDbmc69d42Xg+XvVEVhWk4j/B7HHTb
         LBx8SAm0LewbhkbiNQxqZZ5lQpJE6CPZCrEP83mfV7BZihKhIOj/+Y+QRc+EWEQBoBbX
         EUBwz2u3i4rZxcVPZ+pmAdGSkC1WhTK+NgqGw6L3XQ4XY6vMEMiN/aXpPf4FYhKyA30c
         1SKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSTFIboj0UFypVLWbTZ7jWckUWncrtW8tS0+AAuNfUv4JhTQpG5Qa9pdOxFdhOb84lOMJ3rajoTQwWZ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNn1OodB9JgOBh5QO2wPDWCvLWAMxSDZJTtGKWyxDgGwsY5ufq
	xhp8kATg+Z1la2N90QK6BkyeAqAeyHllUWrcS9fZohYd2UwlAbsRrzSPx+OONF7+1nU3p4vyWkp
	ZZcAM1nrHJydujnrLv3BBdpRITyYj3lIeOWHxp6szX069FcyNlrQ4O5ilcOBCGQ==
X-Received: by 2002:a05:6512:1110:b0:535:6400:1da8 with SMTP id 2adb3069b0e04-536587b42afmr8638115e87.28.1725956189330;
        Tue, 10 Sep 2024 01:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaFrhtSp+vFrYDT5bW+iywaJuoR8w00Hzs3YVtpOauRLTZdYj6Kg9VYOY8Z4r+qFTWIvmWsA==
X-Received: by 2002:a05:6512:1110:b0:535:6400:1da8 with SMTP id 2adb3069b0e04-536587b42afmr8638085e87.28.1725956188780;
        Tue, 10 Sep 2024 01:16:28 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3789564a52csm8190834f8f.11.2024.09.10.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:16:28 -0700 (PDT)
Message-ID: <e4ebdfca-fcb8-43fb-a15b-591d083b286f@redhat.com>
Date: Tue, 10 Sep 2024 10:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] KVM: TDX: Handle TLB tracking for TDX
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-14-rick.p.edgecombe@intel.com>
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
In-Reply-To: <20240904030751.117579-14-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> +static void vt_flush_tlb_all(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * TDX calls tdx_track() in tdx_sept_remove_private_spte() to ensure
> +	 * private EPT will be flushed on the next TD enter.
> +	 * No need to call tdx_track() here again even when this callback is as
> +	 * a result of zapping private EPT.
> +	 * Just invoke invept() directly here to work for both shared EPT and
> +	 * private EPT.
> +	 */
> +	if (is_td_vcpu(vcpu)) {
> +		ept_sync_global();
> +		return;
> +	}
> +
> +	vmx_flush_tlb_all(vcpu);
> +}
> +
> +static void vt_flush_tlb_current(struct kvm_vcpu *vcpu)
> +{
> +	if (is_td_vcpu(vcpu)) {
> +		tdx_flush_tlb_current(vcpu);
> +		return;
> +	}
> +
> +	vmx_flush_tlb_current(vcpu);
> +}
> +

I'd do it slightly different:

static void vt_flush_tlb_all(struct kvm_vcpu *vcpu)
{
	if (is_td_vcpu(vcpu)) {
		tdx_flush_tlb_all(vcpu);
		return;
	}

	vmx_flush_tlb_all(vcpu);
}

static void vt_flush_tlb_current(struct kvm_vcpu *vcpu)
{
	if (is_td_vcpu(vcpu)) {
		/*
		 * flush_tlb_current() is used only the first time for
		 * the vcpu runs, since TDX supports neither shadow
		 * nested paging nor SMM.  Keep this function simple.
		 */
		tdx_flush_tlb_all(vcpu);
		return;
	}

	vmx_flush_tlb_current(vcpu);
}

and put the implementation details close to tdx_track:

void tdx_flush_tlb_all(struct kvm_vcpu *vcpu)
{
	/*
	 * TDX calls tdx_track() in tdx_sept_remove_private_spte() to
	 * ensure private EPT will be flushed on the next TD enter.
	 * No need to call tdx_track() here again, even when this
	 * callback is a result of zapping private EPT.  Just
	 * invoke invept() directly here, which works for both shared
	 * EPT and private EPT.
	 */
	ept_sync_global();
}


