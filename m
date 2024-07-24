Return-Path: <linux-kernel+bounces-261350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37AC93B626
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A413284A92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DC1662EF;
	Wed, 24 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNrcvjkI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533ED157E6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843474; cv=none; b=BxV0SZ86eKQKj3/ykZZ3UqILroas+kd8ezLG4I5qMPKkgNoVN2w+k786CaD6APo1hANDoI9Is1ukpCydufildUfOqLcaK/ejcwV147GY0avIo2qZ312xV9JY9H2dFAIN7n9rsfA393rKDtzT5i9EE051zExevMOiOM6jMk+j0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843474; c=relaxed/simple;
	bh=ihm3b2mDERcKi1vlDfQqgtswyS82YKMiBExvtCbI6ds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+aSSz20na4JFZukm8woCfWHZ5pbcNuzVDV1yyRJ+yp9wFk0PiyZqpmH8eEIW+nEKcA4A0b9eHyS42ujoskeezZ4sqRi3Dg0vz8GYqbwpiEp02tJKEYWHneP1th38hHprlCYKyKYehg81PjZgQGpbcrII10xihI5fJw4CsukDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNrcvjkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721843472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV1yGrjH+Z5B7DihgBc1LzjmdBaSPEJwZnNiDUiNaKs=;
	b=HNrcvjkIURqSSNBYv/gOmn7/jskacl3AH7IrLKNrPKOBbrVo4DJ8ImeufJzj4SI2IUlhV2
	lk6QG+AZ0BlL4bEt8rBLQi1KOP1SlRZlHMJ43QdO7MZRFrJ4smoxsfwHKujQqcwWnzRStI
	ayyaOn2VsQPkh+iR/ZcCW6fjm5j6Kjc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-rT4sCI7SO-Sfa4I91zD7_A-1; Wed, 24 Jul 2024 13:51:10 -0400
X-MC-Unique: rT4sCI7SO-Sfa4I91zD7_A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d4238d65so1023085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843470; x=1722448270;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NV1yGrjH+Z5B7DihgBc1LzjmdBaSPEJwZnNiDUiNaKs=;
        b=EfR7okkgDIRjo8XaVho3BKrCj57IYPk3HhEzo4oQAmRCPW7DV1nb+JpvOu7tZeUK5x
         2GTpUeMjwTcLitOiygVl2HZuZMuo+/UMdA12k0IuORv1qlhONXbEttTasb1N4Maa7UEd
         M5V8S8ZoLQsvW5CPe0UOOUP0GMDWizE8dnGUOhOziK9hisYfK/qT3khgXYMbMHaglvJV
         hynXEWaLvHIOi9Oz0jSX/Wym3CvHrHb5E8yW9nKVlAkl3IILuOkcc3fplpz2g1A6IaH9
         tMMfnp/7CACGuvZ1VMvya5A3MTWZKELz7e52HhvawkImcH1oPZHGYQZxXzbqqJpeadUC
         bljQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNxt32mWGK6H99pyimVL7qE69mMiwXiTWivWrCDO9h/G5qzBnWv1m+kX60ESktdK/bYe2H/aLG9/CTOBPgK8TGwjpIZvlHeEtlye/c
X-Gm-Message-State: AOJu0YwfrlAeYr99QBXtBSx89HH5J6HGvDXJK5mpuUf791ozcOOYs9rh
	TT88Xlobv5V4MDauTUWMIAoqT5kmC6JMiZeT5xrJSadLIrU3puddNLkdHobTZo3jxN6FiJ7akWI
	G+pb8tNAySUxyv9zGT3F0FLzGdfIjgq6t14I15OdXGiJhvij2Uu/vqmvr9t7I5A==
X-Received: by 2002:a05:620a:d8b:b0:79f:44b:9802 with SMTP id af79cd13be357-7a1d44d226fmr52227585a.5.1721843469849;
        Wed, 24 Jul 2024 10:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb/GQkROy5QgxluyJAik03doxFhjjyS4y18Gg4QcaJ0oHppWW9rwwzf46C5FLGv8bjEiGJOQ==
X-Received: by 2002:a05:620a:d8b:b0:79f:44b:9802 with SMTP id af79cd13be357-7a1d44d226fmr52225385a.5.1721843469495;
        Wed, 24 Jul 2024 10:51:09 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fba3c4sm602605685a.35.2024.07.24.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:51:08 -0700 (PDT)
Message-ID: <41bdc5a77013796fa8cb6e61c410af3e064e274b.camel@redhat.com>
Subject: Re: [PATCH v2 23/49] KVM: x86: Handle kernel- and KVM-defined CPUID
 words in a single helper
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:51:07 -0400
In-Reply-To: <ZoxXur7da11tP3aO@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-24-seanjc@google.com>
	 <7bf9838f2df676398f7b22f793b3478addde6ff0.camel@redhat.com>
	 <ZoxXur7da11tP3aO@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 14:18 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > Merge kvm_cpu_cap_init() and kvm_cpu_cap_init_kvm_defined() into a single
> > > helper.  The only advantage of separating the two was to make it somewhat
> > > obvious that KVM directly initializes the KVM-defined words, whereas using
> > > a common helper will allow for hardening both kernel- and KVM-defined
> > > CPUID words without needing copy+paste.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/cpuid.c | 44 +++++++++++++++-----------------------------
> > >  1 file changed, 15 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index f2bd2f5c4ea3..8efffd48cdf1 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -622,37 +622,23 @@ static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
> > >  	return *__cpuid_entry_get_reg(&entry, cpuid.reg);
> > >  }
> > >  
> > > -/* Mask kvm_cpu_caps for @leaf with the raw CPUID capabilities of this CPU. */
> > > -static __always_inline void __kvm_cpu_cap_mask(unsigned int leaf)
> > > +static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
> > >  {
> > >  	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);
> > >  
> > > -	reverse_cpuid_check(leaf);
> > > +	/*
> > > +	 * For kernel-defined leafs, mask the boot CPU's pre-populated value.
> > > +	 * For KVM-defined leafs, explicitly set the leaf, as KVM is the one
> > > +	 * and only authority.
> > > +	 */
> > > +	if (leaf < NCAPINTS)
> > > +		kvm_cpu_caps[leaf] &= mask;
> > > +	else
> > > +		kvm_cpu_caps[leaf] = mask;
> > 
> > Hi,
> > 
> > I have an idea, how about we just initialize the kvm only leafs to 0xFFFFFFFF
> > and then treat them exactly in the same way as kernel regular leafs?
> > 
> > Then the user won't have to figure out (assuming that the user doesn't read
> > the comment, who does?) why we use mask as init value.
> > 
> > But if you prefer to leave it this way, I won't object either.
> 
> Huh, hadn't thought of that.  It's a small code change, but I'm leaning towards
> keeping the current code as we'd still need a comment to explain why KVM sets
> all bits by default. 

I agree that the comment is needed, but the comment in my case is more natural - 
KVM only leaves don't come from boot_cpu_info, so naturally all features there are '1'.


>  And in the unlikely case that we royally screw up and fail
> to call kvm_cpu_cap_init() on a word, starting with 0xff would result in all
> features in the uninitialized word being treated as supported.
Yes, but IMHO the chances of this happening are very low.

I understand your concerns though, but then IMHO it's better to keep the
kvm_cpu_cap_init_kvm_defined, because this way at least the function name
cleanly describes the difference instead of the difference being buried in the function
itself (the comment helps but still it is less noticeable than a function name). 

I don't have a very strong opinion on this though, 
because IMHO the kvm_cpu_cap_init_kvm_defined is also not very user friendly, 
so if you really think that the new code is more readable, let it be.

Best regards,
	Maxim Levitsky


> 
> For posterity...
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 18ded0e682f2..6fcfb0fa4bd6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -762,11 +762,7 @@ do {                                                                       \
>         u32 kvm_cpu_cap_emulated = 0;                                   \
>         u32 kvm_cpu_cap_synthesized = 0;                                \
>                                                                         \
> -       if (leaf < NCAPINTS)                                            \
> -               kvm_cpu_caps[leaf] &= (mask);                           \
> -       else                                                            \
> -               kvm_cpu_caps[leaf] = (mask);                            \
> -                                                                       \
> +       kvm_cpu_caps[leaf] &= (mask);                                   \
>         kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |                   \
>                                kvm_cpu_cap_synthesized);                \
>         kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;                     \
> @@ -780,7 +776,7 @@ do {                                                                        \
>  
>  void kvm_set_cpu_caps(void)
>  {
> -       memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
> +       memset(kvm_cpu_caps, 0xff, sizeof(kvm_cpu_caps));
>  
>         BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
>                      sizeof(boot_cpu_data.x86_capability));
> 



