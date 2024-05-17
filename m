Return-Path: <linux-kernel+bounces-182433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54A8C8B48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFBCB2195D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21B13E02E;
	Fri, 17 May 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABo3HHik"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4313DBBC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967587; cv=none; b=kGl4Y9wL5nvrC3KloIJX82ECJmiXhU5f/ulC/uQf5DDN4THwilnhDzN0/liCsBJw7soOQtbeIRFvj3XyhxCIeDT6Yrrl6q9iSDHW/dsCbp4w8ENSaLO5TRHNP89u3l7iPguDbqTdw3EHGqhM6LqTYpUQFoPtJJF0XmyqyYRJ+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967587; c=relaxed/simple;
	bh=cxZZi/+RXGf6VlFO++B0FtTh367rohJPQ3pHsFlvE9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SXWMsQnf5wUkP8aFTL6LYXc+eP0Sd7GBecUq/U4kZLAW4+JJBYpAzQeXLoOLpCJAL8rAj56nVWBqyXYzT4tF7gX1fsjapIZXZSEL43TvpZtAXl4Io1phZFNfEHQOhT+2falKYaNndHnTduZR2039kEWFCTetRhdJCvabp/pQ12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABo3HHik; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-62a379a7c80so5435951a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967584; x=1716572384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr+9p1wrK6J7sf/488L0fgOszFM1ymo/kH2Sn8Fsd3k=;
        b=ABo3HHikYkStIGMgUIvglflwQA6Q5xE/+VFJfYMszCQyzWi+HKE8tuJwOrQl8B0ZB4
         FhDMeFBUkrYaH8RNOJUsehRxwDoLBAJ0FAQHNVR4x6U9ZYhwz6r4qy9nzlogzHDq9Ymb
         FzF5KfJhgXE7eTHY2vR8k4yUYtZvGTNEtm5oOpIE+d9bmwqeXQKL176FPUL3jmSso35f
         g0NUTCPkn16i+qQbuarcNBWiqInk8Vx9TijfwlDOzWQOUI9o+DIrERudczEbClQaliJr
         hiWgZYJRqX+gsQD/P8LR3CytqP+ccz3PP+IuK+xO/r7NO/Fm+WmCFK1b4MYDT3F0BE+P
         ARrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967584; x=1716572384;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr+9p1wrK6J7sf/488L0fgOszFM1ymo/kH2Sn8Fsd3k=;
        b=CXjk63TBY3Uf6CY46/c0FU9cqnj13hSq0v8iIJl/BekU6bM0bfNKFuA9fcFi0D4FP4
         SC+YXd5/jmGsQ6NvGMrhPPZE/i6R+/DQym3d/9/BLxZZuM5MEs3AiUs4PeJCQJCvEzYW
         XX+PWC5MpbYMyB9s0snAzSSTJJI3zSbpPsTi+Oz/WPJXFkys73CB9FXhQc+NkmS9QIMk
         nU5eKfC1ICEYyVQbOzAqCjACTo6Sg38O6CYP8dpqJcdjOq/KK0w9SaYfS1l7IxECDexX
         sucZzq5ZgtUCrhwKPO5FiMuyxZViour25ftGT+CcEyWHWrVVALMsOQEAUKON13MBLy+o
         EYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLspjl6mjEOF9yLLmjrZ0qs0boVqd46e00qyfeRTUajfl510av3iEWHLK/1nXmVhmtNeFXMETOsJbWqeyWb9IdTfm8qdA3RdEzjdDS
X-Gm-Message-State: AOJu0Yz6d+GTMmtinf4hpz+jYfjTOYHsGcF3b5qa83kvTPA4WOkdutNm
	qsRP+1IhusCRo/N6J8rUJMuS5PUv8plNT+CUWNRq/oEhltH/nrXDMZLl1/k343KIJzP2eTO7b7H
	ZSQ==
X-Google-Smtp-Source: AGHT+IHdDG8Vggrjd/csppCKPtCFid+oJUExlPaZLy0RXI2O67CYNu3iT1UZEnskmS2ojijpGGcVFj4WBlw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5a4b:0:b0:656:fe50:5c70 with SMTP id
 41be03b00d2f7-656fe505d64mr21255a12.4.1715967584301; Fri, 17 May 2024
 10:39:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-1-seanjc@google.com>
Subject: [PATCH v2 00/49] KVM: x86: CPUID overhaul, fixes, and caching
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This is technically v2 of "Replace governed features with guest cpu_caps",
but it obviously snowballed just a bit.  This series wanders all over the
place, and ideally would be 3-4 distinct series, but there are interactions
and dependencies all over the place.

The super short TL;DR: snapshot all X86_FEATURE_* flags that KVM cares
about so that all queries against guest capabilities are "fast", e.g. don't
require manual enabling or judgment calls as to where a feature needs to be
fast.

The guest_cpu_cap_* nomenclature follows the existing kvm_cpu_cap_*
except for a few (maybe just one?) cases where guest cpu_caps need APIs
that kvm_cpu_caps don't.  In theory, the similar names will make this
approach more intuitive.

Maxim's suggestion to incorporate KVM's capabilities into the guest's cpu_caps
grew on me, to the point where I decided to just go for it.  Through macro
shenanigans (see the last DO NOT APPLY patch) and manually verifying that
vcpu->arch.cpu_caps is always a superset of guest CPUID, I was able to gain
sufficient confidence that KVM won't silently change guest behavior.  Many, but
not all, of the new patches are related in some way to that approach.
 
There are *multiple* potentially breaking changes in this series (in for a
penny, in for a pound).  However, I don't expect any fallout for real world
VMMs because the ABI changes either disallow things that couldn't possibly
have worked in the first place, or are following in the footsteps of other
behaviors, e.g. KVM advertises x2APIC, which is 100% dependent on an in-kernel
local APIC.

 * Disallow stuffing CPUID-dependent guest CR4 features before setting guest
   CPUID.
 * Disallow KVM_CAP_X86_DISABLE_EXITS after vCPU creation
 * Reject disabling of MWAIT/HLT interception when not allowed
 * Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID.
 * Advertise HYPERVISOR in KVM_GET_SUPPORTED_CPUID

Lastly, regarding the PoC DO NOT APPLY patch, I hope to turn that into an actual
patch in the future.  E.g. I think we can shove feature usage information into
a .note or something, and then do post-processing a la objtool during the build.

v2:
 - Collect a few reviews (though I dropped several due to the patches changing
   significantly).
 - Incorporate KVM's support into the vCPU's cpu_caps. [Maxim]
 - A massive pile of new patches.

v1: https://lore.kernel.org/all/20231110235528.1561679-1-seanjc@google.com

Sean Christopherson (49):
  KVM: x86: Do all post-set CPUID processing during vCPU creation
  KVM: x86: Explicitly do runtime CPUID updates "after" initial setup
  KVM: x86: Account for KVM-reserved CR4 bits when passing through CR4
    on VMX
  KVM: selftests: Update x86's set_sregs_test to match KVM's CPUID
    enforcement
  KVM: selftests: Assert that the @cpuid passed to get_cpuid_entry() is
    non-NULL
  KVM: selftests: Refresh vCPU CPUID cache in __vcpu_get_cpuid_entry()
  KVM: selftests: Verify KVM stuffs runtime CPUID OS bits on CR4 writes
  KVM: x86: Move __kvm_is_valid_cr4() definition to x86.h
  KVM: x86/pmu: Drop now-redundant refresh() during init()
  KVM: x86: Drop now-redundant MAXPHYADDR and GPA rsvd bits from vCPU
    creation
  KVM: x86: Disallow KVM_CAP_X86_DISABLE_EXITS after vCPU creation
  KVM: x86: Reject disabling of MWAIT/HLT interception when not allowed
  KVM: selftests: Fix a bad TEST_REQUIRE() in x86's KVM PV test
  KVM: selftests: Update x86's KVM PV test to match KVM's disabling
    exits behavior
  KVM: x86: Zero out PV features cache when the CPUID leaf is not
    present
  KVM: x86: Don't update PV features caches when enabling enforcement
    capability
  KVM: x86: Do reverse CPUID sanity checks in __feature_leaf()
  KVM: x86: Account for max supported CPUID leaf when getting raw host
    CPUID
  KVM: x86: Add a macro to init CPUID features that ignore host kernel
    support
  KVM: x86: Rename kvm_cpu_cap_mask() to kvm_cpu_cap_init()
  KVM: x86: Add a macro to init CPUID features that are 64-bit only
  KVM: x86: Add a macro to precisely handle aliased 0x1.EDX CPUID
    features
  KVM: x86: Handle kernel- and KVM-defined CPUID words in a single
    helper
  KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to avoid macro collisions
  KVM: x86: Harden CPU capabilities processing against out-of-scope
    features
  KVM: x86: Add a macro to init CPUID features that KVM emulates in
    software
  KVM: x86: Swap incoming guest CPUID into vCPU before massaging in
    KVM_SET_CPUID2
  KVM: x86: Clear PV_UNHALT for !HLT-exiting only when userspace sets
    CPUID
  KVM: x86: Remove unnecessary caching of KVM's PV CPUID base
  KVM: x86: Always operate on kvm_vcpu data in cpuid_entry2_find()
  KVM: x86: Move kvm_find_cpuid_entry{,_index}() up near
    cpuid_entry2_find()
  KVM: x86: Remove all direct usage of cpuid_entry2_find()
  KVM: x86: Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID
  KVM: x86: Advertise HYPERVISOR in KVM_GET_SUPPORTED_CPUID
  KVM: x86: Add a macro to handle features that are fully VMM controlled
  KVM: x86: Rename "governed features" helpers to use "guest_cpu_cap"
  KVM: x86: Replace guts of "governed" features with comprehensive
    cpu_caps
  KVM: x86: Initialize guest cpu_caps based on guest CPUID
  KVM: x86: Extract code for generating per-entry emulated CPUID
    information
  KVM: x86: Initialize guest cpu_caps based on KVM support
  KVM: x86: Avoid double CPUID lookup when updating MWAIT at runtime
  KVM: x86: Drop unnecessary check that cpuid_entry2_find() returns
    right leaf
  KVM: x86: Update OS{XSAVE,PKE} bits in guest CPUID irrespective of
    host support
  KVM: x86: Update guest cpu_caps at runtime for dynamic CPUID-based
    features
  KVM: x86: Shuffle code to prepare for dropping guest_cpuid_has()
  KVM: x86: Replace (almost) all guest CPUID feature queries with
    cpu_caps
  KVM: x86: Drop superfluous host XSAVE check when adjusting guest
    XSAVES caps
  KVM: x86: Add a macro for features that are synthesized into
    boot_cpu_data
  *** DO NOT APPLY *** KVM: x86: Verify KVM initializes all consumed
    guest caps

 Documentation/virt/kvm/api.rst                |  10 +-
 arch/x86/include/asm/kvm_host.h               |  46 +-
 arch/x86/kvm/cpuid.c                          | 660 +++++++++++-------
 arch/x86/kvm/cpuid.h                          | 141 ++--
 arch/x86/kvm/governed_features.h              |  22 -
 arch/x86/kvm/hyperv.c                         |   2 +-
 arch/x86/kvm/lapic.c                          |   2 +-
 arch/x86/kvm/mmu.h                            |   2 +-
 arch/x86/kvm/mmu/mmu.c                        |   4 +-
 arch/x86/kvm/mtrr.c                           |   2 +-
 arch/x86/kvm/pmu.c                            |   1 -
 arch/x86/kvm/reverse_cpuid.h                  |  22 +-
 arch/x86/kvm/smm.c                            |  10 +-
 arch/x86/kvm/svm/nested.c                     |  22 +-
 arch/x86/kvm/svm/pmu.c                        |   8 +-
 arch/x86/kvm/svm/sev.c                        |  21 +-
 arch/x86/kvm/svm/svm.c                        |  46 +-
 arch/x86/kvm/svm/svm.h                        |   4 +-
 arch/x86/kvm/vmx/hyperv.h                     |   2 +-
 arch/x86/kvm/vmx/nested.c                     |  18 +-
 arch/x86/kvm/vmx/pmu_intel.c                  |   4 +-
 arch/x86/kvm/vmx/sgx.c                        |  14 +-
 arch/x86/kvm/vmx/vmx.c                        |  61 +-
 arch/x86/kvm/x86.c                            | 153 ++--
 arch/x86/kvm/x86.h                            |   6 +-
 include/asm-generic/vmlinux.lds.h             |   4 +
 .../selftests/kvm/include/x86_64/processor.h  |  11 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   2 +
 .../selftests/kvm/x86_64/kvm_pv_test.c        |  38 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  63 +-
 30 files changed, 791 insertions(+), 610 deletions(-)
 delete mode 100644 arch/x86/kvm/governed_features.h


base-commit: 4aad0b1893a141f114ba40ed509066f3c9bc24b0
-- 
2.45.0.215.g3402c0e53f-goog


