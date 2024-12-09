Return-Path: <linux-kernel+bounces-438014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A79E9BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1096280F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC238145B18;
	Mon,  9 Dec 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoE8Vq71"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CE13D638
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761682; cv=none; b=GrlmQkuUJ2c740TsY2vt7GkE9L6KM71FMWVpbD8BfGa0eWOMkrLA6YUcNu7TNLbJa/x1RvRftublYsuQZnRBRxOxfIeDUY8OKApAbFQTAZ3VtlQd2iCFMjUKfwEzGnVULPEXe7rx5yc1A/JCcOiXY92SHKAnAx0nJc7GuhVmpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761682; c=relaxed/simple;
	bh=AdEnxicU2STjpq3ikTbZjnc/S2OME5UFiF4f0x65jR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SvsLrZnD8mcyDeZVOr+skbAOW+XrwXEszW5rOcNlVSyppaijOxcQDNZGP8PEmcJ+bqum6n+rF+MZPdioR8hpnXmrhJZ+P9dc/DKSNBiVUINi/+5C6y261QmVX5ZpVqEIbkXFLXMCrLZTH/2Wi/Rs305lQgMOID/J77gm0q1AaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoE8Vq71; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efc4196ca0so737100a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733761680; x=1734366480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ClcEP5PKkA7szGhQgC5YhzM7rTFIFvC6e9G4p2yd1dU=;
        b=KoE8Vq71EmJkD761dvsKO7ld6HnAREWdWxKOO3rQAi6RRX1Jn717QcW/uT703ST/G/
         MAHxrHYxzlf6EBhnBftgtNoLuq+iZGJ0mOBlLIaU0YVMbPVuw/RvXBFspVLaM1618ng5
         4ByT5EGk/VDt6+M0fztO/EcEZvCEUmioqLaK6f/8rFAEELUYFoR9ooJjTVU2Z+RP2D2X
         3dWPEcaTHfDiwAoDRqor/CZOapauUoV9sftKqNsd7Mo8RrQ768nb5q1luvLmeEDGMQhF
         u7GhwTMavaL1szQ0zDpnZigWA8bUNF6RSzXtXccaAxEhLr9hVVBQLjI5UHE2GRwB8RSH
         hQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761680; x=1734366480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClcEP5PKkA7szGhQgC5YhzM7rTFIFvC6e9G4p2yd1dU=;
        b=eZFxaD8A0e9B48YMXH9B0i/n6+8Zrp1KcLQ5rg9shnb4PkMdl4lAHH8QtYDK00K5jx
         6TETKRfZsbH+1fmjKH7fqe0GggT8blKx+TvuflUESolDiOY0Fzc91oD5/pFkUcaHX6+Q
         Tvw3AJfokJHFpI1LqmkRD138PMAWWKeTGzMZr+F7LCrjk3VFyMphgQaR8h+cbLVxNhDw
         Q4CAwIZap5/uOezKWtuuTlCbu1tJajCl8WHT5yftQREdeA5W+qAuqkPGzWVoifF0LwNN
         WdxgPkIxnpO7PubhGMq2uXUu54b3n0BxFfQIR8uHEWbzUv2uEJ+ZMjZf836oWlAEn03U
         oEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEJvrZ3pXAZdxEyHXdeB57dPPXyxKPvVlS7YKzCCz3VVh6Zhz6aUnKkgeuFYt3CHBHjdPquzLZyDmBviQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmCY4FrC06NVSdmsvpzLDYYzuseh4lf3yChyszEVGFUuUfJHp
	4C1hy/LKCleFvgZ51/Xcvw0R8DW7m2ZXLzNhgbv2Bys1JVKYtTuhoXkhyFBHd5ehjZnqGjQ+zv9
	EfA==
X-Google-Smtp-Source: AGHT+IH4ewNhkYUoS6xXQv9yrWjVawwNqAC9m79KmL2iLdYcKD6kN06Z7tRRwjIKns4aER0Uf2nGP97lIlk=
X-Received: from plsh4.prod.google.com ([2002:a17:902:b944:b0:215:515c:124e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:215:b18d:ef
 with SMTP id d9443c01a7336-21614d4e548mr170466035ad.25.1733761680217; Mon, 09
 Dec 2024 08:28:00 -0800 (PST)
Date: Mon, 9 Dec 2024 08:27:58 -0800
In-Reply-To: <d6680add-f4d2-4d65-a711-3f80bfd43f6d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com> <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
 <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com> <20241129182747.GEZ0oHo1eR0l7sREJY@fat_crate.local>
 <d6680add-f4d2-4d65-a711-3f80bfd43f6d@intel.com>
Message-ID: <Z1cajm9oqRZWDp_4@google.com>
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 06, 2024, Dave Hansen wrote:
> On 11/29/24 10:27, Borislav Petkov wrote:
> > Well, enum cpuid_leafs as it is now is the *indices* into the cap flags array:
> > 
> > struct cpuinfo_x86 {
> > 
> > 	...
> > 
> > 	__u32           x86_capability[NCAPINTS + NBUGINTS];
> > 
> > And having a "CPUID_" prefixed thing and a "CPUID_LEAF_" prefixed other thing
> > is going to cause confusion.

+1.

What about CPUID_FN_xxx for thing architectural leaf function number?  E.g.
CPUID_FN_80000007 or maybe even CPUID_FN_0x80000007.  CPUID_LEAF_xxx is arguably
wrong anyways for entries with sub-leaves.

There's still potential for confusion, but I think it would be clear enough to
be offset by the niceness of replacing all the open coded CPUID function literals.

> > And renaming enum cpuid_leafs is going to cause a massive churn...
> 
> Wait a sec though:
> 
> $ git grep 'enum cpuid_leafs' arch/x86/
> arch/x86/include/asm/cpufeature.h:enum cpuid_leafs
> arch/x86/kvm/cpuid.c:static __always_inline void kvm_cpu_cap_mask(enum
> cpuid_leafs leaf, u32 mask)
> 
> So there is only one direct reference to the type.
> 
> I think all it will take to rename the _type_ is something like the
> attached. Also, I think the new name 'x86_capability_words' and variable
> 'cap_nr' make the KVM site a lot more readable.

KVM's usage of the type will be gone in 6.14[*] (not yet applied, but it will be,
soon).  Unless renaming the enum type is central to your plans, maybe just wait
until after 6.14 to clean that up?  Note, we should also rename KVM's enum
kvm_only_cpuid_leafs to align with whatever the new enum name ends up being.

As for "cap_nr", IMO that is a net negative relative to "leaf".  For all CPUID
leaves that KVM cares about, the array entry is guaranteed to correspond to a
single CPUID leaf, albeit for only one output register.  KVM has definitely
bastardized "leaf", but I do think it helps convey that the "word" being modified
corresponds 1:1 with a specific CPUID leaf output.

[*] https://lore.kernel.org/all/20241128013424.4096668-27-seanjc@google.com

