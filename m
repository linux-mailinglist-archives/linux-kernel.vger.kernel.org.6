Return-Path: <linux-kernel+bounces-524325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BADA3E1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB743AF016
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B651211A0B;
	Thu, 20 Feb 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrNLXzVL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409B1C5F26
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071173; cv=none; b=uCX6tNoJPCSe4B/mvlfA5TAYeAj3sopNHNyhScjMKHW7D58JP/1Wn92lPDXRUQUybHqR10IZZp1SPvGvBq7/i0Mf8AY5Cv6VUzgN+MG1n1eZhvSndquyYOAz+bC1VwtEjWB3RhkiwUBu2SxhLgknxdP+Q8XhN+s3WiGnoNbHzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071173; c=relaxed/simple;
	bh=BWN9cyZKQ3PuOolG7pMQeWAj/m7OAzrTZ/EiEHKgU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvhM8IpuQr3f7/zwbzJnP76CIw0pVNP0jJBr4yfINr0tTrQlrne0hAsgu/SpkyJPw3DVzCwkdb2iMe5kqN8l+fMHReE0tsdwCiynCQG8uHi1xWPsDsqpCxOQ84oj73MSDGFUaFV+YqVbah9e7oCWEqEbA2NeQadQYjHGlwkj5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrNLXzVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OkuBsNmajF7xmkbGbP6a3hmiQXvsDO3/DDO+iLBkBBw=;
	b=XrNLXzVLvdyRFa26bRCqqBshJJAjZ/OTCJXU6h4W7qj0K42uC3JlnKDsRzsfDj4DiX5yJl
	GvgB2tdwapeXb3CA8BvNCmtbgC/vkCBm5eRrrfve2Rs+oN2y8/iWX9JT21ZGLfEaNAS1R4
	VzVpV4rpnn+GHcP2EhQgQ37NFoWNCp4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-gy9e3VDbNM2cUrAd6vWeRw-1; Thu,
 20 Feb 2025 12:06:07 -0500
X-MC-Unique: gy9e3VDbNM2cUrAd6vWeRw-1
X-Mimecast-MFC-AGG-ID: gy9e3VDbNM2cUrAd6vWeRw_1740071166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B621903092;
	Thu, 20 Feb 2025 17:06:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46AA51800359;
	Thu, 20 Feb 2025 17:06:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 00/30] TDX initialization + vCPU/VM creation
Date: Thu, 20 Feb 2025 12:05:34 -0500
Message-ID: <20250220170604.2279312-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

Here is v3 of TDX VM/vCPU creation series, which Rick and others from
Intel have handed off to me.

The only remaining snag could be the retry loop around some SEAMCALLS.
It's likely that it can be dropped but I have left it in place for now,
waiting for Yan's patient advice. :)

I dropped support for CET/PT in trusted domains, as well as for TDX
modules without MD_FIELD_ID_FEATURES0_TOPOLOGY_ENUM.  I have also added
to the end a patch that I scavenged from the Intel tree to add support
for the misc cgroup.

All non-KVM patches have been acked, except for 07/29  ("x86/virt/tdx:
allocate tdx_sys_info in static memory").

This series is based straight off of Linux 6.14-rc3.  It requires TDX
module 1.5.06 or later.

Paolo

Isaku Yamahata (13):
  x86/virt/tdx: Add tdx_guest_keyid_alloc/free() to alloc and free TDX
    guest KeyID
  KVM: TDX: Add placeholders for TDX VM/vCPU structures
  KVM: TDX: Define TDX architectural definitions
  KVM: TDX: Add helper functions to print TDX SEAMCALL error
  KVM: TDX: Add place holder for TDX VM specific mem_enc_op ioctl
  KVM: TDX: Get system-wide info about TDX module on initialization
  KVM: TDX: create/destroy VM structure
  KVM: TDX: Support per-VM KVM_CAP_MAX_VCPUS extension check
  KVM: TDX: initialize VM with TDX specific parameters
  KVM: TDX: Make pmu_intel.c ignore guest TD case
  KVM: TDX: Don't offline the last cpu of one package when there's TDX
    guest
  KVM: TDX: create/free TDX vcpu structure
  KVM: TDX: Do TDX specific vcpu initialization

Kai Huang (5):
  x86/virt/tdx: Read essential global metadata for KVM
  KVM: Export hardware virtualization enabling/disabling functions
  KVM: VMX: Refactor VMX module init/exit functions
  KVM: VMX: Initialize TDX during KVM module load
  KVM: TDX: Get TDX global information

Paolo Bonzini (2):
  x86/virt/tdx: allocate tdx_sys_info in static memory
  KVM: x86: expose cpuid_entry2_find for TDX

Rick Edgecombe (6):
  x86/virt/tdx: Add SEAMCALL wrappers for TDX KeyID management
  x86/virt/tdx: Add SEAMCALL wrappers for TDX TD creation
  x86/virt/tdx: Add SEAMCALL wrappers for TDX vCPU creation
  x86/virt/tdx: Add SEAMCALL wrappers for TDX page cache management
  x86/virt/tdx: Add SEAMCALL wrappers for TDX VM/vCPU field access
  x86/virt/tdx: Add SEAMCALL wrappers for TDX flush operations

Sean Christopherson (1):
  KVM: TDX: Add TDX "architectural" error codes

Xiaoyao Li (2):
  KVM: x86: Introduce KVM_TDX_GET_CPUID
  KVM: x86/mmu: Taking guest pa into consideration when calculate tdp
    level

Zhiming Hu (1):
  KVM: TDX: Register TDX host key IDs to cgroup misc controller

 arch/x86/include/asm/kvm-x86-ops.h            |    4 +-
 arch/x86/include/asm/kvm_host.h               |    2 +
 arch/x86/include/asm/shared/tdx.h             |    7 +-
 arch/x86/include/asm/tdx.h                    |   59 +
 .../tdx => include/asm}/tdx_global_metadata.h |   19 +
 arch/x86/include/uapi/asm/kvm.h               |   60 +
 arch/x86/kvm/Kconfig                          |   12 +
 arch/x86/kvm/Makefile                         |    1 +
 arch/x86/kvm/cpuid.c                          |   33 +-
 arch/x86/kvm/cpuid.h                          |    3 +
 arch/x86/kvm/lapic.c                          |    1 +
 arch/x86/kvm/mmu/mmu.c                        |    9 +-
 arch/x86/kvm/vmx/main.c                       |  180 +-
 arch/x86/kvm/vmx/pmu_intel.c                  |   52 +-
 arch/x86/kvm/vmx/pmu_intel.h                  |   28 +
 arch/x86/kvm/vmx/tdx.c                        | 1557 +++++++++++++++++
 arch/x86/kvm/vmx/tdx.h                        |   90 +
 arch/x86/kvm/vmx/tdx_arch.h                   |  130 ++
 arch/x86/kvm/vmx/tdx_errno.h                  |   37 +
 arch/x86/kvm/vmx/vmx.c                        |   25 +-
 arch/x86/kvm/vmx/vmx.h                        |   37 +-
 arch/x86/kvm/vmx/x86_ops.h                    |   24 +
 arch/x86/kvm/x86.c                            |   14 +-
 arch/x86/virt/vmx/tdx/tdx.c                   |  276 ++-
 arch/x86/virt/vmx/tdx/tdx.h                   |   39 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |   50 +
 include/linux/kvm_host.h                      |    9 +
 include/linux/misc_cgroup.h                   |    4 +
 kernel/cgroup/misc.c                          |    4 +
 virt/kvm/kvm_main.c                           |   21 +-
 30 files changed, 2681 insertions(+), 106 deletions(-)
 rename arch/x86/{virt/vmx/tdx => include/asm}/tdx_global_metadata.h (58%)
 create mode 100644 arch/x86/kvm/vmx/pmu_intel.h
 create mode 100644 arch/x86/kvm/vmx/tdx.c
 create mode 100644 arch/x86/kvm/vmx/tdx.h
 create mode 100644 arch/x86/kvm/vmx/tdx_arch.h
 create mode 100644 arch/x86/kvm/vmx/tdx_errno.h

-- 
2.43.5


