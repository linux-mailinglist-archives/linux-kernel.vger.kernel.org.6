Return-Path: <linux-kernel+bounces-534815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495EAA46B75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B316B9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B103256C60;
	Wed, 26 Feb 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaCBGcsu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CC21CC66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599738; cv=none; b=qGkB0HvzErq316vPOnPZdBVeEC9tMqVCPsKA+s6qBycXz1EfXT6WwR0SzC9mtXQtVUcBx5WRcXigc4ZhOv9CuMwW6/RHwaPfle79ijgapinLVYRRX1aPn5J/lx3FtJnWt5eydPAtDCZcUSgVDt6vnqio5HkBmqrIdVy0lgYCKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599738; c=relaxed/simple;
	bh=oSfoMmn7YNQsLBKyQR4HMYMoqlMbti/WmM+6xD5GnHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=guuZGh3foRzQEesrp/R0J3hpMuXz9ns1WTKNtst03t3vnr9TTPFnvAHO9wA6qkVp57LBgKeSFoUyAtBKRIkDVbPvj+EuHgwmBjGAmbZAd+DGkkdpvvdvN79qOQSgzzJ7TPfDewEkV8yz4EzXuP7LoDhgOkoiITujkNY7oDAwSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaCBGcsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fTuFEyq9MBhk3f/4NXZp6mmbOA7+3m9VHkn192o48f4=;
	b=BaCBGcsu2AdlF1BPYSpyXsRgEz8Qmx78PMW+cIlIkuuRL+TYLYM+6zwubqRpHPgR2WD9u6
	Qi0XswmAh9JqnKbdPLg5sVQvAhS9vrbyqp22MtU0OTtM+u40w7TaK6v3lYzGdVJFVWV2Z4
	CsnNAOKCmkpiqo87tOQQ0/jkJKD9BRk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ol4O3TrCPXWs9OmshU8pIA-1; Wed,
 26 Feb 2025 14:55:32 -0500
X-MC-Unique: ol4O3TrCPXWs9OmshU8pIA-1
X-Mimecast-MFC-AGG-ID: ol4O3TrCPXWs9OmshU8pIA_1740599731
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60C511800873;
	Wed, 26 Feb 2025 19:55:31 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F8A11944D02;
	Wed, 26 Feb 2025 19:55:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 00/29] TDX MMU part 2
Date: Wed, 26 Feb 2025 14:55:00 -0500
Message-ID: <20250226195529.2314580-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Compared to v2 this one has no large changes other than the updated
SEAMCALL API.  The small ones include:
- updated SEAMCALL API
- various bugfixes from Yan
- EPT A/D bits are now required
- Disable PML for TD guests

and various conflicts with earlier parts.

Isaku Yamahata (17):
  x86/virt/tdx: Add SEAMCALL wrapper tdh_mem_sept_add() to add SEPT
    pages
  x86/virt/tdx: Add SEAMCALL wrappers to add TD private pages
  x86/virt/tdx: Add SEAMCALL wrappers to manage TDX TLB tracking
  x86/virt/tdx: Add SEAMCALL wrappers to remove a TD private page
  x86/virt/tdx: Add SEAMCALL wrappers for TD measurement of initial
    contents
  KVM: x86/tdp_mmu: Add a helper function to walk down the TDP MMU
  KVM: TDX: Add accessors VMX VMCS helpers
  KVM: TDX: Set gfn_direct_bits to shared bit
  KVM: TDX: Require TDP MMU, mmio caching and EPT A/D bits for TDX
  KVM: x86/mmu: Add setter for shadow_mmio_value
  KVM: TDX: Set per-VM shadow_mmio_value to 0
  KVM: TDX: Handle TLB tracking for TDX
  KVM: TDX: Implement hooks to propagate changes of TDP MMU mirror page
    table
  KVM: TDX: Implement hook to get max mapping level of private pages
  KVM: TDX: Add an ioctl to create initial guest memory
  KVM: TDX: Finalize VM initialization
  KVM: TDX: Handle vCPU dissociation

Paolo Bonzini (1):
  KVM: TDX: Skip updating CPU dirty logging request for TDs

Rick Edgecombe (3):
  KVM: x86/mmu: Implement memslot deletion for TDX
  KVM: VMX: Teach EPT violation helper about private mem
  KVM: x86/mmu: Export kvm_tdp_map_page()

Sean Christopherson (2):
  KVM: VMX: Split out guts of EPT violation to common/exposed function
  KVM: TDX: Add load_mmu_pgd method for TDX

Yan Zhao (6):
  KVM: x86/mmu: Do not enable page track for TD guest
  KVM: x86/mmu: Bail out kvm_tdp_map_page() when VM dead
  KVM: Add parameter "kvm" to kvm_cpu_dirty_log_size() and its callers
  KVM: x86/mmu: Add parameter "kvm" to
    kvm_mmu_page_ad_need_write_protect()
  KVM: x86: Make cpu_dirty_log_size a per-VM value
  KVM: TDX: Handle SEPT zap error due to page add error in premap

 arch/x86/include/asm/kvm_host.h |  12 +-
 arch/x86/include/asm/tdx.h      |  15 +-
 arch/x86/include/asm/vmx.h      |   1 +
 arch/x86/include/uapi/asm/kvm.h |  10 +
 arch/x86/kvm/mmu.h              |   4 +
 arch/x86/kvm/mmu/mmu.c          |  17 +-
 arch/x86/kvm/mmu/mmu_internal.h |   5 +-
 arch/x86/kvm/mmu/page_track.c   |   3 +
 arch/x86/kvm/mmu/spte.c         |  10 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  49 ++-
 arch/x86/kvm/vmx/common.h       |  43 ++
 arch/x86/kvm/vmx/main.c         | 119 ++++-
 arch/x86/kvm/vmx/tdx.c          | 745 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.h          |  93 ++++
 arch/x86/kvm/vmx/tdx_arch.h     |  23 +
 arch/x86/kvm/vmx/vmx.c          |  31 +-
 arch/x86/kvm/vmx/x86_ops.h      |  51 +++
 arch/x86/kvm/x86.c              |   6 +-
 arch/x86/virt/vmx/tdx/tdx.c     | 139 ++++++
 arch/x86/virt/vmx/tdx/tdx.h     |   8 +
 include/linux/kvm_dirty_ring.h  |  11 +-
 virt/kvm/dirty_ring.c           |  11 +-
 virt/kvm/kvm_main.c             |   5 +-
 23 files changed, 1326 insertions(+), 85 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/common.h

-- 
2.43.5


