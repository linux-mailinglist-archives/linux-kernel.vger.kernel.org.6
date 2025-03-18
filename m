Return-Path: <linux-kernel+bounces-566709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9CA67B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AD11883D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AE2139B5;
	Tue, 18 Mar 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nh0/yY3G"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052D212D95
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320995; cv=none; b=bz3ksWtHG3HEazSrqvL07jDxsheViu3HdBrQbu3QzeZqVCr2mPCKKtyNyJeaK96K/11+I1JfzaWgVK0BC/NHPR/5XfOMK8V91w1GekMHTutGmu72Chb5SVi32HdXoLGH87Bh5uOaXlj78Nn2tRJ2dTR01saNcfJF4hFKBMQTIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320995; c=relaxed/simple;
	bh=XaNGJLkWPs0Qmbxt043B99FS4bhKF+GrcE4g0MLQJNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prEd4VcKprDJlFp+JzYfmkzV3VZf6ABPxJzt0lI2SyWqjR+TTYyE4a9zZldFBRKY6mdfixbneXeykNZMQPIMWTmlJXpxA70DHn+Eliv3zq0xRtAXOK6nDRg19mvXTh8wYHobkX1mH0iESQmPwlLvEe79EJ435+75lmw7YIAY2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nh0/yY3G; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso8589754a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320989; x=1742925789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LnxJk4vBSHp9N1LYFKJLt0e8ikcWRVhvPtecH3/Bee4=;
        b=Nh0/yY3G5b1sdJkbN58sr2FAcrLAnmUr4RBP5rCe05GR51Sf7urOCTV0E8oPDD2Zlf
         /Zs7EJ89bBzyvveDqXWTSLfS3EsobAcxAL/5CZIoYOpe47grN9CNzMJJ0WauW+lo1xcF
         WutNW4IrXFMtu2v/I/Ac5UKyQrmmyjDyGDh/0DpEoEPNkbIrNA5uqSwtmJzae9p/HCuW
         zryO/1M5FC36DMbKrHT1bNeCgBnFbgH8jIgf7KXYdS70KvdkJGUXj9ByOJwozBfEzkXn
         EW2qEaNB/LuyvZTkjmhBzAaapNh/CwjVuXdnyXlm/COxyNlojul377gDFUCd/2EcYtxF
         rORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320989; x=1742925789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnxJk4vBSHp9N1LYFKJLt0e8ikcWRVhvPtecH3/Bee4=;
        b=NRaXoSeXtuO2G9X53PJL3z+RNmxhldPHIlsRcu9RmnJB+Bu15IR2rfT2SjMr6/LVGr
         0k9zo9cyTK73L9hMVSvyHAMZUgwRs4uLhP13e3VM+SJXzW/61awVw90nYsRDHD71dlz2
         fc5dqWFlslFVClayijBRU2FuMrfFiJCK9G36T8aPQtJJYYDTov5zWcfz9W9Dmxo+Ad6U
         8s2ywQSyQqstt2dZmo7P8hYE+7R9xTNS3yOw8uYWGvj1y1rbzNgu6lNjOpNDqtjL7RGQ
         c349o1UMCBzu8Q37S+X1nuYe9QP71/1a4CTWNtIOVTaDiNeBhSRBiev6QK/OmIThGsuD
         BhKA==
X-Forwarded-Encrypted: i=1; AJvYcCV7yxQArVjpXafEh4gx3nZ1Fb7QhqCUkm80SqePzVDpE+xbQkyX60C7X1aRhrRY3llYKEHkDSaBGJgqtC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoEatDI5eNZQxEklrKWv4wKGPkYvdhwilBBHNhtbpYHdW+/5B2
	Z/ricBVvBh7j7ziHPRDbG24V8Yh6LYmaSF1WUCNGHyE5leSkXXb6SVDB7/DoWoWPpBXhTAlJKvp
	3qQ==
X-Google-Smtp-Source: AGHT+IHZwwToMGKFE4smkp6DkYNdKGE/kbs13n/bLX0z07PsjJvXq6Jp/hz8OiDvzRRG1V1mnoUZJJtQRjQ=
X-Received: from pjbsd13.prod.google.com ([2002:a17:90b:514d:b0:2ea:5084:5297])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388b:b0:2fe:b907:562f
 with SMTP id 98e67ed59e1d1-301a5b0d3fdmr4269014a91.14.1742320989263; Tue, 18
 Mar 2025 11:03:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 11:02:56 -0700
In-Reply-To: <20250318180303.283401-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318180303.283401-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318180303.283401-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 6.15
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A variety of cleanups and minor fixes, and improved support (and fixes) for
honoring L1 intercepts when emulating instructions on behalf of L2.

FWIW, unless I'm missing something, the severity of the L2 emulation bugs means
that emulating instructions while L2 is active is _very_ rare for real world
use cases.  I.e. the fixes are not urgent.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-6.15

for you to fetch changes up to e6c8728a8e2d20b262209c70a8ca67719a628833:

  KVM: x86: Remove the unreachable case for 0x80000022 leaf in __do_cpuid_func() (2025-03-04 09:19:49 -0800)

----------------------------------------------------------------
KVM x86 misc changes for 6.15:

 - Fix a bug in PIC emulation that caused KVM to emit a spurious KVM_REQ_EVENT.

 - Add a helper to consolidate handling of mp_state transitions, and use it to
   clear pv_unhalted whenever a vCPU is made RUNNABLE.

 - Defer runtime CPUID updates until KVM emulates a CPUID instruction, to
   coalesce updates when multiple pieces of vCPU state are changing, e.g. as
   part of a nested transition.

 - Fix a variety of nested emulation bugs, and add VMX support for synthesizing
   nested VM-Exit on interception (instead of injecting #UD into L2).

 - Drop "support" for PV Async #PF with proctected guests without SEND_ALWAYS,
   as KVM can't get the current CPL.

 - Misc cleanups

----------------------------------------------------------------
Ethan Zhao (1):
      KVM: x86/cpuid: add type suffix to decimal const 48 fix building warning

Jim Mattson (2):
      KVM: x86: Introduce kvm_set_mp_state()
      KVM: x86: Clear pv_unhalted on all transitions to KVM_MP_STATE_RUNNABLE

Li RongQing (1):
      KVM: x86: Use kvfree_rcu() to free old optimized APIC map

Liam Ni (1):
      KVM: x86: Wake vCPU for PIC interrupt injection iff a valid IRQ was found

Sean Christopherson (19):
      KVM: x86: Use for-loop to iterate over XSTATE size entries
      KVM: x86: Apply TSX_CTRL_CPUID_CLEAR if and only if the vCPU has RTM or HLE
      KVM: x86: Query X86_FEATURE_MWAIT iff userspace owns the CPUID feature bit
      KVM: x86: Defer runtime updates of dynamic CPUID bits until CPUID emulation
      KVM: nVMX: Check PAUSE_EXITING, not BUS_LOCK_DETECTION, on PAUSE emulation
      KVM: nSVM: Pass next RIP, not current RIP, for nested VM-Exit on emulation
      KVM: nVMX: Allow emulating RDPID on behalf of L2
      KVM: nVMX: Emulate HLT in L2 if it's not intercepted
      KVM: nVMX: Consolidate missing X86EMUL_INTERCEPTED logic in L2 emulation
      KVM: x86: Plumb the src/dst operand types through to .check_intercept()
      KVM: x86: Plumb the emulator's starting RIP into nested intercept checks
      KVM: x86: Add a #define for the architectural max instruction length
      KVM: nVMX: Allow the caller to provide instruction length on nested VM-Exit
      KVM: nVMX: Synthesize nested VM-Exit for supported emulation intercepts
      KVM: selftests: Add a nested (forced) emulation intercept test for x86
      KVM: x86: Don't inject PV async #PF if SEND_ALWAYS=0 and guest state is protected
      KVM: x86: Rename and invert async #PF's send_user_only flag to send_always
      KVM: x86: Use a dedicated flow for queueing re-injected exceptions
      KVM: x86: Always set mp_state to RUNNABLE on wakeup from HLT

Ted Chen (1):
      KVM: x86: Remove unused iommu_domain and iommu_noncoherent from kvm_arch

Xiaoyao Li (1):
      KVM: x86: Remove the unreachable case for 0x80000022 leaf in __do_cpuid_func()

 arch/x86/include/asm/kvm_host.h                    |   9 +-
 arch/x86/kvm/cpuid.c                               |  52 ++++----
 arch/x86/kvm/cpuid.h                               |   9 +-
 arch/x86/kvm/emulate.c                             |   5 +-
 arch/x86/kvm/i8259.c                               |   2 +-
 arch/x86/kvm/kvm_emulate.h                         |   7 +-
 arch/x86/kvm/lapic.c                               |  17 +--
 arch/x86/kvm/smm.c                                 |   2 +-
 arch/x86/kvm/svm/nested.c                          |   2 +-
 arch/x86/kvm/svm/sev.c                             |   7 +-
 arch/x86/kvm/svm/svm.c                             |  17 ++-
 arch/x86/kvm/trace.h                               |  14 +-
 arch/x86/kvm/vmx/nested.c                          |  18 +--
 arch/x86/kvm/vmx/nested.h                          |  22 +++-
 arch/x86/kvm/vmx/vmx.c                             | 120 ++++++++++++-----
 arch/x86/kvm/x86.c                                 | 136 +++++++++----------
 arch/x86/kvm/x86.h                                 |   7 +
 arch/x86/kvm/xen.c                                 |   4 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/x86/nested_emulation_test.c      | 146 +++++++++++++++++++++
 20 files changed, 416 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_emulation_test.c

