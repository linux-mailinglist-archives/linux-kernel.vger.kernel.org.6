Return-Path: <linux-kernel+bounces-448333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DE9F3EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D621890FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377A23CB;
	Tue, 17 Dec 2024 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ExLu/oo"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E2A29
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734393904; cv=none; b=FAYj9vZ2qOhMJtBOCAxJfRrmNqjpk3cSpcr+FUpII7KFpu0XUCFScfaeqSSA5lnWYl9HcsOaoSEpBmHzD6eyES/2BE7b+lw7aNPQYRP2Y1SwR0aVh6CemhmcJPSgsjXsxp+v0SBG5F4HMEGKLI80fGEuj7ervtIU/u79HJIyjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734393904; c=relaxed/simple;
	bh=tTuscJutUdd2sLQt+uLIwhRsouGBqOWQjhuN9kir8Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iEQqh4vby6s1kNvkOc5Fb3xU6xB/M2ODFtprT5Q2U1l56Y46yEVfw7diIxjWYmjI3q3PnSS03UlmgQohZ2VftZ4/300j837l5YLanXSudIvxd0CqTZyUfIak6dvIBsaXVFeaS74smBDdzadBironrPf7SM6XSenfUn1FKhGpanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ExLu/oo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so6346377a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734393902; x=1734998702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzh8gciBofFR0aOO1K9biPKw16hOgRnrNY7XSncO8gw=;
        b=0ExLu/ooFubqj3+M3dPKEC8d0DH7UE3h78v9hO8LQpbjOEP5up8ufkuL0wFJ4DnCX6
         Li8JwkabStB/xd81j3U9y/NUtUbvknxwiYIBwOrU/jMdDhbILC/ZSUD3GkoRk/NdPfdG
         HpkVeHY2ZmNBDBm4pTE7jvqJ70MnUOBdmK4QspgxQW23rikobbOMfns21pURUpNNxvJo
         GaW7LxVUtj3z9V9dsyiS6ykPzJhe+/IGOR2WBMAiDCziJHhBiaNV6cIzQZp8P2hluRQr
         E0xRIX/mP6exdMoVq0gjhR3xazZfI3QEH7DMpdcnkUlphw+rfBhOZiyjhgfbZAKqpVQ/
         GAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734393902; x=1734998702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzh8gciBofFR0aOO1K9biPKw16hOgRnrNY7XSncO8gw=;
        b=s7C3b92/YbMTH+yOgoZ0BuNYMgB4MNwA6vM9uC+osfYKT8TTbqeto4pHs4LFuwiqCU
         S3cyDEajbjpG2PFRKfRkL4+HM+F2dQh33CQ1re01OmsjVGloWKQH1ufliCVczlvcmhEi
         2IyMGW3obPX5i/t9D6LlUJgGJqpsQBHUtMwQBmbwlkS8nu/M87hzs3md4G57Utq5wi9b
         KomwCtMV9fg/oeYdtY3NqxBB6gQugdwluV3Uy+M60Do/8GZlX/7oxKjyOHHFtD1kl/dL
         4CCJSI2tD2PruX+hf7B81GofbEO9lzEYRSGVhD7UeC2dpuQHznSp9J5aniSWsHXNWy2p
         ol5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtOyGjf6EkC3lbqjArw7PMbJoqb1DdiDUch+qPq0Aw7U9vg6SWTTMaEdIKuncfkEeY7msDqGp8SLqjKY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjFpxGfXg0dfW8Im0EcFiYxH8P4baJ/P5P+LXu1dz2i77ljAC
	eXeOdgGc164sCWT424itpoymyfjPNTDnUEpBMhOixOg8P166oocYsLwa8SkunEJOP0Nkyalh0JN
	U1w==
X-Google-Smtp-Source: AGHT+IEfEGYrf9Kp0+2ubym5ip7jGdmma8H6AvjPeN7XwsvYzFyoI8GJuVmio+ck2iYi43MOyqOFlyy+ZwQ=
X-Received: from pjbdy11.prod.google.com ([2002:a17:90b:6cb:b0:2eb:12c1:bf8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e48:b0:2ee:6736:8512
 with SMTP id 98e67ed59e1d1-2f28fb6f983mr27557050a91.12.1734393902184; Mon, 16
 Dec 2024 16:05:02 -0800 (PST)
Date: Mon, 16 Dec 2024 16:05:00 -0800
In-Reply-To: <Z1uYihcPhJVRmrxh@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com> <20241128013424.4096668-51-seanjc@google.com>
 <Z1uYihcPhJVRmrxh@intel.com>
Message-ID: <Z2DALDUcfgAHJi79@google.com>
Subject: Re: [PATCH v3 50/57] KVM: x86: Replace (almost) all guest CPUID
 feature queries with cpu_caps
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 13, 2024, Chao Gao wrote:
> On Wed, Nov 27, 2024 at 05:34:17PM -0800, Sean Christopherson wrote:
> >diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> >index d3c3e1327ca1..8d088a888a0d 100644
> >--- a/arch/x86/kvm/cpuid.c
> >+++ b/arch/x86/kvm/cpuid.c
> >@@ -416,7 +416,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > 	 * and can install smaller shadow pages if the host lacks 1GiB support.
> > 	 */
> > 	allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
> >-				      guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES);
> >+				      guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES);
> > 	guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);
> > 
> > 	best = kvm_find_cpuid_entry(vcpu, 1);
> >@@ -441,7 +441,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > 
> > #define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
> > 	vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_) |
> >-					 __cr4_reserved_bits(guest_cpuid_has, vcpu);
> >+					 __cr4_reserved_bits(guest_cpu_cap_has, vcpu);
> 
> So, actually, __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_) can be dropped.
> Is there any reason to keep it? It makes perfect sense to just look up the
> guest cpu_caps given it already takes KVM caps into consideration.

Hmm, good point.  I agree that that keeping the __kvm_cpu_cap_has() checks is
unnecessary, though I'm tempted to turn it into a WARN.  E.g. to guard against
stuffing a feature into cpu_caps without thinking through the implications.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index edef30359c19..3cbf384aeb7a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -460,9 +460,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
        kvm_pmu_refresh(vcpu);
 
+       vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(guest_cpu_cap_has, vcpu);
+       /*
+        * KVM's capabilities are incorporated into the vCPU's capabilities,
+        * and letting the guest to use a CR4-based feature that KVM doesn't
+        * support isn't allowed as KVM either needs to explicitly emulate the
+        * feature or set the CR4 bit in hardware.
+        */
 #define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
-       vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_) |
-                                        __cr4_reserved_bits(guest_cpu_cap_has, vcpu);
+       WARN_ON_ONCE(~vcpu->arch.cr4_guest_rsvd_bits &
+                    __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_));
 #undef __kvm_cpu_cap_has
 
        kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu));

