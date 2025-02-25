Return-Path: <linux-kernel+bounces-531807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DFA44540
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8924F7ACB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1321624D4;
	Tue, 25 Feb 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/6l+hEt"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8316C684
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499287; cv=none; b=eKki/2MOxdbpHj/7Y33AFkR6i0/dUtah+pMp5dujrYOxsHGCV0ToeRcGH0aXL5zakgxj9CYw2hW9cm/rHEJ86k9DPicYmiGVtLBhYHyjD7ye8tFd/QXkZ7FU9AAv+AZ3J3+mIcbBNIPA6QIyGCM407JOcRg818fJ/kQUOkK408Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499287; c=relaxed/simple;
	bh=p7TD3Go22x7b2dc7NZP8nHVeDDYqMnRGFaDWmNw/XHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WYdk1OrEm5lFYkXmYD0tYwnt9tgc4cO05hddKjadsR1v6BNScCuFuU9693YxaUdhxpazwv5pbhg/H7Aqvq2YxwzhtQHnC/hR0RK83EjVXeUVBlbCwPh5kLPuWdFfFJHGpINZkbtGFrUV68/dx0kulb305FKvca5TI/BhPh1HO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/6l+hEt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d8aa893dso91810925ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740499285; x=1741104085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LxD0tQorOHIkEX1Wne9NF5WWRrn54kUL0zS9HrlpVk=;
        b=c/6l+hEtrexqRLjIibdArlV4tq23vAQDhIhQeB7fa1VY2FLyTIoxRHtg3TWcCAUqqz
         WOJ1RC6hXflwL2AMaMui98Wih3LcqFQuCHT7NvwPjr/CE50BjeLyREcC3RzIysK6pfN4
         91JIiEsDHgwOnG8/ahRKb+LXFpDBuZgFg9AzuTMgvbMUrGEk/jdvM5bKjRzqcXv+Gke0
         ceINbRwG4y+bQ46ClVFzJqeNW8kc1/KTI87SNr+U0zcvztyzQ/mkjqvmqnJobpu3k2XX
         0YRHiNneOuHBCk/sQqcYYRx3mPCy3y1v4LsL7uaQh17pUFPAQ0qg1tyhGuIqsTS6W2UL
         hdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499285; x=1741104085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LxD0tQorOHIkEX1Wne9NF5WWRrn54kUL0zS9HrlpVk=;
        b=Fa/J+8ihfl69iTLkzgBx92EcTRoIZhLysV5zlWbJy6zES+RMH1mkgoeg2G/6tAWjQm
         PhbDXd6/XSppMJ+hMGBNwO9U5gbipW6WJsNlcw0OaEKdIpT4+O5OFNGZXo2srkhzcHu5
         viaPxPvOah/NjyGyZiDoeIS6KNUXYo8PoDSQC4BBvE2dOrLDugCBXbg0KjlWLDOtiTsh
         I4bJs35N8oNya/9nxy+Re0/KSK4GD2QcOMNe/oKyYweUmuIplQHabbs65wH1I4RnfnbC
         Xc3IzETS8+UlhZZ21Ogj2qgrbOUbdruBIwhD05ylvcUGtNCMlXBmQINS9QrpSCjpLxkW
         tf9g==
X-Forwarded-Encrypted: i=1; AJvYcCVEBnr1r9qSMp1JrnOafhWqvJXPQsDdn2/NyP7jBt3WWvSE/ZyQDX5SpK5nLXpAW1oW0yZ8BqTqXQIGy9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jxd/585vMOqZasXZTMykjiGLSBZdpTvu7zsSXo3orOndq/wu
	bGb3bPuQM9ivzx1m4FZKsHrQq5z3XYsLiQo36mzRaycYwplG0g8SNRAt1zj8tBQERUKHWiXUuBE
	RyQ==
X-Google-Smtp-Source: AGHT+IEBXqMORvCpUqsfkZoTABv8DWEBYtiJakKmy5X9+czevxUoPIQVz54F8dk3PSNGmGOA4AqRgSPCRVw=
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:2ea:5084:5297])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f542:b0:220:d909:1734
 with SMTP id d9443c01a7336-22307b52281mr68919445ad.14.1740499284799; Tue, 25
 Feb 2025 08:01:24 -0800 (PST)
Date: Tue, 25 Feb 2025 08:01:23 -0800
In-Reply-To: <edcdad12-bbb7-46b9-8914-9bbb36b44597@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001050110.3643764-1-xin@zytor.com> <20241001050110.3643764-22-xin@zytor.com>
 <Zxn8BX6vxQKY+YNF@intel.com> <edcdad12-bbb7-46b9-8914-9bbb36b44597@zytor.com>
Message-ID: <Z73pU45jzA8e2i0S@google.com>
Subject: Re: [PATCH v3 21/27] KVM: VMX: Invoke vmx_set_cpu_caps() before
 nested setup
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 25, 2024, Xin Li wrote:
> On 10/24/2024 12:49 AM, Chao Gao wrote:
> > On Mon, Sep 30, 2024 at 10:01:04PM -0700, Xin Li (Intel) wrote:
> > > From: Xin Li <xin3.li@intel.com>
> > > 
> > > Set VMX CPU capabilities before initializing nested instead of after,
> > > as it needs to check VMX CPU capabilities to setup the VMX basic MSR
> > > for nested.
> > 
> > Which VMX CPU capabilities are needed? after reading patch 25, I still
> > don't get that.

Heh, I had the same question.  I was worried this was fixing a bug.

> Sigh, in v2 I had 'if (kvm_cpu_cap_has(X86_FEATURE_FRED))' in
> nested_vmx_setup_basic(), which is changed to 'if (cpu_has_vmx_fred())'
> in v3.  So the reason for the change is gone.  But I think logically
> the change is still needed; nested setup should be after VMX setup.

Hmm, no, I don't think we want to allow nested_vmx_setup_ctls_msrs() to consume
any "output" from vmx_set_cpu_caps().  vmx_set_cpu_caps() is called only on the
CPU that loads kvm-intel.ko, whereas nested_vmx_setup_ctls_msrs() is called on
all CPUs to check for consistency between CPUs.

And thinking more about the relevant flows, there's a flaw with kvm_cpu_caps and
vendor module reload.  KVM zeroes kvm_cpu_caps during init, but not until
kvm_set_cpu_caps() is called, i.e. quite some time after KVM has started doing
setup.  If KVM had a bug where it checked a feature kvm_set_cpu_caps(), the bug
could potentially go unnoticed until just the "right" combination of hardware,
module params, and/or Kconfig exposed semi-uninitialized data.

I'll post the below (assuming it actually works) to guard against that.  Ideally,
kvm_cpu_cap_get() would WARN if it's used before caps are finalized, but I don't
think the extra protection would be worth the increase in code footprint.

--
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 97a90689a9dc..8fd48119bd41 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -817,7 +817,8 @@ do {                                                                        \
 
 void kvm_set_cpu_caps(void)
 {
-       memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
+       WARN_ON_ONCE(!bitmap_empty((void *)kvm_cpu_caps,
+                                  sizeof(kvm_cpu_caps) * BITS_PER_BYTE));
 
        BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
                     sizeof(boot_cpu_data.x86_capability));
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f5685f153e08..075a07412893 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9737,6 +9737,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
        }
 
        memset(&kvm_caps, 0, sizeof(kvm_caps));
+       memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
 
        x86_emulator_cache = kvm_alloc_emulator_cache();
        if (!x86_emulator_cache) {

