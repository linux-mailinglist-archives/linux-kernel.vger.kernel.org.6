Return-Path: <linux-kernel+bounces-389592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B49B6EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674071F212C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B53216423;
	Wed, 30 Oct 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFLA7yFr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6F1993BD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323551; cv=none; b=BEhDl3fl3odA1VltC8GUatKbfGWOUAUSfCBrj1nB42bNlQ20XVHcMzyqNzxVZOLLh8X2UHfYLjAcHU8V2pj8GAsiqEx+ox1SZQ4YQdtGgRtvs/tSnboJDMxQjbmZJcgHPg+wNjdvao5ZE5Ph9S5qiDODBCnhbbj5TpaNKN5utBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323551; c=relaxed/simple;
	bh=uktb2/n9LYbyfoz9ULmhE7qqOwivNjmiOVpQE1g9hoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9iaZpjOVlAH6eWCoG1u/V+wUQyzYqoJ9Mzn8QZ/UBLR3t+xzDeo45iPxxwEnUv7Lqh14gWlVZWulSYHr1LpwhQU0zYMwJI0svk6BlyQBTDXa/Bx2033BZmQZZx7IZhcwHXqTmUhUOXRhirewaj3IzdK5Gc/+A3d9rSX58a2oi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFLA7yFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730323547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEvC6qj73WFs9v4jNz8NvTdgCtpn9X+dib3hOxuvGwE=;
	b=eFLA7yFrcYfYKGZUWwAsG6NDZf+vWSiBLbKs2NRfPY6o4yhmcZtzlhPBlN+uvRe/EI1ie6
	M8nFOi15gFPo/6qTGNAzkKJOsu5HooZPHKsdIWdqhEBRsNhmo0BWdao9tRu8gFE0fvxqt9
	vZCF5UqTB22WyhIdrSpAsL/N5KUjpkg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-R57x_T0bNvSGg-M9VC7zTw-1; Wed, 30 Oct 2024 17:25:46 -0400
X-MC-Unique: R57x_T0bNvSGg-M9VC7zTw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84ff4a09958so128332241.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323546; x=1730928346;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEvC6qj73WFs9v4jNz8NvTdgCtpn9X+dib3hOxuvGwE=;
        b=YjYHdqSUWU5HOCEOS4YXtC+yuLPb8m2MqU+XqHsL7igvaa89PEmxOyLElKdtfS4AJI
         VIqZVyRvo0l3b76i3N40OhM2Yd1P5jPWTAXme9bwXeF2ku9q6aFnog42Mb9aiiPfOtt5
         4H3LcXUW3G8Gzvkoc1OCU6Ad3aDT9R0OWtPfG8Lzvvo/E9y+GMs4x0btHw0De3z3YSiC
         tYRwXEL9zJfe8eAd/UBXfHpt8j5yfyh/6Sj7mEcOK2AyZIS3wWHpUwNI6RiYktvti2Nv
         rlchvFbhvJV0ez44CtprEjkNVb4NqHrWoPFSTEEVYL1q5k+PbI7RShBy8O8KSmWQG61j
         eTZw==
X-Forwarded-Encrypted: i=1; AJvYcCVJLiDoscYebusIq/WKGFvAIG9rZnQQcgnmJ90sZoh0JZckJQNaVmR2hgZDnJ7q4Ju6cMbUbDLVCCuvdHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHzSIVeq2GnWqtzImQqgG5ewg84UI18zcmDR36Vd6cTgz99aO
	0oaeInr+Hmx9hYz5+NZLqMY+CQSwwpAZoFIs9bVCpy7WxT3+s2WBjX8Y/wL/8Hcedhy52L2I2AZ
	jU37tjMkWeb6fIstjTZwUX8/+MxfDVSXzPBiLnQBpZ/Nh/tg7v/P1wsBgcAHIZA==
X-Received: by 2002:a05:6102:510b:b0:4a5:6f41:211a with SMTP id ada2fe7eead31-4a9543ece2fmr1214642137.25.1730323545844;
        Wed, 30 Oct 2024 14:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPKt+ZHVFm3aHKNJwyVie7PbEWGYm60aYyQTyJOoOVF8tlcJOmvRMAS7EwXqLyiMCFaGrSvA==
X-Received: by 2002:a05:6102:510b:b0:4a5:6f41:211a with SMTP id ada2fe7eead31-4a9543ece2fmr1214629137.25.1730323545465;
        Wed, 30 Oct 2024 14:25:45 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0c1c6sm5677385a.61.2024.10.30.14.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:25:45 -0700 (PDT)
Message-ID: <c408aae3fe48477145afa74ee9f8bbc968e8e94c.camel@redhat.com>
Subject: Re: [PATCH v4 0/4] Relax canonical checks on some arch msrs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 17:25:44 -0400
In-Reply-To: <ZyKjo-XpaNjIkMdA@google.com>
References: <20240906221824.491834-1-mlevitsk@redhat.com>
	 <c6594c5f040eedc7e5b3cb001aac1bcfcb6782cd.camel@redhat.com>
	 <ZyKjo-XpaNjIkMdA@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-10-30 at 14:22 -0700, Sean Christopherson wrote:
> On Wed, Oct 30, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-09-06 at 18:18 -0400, Maxim Levitsky wrote:
> > > Recently we came up upon a failure where likely the guest writes
> > > 0xff4547ceb1600000 to MSR_KERNEL_GS_BASE and later on, qemu
> > > sets this value via KVM_PUT_MSRS, and is rejected by the
> > > kernel, likely due to not being canonical in 4 level paging.
> > > 
> > > One of the way to trigger this is to make the guest enter SMM,
> > > which causes paging to be disabled, which SMM bios re-enables
> > > but not the whole 5 level. MSR_KERNEL_GS_BASE on the other
> > > hand continues to contain old value.
> > > 
> > > I did some reverse engineering and to my surprise I found out
> > > that both Intel and AMD indeed ignore CR4.LA57 when doing
> > > canonical checks on this and other msrs and/or other arch
> > > registers (like GDT base) which contain linear addresses.
> > > 
> > > V2: addressed a very good feedback from Chao Gao. Thanks!
> > > 
> > > V3: also fix the nested VMX, and also fix the
> > > MSR_IA32_SYSENTER_EIP / MSR_IA32_SYSENTER_ESP
> > > 
> > > V4:
> > >   - added PT and PEBS msrs
> > >   - corrected emulation of SGDT/SIDT/STR/SLDT instructions
> > >   - corrected canonical checks for TLB invalidation instructions
> > > 
> > > Best regards,
> > > 	Maxim Levitsky
> > > 
> > > Maxim Levitsky (4):
> > >   KVM: x86: drop x86.h include from cpuid.h
> > >   KVM: x86: implement emul_is_noncanonical_address using
> > >     is_noncanonical_address
> > >   KVM: x86: model canonical checks more precisely
> > >   KVM: nVMX: fix canonical check of vmcs12 HOST_RIP
> > > 
> > >  arch/x86/kvm/cpuid.h         |  1 -
> > >  arch/x86/kvm/emulate.c       | 15 ++++++-----
> > >  arch/x86/kvm/kvm_emulate.h   |  5 ++++
> > >  arch/x86/kvm/mmu.h           |  1 +
> > >  arch/x86/kvm/mmu/mmu.c       |  2 +-
> > >  arch/x86/kvm/vmx/hyperv.c    |  1 +
> > >  arch/x86/kvm/vmx/nested.c    | 35 +++++++++++++++++---------
> > >  arch/x86/kvm/vmx/pmu_intel.c |  2 +-
> > >  arch/x86/kvm/vmx/sgx.c       |  5 ++--
> > >  arch/x86/kvm/vmx/vmx.c       |  4 +--
> > >  arch/x86/kvm/x86.c           | 13 +++++++---
> > >  arch/x86/kvm/x86.h           | 49 ++++++++++++++++++++++++++++++++++--
> > >  12 files changed, 102 insertions(+), 31 deletions(-)
> > > 
> > > -- 
> > > 2.26.3
> > > 
> > > 
> > 
> > Hi,
> > A very gentle ping on this patch series.
> 
> Heh, good timing, I literally (like, 2 seconds ago) applied this (still need to
> test before you'll see a "thank you" email).
> 

Thank you!

Best regards,
	Maxim Levitsky


