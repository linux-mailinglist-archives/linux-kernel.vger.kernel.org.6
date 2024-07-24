Return-Path: <linux-kernel+bounces-261354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3993B634
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8B71C2153F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3547A76;
	Wed, 24 Jul 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTfP0Cet"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408282E639
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843686; cv=none; b=RLLGWzhqElgiUGZ6/ImGlR2/OAtZkjfnaui6+UQ0Fb2rIRnDWvmj5pQ6XGIiCC4DrLdDmMcsLlTcyKBkSGJu+tL1YbKgWYDdY/XIM4oIEJYa0RzB8S5rcUSvX9lisk/VwfrWmTv+hX+uRsvy3vmTVIXJToVZ1Bys32MQB2jatzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843686; c=relaxed/simple;
	bh=wPbZa8uAkjpmTlvhMMPRbL1i9A7Un2i3eW8F2HLaIco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QR9QrJYDsqhnxr5J/PY9Bs8miF7TKeDvz6j/bE8IxJsDDLQGMYgMq/+pSlfLLrjzV1dHtwiezwdggklA99KZHjXuNxW2dfeojjThGXptok7zzsnqkd3YlzkO+zo9PpxWotHGaDBpJuKqHeWjUFa2gxrfrCg3b6AxpUu+X39NfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTfP0Cet; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721843684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtsJeKW2MN5I+G1FVsyysTWbPnlcSoryOv+03zhCSuY=;
	b=UTfP0CetoOCDXzrL41V1sYCZFjoLv0oPEoi0yGpPDSLI4Qb8xYub+DEOCtarQmQRmfrkuQ
	ELchg6AulOtviMCkXhVtXrl5A8/axd6Zl3Y24CTGV3LFfRgRtV4dDvHFW0n92893y9YRD4
	QHTid1/DyQ6GNl2KWc7WJXWHSKROMng=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-gRK9xETIPd2wAngRBd36Eg-1; Wed, 24 Jul 2024 13:54:42 -0400
X-MC-Unique: gRK9xETIPd2wAngRBd36Eg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-66a2aee82a0so2107937b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843682; x=1722448482;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtsJeKW2MN5I+G1FVsyysTWbPnlcSoryOv+03zhCSuY=;
        b=t/xZxsAKj+y8rKtYlw0iBZJEdq2Wif0bfw5Lguobo/hWwN4V8qvpp0Re1SA6r9VolS
         RlKjyUgfWp6Epr/kqai2a7B+Xo5w6TdY/WHSIepia5ZfeJFtVDfgCFiP8w+BuWNTnb4s
         LFXYUTqt5W3vna34EEqqH88B/TCUhw09RLQCF2wTOkmJ6mndLxhXlyxJg9Sh50Hi3T3e
         /XOej5rEsC4bFjDBfyEkjeDJmTAr8KlC+qJx3IP7Bc+GfyOt+l5v8gFf+HfbhIPpi0u7
         vTa3xPvzpg8LgNc0I9PIWZ7pqibJ2oI4TZfke6svOSFEVKOPKSyCqecT5QIUlAJRDwm7
         eW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQHSrM4vlVQ9zGEET70JDqmLHFiNaFZzbPk4Va7OAzDO0yayZ6hulA5tP8/luDM8FrBZAcmV3I4SzSyv4qvOa5gvuD5xMJPmdJJOlb
X-Gm-Message-State: AOJu0YxBNFTEaOMPJNVPzopHKqFd7+Ayhh3/HWZKwF3Xl/hY8PBwXvTu
	dhWE5ID+IOmIa70mq6mkr2r2Eir0ODNv4lGcQb+bgWXsoEksvnnRfVQufKYXwi0p0lBN4TUzTaT
	rryJY9K0PR3RXrMjerhnCaM7Rs+MSDRaiMcbnbGYvBJH5AK9qqxjCR9ENYqD59A==
X-Received: by 2002:a05:690c:6ac4:b0:64b:77e:84cf with SMTP id 00721157ae682-675157de1b7mr2129857b3.43.1721843682225;
        Wed, 24 Jul 2024 10:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7ZhufvVDu7CBu0unHvBaoAn0APjwBQ3xRxdftEl7H3sXGXMaJ3Q7LuMOi4YATlacG3B5dzg==
X-Received: by 2002:a05:690c:6ac4:b0:64b:77e:84cf with SMTP id 00721157ae682-675157de1b7mr2129627b3.43.1721843681907;
        Wed, 24 Jul 2024 10:54:41 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7bd61dsm60223346d6.12.2024.07.24.10.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:54:41 -0700 (PDT)
Message-ID: <31cf77d34fc49735e6dff57344a0e532e028a975.camel@redhat.com>
Subject: Re: [PATCH v2 24/49] KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to
 avoid macro collisions
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:54:40 -0400
In-Reply-To: <ZoxaOqvXzTH6O64D@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-25-seanjc@google.com>
	 <20d3017a8dd54b345104bf2e5cb888a22a1e0a53.camel@redhat.com>
	 <ZoxaOqvXzTH6O64D@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 14:29 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > Undefine SPEC_CTRL_SSBD, which is #defined by msr-index.h to represent the
> > > enable flag in MSR_IA32_SPEC_CTRL, to avoid issues with the macro being
> > > unpacked into its raw value when passed to KVM's F() macro.  This will
> > > allow using multiple layers of macros in F() and friends, e.g. to harden
> > > against incorrect usage of F().
> > > 
> > > No functional change intended (cpuid.c doesn't consume SPEC_CTRL_SSBD).
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/cpuid.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index 8efffd48cdf1..a16d6e070c11 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -639,6 +639,12 @@ static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
> > >  	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);
> > >  }
> > >  
> > > +/*
> > > + * Undefine the MSR bit macro to avoid token concatenation issues when
> > > + * processing X86_FEATURE_SPEC_CTRL_SSBD.
> > > + */
> > > +#undef SPEC_CTRL_SSBD
> > > +
> > >  void kvm_set_cpu_caps(void)
> > >  {
> > >  	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
> > 
> > Hi,
> > 
> > Maybe we should instead rename the SPEC_CTRL_SSBD to
> > 'MSR_IA32_SPEC_CTRL_SSBD' and together with it, other fields of this msr.  It
> > seems that at least some msrs in this file do this.
> 
> Yeah, the #undef hack is quite ugly.  But I didn't (and still don't) want to
> introduce all the renaming churn in the middle of this already too-big series,
> especially since it would require touching quite a bit of code outside of KVM.



> 
> I'm also not sure that's the right thing to do; I kinda feel like KVM is the one
> that's being silly here.

I don't think that KVM is silly here. I think that hardware definitions like
MSRs, register names, register bit fields, etc, *must* come with a unique prefix,
it's not an issue of breaking some deeply nested macro, but rather an issue of readability.

SPEC_CTRL_SSBD for example won't mean much to someone who only knows ARM, while
MSR_SPEC_CTRL_SSBD, or even better IA32_MSR_SPEC_CTRL_SSBD, lets you instantly know
that this is a MSR, and anyone with even a bit of x86 knowledge should at least have
heard about what a MSR is.

In regard to X86_FEATURE_INTEL_SSBD, I don't oppose this idea, because we have
X86_FEATURE_AMD_SSBD, but in general I do oppose the idea of adding 'INTEL' prefix,
because it sets a not that good precedent, because most of the features on x86
are first done by Intel, but then are also implemented by AMD, and thus an intel-only
feature name can stick after it becomes a general x86 feature.

IN case of X86_FEATURE_INTEL_SSBD, we already have sadly different CPUID bits for
each vendor (although I wonder if AMD also sets the X86_FEATURE_INTEL_SSBD).

I vote to rename 'SPEC_CTRL_SSBD', it can be done as a standalone patch, and can
be accepted right now, even before this patch series is accepted.

Best regards,
	Maxim Levitsky


> 
> Aha!  Rather than rename the MSR bits, what if we rename the X86_FEATURE flag,
> e.g. to X86_FEATURE_INTEL_SPEC_CTRL_SSBD, X86_FEATURE_MSR_SPEC_CTRL_SSBD, or maybe
> even just X86_FEATURE_INTEL_SSBD.  Much less churn, and it would add even more
> clarity as to why there's also X86_FEATURE_SSBD and X86_FEATURE_AMD_SSBD.
> 
> I'll post a standalone patch to make that change, and maybe see if I can take it
> through the KVM tree.
> 




