Return-Path: <linux-kernel+bounces-425994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082F9DED84
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFE9163C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01F19924D;
	Fri, 29 Nov 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g03MGTYy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373138FAD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922333; cv=none; b=a+KHN6xXD9rlkhDxa9KmHoREaqkL5K0jbdD2QhpUYHIQJ02A0E2jTTeAGPfbLoZ325Eew3BMsap618pNd1RJn5RTYtSHtSzSEq+RFVijqaSI20E4U/T3C6KAgzUTR1WmVTeN5bObvhEI/40zB4wiNW0tLWdubpqUt+Swfyp+zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922333; c=relaxed/simple;
	bh=6goSQOe/s3OVc7KgWqBRRYDI+YPt/IyKKnh3wVVk6a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnUXPz6Lv8A1hZf7WUURGyMXhhDIHyJEGc8usvQZ7CgALCSupFUofCLF1npYd/6XFfwq6dae3Ib8fBmNfDsgdDT14Io2t41puJIaf2+m5PMsW5AUs92cqox7xSembRrFz0+K60vfmywdOR33zQjsf37XGO76mTN21myR+gzM30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g03MGTYy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732922327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CvQZD8BqiH/dggb6iGesxSTTYCQI5/E9WUH3WgYU8lg=;
	b=g03MGTYyID3wG1VrQ56a2jm720ABNWUTvXrsdzp/q06bThVjNoFnyFxh9Byxsxu7wFZLyE
	4nEcnu4kkiKYdkW2K6o2fMmSMVI6iBgi4DwvjnGxNfzu2BObqD0VWjFppE38uEF6knvGSa
	KsA4d4KCkI3thLzdAlMexd2QQvdQadY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-FutI7yt_MEejaLN9aMGbyQ-1; Fri,
 29 Nov 2024 18:18:44 -0500
X-MC-Unique: FutI7yt_MEejaLN9aMGbyQ-1
X-Mimecast-MFC-AGG-ID: FutI7yt_MEejaLN9aMGbyQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 394F91954193;
	Fri, 29 Nov 2024 23:18:43 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FE09300018D;
	Fri, 29 Nov 2024 23:18:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] Second batch of KVM changes for Linux 6.13
Date: Fri, 29 Nov 2024 18:18:41 -0500
Message-ID: <20241129231841.139239-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Linus,

The following changes since commit 8d4f1e05ff821a5d59116ab8c3a30fcae81d8597:

  RISC-V: Remove unnecessary include from compat.h (2024-11-26 11:48:53 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 4d911c7abee56771b0219a9fbf0120d06bdc9c14:

  Merge tag 'kvm-riscv-6.13-2' of https://github.com/kvm-riscv/linux into HEAD (2024-11-27 12:00:28 -0500)

----------------------------------------------------------------
ARM:

* Fixes.

RISC-V:

* Svade and Svadu (accessed and dirty bit) extension support for host and
  guest.  This was acked on the mailing list by the RISC-V maintainer, see
  https://patchew.org/linux/20240726084931.28924-1-yongxuan.wang@sifive.com/.

----------------------------------------------------------------
Marc Zyngier (5):
      KVM: arm64: vgic-v3: Sanitise guest writes to GICR_INVLPIR
      KVM: arm64: vgic: Make vgic_get_irq() more robust
      KVM: arm64: vgic: Kill VGIC_MAX_PRIVATE definition
      KVM: arm64: vgic-its: Add stronger type-checking to the ITS entry sizes
      KVM: arm64: Mark set_sysreg_masks() as inline to avoid build failure

Oliver Upton (1):
      KVM: arm64: Use MDCR_EL2.HPME to evaluate overflow of hyp counters

Paolo Bonzini (3):
      Merge tag 'kvmarm-fixes-6.13-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'riscv-for-linus-6.13-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux into HEAD
      Merge tag 'kvm-riscv-6.13-2' of https://github.com/kvm-riscv/linux into HEAD

Raghavendra Rao Ananta (1):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status

Yong-Xuan Wang (4):
      RISC-V: Add Svade and Svadu Extensions Support
      dt-bindings: riscv: Add Svade and Svadu Entries
      RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
      KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list test

 .../devicetree/bindings/riscv/extensions.yaml      | 28 ++++++++
 arch/arm64/kvm/nested.c                            |  2 +-
 arch/arm64/kvm/pmu-emul.c                          | 62 ++++++++++++-----
 arch/arm64/kvm/vgic/vgic-debug.c                   |  5 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c                     | 77 +++++++++++++++-------
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                 | 12 ++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 | 13 ++--
 arch/arm64/kvm/vgic/vgic-mmio.c                    | 38 +++++------
 arch/arm64/kvm/vgic/vgic-v2.c                      |  2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |  2 +-
 arch/arm64/kvm/vgic/vgic-v4.c                      |  4 +-
 arch/arm64/kvm/vgic/vgic.c                         | 43 +++++++-----
 arch/arm64/kvm/vgic/vgic.h                         | 27 +-------
 arch/riscv/Kconfig                                 |  1 +
 arch/riscv/include/asm/csr.h                       |  1 +
 arch/riscv/include/asm/hwcap.h                     |  2 +
 arch/riscv/include/asm/pgtable.h                   | 13 +++-
 arch/riscv/include/uapi/asm/kvm.h                  |  2 +
 arch/riscv/kernel/cpufeature.c                     | 12 ++++
 arch/riscv/kvm/vcpu.c                              |  4 ++
 arch/riscv/kvm/vcpu_onereg.c                       | 15 +++++
 include/kvm/arm_vgic.h                             |  1 -
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  8 +++
 24 files changed, 257 insertions(+), 119 deletions(-)


