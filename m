Return-Path: <linux-kernel+bounces-406630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288629C6194
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A37B28305A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776721A71D;
	Tue, 12 Nov 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9FiEvsh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400782194B7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440027; cv=none; b=fKyXlePvXBJ/QzT+uHUS9U4uGSeeLaLpGKNwagCPzZzmgm1NR9h3KrZtRFGfHdTWdcHVT19wkUUZhH3lRHMJlRIW/GsDsAsEihB1oE9WQlxmX0aZDmYyuSNPNr1JFEdxZCOqwGYtseI0eVJFNjpeCykz8qN/HBlKvGO0uby7w2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440027; c=relaxed/simple;
	bh=4N4aDMkg9TufS5V2FoU5nCjbGHO+27tSIkMdX3Hjx6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OibwcZ0uDzpixHRqezNMlJOdsySJ4Vn8RyjU7pasNDfa5nOqmR1l9drTBf28bHyBQ1Qlc8j4KYaxRVfYg3DK6D9PsYBCpaubXYqEDqU8wBnHvk8Tk5S+/GEx9Rd+1L7cXGAAMxPe5/FgdMRXc1TY9lNBXVii+QNGi4YtHWn2BGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9FiEvsh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso10294109276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440024; x=1732044824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3rizDBoH2aSpmzNyihPm36UqCZjPpAF20d37siqJZdM=;
        b=D9FiEvsh6ATH7HYneDoWh+iP75bUowuCwZvaDf1woObpmGiQQTTZiKyk9NVM8lWzqI
         6UgHJVP031EoTgkWkjpZKzlOwQs0uERtryXTZ94PhFS19oxfMiFo+bqRkXuiq/sc2vCv
         UeOm2C2i69sRdfxh+ECYUvof1t015SHrpTLD0AsmVHcYINuT84oNcMvUP9UTgyl4taMN
         RmWlaw7lvyukfa0+l1A+bXLGELDQ8opUzcovnZDYVnr1EC0DyZKJiLke2Y0XKpHJa9/b
         k6aBgfozKAaUVr6ndTP7RRlVmuqi37zrwN92JNTjojWsdtPRWUSvBVnj3p9MVwM+WSDc
         GRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440024; x=1732044824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rizDBoH2aSpmzNyihPm36UqCZjPpAF20d37siqJZdM=;
        b=BSUBU2zZHh37YbEcTO698+G20GopFX0F0Kq0QDLmIGq1gkMltG7tbDBWrRiqZL5vKz
         8ymDXy60f7WwS8A3UUEbwvyFZJViTeJXAKhkGCj/AO3E7KDPWfj5zOlZntjIRaPNuInD
         ijaSdf4mxtpCylTeEsa4v3FgOYYnQtTIY22KFtr+KMUDUbXnsJ8ab6TqZJaeocr+HHjM
         bXBxAXGFw4kfyilmTrxPcC9YY8DFxqAO/opyc6DtfY09hcy+TId/zucmyYiA9oPXdfoH
         eXx2tzBA+rCpkAfLy89N+pHBfAYklDiEDr5YA4GP/FEU3EDJmCGiGiGKxjI+7AeYSDQM
         m3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUC1d/RV0xMG4KkB7PY5WrgQNjGMsfpROeaKr2GPv82HJn4nCPDPLHfRSRljiPqcnMv7WErZbO+0rjPFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNvT+SY0lPWtPmbh0rQGv0J7ONUiYgqfFzqXU/wRDGgpGQ23v
	lw5hBH4wsxim4RqmFcoRkeXTXxPeCrvM1eO/Fp40gIbzHOtH4eiu31OpC4O/+HTgCrJ3G3K6mP/
	mIQ==
X-Google-Smtp-Source: AGHT+IGVEPhtkj5zHTgwIth3z8eKGR7b6n8Am/vUMdU5ce0m4bHhJQ7pQkBCC9OJW22AjQYpAftiZcIvcCY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:c404:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e35dc574bfdmr3145276.6.1731440024217; Tue, 12 Nov 2024 11:33:44
 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Nov 2024 11:33:32 -0800
In-Reply-To: <20241112193335.597514-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112193335.597514-3-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 6.13
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a variety of misc x86 changes.  The highlight is Maxim's
overhaul of the non-canonical logic to (try to) better follow hardware
behavior when LA57 is supported.

The STUFF_FEATURE_MSRS quirk might also be worth a second glance?

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-6.13

for you to fetch changes up to a75b7bb46a83a2990f6b498251798930a19808d9:

  KVM: x86: Short-circuit all of kvm_apic_set_base() if MSR value is unchanged (2024-11-04 20:57:55 -0800)

----------------------------------------------------------------
KVM x86 misc changes for 6.13

 - Clean up and optimize KVM's handling of writes to MSR_IA32_APICBASE.

 - Quirk KVM's misguided behavior of initialized certain feature MSRs to
   their maximum supported feature set, which can result in KVM creating
   invalid vCPU state.  E.g. initializing PERF_CAPABILITIES to a non-zero
   value results in the vCPU having invalid state if userspace hides PDCM
   from the guest, which can lead to save/restore failures.

 - Fix KVM's handling of non-canonical checks for vCPUs that support LA57
   to better follow the "architecture", in quotes because the actual
   behavior is poorly documented.  E.g. most MSR writes and descriptor
   table loads ignore CR4.LA57 and operate purely on whether the CPU
   supports LA57.

 - Bypass the register cache when querying CPL from kvm_sched_out(), as
   filling the cache from IRQ context is generally unsafe, and harden the
   cache accessors to try to prevent similar issues from occuring in the
   future.

 - Advertise AMD_IBPB_RET to userspace, and fix a related bug where KVM
   over-advertises SPEC_CTRL when trying to support cross-vendor VMs.

 - Minor cleanups

----------------------------------------------------------------
Jim Mattson (2):
      KVM: x86: Advertise AMD_IBPB_RET to userspace
      KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB

Kai Huang (2):
      KVM: x86: Fix a comment inside kvm_vcpu_update_apicv()
      KVM: x86: Fix a comment inside __kvm_set_or_clear_apicv_inhibit()

Maxim Levitsky (5):
      KVM: x86: drop x86.h include from cpuid.h
      KVM: x86: Route non-canonical checks in emulator through emulate_ops
      KVM: x86: Add X86EMUL_F_MSR and X86EMUL_F_DT_LOAD to aid canonical checks
      KVM: x86: model canonical checks more precisely
      KVM: nVMX: fix canonical check of vmcs12 HOST_RIP

Sean Christopherson (23):
      KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
      KVM: x86: Bypass register cache when querying CPL from kvm_sched_out()
      KVM: x86: Add lockdep-guarded asserts on register cache usage
      KVM: x86: Use '0' for guest RIP if PMI encounters protected guest state
      KVM: x86: Document an erratum in KVM_SET_VCPU_EVENTS on Intel CPUs
      KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
      KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU has run
      KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration
      KVM: x86: Reject userspace attempts to access PERF_CAPABILITIES w/o PDCM
      KVM: VMX: Remove restriction that PMU version > 0 for PERF_CAPABILITIES
      KVM: x86: Reject userspace attempts to access ARCH_CAPABILITIES w/o support
      KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES
      KVM: selftests: Verify get/set PERF_CAPABILITIES w/o guest PDMC behavior
      KVM: selftests: Add a testcase for disabling feature MSRs init quirk
      KVM: x86: Short-circuit all kvm_lapic_set_base() if MSR value isn't changing
      KVM: x86: Drop superfluous kvm_lapic_set_base() call when setting APIC state
      KVM: x86: Get vcpu->arch.apic_base directly and drop kvm_get_apic_base()
      KVM: x86: Inline kvm_get_apic_mode() in lapic.h
      KVM: x86: Move kvm_set_apic_base() implementation to lapic.c (from x86.c)
      KVM: x86: Rename APIC base setters to better capture their relationship
      KVM: x86: Make kvm_recalculate_apic_map() local to lapic.c
      KVM: x86: Unpack msr_data structure prior to calling kvm_apic_set_base()
      KVM: x86: Short-circuit all of kvm_apic_set_base() if MSR value is unchanged

 Documentation/virt/kvm/api.rst                     |  22 ++++
 Documentation/virt/kvm/x86/errata.rst              |  12 +++
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   4 +-
 arch/x86/include/uapi/asm/kvm.h                    |   1 +
 arch/x86/kvm/cpuid.c                               |  12 ++-
 arch/x86/kvm/cpuid.h                               |   1 -
 arch/x86/kvm/emulate.c                             |  15 +--
 arch/x86/kvm/kvm_cache_regs.h                      |  17 +++
 arch/x86/kvm/kvm_emulate.h                         |   5 +
 arch/x86/kvm/lapic.c                               |  39 ++++++-
 arch/x86/kvm/lapic.h                               |  11 +-
 arch/x86/kvm/mmu.h                                 |   1 +
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/mtrr.c                                |   1 +
 arch/x86/kvm/svm/svm.c                             |   5 +-
 arch/x86/kvm/vmx/hyperv.c                          |   1 +
 arch/x86/kvm/vmx/main.c                            |   1 +
 arch/x86/kvm/vmx/nested.c                          |  35 +++---
 arch/x86/kvm/vmx/pmu_intel.c                       |   2 +-
 arch/x86/kvm/vmx/sgx.c                             |   5 +-
 arch/x86/kvm/vmx/vmx.c                             |  38 ++++---
 arch/x86/kvm/vmx/vmx.h                             |   1 +
 arch/x86/kvm/x86.c                                 | 120 ++++++++++-----------
 arch/x86/kvm/x86.h                                 |  48 ++++++++-
 tools/testing/selftests/kvm/Makefile               |   2 +-
 .../selftests/kvm/x86_64/feature_msrs_test.c       | 113 +++++++++++++++++++
 .../selftests/kvm/x86_64/get_msr_index_features.c  |  35 ------
 .../selftests/kvm/x86_64/platform_info_test.c      |   2 -
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c       |  23 ++++
 30 files changed, 419 insertions(+), 156 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/feature_msrs_test.c
 delete mode 100644 tools/testing/selftests/kvm/x86_64/get_msr_index_features.c

