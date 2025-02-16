Return-Path: <linux-kernel+bounces-516479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DACA37248
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122AF1892037
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49E14F9F7;
	Sun, 16 Feb 2025 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKnxQqQg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5586344
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739687325; cv=none; b=f5WupjnbtP7+TQGaIvk9W1zYGRQrOe8oFl2qmOVO9T6sKUSQAkwUynDt4QR6Pk2yu1gpVWJCaBZiT38berjiAjQy5wqCSUJQGzcQJm6WvJfYu0utbI5Ht5ZtAM07TmXBI1r1reGwfKYkDRfXVKLJsfQN6Hns+e/+R0M+ZmYw0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739687325; c=relaxed/simple;
	bh=vvBmhytAcj3i5WgVJFvgq/urGk853xXGqxFJZ5PFEJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwfYeroyXwCEvisuUPxn+f/NgNsewOV2w0fRYThocmwxTxR80TkyQdt2C8fU//uQ5cL1B5tmwHm+gu1JTfIxqKaCs65U4e47sf4ukMih/Lk6Ei/J27vEyDlmWeWbx1lpeZ0ZVoj9Sn0ZbQXjGOImT48pqkDTVfkWasNv0E6axt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKnxQqQg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739687322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fUHMwDQtDKIjWDHBjGlmonYD/MxpnLjHDJs6JdZQtw4=;
	b=GKnxQqQgeSgdXLcP9qxTV9ZBElhLyqgKQN84Va5qY3o9MnVZlRxCz/HuqEfs9QOmj4My72
	eO1g3ND2eIXvdM0zqlaHSh64pP3pTF3Cu3phG3Q2nr+DCj9gvkudthw8sxBLpIAFFvHj+o
	NQPghsOP5iayu4WYid5TNKGZcjZ+Cak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-oqDxAXhVPBOvu7yo21EScQ-1; Sun, 16 Feb 2025 01:28:40 -0500
X-MC-Unique: oqDxAXhVPBOvu7yo21EScQ-1
X-Mimecast-MFC-AGG-ID: oqDxAXhVPBOvu7yo21EScQ_1739687320
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f27acb979so2670911f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 22:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739687319; x=1740292119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUHMwDQtDKIjWDHBjGlmonYD/MxpnLjHDJs6JdZQtw4=;
        b=ey/14mToL8VgsH6qZnxThKaD5qhJ4ZrsTDyZR7g7/jykqJSkeUdqVVnw+ZqNLga+YD
         5T9PNeGA/VE1nrwENzvv65ONtDvF32x8M6B5U/gPV8gM70QXTTb+PiSEe4R4RnH3Ybya
         5lR32aEgj5JxVHRJLPuWdsiGlAweMbyDyi6Lm7VMe/9BNYoq2479H2Ej7nGm3AjEeQMH
         KplBn9cTyTH7PtxDQC1FIxO8XCAJuQubA4SqZvZpXtsOXRu/kbTrdETUXYKfmwzvgSd8
         WtFRcBgvdJtE9YyWA2ZN96753bFRjGRJuEVyb2U0XcrGQMgcuqZM1UEvkMGK3l5bpZke
         FhKg==
X-Gm-Message-State: AOJu0Yzz5pQPdP0OSkWlcqWr2sD6IRFPm/bxblQWAVXmQeRPApK/N8tX
	Z+5Kd164zgRjVCLzpFvwNf75H11AdkxJj2UdPDin7nf5A8yMU/tuQsh9mvYH95RScJ5w3b0fLUh
	Q3sa9D5MMuB29YAA1QCdWkCAr+XwIDhxeL5NiTbVrKRbSIUBLi/XiIo71zCxh3Q==
X-Gm-Gg: ASbGnctasX/XQpeb3CdOG9GczuxvUpi3pPv4NGfJw9uF1fWnzY52EV9YBcIPqAfeIjt
	Rtesfim4Jv95RVn54vB3cFWqhMvfDw1rQ0iUCMKbuW0iC5VaAwzxhs3h/KuZbFzPfbF6XaadEjl
	ZHi64t4qQYQ9gd7XApfLx4tWZRUYauGaUNf+8KjPsIzdVtnGfSy0b2xFRHd6HB02BOy0Uj8kJ8q
	ZxPZIXoKuNSrwWAObqmueLXJDvi0WohYi89LMPn0LTOE4rCv6JAuG7E2CF00nA8NQtfTF7Sk4MR
	rlkrVNsjp1E=
X-Received: by 2002:a5d:5887:0:b0:38f:3b57:681e with SMTP id ffacd0b85a97d-38f3b576996mr1890130f8f.49.1739687319351;
        Sat, 15 Feb 2025 22:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjN+naMbYq/QzR148F7bY8c8IVUBBJrBx8C9VPSfBs1cbj3Dg/jLe7jN5AIAK7PvxivZRPMg==
X-Received: by 2002:a5d:5887:0:b0:38f:3b57:681e with SMTP id ffacd0b85a97d-38f3b576996mr1890115f8f.49.1739687318919;
        Sat, 15 Feb 2025 22:28:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25914d73sm9045831f8f.54.2025.02.15.22.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 22:28:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	eauger@redhat.com,
	maz@kernel.org,
	seanjc@google.com
Subject: [GIT PULL] KVM fixes for Linux 6.14-rc3
Date: Sun, 16 Feb 2025 07:28:37 +0100
Message-ID: <20250216062837.4152522-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to d3d0b8dfe06098d6d584266c35e9a0947f5b7132:

  Merge tag 'kvm-x86-fixes-6.14-rcN' of https://github.com/kvm-x86/linux into HEAD (2025-02-14 19:08:35 -0500)

Yet another largish pull request, this time that's (mostly) thanks to ARM
which has a vector register ~rewrite that fixes a good deal of bugs and
actually removes more code than it adds.

Paolo

----------------------------------------------------------------
ARM:

- Large set of fixes for vector handling, specially in the interactions
  between host and guest state. This fixes a number of bugs affecting
  actual deployments, and greatly simplifies the FP/SIMD/SVE handling.
  Thanks to Mark Rutland for dealing with this thankless task.

- Fix an ugly race between vcpu and vgic creation/init, resulting in
  unexpected behaviours.

- Fix use of kernel VAs at EL2 when emulating timers with nVHE.

- Small set of pKVM improvements and cleanups.

x86:

- Fix broken SNP support with KVM module built-in, ensuring the PSP
  module is initialized before KVM even when the module infrastructure
  cannot be used to order initcalls

- Reject Hyper-V SEND_IPI hypercalls if the local APIC isn't being emulated
  by KVM to fix a NULL pointer dereference.

- Enter guest mode (L2) from KVM's perspective before initializing the vCPU's
  nested NPT MMU so that the MMU is properly tagged for L2, not L1.

- Load the guest's DR6 outside of the innermost .vcpu_run() loop, as the
  guest's value may be stale if a VM-Exit is handled in the fastpath.

----------------------------------------------------------------
Ashish Kalra (1):
      x86/sev: Fix broken SNP support with KVM module built-in

Marc Zyngier (4):
      KVM: arm64: Fix __pkvm_host_mkyoung_guest() return value
      KVM: arm64: Convert timer offset VA when accessed in HYP code
      KVM: arm64: timer: Drop warning on failed interrupt signalling
      KVM: arm64: vgic: Hoist SGI/PPI alloc from vgic_init() to kvm_create_vgic()

Mark Rutland (9):
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      KVM: arm64: Refactor CPTR trap deactivation
      KVM: arm64: Refactor exit handlers
      KVM: arm64: Mark some header functions as inline
      KVM: arm64: Eagerly switch ZCR_EL{1,2}
      KVM: arm64: Simplify warning in kvm_arch_vcpu_load_fp()

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-6.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-fixes-6.14-rcN' of https://github.com/kvm-x86/linux into HEAD

Quentin Perret (3):
      KVM: arm64: Improve error handling from check_host_shared_guest()
      KVM: arm64: Simplify np-guest hypercalls
      KVM: arm64: Fix alignment of kvm_hyp_memcache allocations

Sean Christopherson (8):
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
      KVM: selftests: Mark test_hv_cpuid_e2big() static in Hyper-V CPUID test
      KVM: selftests: Manage CPUID array in Hyper-V CPUID test's core helper
      KVM: selftests: Add CPUID tests for Hyper-V features that need in-kernel APIC
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop
      crypto: ccp: Add external API interface for PSP module initialization
      KVM: SVM: Ensure PSP module is initialized if KVM module is built-in

 arch/arm64/include/asm/kvm_emulate.h           |  42 -------
 arch/arm64/include/asm/kvm_host.h              |  22 +---
 arch/arm64/kernel/fpsimd.c                     |  25 -----
 arch/arm64/kvm/arch_timer.c                    |  16 ++-
 arch/arm64/kvm/arm.c                           |   8 --
 arch/arm64/kvm/fpsimd.c                        | 107 ++----------------
 arch/arm64/kvm/hyp/entry.S                     |   5 +
 arch/arm64/kvm/hyp/include/hyp/switch.h        | 148 ++++++++++++++++++-------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c             |  15 ++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c          |  76 +++++++------
 arch/arm64/kvm/hyp/nvhe/switch.c               |  89 +++++++--------
 arch/arm64/kvm/hyp/vhe/switch.c                |  33 +++---
 arch/arm64/kvm/vgic/vgic-init.c                |  74 ++++++-------
 arch/x86/include/asm/kvm-x86-ops.h             |   1 +
 arch/x86/include/asm/kvm_host.h                |   1 +
 arch/x86/include/asm/sev.h                     |   2 +
 arch/x86/kvm/hyperv.c                          |   6 +-
 arch/x86/kvm/mmu/mmu.c                         |   2 +-
 arch/x86/kvm/svm/nested.c                      |  10 +-
 arch/x86/kvm/svm/sev.c                         |  10 ++
 arch/x86/kvm/svm/svm.c                         |  13 +--
 arch/x86/kvm/vmx/main.c                        |   1 +
 arch/x86/kvm/vmx/vmx.c                         |  10 +-
 arch/x86/kvm/vmx/x86_ops.h                     |   1 +
 arch/x86/kvm/x86.c                             |   3 +
 arch/x86/virt/svm/sev.c                        |  23 ++--
 drivers/crypto/ccp/sp-dev.c                    |  14 +++
 drivers/iommu/amd/init.c                       |  34 +++++-
 include/linux/psp-sev.h                        |   9 ++
 tools/testing/selftests/kvm/x86/hyperv_cpuid.c |  47 +++++---
 30 files changed, 420 insertions(+), 427 deletions(-)


