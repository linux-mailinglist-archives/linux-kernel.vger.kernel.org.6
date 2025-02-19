Return-Path: <linux-kernel+bounces-520674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED272A3AD11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2764816646E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B017BA5;
	Wed, 19 Feb 2025 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeNf4p7s"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B6EAC7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924984; cv=none; b=oxnj/CaAHrRetqX29WwTCUCHFoMV60UEqqFPns72wbiz7a9UV8xlGXBzdMZt6bmL1fE/ErdkgXStW0q8Rsvox+kyRREd7jF6wZWj/s0GET7KscQEwi4qkQC+bKJDf17cDXnSM4Wi7tjUtY7Km73swKhu7MJbJ4ZugLw7ib1XPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924984; c=relaxed/simple;
	bh=MSY6ULYMMJWtOasisY6DXM9ZtoSI4zZXGfWXzlWsE9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dTuJeATRxaJ4sBFMttuRFrPnNWYy6bGOE7TQIneY3sR8nZmFoMkaVj5VcXJUL+znAFZe/aFAG1EDizxnGX8VpupP2HNschGpYDeKQyHDwfU+V09Ia2lV+OdCw4mANwdB1pJOgbM21IXMr1zVpUcisMdfnoRRGI0jYoXyVY+s3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeNf4p7s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so12273110a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739924982; x=1740529782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAXzhHin3ZjxLT2liyUySrKbjCNx65P5j8lmrfvopPs=;
        b=qeNf4p7sXNgfEIKmT3TkRQzp465buHW5ug7nYA3vSstWi6lUuBvC4FtmLc87kEddrH
         Wyin+tW35q8VJR3BPazJUDTBZOCxOyJt2Ng2Pese1xYtoNia3gQjuoWPFqUm/yeHAXgz
         nSKDfudnHKdCu5UJK1Wknh/OlUZ8zMjQXLBxnIu8V5qKXW/j+xnKAUELGaO6+OPgYhVa
         P3cTI2RNmWhUs/jsSWxWrOKUOHOHl8DIf162bYTSCksdNIkNsaRlGL5G/kHWhSQMdybf
         MpWcQ+z6woeZgNU8vBX8baR2FGQy5M6iu24pfY4FTtD3NejOeL93wZJKKZomYpGquGPv
         I8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739924982; x=1740529782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAXzhHin3ZjxLT2liyUySrKbjCNx65P5j8lmrfvopPs=;
        b=qH3Y8kpI2Vd61J7j8Up8n0VPOfWK4l0L9MU4+Kib5z8lI/D1xgCNkYf+O0uX9cpEhg
         UotmVDrTa5sJPvRcXrThGwVzuFg9v1v1xnqYtLKiW6CFwQp8kGt+0rxH9Wmb/+jDLJuX
         7E0XeFOW/UlQdg8S2kkOlcT3woLU4Gntv821E1GvMwq5I/yI7CiFBJwg8LV/8FerqqcR
         gIHBHdrOpa5SVtd8xhNW1R9i3+YjF89vZJ5k/EbbWDtKZg9/rdL0o7GpumfNMTbx4lm0
         zfPQeEA+f3cRD51mfKHiQBlJbzFGgueGSK4htj9VSYESOadtX4ORuor1fQy6ZJw8CBnp
         HkFA==
X-Forwarded-Encrypted: i=1; AJvYcCV1b9A5fPKwg5pyJdCqv92N9Dgd7c+EzR2+xwotu4Amedl7+rNh45rhCCVYIKul+Vktg7BcLQ77FzWicqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOY5zivlyY+B9ZKxZDlcBt/utRH6zcntvOG424DBguVS1s8mt5
	h0KJnKQPWJpTM6GfVvNZvRCLQ8qy/fwiZ+LbM3c7jv8g5tIOAQGJi4HPpbBMrKbrwY04BH9RbXy
	/QQ==
X-Google-Smtp-Source: AGHT+IH3qQKoHeOB4uTnpvP3H/tcvAM/Tw+6sd4dITiILuCuL5QapHtrj1o4BTK7CB9iRs/yltwSJC9ONC4=
X-Received: from pjbdj7.prod.google.com ([2002:a17:90a:d2c7:b0:2ef:973a:3caf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c45:b0:2ee:964e:67ce
 with SMTP id 98e67ed59e1d1-2fc40d131cbmr24311104a91.3.1739924982582; Tue, 18
 Feb 2025 16:29:42 -0800 (PST)
Date: Tue, 18 Feb 2025 16:29:40 -0800
In-Reply-To: <bcb80309-10ec-44e3-90db-259de6076183@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z6r0Q/zzjrDaHfXi@yzhao56-desk.sh.intel.com> <926a035f-e375-4164-bcd8-736e65a1c0f7@linux.intel.com>
 <Z6sReszzi8jL97TP@intel.com> <Z6vvgGFngGjQHwps@google.com>
 <3033f048-6aa8-483a-b2dc-37e8dfb237d5@linux.intel.com> <Z6zu8liLTKAKmPwV@google.com>
 <f12e1c06-d38d-4ed0-b471-7f016057f604@linux.intel.com> <c47f0fa1-b400-4186-846e-84d0470d887e@linux.intel.com>
 <Z64M_r64CCWxSD5_@google.com> <bcb80309-10ec-44e3-90db-259de6076183@linux.intel.com>
Message-ID: <Z7Ul9ORPitXpQAV5@google.com>
Subject: Re: [PATCH v2 5/8] KVM: TDX: Handle TDG.VP.VMCALL<MapGPA>
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 17, 2025, Binbin Wu wrote:
> On 2/13/2025 11:17 PM, Sean Christopherson wrote:
> > On Thu, Feb 13, 2025, Binbin Wu wrote:
> > > On 2/13/2025 11:23 AM, Binbin Wu wrote:
> > > > On 2/13/2025 2:56 AM, Sean Christopherson wrote:
> > > > > On Wed, Feb 12, 2025, Binbin Wu wrote:
> > > > > > On 2/12/2025 8:46 AM, Sean Christopherson wrote:
> > > > > > > I am completely comfortable saying that KVM doesn't care about STI/SS shadows
> > > > > > > outside of the HALTED case, and so unless I'm missing something, I think it makes
> > > > > > > sense for tdx_protected_apic_has_interrupt() to not check RVI outside of the HALTED
> > > > > > > case, because it's impossible to know if the interrupt is actually unmasked, and
> > > > > > > statistically it's far, far more likely that it _is_ masked.
> > > > > > OK. Will update tdx_protected_apic_has_interrupt() in "TDX interrupts" part.
> > > > > > And use kvm_vcpu_has_events() to replace the open code in this patch.
> > > > > Something to keep an eye on: kvm_vcpu_has_events() returns true if pv_unhalted
> > > > > is set, and pv_unhalted is only cleared on transitions KVM_MP_STATE_RUNNABLE.
> > > > > If the guest initiates a spurious wakeup, pv_unhalted could be left set in
> > > > > perpetuity.
> > > > Oh, yes.
> > > > KVM_HC_KICK_CPU is allowed in TDX guests.
> > And a clever guest can send a REMRD IPI.
> > 
> > > > The change below looks good to me.
> > > > 
> > > > One minor issue is when guest initiates a spurious wakeup, pv_unhalted is
> > > > left set, then later when the guest want to halt the vcpu, in
> > > > __kvm_emulate_halt(), since pv_unhalted is still set and the state will not
> > > > transit to KVM_MP_STATE_HALTED.
> > > > But I guess it's guests' responsibility to not initiate spurious wakeup,
> > > > guests need to bear the fact that HLT could fail due to a previous
> > > > spurious wakeup?
> > > Just found a patch set for fixing the issue.
> > FWIW, Jim's series doesn't address spurious wakeups per se, it just ensures
> > pv_unhalted is cleared when transitioning to RUNNING.  If the vCPU is already
> > RUNNING, __apic_accept_irq() will set pv_unhalted and nothing will clear it
> > until the next transition to RUNNING (which implies at least an attempted
> > transition away from RUNNING).
> > 
> Indeed.
> 
> I am wondering why KVM doesn't clear pv_unhalted before the vcpu entering guest?
> Is the additional memory access a concern or is there some other reason?

Not clearing pv_unhalted when entering the guest is necessary to avoid races.
Stating the obvious, the guest must set up all of its lock tracking before executing
HLT, which means that the soon-to-be-blocking vCPU is eligible for wakeup *before*
it executes HLT.  If an asynchronous exit happens on the vCPU at just the right
time, KVM could clear pv_unhalted before the vCPU executes HLT.

