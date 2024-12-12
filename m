Return-Path: <linux-kernel+bounces-443806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D99EFC02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A570B288ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D518FDC9;
	Thu, 12 Dec 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXRpmOFS"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C42188722
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030338; cv=none; b=Mwz94QKAGJhORKCfmnLYgoKfuVQ/jj4GDkZOBzn0ZMSGE4gXlhyO3tUG3oHuuxHduiASL+QV77ySai+nmgvQuPodx8fdE9l6ZyjEr0nPTyn5kS2gqqM+ylvW8yLOBJqCchbp+XPNa4p3JT6zQBLF5oV1c3nEy5OD0TBG1LiUMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030338; c=relaxed/simple;
	bh=Dw47rf7cLJIaN7t10ASVEiOwdAE/23UQLgOS/2Rgsp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=siXPTTIrJHBjaKP8h2QKF2nUD/kD2YIIjdnObFRt23p57EWrIrvQxmTWodrb+A7ZePlfcJw/FLka6C/i5dNnSk3lPIIMNjp4lBf+DWW5njcwfCJlzTyN/kgxMyLWcqqKu9X00XsDhHDnZnPllePwnJ1Vj7rbbl7f1+4+3yWfA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXRpmOFS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso949686a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734030336; x=1734635136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYWrigOtuAf9LdwbPjTO9DkgxrnSgDFVgY1WMibPFs=;
        b=XXRpmOFS34OVxXrCoBQW2tc+M0xbuEzUrALdiUN7QfRt44RE1gt946M6PSyGY34rm7
         F3iXW+FdkRcoRsimw4gVUralS0QQNBbNhLWmc7g3J1VhFTF85pPVDHQEp/VR5E4rgLq9
         YH3j13w7KdQPcuFZMuFeaJK3kV9nPkc42RYoNNnFLZBrbepR/5PniLTi+3Q3wE5WlWUS
         IsUTOKLyR5mQUgetfgkcPtzeWQ6Xl2pr1g+FEUzatqW06+tT7I9dqHPwfy3Y8yANVrP/
         R9nSssCFRcHYTLs48qqTEbmy2wkm6FlUT7LB8Qxoc21RE3/pAUrfLYuS4MKB5eusBM8S
         KY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030336; x=1734635136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYWrigOtuAf9LdwbPjTO9DkgxrnSgDFVgY1WMibPFs=;
        b=DU7paNk0KgJhDPfNiGh98EjIM+T9Gj1ERzjzQ0VNCMwnihul66qrV/nEBoFRGAzNG1
         +d+60SqM4+V/rRaaZaE9PmbSKNp7kGUzUUj2C2Y8vd+19JOPZ2dAxkTDqmzyuM+hJ73W
         +AD+q3C8CJ806pDAjF7yHZuG+yaFYbt4my1jC+q8/dYu94jpcg/nfE3nzatzsjAAh+vC
         JL4Xuytxy4OnXGyWil5HW+Rw4eUwtMqslk5MBZPqDpx3ngBwVKEwji6T7Zog3ltcMGAk
         zXRFk7ek3R5+T09PkZHu9PkZAN7wTuvUq25d5T7+lwwCqHbv7Z0PkCuU9QO72DcCshdc
         AxNw==
X-Forwarded-Encrypted: i=1; AJvYcCUu3Y6HjRe9iOFW7XYp/lCOF2vG2q2Rbb8pVszOS6DssoI9wbuMS3UZRDCaceWO9q5gIidXNvNnwIsUB4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOPvAeh15up9TwNQeTwAW8+MbOA/wEo+ZB+dazQ0cXeX9BOgo
	L2wUZhqq0ACza8wi/jB4pTvffgkw6m5JO+KOKbUUt7R8TV4yW8DxmSFCFy/nNQu9j9U7Mazg3H4
	Tgw==
X-Google-Smtp-Source: AGHT+IEdEhxrbv665tX5mqtqZnesDlC8QyYfPay6nTyYChemGnidc5QlP+2jSdQpsoMDrBFTy7xKqsXeQuk=
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:2ea:adc3:8daa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d04:b0:2ea:6f19:1815
 with SMTP id 98e67ed59e1d1-2f13930b9b2mr7758202a91.24.1734030335893; Thu, 12
 Dec 2024 11:05:35 -0800 (PST)
Date: Thu, 12 Dec 2024 11:05:34 -0800
In-Reply-To: <3ec986fa-2bf0-4c78-b532-343ad19436b2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001050110.3643764-1-xin@zytor.com> <20241001050110.3643764-18-xin@zytor.com>
 <Zxn0tfA+k4ppu2WL@intel.com> <3ec986fa-2bf0-4c78-b532-343ad19436b2@zytor.com>
Message-ID: <Z1sz_oMq8yX--H7U@google.com>
Subject: Re: [PATCH v3 17/27] KVM: x86: Mark CR4.FRED as not reserved when
 guest can use FRED
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 12, 2024, Xin Li wrote:
> On 10/24/2024 12:18 AM, Chao Gao wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 03f42b218554..bfdd10773136 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -8009,6 +8009,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > > 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LAM);
> > > 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
> > > 
> > > +	/* Don't allow CR4.FRED=1 before all of FRED KVM support is in place. */
> > > +	if (!guest_can_use(vcpu, X86_FEATURE_FRED))
> > > +		vcpu->arch.cr4_guest_rsvd_bits |= X86_CR4_FRED;
> > 
> > is this necessary? __kvm_is_valid_cr4() ensures that guests cannot set any bit
> > which isn't supported by the hardware.
> > 
> > To account for hardware/KVM caps, I think the following changes will work. This
> > will fix all other bits besides X86_CR4_FRED.
> 
> This seems a generic infra improvement, maybe it's better for you to
> send it as an individual patch to Sean and the KVM mailing list?

Already ahead of y'all :-)  (I think, I didn't look closely at this).

https://lore.kernel.org/all/20241128013424.4096668-6-seanjc@google.com

