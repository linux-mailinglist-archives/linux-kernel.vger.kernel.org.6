Return-Path: <linux-kernel+bounces-246585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABA92C3E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C86B2233C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64709182A74;
	Tue,  9 Jul 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnYN+9U5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B4182A67
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553288; cv=none; b=MtIETNwfcHHBl7vqKe7WGiBAFVu2l51UTcvzAQAJWmA9aFea86InvlJ8uyELTCm4ZxAH0AtAPyax1U0g1qt/Rgooo6f+4cV6KCzib+XZZNDc8vK/MaiT1mihX7aLJBM1CzBG8aihxPLwQaCGO6gjA3VsJjOzmWJpR6mVI8fIT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553288; c=relaxed/simple;
	bh=tGk64PZTZhXihUtRm6IYWWYJazPp+3ZgAGpmSoZB3ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEtiPdFreu39g8T++TELB3TRqGHpG6FvfI4nxKyZGk/lgEdMMNjxsN9b9Uv1lfMW1nG3fSfqlIN/eh0YeZfDkkkYbWPmi9b/8cHmEfZYld7zdzIwn/itM3pVC+iNy9rtyvRLFi+AKJnR8KRjSRpTokNbBzNIs/GViVLnCeVM/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnYN+9U5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1faf6103680so25657275ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720553287; x=1721158087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BfHp9bQzvvOsKp2JilOmjO7TBNJLedjR/ZG6jBd2vA=;
        b=jnYN+9U5f9nJUmTLrypaEUgiP6tK+WF3Y3e1NveKBF8A65sOztA3VCIJj8cLxAhMko
         uFbuWgtrm1Ln62JPVM6XD4rCzgSNkVWI/DapXXa4bkENjzYuuoUiWSAFd3O+Oglfo5g8
         WCDW73vKsKoN1h2Y42vDY1aECaRF1SVxJIeiJmc14O7XY5cvuCGNQvcSim+qLQb3xwDw
         6U0POcugwlX8QTxPJxxe5b3wDG8L9Ko52t0aka12dP+MRnNXxiwe83qMF/bBcce29Z7N
         2xlPAiNuHLfk2ileCbDjs+UZQqf+Dn515UknkkV5wlkmj0kh8mg5dy8Q5Dja2mAxzAPo
         IzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720553287; x=1721158087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BfHp9bQzvvOsKp2JilOmjO7TBNJLedjR/ZG6jBd2vA=;
        b=psmx/0bxN4E6pgHcHUswVutRQueBhqncpb/9/ipp0+ObRrPzYJJ1YeeKrP2iTAOrGc
         oNuLi57iVAIsJyoagAgiEO0w1hBGBlM+9luPcLIdkkzp3stYUyq3+d3tvCtNe3xptezW
         2iOwQHBq9zJBQb0cJ9WJv5QnQuFULUDc3hZzpn4/ekgTKnzChI+QxxTZX9DCtGdgLZt7
         YayPZ/MUgeYRSNcqCsO2pC7E+vExEBKxIVfvQYdCs2UMfoyl9qQrEJ2ckfTkMPaXN+EF
         03O0ilWKO7Zh+qZsGSGDPYQAPKgloWbM68PL2QilPscWCwFWtShQzWrkgEJlWKHO8vzJ
         3ykA==
X-Forwarded-Encrypted: i=1; AJvYcCWo9v5bltQJfUavaOy0TfbGUeMaG061BHpEk60FhY/5hrGQ6/sN/X5b3rRgd8MnqHi2t/I4D1GZHq1+UotP/3pQyQu65ryAFwbMlQMI
X-Gm-Message-State: AOJu0Yz8FjorIo5OUhoLAkPjOS5QTrGxfjhTBKwKejqzqUeNryreMJed
	9L/yro4kAYsHJYPL5Gd6x/NXm4aLm2Ad/AJNRi1ERQNYLt/V0nDj4OsFKwAFuz1SqaljwncwyEE
	lHw==
X-Google-Smtp-Source: AGHT+IGWhkiIz2Y2g3Ner7BOHEwPH6Z/gYQ/jE0/y9L37RbGyZJn6Z1cRXZGPxQRndFfUlsvmeisfjj31Zs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2442:b0:1fa:13d8:a09c with SMTP id
 d9443c01a7336-1fbb6d601c4mr1788535ad.10.1720553286750; Tue, 09 Jul 2024
 12:28:06 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:28:05 -0700
In-Reply-To: <924352564a5ab003b85bf7e2ee422907f9951e26.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-34-seanjc@google.com>
 <924352564a5ab003b85bf7e2ee422907f9951e26.camel@redhat.com>
Message-ID: <Zo2PRdv1KMf_Mgwj@google.com>
Subject: Re: [PATCH v2 33/49] KVM: x86: Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID
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
> >  4.47 KVM_PPC_GET_PVINFO
> >  -----------------------
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 699ce4261e9c..d1f427284ccc 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -680,8 +680,8 @@ void kvm_set_cpu_caps(void)
> >  		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |
> >  		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
> >  		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
> > -		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
> > -		F(F16C) | F(RDRAND)
> > +		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
> > +		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
> >  	);
> >  
> >  	kvm_cpu_cap_init(CPUID_1_EDX,
> 
> Hi,
> 
> I have a mixed feeling about this.
> 
> First of all KVM_GET_SUPPORTED_CPUID documentation explicitly states that it
> returns bits that are supported in *default* configuration TSC_DEADLINE_TIMER
> and arguably X2APIC are only supported after enabling various caps, e.g not
> default configuration.

Another side topic, in the near future, I think we should push to make an in-kernel
local APIC a hard requirement.  AFAIK, userspace local APIC gets no meaningful
test coverage, and IIRC we have known bugs where a userspace APIC doesn't work
as it should, e.g. commit 6550c4df7e50 ("KVM: nVMX: Fix interrupt window request
with "Acknowledge interrupt on exit"").

> However, since X2APIC also in KVM_GET_SUPPORTED_CPUID (also wrongly IMHO),
> for consistency it does make sense to add TSC_DEADLINE_TIMER as well.
> 
> I do think that we need at least to update the documentation of KVM_GET_SUPPORTED_CPUID
> and KVM_GET_EMULATED_CPUID, as I state in a review of a later patch.

+1

