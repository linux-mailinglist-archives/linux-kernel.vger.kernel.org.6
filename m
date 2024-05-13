Return-Path: <linux-kernel+bounces-177678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC878C42EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7356E1C211AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D815382D;
	Mon, 13 May 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA0/UwP/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E2153BEF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609564; cv=none; b=RWUSDdWHyv8pu0Psr5MYNVl4Syv7FM9p6RgjfdmLa5lpaC1avH199x3Nuounq5YHZ87u4OzLRNQPgzxCRB3lXACpqWBr2p+BOok4I28RDu6jSK0mWjk3BynDTTVVrXy2TMGheUOTvYIDpUMRj4Gwep+7gL0jup8Qfzk60yH3gVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609564; c=relaxed/simple;
	bh=JiVcnFkfIWkSPdEwVC1UflSAf1GtozE2Y1Cm4v16vng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze3iH4RYWcoLLUXDRNlH8FVub08UzGnvI1fo7EHa/xEaSj4u7V86WeYsvoMIEOzGiCGonSNa5s64jJwZNHE9DQKvFdqGh+KchxVsAu85/jdmHt+iC4XRjmphOGU+o2Q+w7V2S2sSKifPsuwtuWCvjRxkbHxLK1HKAO9ztM0u35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA0/UwP/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715609560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0hdTKCCj04pt0LL0tQaS1Zpm2moBRFzHZ42+JJy4qmY=;
	b=OA0/UwP/9LPTVLrWco82A6HM96qjnr0stAFh6Yl/4GKZmNQP2rZsZ0dLrP5BvnMaM+2hxd
	gUYF5o5yu1odBMfIgNW6GyAM3Vw3i8gbgwO+Mmh10a9IoNe2zxrscoOtbRQwgQGcXNMXbM
	jljXCAZW3LI4qYEVCex1vmsVEINdMBo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-QYAO7JcaP7G6MQKot8xnJQ-1; Mon, 13 May 2024 10:09:28 -0400
X-MC-Unique: QYAO7JcaP7G6MQKot8xnJQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e3003fae2dso29075751fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609367; x=1716214167;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hdTKCCj04pt0LL0tQaS1Zpm2moBRFzHZ42+JJy4qmY=;
        b=MuGbkjJF4W3kBPHuSPXC0WTlrxoISfoOab/Q8XXWTQjZTNpSejq2eTN74rZ3ZGxmSW
         KJslJrbNJei6IeDFGlAWKcM2vMVgKGoUuUa7RoRGWeCZ9GVTa2Umqv/0ynqyMyYraDID
         L9loSS3Bc+dcSfJMji4hxyCQ9rIqgH0/Colhrx7CJUfLXI3RcE66Aby2yKSwInzIXYI4
         UudYIszFNqHS+ob06gJyTkJglPtwB9MCXMKRlrCRYZqMY7Zzk4ly293VVm32d+6PR9PW
         KWErWdozu9nUe+O8+3zZHE3VcNZJrryWs/4jfyiSa+l8L50wAqXYX6MGqlXFXYiyE4ru
         F/bw==
X-Gm-Message-State: AOJu0Yy8lvZYsirdLfdDJQVge5FdbE+d7aV/uVbUa/vRVGAfO0rSrKjz
	tMayMvdBe2QN9WTHPklR/QaYsRFHvTzbAvUjFUIUFUhOkhRPRpVMtQGsP2NyvNtdTJUcyozrrEk
	OH1mxdFY+5cWj3vurisU/oi/8pWjoQVIzvyjxXT8ncqzKZ6fmph9gv7MmL9evgw==
X-Received: by 2002:a2e:8e93:0:b0:2e4:3f51:33b0 with SMTP id 38308e7fff4ca-2e5204b1cfbmr71984341fa.43.1715609366763;
        Mon, 13 May 2024 07:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYc4NyeiFOtQ9FRqCISBRDcQgtDXcycKDbhFuaaf0vBjBuIBl3TKYVNFG05aoTzOQFYvKXEQ==
X-Received: by 2002:a2e:8e93:0:b0:2e4:3f51:33b0 with SMTP id 38308e7fff4ca-2e5204b1cfbmr71983771fa.43.1715609365237;
        Mon, 13 May 2024 07:09:25 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fe1ab43casm76679955e9.1.2024.05.13.07.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 07:09:24 -0700 (PDT)
Message-ID: <22def35f-5b8d-4424-a03b-c90e9174a14d@redhat.com>
Date: Mon, 13 May 2024 16:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Drop spinlocks on contention iff kernel is
 preemptible
To: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
 Valentin Schneider <valentin.schneider@arm.com>,
 Marco Elver <elver@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 David Matlack <dmatlack@google.com>
References: <20240110214723.695930-1-seanjc@google.com>
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
In-Reply-To: <20240110214723.695930-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 22:47, Sean Christopherson wrote:
> Use preempt_model_preemptible() to detect a preemptible kernel when
> deciding whether or not to reschedule in order to drop a contended
> spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
> built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
> preemption model is "none" or "voluntary".  In short, make kernels with
> dynamically selected models behave the same as kernels with statically
> selected models.

Peter, looks like this patch fell through the cracks.  Could this be 
applied for 6.10?

There is a slightly confusing line in the commit message below, so that 
it reads more like an RFC; but the patch fixes a CONFIG_PREEMPT_DYNAMIC 
regression wrt static preemption models and has no functional change for 
!CONFIG_PREEMPT_DYNAMIC.

> Somewhat counter-intuitively, NOT yielding a lock can provide better
> latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
> rwlock, is often contended between an invalidation event (takes mmu_lock
> for write) and a vCPU servicing a guest page fault (takes mmu_lock for
> read).  For _some_ setups, letting the invalidation task complete even
> if there is mmu_lock contention provides lower latency for *all* tasks,
> i.e. the invalidation completes sooner *and* the vCPU services the guest
> page fault sooner.
> 
> But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
> can vary depending on the host VMM, the guest workload, the number of
> vCPUs, the number of pCPUs in the host, why there is lock contention, etc.
> 
> In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This should be "deleting the preempt_model_preemptible() guard" given 
that the patch does delete CONFIG_PREEMPTION, and only leaves 
preempt_model_preemptible() in place.

Thanks,

Paolo

> opposite and removing contention yielding entirely) needs to come with a
> big pile of data proving that changing the status quo is a net positive.
> 
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/sched.h | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 03bfe9ab2951..51550e64ce14 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2229,11 +2229,10 @@ static inline bool preempt_model_preemptible(void)
>    */
>   static inline int spin_needbreak(spinlock_t *lock)
>   {
> -#ifdef CONFIG_PREEMPTION
> +	if (!preempt_model_preemptible())
> +		return 0;
> +
>   	return spin_is_contended(lock);
> -#else
> -	return 0;
> -#endif
>   }
>   
>   /*
> @@ -2246,11 +2245,10 @@ static inline int spin_needbreak(spinlock_t *lock)
>    */
>   static inline int rwlock_needbreak(rwlock_t *lock)
>   {
> -#ifdef CONFIG_PREEMPTION
> +	if (!preempt_model_preemptible())
> +		return 0;
> +
>   	return rwlock_is_contended(lock);
> -#else
> -	return 0;
> -#endif
>   }
>   
>   static __always_inline bool need_resched(void)
> 
> base-commit: cdb3033e191fd03da2d7da23b9cd448dfa180a8e


