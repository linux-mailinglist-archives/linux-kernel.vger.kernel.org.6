Return-Path: <linux-kernel+bounces-524355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F051BA3E246
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120DC707180
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BB213E86;
	Thu, 20 Feb 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isZx8VU3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A64213E75
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071229; cv=none; b=n3lumqyFeDPWS4H/+b1v1IF6If3xesEwhLwhoBUY67mTmjruprb2x7OXSulO3VEF3msAvFdTd4O68vrP/8NAEfMbIXSejgDOauzi4+8AAsAKEK0i+1ikgx9qTIH4gs2rZ+OrGyIvXsNlVFcYlnH0icfmZudeFx6L7nVn4+oq5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071229; c=relaxed/simple;
	bh=WjyPZsuYt/J1ZXDdahnzCeLRanspFNYQ0w02lSCEdig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwlmnSwSt7AFNbbjMkErfQR08ozbOwXkVm+4UhO2QuM1FUoqDhHiHJDg/txhXmidPHIeqIrSE+7wc7HtFSp0iyJxFw2dF39+8JH8njmrRTTa+dMvvNZ5VwNkvl7z7qx13gNgo7i8pV5LGVYarD9x8oUFX53EMMSDFsMZRWjhjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isZx8VU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw+GWEMGktTe2EG3idQ1LE3+Xb5+a50/AkTUJ8BT5dQ=;
	b=isZx8VU3lI1gX2y5Cd5HX9jUfoB5CIAVk5Z9RsofSinG0lKIkq6pJ7y2LSP/oCJ6gRxZgq
	+8Umkfya9Wz2FZiH52dYnVuQIG6EZxYWBv4ZVZLTnejV/1PBt3knYh7US7wPGMJszXoGxX
	xKeFPcr0BFNeycBv06ZCVUhX4seYbUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-2GvadszLNS-7OACkx05beA-1; Thu,
 20 Feb 2025 12:06:50 -0500
X-MC-Unique: 2GvadszLNS-7OACkx05beA-1
X-Mimecast-MFC-AGG-ID: 2GvadszLNS-7OACkx05beA_1740071209
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 056B31800872;
	Thu, 20 Feb 2025 17:06:49 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF8819412A4;
	Thu, 20 Feb 2025 17:06:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 29/30] KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level
Date: Thu, 20 Feb 2025 12:06:03 -0500
Message-ID: <20250220170604.2279312-30-pbonzini@redhat.com>
In-Reply-To: <20250220170604.2279312-1-pbonzini@redhat.com>
References: <20250220170604.2279312-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Xiaoyao Li <xiaoyao.li@intel.com>

For TDX, the maxpa (CPUID.0x80000008.EAX[7:0]) is fixed as native and
the max_gpa (CPUID.0x80000008.EAX[23:16]) is configurable and used
to configure the EPT level and GPAW.

Use max_gpa to determine the TDP level.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c   | 14 ++++++++++++++
 arch/x86/kvm/cpuid.h   |  1 +
 arch/x86/kvm/mmu/mmu.c |  9 ++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 936c5dd13bd5..7ff84079c1f4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -494,6 +494,20 @@ int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
 	return 36;
 }
 
+int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0x80000000);
+	if (!best || best->eax < 0x80000008)
+		goto not_found;
+	best = kvm_find_cpuid_entry(vcpu, 0x80000008);
+	if (best)
+		return (best->eax >> 16) & 0xff;
+not_found:
+	return 0;
+}
+
 /*
  * This "raw" version returns the reserved GPA bits without any adjustments for
  * encryption technologies that usurp bits.  The raw mask should be used if and
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 91bde94519f9..46e059b47825 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -37,6 +37,7 @@ void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
+int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu);
 u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu);
 
 static inline int cpuid_maxphyaddr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d4ac4a1f8b81..c1c54a7a7735 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5416,12 +5416,19 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 
 static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
 {
+	int maxpa;
+
+	if (vcpu->kvm->arch.vm_type == KVM_X86_TDX_VM)
+		maxpa = cpuid_query_maxguestphyaddr(vcpu);
+	else
+		maxpa = cpuid_maxphyaddr(vcpu);
+
 	/* tdp_root_level is architecture forced level, use it if nonzero */
 	if (tdp_root_level)
 		return tdp_root_level;
 
 	/* Use 5-level TDP if and only if it's useful/necessary. */
-	if (max_tdp_level == 5 && cpuid_maxphyaddr(vcpu) <= 48)
+	if (max_tdp_level == 5 && maxpa <= 48)
 		return 4;
 
 	return max_tdp_level;
-- 
2.43.5



