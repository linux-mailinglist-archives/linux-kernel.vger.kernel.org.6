Return-Path: <linux-kernel+bounces-511742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3FA32F01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959593A7141
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EEB260A5D;
	Wed, 12 Feb 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2fJVk6w"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03825E44A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386614; cv=none; b=hp+3q70S+WxCxxUsx/8hVWuM50Aq1rR6bCtobC1SzHjcUF0EHk3PcvrxJAOA4gc9nF7bwdz13pYa0y6Li+8KhXFy0Ao+w1KdQE2YlMP39jicoMPtTQjN14zUR8kJ74u/WWutrAQeONWbc1txBmlFbwEY4mF1MSU84guys63w8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386614; c=relaxed/simple;
	bh=gXAMwaNKe/OFLTTd0ChTLjmEKcH0pYoE4A5hVxE8oiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mo3TsYOxtyiGiZG2f7Zm3fLQPJmvay4sS+f4jlrVdF0zaNkc5IYvXjD31MOx47ruHbc8PHyz6zc3mueGFK7af1eQ+WthBl3U0HOxsFFV8n7HPtyOLsWKPJZEC6VC3u83/Rr3Lpd/Od1SfUTJEmEL6uhoVgE3zYfYxJTNqhzh71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2fJVk6w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa166cf693so316209a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739386612; x=1739991412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBZPcffr4UmrLT0Oe+KhK2m9rvtxlhltkwaD4SGVEyY=;
        b=v2fJVk6w2SriRpB7KmyR0AmeVR0wAMskfeT+MfyVwO+lOkLSXYsFY0og6aC9RSTV3s
         BTRO4PihiUshyZB8n8pESO0u/q8kdPPOamNuhIlauE9zwvdGWXVWVf5Hal+4xHD0DJAg
         bVtAMa8eQA3FA+2Jpw6U+WLW5xqDc+kEbT7GyQn9Sq2i7FMlf0MULRlPiU+1ghLTRUeE
         37Ef+a2O5vI1g/eC86pftT5tlbQCS3mh74NxIo0vUSnjYBDVuJp2Hwogtg7lqTtjK9/h
         dA5zxPIyFlgvxl+gVU4ptuhohBgxxGLMyd3RoJb1YGIPIzSwTWFci8hV2w3fSnCi2nrV
         XyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386612; x=1739991412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBZPcffr4UmrLT0Oe+KhK2m9rvtxlhltkwaD4SGVEyY=;
        b=U9xjcjHP/BVSJfCti9UxJ322+wcLVAQyK7KCs1kOQboYO1dEpSsshs9sqwJodaAE8Z
         /vipVAoVCX5u34piDsqKesDFZsTvf1AhhuBvVyOBfJy098qeHcfoAPFQBIjv/lKwuL68
         2G0j2ahHpg6jwohTPVuo7VU+cRrMOaY8QfoRBLSFLHeQ2HiQS6LjT7GpPK5M6hYtjDAE
         0sjcZMJZVYpeADugA9HRq9fwQ9AIxJhpEyEcGp5eyh0r+Tl7g73Fs4iF71z61sg6xwAN
         2KgZm7kWTvFNVbPxe+lF+K+S3XGFUEpumnj4MxlZQlF+q6kkH1R3T5DzOXyrfdtOWSBZ
         TZZw==
X-Forwarded-Encrypted: i=1; AJvYcCVlni2absP4YT6mGxkmH6CW0E9kwjE0ZSXTsNJGobx2JWTNGLsEpFVurLB09jCNIbgpuwlMw/7L5DJlD/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fcMmmUE876LJde7MW6+ubj971RhQY9K44Ec6OudZN1mP3UcU
	Mn2az16RtPCV2D26eang3zAH3LWBbmvklK3L33PN2jJZ4s1KvIeGA5+hrEugmm2HT26OfkGSELx
	bNQ==
X-Google-Smtp-Source: AGHT+IHnI9eCIwY5iLdUaBHbR0QxmyULog1J24FtVK82My0OyHeYlaWf/Ktl3IeQRpNhpz4LwNTd6/yAvkc=
X-Received: from pfbig13.prod.google.com ([2002:a05:6a00:8b8d:b0:730:96d1:c213])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a1f:b0:730:91fc:f9c9
 with SMTP id d2e1a72fcca58-7323c1c8055mr239487b3a.16.1739386612053; Wed, 12
 Feb 2025 10:56:52 -0800 (PST)
Date: Wed, 12 Feb 2025 10:56:50 -0800
In-Reply-To: <3033f048-6aa8-483a-b2dc-37e8dfb237d5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025442.3071607-1-binbin.wu@linux.intel.com>
 <20250211025442.3071607-6-binbin.wu@linux.intel.com> <Z6r0Q/zzjrDaHfXi@yzhao56-desk.sh.intel.com>
 <926a035f-e375-4164-bcd8-736e65a1c0f7@linux.intel.com> <Z6sReszzi8jL97TP@intel.com>
 <Z6vvgGFngGjQHwps@google.com> <3033f048-6aa8-483a-b2dc-37e8dfb237d5@linux.intel.com>
Message-ID: <Z6zu8liLTKAKmPwV@google.com>
Subject: Re: [PATCH v2 5/8] KVM: TDX: Handle TDG.VP.VMCALL<MapGPA>
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Binbin Wu wrote:
> On 2/12/2025 8:46 AM, Sean Christopherson wrote:
> > I am completely comfortable saying that KVM doesn't care about STI/SS shadows
> > outside of the HALTED case, and so unless I'm missing something, I think it makes
> > sense for tdx_protected_apic_has_interrupt() to not check RVI outside of the HALTED
> > case, because it's impossible to know if the interrupt is actually unmasked, and
> > statistically it's far, far more likely that it _is_ masked.
> OK. Will update tdx_protected_apic_has_interrupt() in "TDX interrupts" part.
> And use kvm_vcpu_has_events() to replace the open code in this patch.

Something to keep an eye on: kvm_vcpu_has_events() returns true if pv_unhalted
is set, and pv_unhalted is only cleared on transitions KVM_MP_STATE_RUNNABLE.
If the guest initiates a spurious wakeup, pv_unhalted could be left set in
perpetuity.

I _think_ this would work and is generally desirable?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e77e61d4fbd..435ca2782c3c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11114,9 +11114,6 @@ static bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
            kvm_apic_init_sipi_allowed(vcpu))
                return true;
 
-       if (vcpu->arch.pv.pv_unhalted)
-               return true;
-
        if (kvm_is_exception_pending(vcpu))
                return true;
 
@@ -11157,7 +11154,8 @@ static bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
-       return kvm_vcpu_running(vcpu) || kvm_vcpu_has_events(vcpu);
+       return kvm_vcpu_running(vcpu) || vcpu->arch.pv.pv_unhalted ||
+              kvm_vcpu_has_events(vcpu);
 }
 
 /* Called within kvm->srcu read side.  */
@@ -11293,7 +11291,7 @@ static int __kvm_emulate_halt(struct kvm_vcpu *vcpu, int state, int reason)
         */
        ++vcpu->stat.halt_exits;
        if (lapic_in_kernel(vcpu)) {
-               if (kvm_vcpu_has_events(vcpu))
+               if (kvm_vcpu_has_events(vcpu) || vcpu->arch.pv.pv_unhalted)
                        vcpu->arch.pv.pv_unhalted = false;
                else
                        vcpu->arch.mp_state = state;


