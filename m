Return-Path: <linux-kernel+bounces-287044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F5952215
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB74285341
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E11BDA8E;
	Wed, 14 Aug 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuFO1j+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447593BBCB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660438; cv=none; b=ZiPVfvU353Cwnu24HUGxlryuNG+Q/cCBfyzSbNWsOBXt4F3p4PrXGfTUw5J2LQuQTSoBpA2UiLgNITdmr2AcMvu97xNKDyom3IeISr39uzMpPsEC++inyTnLBIYSNpoDwYRogQDEKQ3LSI6JgN9Ti7qQqLPFfMv2ViWo+y1aJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660438; c=relaxed/simple;
	bh=5Ce1/H9Ux655K9UiP++aF7o997PoE3Y0IQkw/iyPbAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSguaQBIitivVYZaziLF+DDGL1BSFDncpdICNC6bOiJNs+kOb1YbN2dD7nPkscU3CzX8GSKKZtlD+ff2e2pEXz3kVpatllRTyEPxaPpFZYTRj9KeY+M/3iRdWWEFdJ3KJUx7M2Ub5AshVr5FxiQh9PlqHIrGvuQ4P7BFhRN5m6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuFO1j+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723660435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VcmqJGRF+dA2IAlaAzlNRKtjmnsV6SFx5m9u5O7ZuJE=;
	b=QuFO1j+rMPaPCk0hqGRnNSdlxD3enQUAJSKKXAaKnBWP/4oxklGC5KZwhCcGXoIXjH3vjF
	t3tXmgU/clmwqCerdYTnc4gw+1kQyMfOpKBJgaJBYYHrzkzu9GtflWAkwu8QMoMgEK/Yg7
	wRYplh0ooMGSEJHenHap/Evt1Lm14uk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-sKSjAJoIPlKhoSq9UupV4g-1; Wed,
 14 Aug 2024 14:33:51 -0400
X-MC-Unique: sKSjAJoIPlKhoSq9UupV4g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A3C918EA8E1;
	Wed, 14 Aug 2024 18:33:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D048419560AA;
	Wed, 14 Aug 2024 18:33:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 6.11-rc4
Date: Wed, 14 Aug 2024 14:33:48 -0400
Message-ID: <20240814183348.148233-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Linus,

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 1c0e5881691a787a9399a99bff4d56ead6e75e91:

  KVM: SEV: uapi: fix typo in SEV_RET_INVALID_CONFIG (2024-08-14 13:05:42 -0400)

Another largish pull request; this time though it's more the number
of patches than the size, and there's nothing scary in it.

----------------------------------------------------------------
s390:

* Fix failure to start guests with kvm.use_gisa=0

* Panic if (un)share fails to maintain security.

ARM:

* Use kvfree() for the kvmalloc'd nested MMUs array

* Set of fixes to address warnings in W=1 builds

* Make KVM depend on assembler support for ARMv8.4

* Fix for vgic-debug interface for VMs without LPIs

* Actually check ID_AA64MMFR3_EL1.S1PIE in get-reg-list selftest

* Minor code / comment cleanups for configuring PAuth traps

* Take kvm->arch.config_lock to prevent destruction / initialization
  race for a vCPU's CPUIF which may lead to a UAF

x86:

* Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX)

* Fix smatch issues

* Small cleanups

* Make x2APIC ID 100% readonly

* Fix typo in uapi constant

Generic:

* Use synchronize_srcu_expedited() on irqfd shutdown

----------------------------------------------------------------
Amit Shah (1):
      KVM: SEV: uapi: fix typo in SEV_RET_INVALID_CONFIG

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Dan Carpenter (2):
      KVM: SVM: Fix uninitialized variable bug
      KVM: SVM: Fix an error code in sev_gmem_post_populate()

Danilo Krummrich (1):
      KVM: arm64: free kvm->arch.nested_mmus with kvfree()

Fuad Tabba (1):
      KVM: arm64: Tidying up PAuth code in KVM

Isaku Yamahata (1):
      KVM: x86: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id())

Li RongQing (1):
      KVM: eventfd: Use synchronize_srcu_expedited() on shutdown

Marc Zyngier (2):
      KVM: arm64: Enforce dependency on an ARMv8.4-aware toolchain
      KVM: arm64: vgic: Hold config_lock while tearing down a CPU interface

Mark Brown (1):
      KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list

Michael Mueller (1):
      KVM: s390: fix validity interception issue when gisa is switched off

Michal Luczaj (1):
      KVM: selftests: Add a testcase to verify x2APIC is fully readonly

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-s390-master-6.11-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

Sean Christopherson (2):
      KVM: x86: Make x2APIC ID 100% readonly
      KVM: x86: Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX)

Sebastian Ott (3):
      KVM: arm64: fix override-init warnings in W=1 builds
      KVM: arm64: fix kdoc warnings in W=1 builds
      KVM: arm64: vgic: fix unexpected unlock sparse warnings

Takahiro Itazuri (1):
      docs: KVM: Fix register ID of SPSR_FIQ

Yue Haibing (1):
      KVM: x86: hyper-v: Remove unused inline function kvm_hv_free_pa_page()

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Exit the iterator properly w/o LPI

 Documentation/virt/kvm/api.rst                     |  2 +-
 arch/arm64/include/asm/kvm_ptrauth.h               |  2 +-
 arch/arm64/kvm/Kconfig                             |  1 +
 arch/arm64/kvm/Makefile                            |  3 +++
 arch/arm64/kvm/arm.c                               | 15 ++++--------
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  1 -
 arch/arm64/kvm/hyp/nvhe/Makefile                   |  2 ++
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  5 ++--
 arch/arm64/kvm/hyp/vhe/Makefile                    |  2 ++
 arch/arm64/kvm/nested.c                            |  2 +-
 arch/arm64/kvm/vgic/vgic-debug.c                   |  5 ++--
 arch/arm64/kvm/vgic/vgic-init.c                    |  3 +--
 arch/arm64/kvm/vgic/vgic-irqfd.c                   |  7 +++---
 arch/arm64/kvm/vgic/vgic-its.c                     | 18 ++++++++------
 arch/arm64/kvm/vgic/vgic-v3.c                      |  2 +-
 arch/arm64/kvm/vgic/vgic.c                         |  2 +-
 arch/arm64/kvm/vgic/vgic.h                         |  2 +-
 arch/s390/include/asm/uv.h                         |  5 +++-
 arch/s390/kvm/kvm-s390.h                           |  7 +++++-
 arch/x86/include/asm/kvm_host.h                    |  2 ++
 arch/x86/kvm/hyperv.h                              |  1 -
 arch/x86/kvm/lapic.c                               | 22 +++++++++++------
 arch/x86/kvm/svm/sev.c                             |  7 +++---
 arch/x86/kvm/x86.c                                 |  6 ++---
 include/linux/kvm_host.h                           |  7 ++++++
 include/uapi/linux/psp-sev.h                       |  1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  4 ++--
 .../selftests/kvm/x86_64/xapic_state_test.c        | 28 ++++++++++++++++++++++
 virt/kvm/eventfd.c                                 | 13 +++++-----
 virt/kvm/kvm_main.c                                |  5 ++--
 30 files changed, 120 insertions(+), 62 deletions(-)


