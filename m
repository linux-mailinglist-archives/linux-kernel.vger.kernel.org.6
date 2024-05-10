Return-Path: <linux-kernel+bounces-176310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB88C2DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E16F1F23AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25417BB28;
	Fri, 10 May 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4Zy1ZCz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6F17556D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385070; cv=none; b=Xh9fVUwUAmMphnDzZab48s+BLZln6snivXluJTJxFJvfZ720Vi5+9yPtHP6i0f1cXXNqmwql6RrHnx62at3Djvt6Ja9javPmGY3B3cWcSmPpU8oavEeJVY//0hRzPAwAYY84wF1MGIUVdwtGpxwbeQMzqKEdGh/E5NM+g/FidLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385070; c=relaxed/simple;
	bh=rJJ8HT1wt4Qw9zNPR03GUPcqwyvb036fRSV1yajH3ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PHEM0aPz6XTpM7ucjYiSOHEm/W/kTpKixFypqzscHzcPidRbMvqKTVm+gJdrtf91TDt7Lu16Nz3SsiI/XbnS3aIjRKEWSP3fFpn1/YBJDtH5U86FWkwrqfzXhfr2inEoUvPNw66HMNlyt4Oc1vAT1+0JCtHL69uE/U9u+1Ht3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4Zy1ZCz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de468af2b73so4443983276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715385068; x=1715989868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EhtSH1buLP4iSrusUvRNX1fIwBVmFX1pa+rLJsu4JlM=;
        b=j4Zy1ZCzJA1oznohCfhqnaJPTQAiqS8leBwKMgq56en/hCyxMSOclS6c9uQPZwz0lY
         XyXX4L1KMSu21qyuL6zLT7P8C0XRl3PeyDW1+cXb0YV25dQNk9Eox/tQBg1nEvhm7u60
         rImnsL1ZKJZHSEHtnLF9ihQFVWIIRgP6z43SQcBhO+l0t3ZcMPq5umICjg6Hrm/PUVJQ
         0JK0dN9UiHqseu83Hs/OcAhetEk3NJL3QIV/X36BQXgl7imVQBuPYtLQ22k7i1/CvTpK
         pPGgQq8zMRHev9iIzKI983bP3QLappllJuCASiAmLCYCFXQ/CIY3B6eMD8bfG/OPupLA
         elQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715385068; x=1715989868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhtSH1buLP4iSrusUvRNX1fIwBVmFX1pa+rLJsu4JlM=;
        b=bG2BZvlt+7jYsDCjd29BkLFouNlxLD/4rdz2WkHQ/L9B8OkK5+Ey4CSYDZilpjDq7g
         BJFE0nfbrPKwoWtxzPtuhmddrokk+Gts4z3omTBFTM0iHo8PhRLzB1nJH1OHViETXcoD
         2dsSo/iwv0Oj2i04rF4BDIMCErvjxOBhftXQFa/j/cTMisji0HDCJuf+AQFXPS3w4f9q
         wCMaPHDWjswYUOX8GVL/kw+Yaodm+dCPBhw0wR+iLmwOtORCA+gisqfThdXcMJ4cWb4j
         8wIFrIUZ2oJd2J0wfzgaGY8Bwkmqj0FQeLGf9bWzE9dV6N/b2lpraCvvnXswYveq2wAU
         Kcsg==
X-Forwarded-Encrypted: i=1; AJvYcCXbucaurqDprFBkyGWIAjn5/7PFmgIDPp4xuNz9ESyQa5ujCPXTdvv5mbQQbOR/HZ1J95A7CzlFX7G7YRSG7gHe+9UzvGVWvbNZq5J+
X-Gm-Message-State: AOJu0YyvjtxWaarlYW88fpjRtXcf532A5tK6YLZ4o/yi7OZw4nH8UQ1N
	NZNu774jv5IfVmzV9K/erNYJDL2qgbku7FEkDKl/V96pVhEo4L3izgjcrJ7bb25mQjv+F++75i4
	hfQ==
X-Google-Smtp-Source: AGHT+IFv9O2I4slGeiI/d71AXAmRX0qOK+4unXCWaiBKAY5iqk0UvAYQYq71WpKYeyR9BIwWT1Z8qY9p8pg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr1004667276.9.1715385068018; Fri, 10 May 2024
 16:51:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 May 2024 16:50:50 -0700
In-Reply-To: <20240510235055.2811352-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510235055.2811352-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510235055.2811352-6-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests "tree"-wide changes for 6.10
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Selftests pull request 2 of 2.  I put these changes into a separate branch so
that other arch maintainers had a stable target to build on, though AFAIK there
are no branches that depend on this, nor that conflict with this.

The most annoying change is to revert kvm_util_base.h back to kvm_util.h.  The
_entire_ reason for the layer of inclusion indirection was to avoid a handful
of explicit ucall_common.h #includes.  /facepalm

The other wide-sweeping change is to define _GNU_SOURCE in the Makefile, mostly
in response to an annoying warning that was introduced late in 6.9 due
kselftest_harness.h using a _GNU_SOURCE-only function, but not guaranteeing
that _GNU_SOURCE was defined before stdio.h was first included (I think that
was the offending #include).

Long story short, it was/is a bit of a mess, and there will likely be a true
tree-wide tools series/patch coming along early in 6.10 to essentially give all
of tools the same treatment, i.e. define _GNU_SOURCE for everything.  We
shouldn't *need* to do anything, though if/when that lands, we may need to
remove the definition from KVM selftests' Makefile (like I said, it's a mess).

The following changes since commit a96cb3bf390eebfead5fc7a2092f8452a7997d1b:

  Merge x86 bugfixes from Linux 6.9-rc3 (2024-04-19 09:02:22 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests_utils-6.10

for you to fetch changes up to b093f87fd1957cdfbe518d5bb2caa39ba80c1669:

  KVM: selftests: Drop @selector from segment helpers (2024-04-29 12:55:22 -0700)

----------------------------------------------------------------
KVM selftests treewide updates for 6.10:

 - Define _GNU_SOURCE for all selftests to fix a warning that was introduced by
   a change to kselftest_harness.h late in the 6.9 cycle, and because forcing
   every test to #define _GNU_SOURCE is painful.

 - Provide a global psuedo-RNG instance for all tests, so that library code can
   generate random, but determinstic numbers.

 - Use the global pRNG to randomly force emulation of select writes from guest
   code on x86, e.g. to help validate KVM's emulation of locked accesses.

 - Rename kvm_util_base.h back to kvm_util.h, as the weird layer of indirection
   was added purely to avoid manually #including ucall_common.h in a handful of
   locations.

 - Allocate and initialize x86's GDT, IDT, TSS, segments, and default exception
   handlers at VM creation, instead of forcing tests to manually trigger the
   related setup.

----------------------------------------------------------------
Ackerley Tng (1):
      KVM: selftests: Fix off-by-one initialization of GDT limit

Sean Christopherson (23):
      KVM: selftests: Define _GNU_SOURCE for all selftests code
      KVM: selftests: Provide a global pseudo-RNG instance for all tests
      KVM: selftests: Provide an API for getting a random bool from an RNG
      KVM: selftests: Add global snapshot of kvm_is_forced_emulation_enabled()
      KVM: selftests: Add vcpu_arch_put_guest() to do writes from guest code
      KVM: selftests: Randomly force emulation on x86 writes from guest code
      Revert "kvm: selftests: move base kvm_util.h declarations to kvm_util_base.h"
      KVM: sefltests: Add kvm_util_types.h to hold common types, e.g. vm_vaddr_t
      KVM: selftests: Move GDT, IDT, and TSS fields to x86's kvm_vm_arch
      KVM: selftests: Move platform_info_test's main assert into guest code
      KVM: selftests: Rework platform_info_test to actually verify #GP
      KVM: selftests: Explicitly clobber the IDT in the "delete memslot" testcase
      KVM: selftests: Move x86's descriptor table helpers "up" in processor.c
      KVM: selftests: Rename x86's vcpu_setup() to vcpu_init_sregs()
      KVM: selftests: Init IDT and exception handlers for all VMs/vCPUs on x86
      KVM: selftests: Map x86's exception_handlers at VM creation, not vCPU setup
      KVM: selftests: Allocate x86's GDT during VM creation
      KVM: selftests: Drop superfluous switch() on vm->mode in vcpu_init_sregs()
      KVM: selftests: Fold x86's descriptor tables helpers into vcpu_init_sregs()
      KVM: selftests: Allocate x86's TSS at VM creation
      KVM: selftests: Add macro for TSS selector, rename up code/data macros
      KVM: selftests: Init x86's segments during VM creation
      KVM: selftests: Drop @selector from segment helpers

 tools/testing/selftests/kvm/Makefile               |    4 +-
 tools/testing/selftests/kvm/aarch64/arch_timer.c   |    3 +-
 .../selftests/kvm/aarch64/page_fault_test.c        |    1 -
 tools/testing/selftests/kvm/aarch64/psci_test.c    |    3 -
 tools/testing/selftests/kvm/aarch64/vgic_init.c    |    1 -
 tools/testing/selftests/kvm/arch_timer.c           |    4 +-
 tools/testing/selftests/kvm/demand_paging_test.c   |    4 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c  |   10 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |   26 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |    4 +-
 tools/testing/selftests/kvm/guest_print_test.c     |    1 +
 .../testing/selftests/kvm/hardware_disable_test.c  |    3 -
 .../selftests/kvm/include/aarch64/processor.h      |    2 +
 .../testing/selftests/kvm/include/aarch64/ucall.h  |    2 +-
 tools/testing/selftests/kvm/include/kvm_util.h     | 1111 +++++++++++++++++++-
 .../testing/selftests/kvm/include/kvm_util_base.h  |   15 +-
 .../testing/selftests/kvm/include/kvm_util_types.h |   20 +
 tools/testing/selftests/kvm/include/memstress.h    |    1 -
 tools/testing/selftests/kvm/include/s390x/ucall.h  |    2 +-
 tools/testing/selftests/kvm/include/test_util.h    |   19 +
 .../selftests/kvm/include/userfaultfd_util.h       |    3 -
 .../selftests/kvm/include/x86_64/kvm_util_arch.h   |   28 +
 .../selftests/kvm/include/x86_64/processor.h       |    5 +-
 tools/testing/selftests/kvm/include/x86_64/ucall.h |    2 +-
 .../testing/selftests/kvm/kvm_binary_stats_test.c  |    2 -
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c |    2 -
 tools/testing/selftests/kvm/kvm_page_table_test.c  |    4 +-
 .../testing/selftests/kvm/lib/aarch64/processor.c  |    2 +
 tools/testing/selftests/kvm/lib/assert.c           |    3 -
 tools/testing/selftests/kvm/lib/kvm_util.c         |   12 +-
 tools/testing/selftests/kvm/lib/memstress.c        |   13 +-
 tools/testing/selftests/kvm/lib/riscv/processor.c  |    1 +
 tools/testing/selftests/kvm/lib/test_util.c        |    2 -
 tools/testing/selftests/kvm/lib/ucall_common.c     |    5 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |    3 -
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  308 +++---
 tools/testing/selftests/kvm/lib/x86_64/sev.c       |    1 -
 .../testing/selftests/kvm/max_guest_memory_test.c  |    2 -
 .../kvm/memslot_modification_stress_test.c         |    3 -
 tools/testing/selftests/kvm/riscv/arch_timer.c     |    4 +-
 tools/testing/selftests/kvm/rseq_test.c            |   13 +-
 tools/testing/selftests/kvm/s390x/cmma_test.c      |    3 +-
 tools/testing/selftests/kvm/s390x/memop.c          |    1 +
 tools/testing/selftests/kvm/s390x/sync_regs_test.c |    2 -
 tools/testing/selftests/kvm/s390x/tprot.c          |    1 +
 .../testing/selftests/kvm/set_memory_region_test.c |   13 +-
 tools/testing/selftests/kvm/steal_time.c           |    2 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c      |    4 -
 .../kvm/x86_64/dirty_log_page_splitting_test.c     |    1 +
 .../kvm/x86_64/exit_on_emulation_failure_test.c    |    5 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c      |    2 -
 tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c |    2 -
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c  |    2 -
 tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c  |    3 -
 .../testing/selftests/kvm/x86_64/hyperv_features.c |    6 -
 tools/testing/selftests/kvm/x86_64/hyperv_ipi.c    |    5 -
 .../testing/selftests/kvm/x86_64/hyperv_svm_test.c |    1 -
 .../selftests/kvm/x86_64/hyperv_tlb_flush.c        |    2 -
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c   |    3 -
 .../selftests/kvm/x86_64/monitor_mwait_test.c      |    3 -
 .../selftests/kvm/x86_64/nested_exceptions_test.c  |    2 -
 .../selftests/kvm/x86_64/nx_huge_pages_test.c      |    3 -
 .../selftests/kvm/x86_64/platform_info_test.c      |   61 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c       |    8 -
 .../selftests/kvm/x86_64/pmu_event_filter_test.c   |    9 -
 .../kvm/x86_64/private_mem_conversions_test.c      |    1 -
 .../testing/selftests/kvm/x86_64/set_boot_cpu_id.c |    1 -
 .../testing/selftests/kvm/x86_64/set_sregs_test.c  |    1 -
 .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c |    6 -
 tools/testing/selftests/kvm/x86_64/smm_test.c      |    1 -
 tools/testing/selftests/kvm/x86_64/state_test.c    |    1 -
 .../selftests/kvm/x86_64/svm_int_ctl_test.c        |    3 -
 .../kvm/x86_64/svm_nested_shutdown_test.c          |    5 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c       |    5 +-
 .../testing/selftests/kvm/x86_64/sync_regs_test.c  |    2 -
 .../selftests/kvm/x86_64/ucna_injection_test.c     |    7 -
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c |   15 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c      |    3 -
 .../vmx_exception_with_invalid_guest_state.c       |    3 -
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c       |    4 -
 .../kvm/x86_64/vmx_preemption_timer_test.c         |    1 -
 .../testing/selftests/kvm/x86_64/xapic_ipi_test.c  |    4 -
 .../selftests/kvm/x86_64/xapic_state_test.c        |    1 -
 .../testing/selftests/kvm/x86_64/xcr0_cpuid_test.c |    3 -
 .../testing/selftests/kvm/x86_64/xen_shinfo_test.c |    7 +-
 tools/testing/selftests/kvm/x86_64/xss_msr_test.c  |    2 -
 86 files changed, 1423 insertions(+), 451 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util_types.h

