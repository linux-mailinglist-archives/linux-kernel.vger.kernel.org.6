Return-Path: <linux-kernel+bounces-241830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53EC92800D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6C01C22403
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A511CB8;
	Fri,  5 Jul 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADfzIs0E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5733233
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145338; cv=none; b=o2Wk9+kpJEd85a4oIKRR6QiCogToArO1G1f0KoTuySE97aStAiilxvQfrvdFSiH+/brh2S6XPvcU5sd9Rn0XVs6q/7prqo6kn7EUIGGr/dKPVl5fYSp5z9+CajTc6mvtrG4eywwNjmP8MQEqi0xVyuhR8vA1nI+W9a8hEfUqbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145338; c=relaxed/simple;
	bh=/c/SA/KQqlvSbEm6iZ3RKVvDFIJf7v5KIC3xfayjxOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsoZeADqWsBYFHQly4+Fp4ZgZYiE17KzoF5isKBO3udZMvngtDgQQbLDgCFItPCMciCuqaUFIuB2Z5eU3UDm7fTs+aUK+LNyTFJ8oNQ35BcyXBqmLzV0FXqDdZD9Y0BnNzRonY+A1lwrXFrryzUaRgoDuuBtRpawywVClSxnBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADfzIs0E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720145335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVyK8WUp1Wae740hnvwJTl/AGYGXmM83fE46RAokPb4=;
	b=ADfzIs0EiO1HLpui+0CxIBWjZT2hn2pvOBn4uHuCTkXmoj/qQ2j8bWgkmFoBxor7SK+yTm
	LJvrdx4ieRjk5AghcqykGuFPoSdDfBNnP3EARfgNaRXPsxLuYj7WUhgeBjir0klhtHplfe
	li3mcK1Sm4rohYbuEtB7kPQa6uDSUW0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-2j12hJMGMO-zjYhuVV13Ag-1; Thu, 04 Jul 2024 22:08:54 -0400
X-MC-Unique: 2j12hJMGMO-zjYhuVV13Ag-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79d5975f301so111156585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720145334; x=1720750134;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVyK8WUp1Wae740hnvwJTl/AGYGXmM83fE46RAokPb4=;
        b=PukSU37eI3DHFio1VL1dZGodUfKSipOcoksQUoKkfGGb+JwgnxG7u2b7TP3IA1FeQV
         OREsXfa14zL1a8vIMQTaOK8vFwAnLAaJ1ncmRN/5V4PgDZ9YOF7g53HZ9fJpKyvGfyny
         edjGC8J/feCPP211Hp0MVU2FCwrd19/1P+7F4Ayug51WR1sdqx/qXTaTo4OOOmP0jiqz
         Om9e2paJ9BAY4wMos8jIveMOh/jgMin79JI1TTFdxvKDl8JQWgxUZDMg84FrkizX/brW
         XJU/pRRIlAR0HR6HqjO2HWyB9D3c4LFeoDqScg+4vkmTm7BHYI2+SisBmbmT1p20/4IN
         EmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3yB67a3JXwgVAkSiDS0PSIVaJ0hCe/tYF7NMGNcIus5A3LZFOpKzM6eHeGqx1BTF81c5XrEbFuwHtOsbbLAZkDJ6sQwnsfRAcUrGT
X-Gm-Message-State: AOJu0YwNCosqzR93dvCLipimo9RPMsr5Yoj/jLjfLItAL4u4NTY1Bff9
	cQsNiV4aMTMjozutfxx6v8MOqtaJSkNVMFkUWN8tQHWXBeExXN/eNFw5Qmvx3K/EYnkTW+Pj0ic
	td5IsLXqVoyUEKjcfQRVp+P5O3CjakEUuyrW5yMEyJbj8GZK8fDkXRIoRoSFQWQ==
X-Received: by 2002:a05:620a:1a03:b0:79d:5b8d:8cb with SMTP id af79cd13be357-79eee1ac16bmr446494785a.35.1720145333735;
        Thu, 04 Jul 2024 19:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVpOmnvLfUQmHiz45S8Y1gyhH7SJOWXX7UMiLphthR+JOl+IkHbZUFWn9BahbvqjABigfXaA==
X-Received: by 2002:a05:620a:1a03:b0:79d:5b8d:8cb with SMTP id af79cd13be357-79eee1ac16bmr446492885a.35.1720145333380;
        Thu, 04 Jul 2024 19:08:53 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69328d75sm726157585a.127.2024.07.04.19.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:08:53 -0700 (PDT)
Message-ID: <2c4f83129772fa6ba1d6301a093b60d5ea1bd3f9.camel@redhat.com>
Subject: Re: [PATCH v2 35/49] KVM: x86: Add a macro to handle features that
 are fully VMM controlled
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:08:52 -0400
In-Reply-To: <20240517173926.965351-36-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-36-seanjc@google.com>
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
> Add a macro to track CPUID features for which KVM fully defers to
> userspace, i.e. that KVM honors if they are enumerated to the guest, even
> if KVM itself doesn't advertise them to usersepace.
> 
> Somewhat unfortunately, this behavior only applies to MWAIT (largely
> because of KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS), and it's not all that
> likely future features will be handled in a similar way.  I.e. very
> arguably, potentially tracking every feature in kvm_vmm_cpu_caps is a
> waste of memory.
> 
> However, adding one-off handling for individual features is quite painful,
> especially when considering future hardening.  It's very doable to verify,
> at compile time, that every CPUID-based feature that KVM queries when
> emulating guest behavior is actually known to KVM, e.g. to prevent KVM
> bugs where KVM emulates some feature but fails to advertise support to
> userspace.  In other words, any features that are special cased, i.e. not
> handled generically in the CPUID framework, would also need to be special
> cased for any hardening efforts that build on said framework.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index de898d571faa..16bb873188d6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -36,6 +36,8 @@
>  u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
>  EXPORT_SYMBOL_GPL(kvm_cpu_caps);
>  
> +static u32 kvm_vmm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
> +
>  u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  {
>  	int feature_bit = 0;
> @@ -115,6 +117,21 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  	feature_bit(name);							\
>  })
>  
> +/*
> + * VMM Features - For features that KVM "supports" in some capacity, i.e. that
> + * KVM may query, but that are never advertised to userspace.  E.g. KVM allows
> + * userspace to enumerate MONITOR+MWAIT support to the guest, but the MWAIT
> + * feature flag is never advertised to userspace because MONITOR+MWAIT aren't
> + * virtualized by hardware, can't be faithfully emulated in software (KVM
> + * emulates them as NOPs), and allowing the guest to execute them natively
> + * requires enabling a per-VM capability.
> + */
> +#define VMM_F(name)								\
> +({										\
> +	kvm_vmm_cpu_caps[__feature_leaf(X86_FEATURE_##name)] |= F(name);	\
> +	0;									\
> +})
> +
>  /*
>   * Magic value used by KVM when querying userspace-provided CPUID entries and
>   * doesn't care about the CPIUD index because the index of the function in
> @@ -674,7 +691,7 @@ void kvm_set_cpu_caps(void)
>  		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
>  		 * advertised to guests via CPUID!
>  		 */
> -		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
> +		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64 */ | VMM_F(MWAIT) |
>  		0 /* DS-CPL, VMX, SMX, EST */ |
>  		0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
>  		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |

Hi,

Not sure that this is worth it. Especially, IMHO the definition of
'KVM honors if they are enumerated to the guest, even if KVM itself doesn't advertise them to usersepace',
is very problematic - AFAIK KVM allows/honours userspace to set anything in the guest visible CPUID, I myself
caused a guest crash once on purpose by forcing it to see AVX3 which is not supported on my CPU.

I think that you mean features that KVM also uses for itself, e.g disables certain VMEXITS, etc,
but this is very hard to understand.

IMHO it is better to handle this case by case basis, it is less confusing.

So far, MWAIT is the only such feature, what do you think is the probability
of Intel/AMD adding more such features?

Best regards,	
	Maxim Levitsky


