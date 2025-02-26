Return-Path: <linux-kernel+bounces-534654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA0A4698C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E090172F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941526869E;
	Wed, 26 Feb 2025 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwubnUUD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E9262800
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593752; cv=none; b=AxuHRr1VBa0ebw/dOZPCtUSkJlpbLF/sG4bgNG7N0c4/Qo4XXDmNYKQbGeHRpykRv4xebEXV3W3bv8yHYo0ITML78wGa5T5FxfqAHaFTKuMkNfmEJK/3SzPVpXeYr+waqqwuyEp3Tpuo6EzpjzRs8YHdNQj5PH8lEjRo/ciOV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593752; c=relaxed/simple;
	bh=WjyPZsuYt/J1ZXDdahnzCeLRanspFNYQ0w02lSCEdig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4M/Ahvwbsq9R61t+KF2In2+dwjh8zByjFSIaIpo7mYIZOXXL5J2K0m4BnvQ1h8Nr+1/g4Q8u7gnJssxqulVX+Lxe9OKRaDS1I3Wl6SETvzP20U+g8zfuGRoUKJeDn9fyXZvxF6ymTlEM7oDO3UHrIL2BPwYxffDY3xyVclP/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwubnUUD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740593748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw+GWEMGktTe2EG3idQ1LE3+Xb5+a50/AkTUJ8BT5dQ=;
	b=HwubnUUDA8PJ6kOCodJZ26uwKDynXZ0L5Yv54cyowhJZTQJkdy5mzKoQHY3nGudRS2vTQf
	dkGaCLyMvYiBSPyXYQuUZvHkokOom0KPodA8QhjROV2mzHs3uhEx0Akjhzchw5JI95s1Kh
	CzjCJcuPR6N75MYL6R3QykSP37GPA1c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-GRceG_3LNhCqIztny9IIbw-1; Wed,
 26 Feb 2025 13:15:43 -0500
X-MC-Unique: GRceG_3LNhCqIztny9IIbw-1
X-Mimecast-MFC-AGG-ID: GRceG_3LNhCqIztny9IIbw_1740593742
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70CBA193585F;
	Wed, 26 Feb 2025 18:15:42 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7929B1800352;
	Wed, 26 Feb 2025 18:15:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 32/33] KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level
Date: Wed, 26 Feb 2025 13:14:51 -0500
Message-ID: <20250226181453.2311849-33-pbonzini@redhat.com>
In-Reply-To: <20250226181453.2311849-1-pbonzini@redhat.com>
References: <20250226181453.2311849-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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



