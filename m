Return-Path: <linux-kernel+bounces-539836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11DA4A997
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A8A17550E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319231CD215;
	Sat,  1 Mar 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caMhHIwI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E911C4A24
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740815873; cv=none; b=N1Q7ghZTx9H4508UEk7ifqgbc9eVaI2yxmsTWLzQxk6/3cmb9qovFhAob7FRT4nQm2SXg4R3fOnzwLFhuoxOXZFySogFxZ4rqDbZYuARrxIyWy/zmKSw96FNrYgr6LN+RdfI+5PaPttSBN22U8nGUdX09H+qOuf2D404QGAJd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740815873; c=relaxed/simple;
	bh=6QUcifrKhzUKgXPcxaZK3/0bvh4sxZHVVHWo3IB+PGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWzm1JP5yJhNeahz/ejdpPhnViiXuhiNJuR+xilX8fMOO1CijwFUVdMiTIAryM/a/lLTXaQDtnkDWkRPjcfGI65UEFCOKBv5DXk++qMyMY8Qsxdf0z6wfdGaaJUFa5b8uczQAl/P0gyynPGAgTUA5EtsKpzzIW8Dab4Jy2w1hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caMhHIwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740815870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f8IcxfwIe3Oc9yKSSo05CvmrpOyTrW66IHpbwozDSMA=;
	b=caMhHIwI1Jvn6w7y1pIfVE4AgdX0PxKolf5VxS0nvM+nrSsMzPcbRsKpk1D1mF9V1axCFV
	YOc4v53pEwm1cwFkw8hHtrUKIkByBHiJQ/mZiP10Dh0afLZUdY8VhUeF8YMuCJrvc5jLHl
	b1fvV2g+AZPMvOxKjxNUPJDvoWGioG4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-2hnLaSK4OMqWWssQWn5FkA-1; Sat,
 01 Mar 2025 02:57:34 -0500
X-MC-Unique: 2hnLaSK4OMqWWssQWn5FkA-1
X-Mimecast-MFC-AGG-ID: 2hnLaSK4OMqWWssQWn5FkA_1740815853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780111954B20;
	Sat,  1 Mar 2025 07:57:33 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9A701800371;
	Sat,  1 Mar 2025 07:57:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.14-rc5
Date: Sat,  1 Mar 2025 02:57:32 -0500
Message-ID: <20250301075732.2438425-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Linus,

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 916b7f42b3b3b539a71c204a9b49fdc4ca92cd82:

  kvm: retry nx_huge_page_recovery_thread creation (2025-03-01 02:54:18 -0500)

----------------------------------------------------------------
ARM:

* Fix TCR_EL2 configuration to not use the ASID in TTBR1_EL2
  and not mess-up T1SZ/PS by using the HCR_EL2.E2H==0 layout.

* Bring back the VMID allocation to the vcpu_load phase, ensuring
  that we only setup VTTBR_EL2 once on VHE. This cures an ugly
  race that would lead to running with an unallocated VMID.

RISC-V:

* Fix hart status check in SBI HSM extension

* Fix hart suspend_type usage in SBI HSM extension

* Fix error returned by SBI IPI and TIME extensions for
  unsupported function IDs

* Fix suspend_type usage in SBI SUSP extension

* Remove unnecessary vcpu kick after injecting interrupt
  via IMSIC guest file

x86:

* Fix an nVMX bug where KVM fails to detect that, after nested
  VM-Exit, L1 has a pending IRQ (or NMI).

* To avoid freeing the PIC while vCPUs are still around, which
  would cause a NULL pointer access with the previous patch,
  destroy vCPUs before any VM-level destruction.

* Handle failures to create vhost_tasks

----------------------------------------------------------------
Andrew Jones (5):
      riscv: KVM: Fix hart suspend status check
      riscv: KVM: Fix hart suspend_type use
      riscv: KVM: Fix SBI IPI error generation
      riscv: KVM: Fix SBI TIME error generation
      riscv: KVM: Fix SBI sleep_type use

BillXiang (1):
      riscv: KVM: Remove unnecessary vcpu kick

Keith Busch (2):
      vhost: return task creation error instead of NULL
      kvm: retry nx_huge_page_recovery_thread creation

Oliver Upton (1):
      KVM: arm64: Ensure a VMID is allocated before programming VTTBR_EL2

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-6.14-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-riscv-fixes-6.14-1' of https://github.com/kvm-riscv/linux into HEAD

Sean Christopherson (2):
      KVM: x86: Free vCPUs before freeing VM state
      KVM: nVMX: Process events on nested VM-Exit if injectable IRQ or NMI is pending

Will Deacon (1):
      KVM: arm64: Fix tcr_el2 initialisation in hVHE mode

 arch/arm64/include/asm/kvm_arm.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              | 37 ++++++++++++++++-----------------
 arch/arm64/kvm/vmid.c             | 11 +++-------
 arch/riscv/kvm/aia_imsic.c        |  1 -
 arch/riscv/kvm/vcpu_sbi_hsm.c     | 11 +++++-----
 arch/riscv/kvm/vcpu_sbi_replace.c | 15 +++++++++++---
 arch/riscv/kvm/vcpu_sbi_system.c  |  3 ++-
 arch/x86/kvm/mmu/mmu.c            | 12 +++++------
 arch/x86/kvm/vmx/nested.c         | 11 ++++++++++
 arch/x86/kvm/x86.c                |  2 +-
 drivers/vhost/vhost.c             |  2 +-
 include/linux/call_once.h         | 43 +++++++++++++++++++++++++++++----------
 kernel/vhost_task.c               |  4 ++--
 14 files changed, 94 insertions(+), 62 deletions(-)


