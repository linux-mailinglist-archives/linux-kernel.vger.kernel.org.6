Return-Path: <linux-kernel+bounces-244894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E492AB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC61B1C219F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF014EC77;
	Mon,  8 Jul 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pB0h5bSd"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098181211
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473534; cv=none; b=KeZA49fgjMERKPHR8HeZmN24R17elk1UbiQmVMZuHq7uIg+Fy3W2+zgRNJDKVqkezq6+wOYuzlNBbU9Umuhp2DXSId/gCGOE8gbflLQCL5Rdxh5vPvqVpEFhLI5opddEXVLqxywqaS8xwk9/E+Cbe/qV22KsE9njr0h3zJy+HCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473534; c=relaxed/simple;
	bh=4tpbHtGgkrRcpM7dGHbd69PC5ucXnx833z8uv+u3LPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLTaGGf7mEN6v3DBWwY87BecjeGxWmsnCJqMe2xMLdzaZzIXzXm3pOV3iIJb/Kf6YRrVMmNKZ/jyNICjwMar5wpHsGf+yg042Re276AA6ciYl7opY0CPhEvFog/L1pwytVCoZiK1cvYTjBW90fwjVTUgWqZ3wMEKqqJhpCNIPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pB0h5bSd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7276dd142b4so3568042a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720473531; x=1721078331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tj1ms3U8LTm4UyZ4fve/C+MAzvup9uK9AJzLieincvc=;
        b=pB0h5bSdO/5rrnI90Jl1oytkGKots4VSA3dFWsODbfmkNedZ2PZL+wG5EAJdxpuYim
         tJzuttGDaSjLKTTeHoetoHT/yVZQmmCs2YQ60xsWXWLTMwKFA2RxdImErAHMociHVj4l
         vDfMdaop0CdV4xKUAA86qpS/dnmQWmoj9dHM8BhcC0DLqMt6d/qGlbRlalnxWZc17rh0
         jPHe6JnlFwtptlHkV9vXqwLRk72hQ3L76kFtTnDZ+1AGXFheI38d7QC3jGxDYEtV6MMH
         sWNpxbGdpqHwARW+POUx4ZfdVtR0ZnIWP6QilLOt0MsSFQwD6Oz14O9UT/QfmXaJXzzI
         mAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473531; x=1721078331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tj1ms3U8LTm4UyZ4fve/C+MAzvup9uK9AJzLieincvc=;
        b=Jtuz5bNLI/qbR2MN7NYK9X4s1+kJ9WQ2Rxr118KB+oSqVObF+Rbv7dFxOuhi9HsXWb
         DqA3TI5EdlrfngbZXSq8BE43L8WyX8sRQGh/lixgzid8iQYWQjz4YPXj3n4NAS1spMc3
         F8R5kO4C3VVjXt0jfTiiHqdShvNR9LZ02N3zgTLvYqOoFJp+pCWVcJonpREi7o4NxF0b
         9xSvDRRjDZChbiylFCE/NmLscV/POLOYn8O3oEHyobsBg/amgYdFyx2qcFOMR1Sg+JS9
         IJ5UOYbigUND0BHVOhRh7gdePc308OW4Amf2fnSSJHq818ljpN13ipUvFdmDVai2AFTd
         uIQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6RxcsLIcfYUKetcK6PvmY6yIGv9owZ0PqgpGE55V0i+5blPZXjEx/2ZMQIlMzx2B87EE+S3qwlkpTfI3Tf8EzLklbWj5lU6h2bOXW
X-Gm-Message-State: AOJu0YxnEhha+bQfrp40h8yPagRfvg7tC0XJ3OOHLky7u4C5lxrQSoyt
	7bht0XeEzul49LsIDUPctLZLs4E4ga00wEnnhxcmD/WIjlQUBB+qTJp0LqFQwzKD9uErfo6W/lW
	uTg==
X-Google-Smtp-Source: AGHT+IGg5p5OadF9zVGv2d0hOmKOT17RVRkOTmycs6tdmWNfiB6T/IuUOm5CedZTAAwwzx7oc6rsO31VX+Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a0a:b0:2c8:632:7efe with SMTP id
 98e67ed59e1d1-2ca3a833655mr8182a91.4.1720473531440; Mon, 08 Jul 2024 14:18:51
 -0700 (PDT)
Date: Mon, 8 Jul 2024 14:18:50 -0700
In-Reply-To: <7bf9838f2df676398f7b22f793b3478addde6ff0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-24-seanjc@google.com>
 <7bf9838f2df676398f7b22f793b3478addde6ff0.camel@redhat.com>
Message-ID: <ZoxXur7da11tP3aO@google.com>
Subject: Re: [PATCH v2 23/49] KVM: x86: Handle kernel- and KVM-defined CPUID
 words in a single helper
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > Merge kvm_cpu_cap_init() and kvm_cpu_cap_init_kvm_defined() into a single
> > helper.  The only advantage of separating the two was to make it somewhat
> > obvious that KVM directly initializes the KVM-defined words, whereas using
> > a common helper will allow for hardening both kernel- and KVM-defined
> > CPUID words without needing copy+paste.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 44 +++++++++++++++-----------------------------
> >  1 file changed, 15 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index f2bd2f5c4ea3..8efffd48cdf1 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -622,37 +622,23 @@ static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
> >  	return *__cpuid_entry_get_reg(&entry, cpuid.reg);
> >  }
> >  
> > -/* Mask kvm_cpu_caps for @leaf with the raw CPUID capabilities of this CPU. */
> > -static __always_inline void __kvm_cpu_cap_mask(unsigned int leaf)
> > +static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
> >  {
> >  	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);
> >  
> > -	reverse_cpuid_check(leaf);
> > +	/*
> > +	 * For kernel-defined leafs, mask the boot CPU's pre-populated value.
> > +	 * For KVM-defined leafs, explicitly set the leaf, as KVM is the one
> > +	 * and only authority.
> > +	 */
> > +	if (leaf < NCAPINTS)
> > +		kvm_cpu_caps[leaf] &= mask;
> > +	else
> > +		kvm_cpu_caps[leaf] = mask;
> 
> Hi,
> 
> I have an idea, how about we just initialize the kvm only leafs to 0xFFFFFFFF
> and then treat them exactly in the same way as kernel regular leafs?
> 
> Then the user won't have to figure out (assuming that the user doesn't read
> the comment, who does?) why we use mask as init value.
> 
> But if you prefer to leave it this way, I won't object either.

Huh, hadn't thought of that.  It's a small code change, but I'm leaning towards
keeping the current code as we'd still need a comment to explain why KVM sets
all bits by default.  And in the unlikely case that we royally screw up and fail
to call kvm_cpu_cap_init() on a word, starting with 0xff would result in all
features in the uninitialized word being treated as supported.

For posterity...

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 18ded0e682f2..6fcfb0fa4bd6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -762,11 +762,7 @@ do {                                                                       \
        u32 kvm_cpu_cap_emulated = 0;                                   \
        u32 kvm_cpu_cap_synthesized = 0;                                \
                                                                        \
-       if (leaf < NCAPINTS)                                            \
-               kvm_cpu_caps[leaf] &= (mask);                           \
-       else                                                            \
-               kvm_cpu_caps[leaf] = (mask);                            \
-                                                                       \
+       kvm_cpu_caps[leaf] &= (mask);                                   \
        kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |                   \
                               kvm_cpu_cap_synthesized);                \
        kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;                     \
@@ -780,7 +776,7 @@ do {                                                                        \
 
 void kvm_set_cpu_caps(void)
 {
-       memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
+       memset(kvm_cpu_caps, 0xff, sizeof(kvm_cpu_caps));
 
        BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
                     sizeof(boot_cpu_data.x86_capability));

