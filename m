Return-Path: <linux-kernel+bounces-244951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DA92AC22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A872829B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5621514DE;
	Mon,  8 Jul 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDHSrmw2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10009BA46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478181; cv=none; b=aBe19tD/RrCy2caYbkc7S7+emabrwkQ9yzI54yuP9vfVhrw+sfWNEjEK54QptVdS8TNfma+wGlxyXEAj3OC7u/2kPkKqFFcOGqDF2lJTKatS6DfZER2w9Ixs+lnkrM6Y8LjWCIWUiuALdN652SliThOi6keCCvHFqVln/qk607U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478181; c=relaxed/simple;
	bh=sS+aA+61WvmVMRyWzqSmxp9lCMKYKLpnWDbbWJ/3+Ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tt84PA3VSTNa4ALgb9ZDbPEY/B//2hiMoIVtypVCL0aj8lIzIUd9YDUz1L+7vftt+4B5Xe8hkuyqOz6rVWGH5t0oe4jo2hQt2RCoEQ7ZcAWFh+1H8ArhYrc33/uytDMbOu2wews4CZcK6xEKGXz3A1hZYa0rjHf28aiAmQH6kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDHSrmw2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7276dd142b4so3606493a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720478179; x=1721082979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cD1Qpo+uuv5xlu18prTjZ+BvmV59bvvDA/o4JDPvEwE=;
        b=CDHSrmw2wwVVY6knqZFZQiGVxxk5NK/dPAYCOgOWUY16AlPwydjcxTSztZSr/TnLaO
         Rx8/8F7myFwZx/6j/MpF7qtH6qJ/f3a9ZQNTLmMnG3gXdga4YKzWyYJ0cckdhRLkTAZC
         2opC+mxIEwveW+62nl7FE2ZreyI5iuDvn5ltW4G8Hksor5yGBu7CZrBnoB0wpUvHPbyn
         lXJcHduv3wdQfUBMZzjuGVmtj8W/l6zoNxlchew2re14+0XTyx6xtGCIxEtQr8kxXra8
         IO+dDEFd3j+JE7or5vO2wb+riPndHiZ4DsjkeNmJGIa6y/bZVIKbE/SUOLDxIoVU9luI
         8HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720478179; x=1721082979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD1Qpo+uuv5xlu18prTjZ+BvmV59bvvDA/o4JDPvEwE=;
        b=lKX7zhprT2eNJeNVJYNXTOrd3AFeTpS8z1ywYIr/snfA1zr7U1JIwYdZo5KtMXspMB
         eu8hQOa/JzXeLmypYLICRXHTmrZJKQTsvfUDS+V3jNcH5fJ/oz+h095hkyuXOPQI900K
         P2o+KCowkKBY0dPUcPt5wCpHEobjeuV3Y0DVJthASYWIwIJXMWTW5p9Alj9W1MRK4bLz
         LfcQGTkflK11g59gMYw7P3v4Gt+0VtolmBFThjg7QHVIiQuDRoQ5MVtqER2Hl2wyF9az
         3L/B64PGR+jB7oqQ6pcuNdQDoROlHVi9rEVCpVYGQivTKYXeokqV//S0CB+32Cwevia7
         dHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW26f1SfUIEcEUBKaE0sGO5+AeBkvONOhJRlF6u29U8yWheKlHjughNDlVsh17ATr/E414CDvSHq0OXJ3Hv0LvIwJTMwzs3RUpkntwF
X-Gm-Message-State: AOJu0YylwMacA58DMOUTaxOLFFZPPn7ysJxrkH8jKLUOJe828eNvgdWX
	tXPtGzEwQA9Ku35VNYMcegrbUdea/CyvK/gOqWaG6IPgorZQ62wA+sj63HIM4Dq+y42gqPGWgxM
	Tag==
X-Google-Smtp-Source: AGHT+IEk/qagQm+PPoKBgAq1/IZEHMXRJTtdyHcj3BaOnR/XnjzjVOfM2KhbJnFogRXhtaCmRNAUu5C1hbM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f18b:b0:2c6:d13f:3f9e with SMTP id
 98e67ed59e1d1-2ca3a7abd45mr10383a91.1.1720478179380; Mon, 08 Jul 2024
 15:36:19 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:36:17 -0700
In-Reply-To: <2a4052ba67970ce41e79deb0a0931bb54e2c2a86.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-20-seanjc@google.com>
 <2a4052ba67970ce41e79deb0a0931bb54e2c2a86.camel@redhat.com>
Message-ID: <Zoxp4ahfifWA-P34@google.com>
Subject: Re: [PATCH v2 19/49] KVM: x86: Add a macro to init CPUID features
 that ignore host kernel support
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > +/*
> > + * Raw Feature - For features that KVM supports based purely on raw host CPUID,
> > + * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> > + * Simply force set the feature in KVM's capabilities, raw CPUID support will
> > + * be factored in by kvm_cpu_cap_mask().
> > + */
> > +#define RAW_F(name)						\
> > +({								\
> > +	kvm_cpu_cap_set(X86_FEATURE_##name);			\
> > +	F(name);						\
> > +})
> > +
> >  /*
> >   * Magic value used by KVM when querying userspace-provided CPUID entries and
> >   * doesn't care about the CPIUD index because the index of the function in
> > @@ -682,15 +694,12 @@ void kvm_set_cpu_caps(void)
> >  		F(AVX512VL));
> >  
> >  	kvm_cpu_cap_mask(CPUID_7_ECX,
> > -		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> > +		F(AVX512VBMI) | RAW_F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> >  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
> >  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> >  		F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B) | 0 /*WAITPKG*/ |
> >  		F(SGX_LC) | F(BUS_LOCK_DETECT)
> >  	);
> > -	/* Set LA57 based on hardware capability. */
> > -	if (cpuid_ecx(7) & F(LA57))
> > -		kvm_cpu_cap_set(X86_FEATURE_LA57);
> >  
> >  	/*
> >  	 * PKU not yet implemented for shadow paging and requires OSPKE
> 
> Putting a function call into a macro which evaluates into a bitmask is somewhat misleading,
> but let it be...

And weird.  Rather than abuse kvm_cpu_cap_set(), what about adding another variable
scoped to kvm_cpu_cap_init()?

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0e64a6332052..b8bc8713a0ec 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -87,12 +87,10 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 /*
  * Raw Feature - For features that KVM supports based purely on raw host CPUID,
  * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
- * Simply force set the feature in KVM's capabilities, raw CPUID support will
- * be factored in by __kvm_cpu_cap_mask().
  */
 #define RAW_F(name)                                            \
 ({                                                             \
-       kvm_cpu_cap_set(X86_FEATURE_##name);                    \
+       kvm_cpu_cap_passthrough |= F(name);                     \
        F(name);                                                \
 })
 
@@ -737,6 +735,7 @@ do {                                                                        \
 do {                                                                   \
        const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);    \
        const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;   \
+       u32 kvm_cpu_cap_passthrough = 0;                                \
        u32 kvm_cpu_cap_emulated = 0;                                   \
        u32 kvm_cpu_cap_synthesized = 0;                                \
                                                                        \
@@ -745,6 +744,7 @@ do {                                                                        \
        else                                                            \
                kvm_cpu_caps[leaf] = (mask);                            \
                                                                        \
+       kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;                  \
        kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |                   \
                               kvm_cpu_cap_synthesized);                \
        kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;                     \

