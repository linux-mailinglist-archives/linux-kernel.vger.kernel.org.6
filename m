Return-Path: <linux-kernel+bounces-552957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F7A58179
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A993ADE7E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54618DB2B;
	Sun,  9 Mar 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+ohwJQU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3518787F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507888; cv=none; b=Yk6qjUtZRWV90yGvIXC5ap5H3jYY6v7wM182dtJwYvFHqjsbonlTEa0Xg3OC9iSpNBqPnbeVzgxTW75GxOSg06AaOOlQg4R1lj96xzrviJZNwnDpMJJHVcvImtfaeIKZro2txdNlqNE2ly/whGZYgEUkNOYh5hCK3Wm4+kFC7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507888; c=relaxed/simple;
	bh=ywIIx7CiwkSiZ7dUfWCVTJcaWhwCEYd2mnYkP29YtLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFvuO1wb8f4JHS2oQkgw7Jnwyb1wRAiHlQpq98i8+nhW+RFfkjOePPZQD3F7C/HmS8abFEGareFgLgd7BulMW0gnfMYWhnkpLFMONyPjy0xJdJJga/N+n7snLh+lj7n4JEca/LjbWNYDbGTX9pTm3N+ozzBSlbQu7twovql2K98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+ohwJQU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741507885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7sH7FGfqnhoLEuqI61iUbKKZNJk8uSxjiDzSzhKVUkA=;
	b=J+ohwJQUMm1UaURcA/6hVfd1IiwNlZpW7prlf2j54fbHm/mfVJg17a8hDsxyDEmu/gpcY8
	WiZXZGieUqvPQDKXlSiLcv0fherhu2dVcPz3lmoTaPL73u2GK/70KqaVV1eiLEYbm8kQ7K
	FWIChhnDsLU+tb09WkvwPUaYP74Cg9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-MWeIDluvMKy8ay3kww2keg-1; Sun,
 09 Mar 2025 04:11:21 -0400
X-MC-Unique: MWeIDluvMKy8ay3kww2keg-1
X-Mimecast-MFC-AGG-ID: MWeIDluvMKy8ay3kww2keg_1741507880
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D9731956080;
	Sun,  9 Mar 2025 08:11:20 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46D0E1800370;
	Sun,  9 Mar 2025 08:11:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux-6.14-rc6
Date: Sun,  9 Mar 2025 04:11:18 -0400
Message-ID: <20250309081118.2953196-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Linus,

The following changes since commit 916b7f42b3b3b539a71c204a9b49fdc4ca92cd82:

  kvm: retry nx_huge_page_recovery_thread creation (2025-03-01 02:54:18 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to ea9bd29a9c0d757b3384ae3e633e6bbaddf00725:

  Merge tag 'kvm-x86-fixes-6.14-rcN.2' of https://github.com/kvm-x86/linux into HEAD (2025-03-09 03:44:06 -0400)

This remains quite an active rc period, but these are "just" bugs and
issues introduced during this merge window.  So, no big deal overall.

Paolo

----------------------------------------------------------------
KVM/arm64 fixes for 6.14, take #4

* Fix a couple of bugs affecting pKVM's PSCI relay implementation
  when running in the hVHE mode, resulting in the host being entered
  with the MMU in an unknown state, and EL2 being in the wrong mode.

x86:

* Set RFLAGS.IF in C code on SVM to get VMRUN out of the STI shadow.

* Ensure DEBUGCTL is context switched on AMD to avoid running the guest with
  the host's value, which can lead to unexpected bus lock #DBs.

* Suppress DEBUGCTL.BTF on AMD (to match Intel), as KVM doesn't properly
  emulate BTF.  KVM's lack of context switching has meant BTF has always been
  broken to some extent.

* Always save DR masks for SNP vCPUs if DebugSwap is *supported*, as the guest
  can enable DebugSwap without KVM's knowledge.

* Fix a bug in mmu_stress_tests where a vCPU could finish the "writes to RO
  memory" phase without actually generating a write-protection fault.

* Fix a printf() goof in the SEV smoke test that causes build failures with
  -Werror.

* Explicitly zero EAX and EBX in CPUID.0x8000_0022 output when PERFMON_V2
  isn't supported by KVM.

----------------------------------------------------------------
Ahmed Genidi (1):
      KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()

Mark Rutland (1):
      KVM: arm64: Initialize HCR_EL2.E2H early

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-6.14-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-fixes-6.14-rcN.2' of https://github.com/kvm-x86/linux into HEAD

Sean Christopherson (11):
      KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI shadow
      KVM: selftests: Assert that STI blocking isn't set after event injection
      KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
      KVM: SVM: Suppress DEBUGCTL.BTF on AMD
      KVM: x86: Snapshot the host's DEBUGCTL in common x86
      KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is disabled
      KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
      KVM: SVM: Save host DR masks on CPUs with DebugSwap
      KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
      KVM: selftests: Ensure all vCPUs hit -EFAULT during initial RO stage
      KVM: selftests: Fix printf() format goof in SEV smoke test

Xiaoyao Li (1):
      KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't supported by KVM

 arch/arm64/include/asm/el2_setup.h                 | 31 +++++++++++---
 arch/arm64/kernel/head.S                           | 22 ++--------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 | 10 +++--
 arch/arm64/kvm/hyp/nvhe/psci-relay.c               |  3 ++
 arch/x86/include/asm/kvm_host.h                    |  1 +
 arch/x86/kvm/cpuid.c                               |  2 +-
 arch/x86/kvm/svm/sev.c                             | 24 +++++++----
 arch/x86/kvm/svm/svm.c                             | 49 ++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h                             |  2 +-
 arch/x86/kvm/svm/vmenter.S                         | 10 +----
 arch/x86/kvm/vmx/vmx.c                             |  8 +---
 arch/x86/kvm/vmx/vmx.h                             |  2 -
 arch/x86/kvm/x86.c                                 |  2 +
 tools/testing/selftests/kvm/mmu_stress_test.c      | 21 ++++++----
 .../selftests/kvm/x86/nested_exceptions_test.c     |  2 +
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  3 +-
 16 files changed, 130 insertions(+), 62 deletions(-)


