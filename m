Return-Path: <linux-kernel+bounces-248042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62B92D7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE5B28B31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4192198E61;
	Wed, 10 Jul 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsArV9+E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6619885B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633248; cv=none; b=fy5LJ0XSZ4bfcinqMsxVaMZ5OHrWxfx2xROZP21OLc0pMxuXPP+Teb38vTynjqBPQG1AWrcmY2qbG10WtMvKU6tp6yD94sjWKRMiHapfUPIjJPaAWyvTe8S5X4CVReq1MeCSIWP7tDgCte6sCtCNtrotKfSMLFwA6yDdpvuuxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633248; c=relaxed/simple;
	bh=g0IMoE8SvUpIehtm5fxYZhYMIPJrDsiObiBl1Lq/ZYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZQArMczRFa5BLC9E4G8Og+kmoFuYcyDIolNJH1nNxw9O3x6tS1FrqPwLOuMERHsvT68sGVRxrlMYOl7Uz5aAFlFT36rpUepyqmPMLoImgdv/PR+U2GhUFLsO+G5bicXHyKj3iChrRXTDLjqdElA3ULH85N7hTDjMWVuQK8sQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsArV9+E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720633245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypl1rWILZoP1XkNrIA66WS0UNhxa95PHxGXctc+eNm8=;
	b=MsArV9+E1Re9BYOubVwiIpOkv/rKwzIQTAKm4YZ+U0udPeNDlKeF1BE2hH4b6KccSSV+E3
	pfZ8GnMdtgDfxggSzD5uqrEefYZlLmWFn5fmnzYSbxXERBBXLv9DhpLpKZOGPjtYiWtJQH
	z0yV9qm1GVqFTAdiUeR9Po54tuVX//0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-yl9iBuRxM0auRUiLK4YGfg-1; Wed,
 10 Jul 2024 13:40:38 -0400
X-MC-Unique: yl9iBuRxM0auRUiLK4YGfg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FC7C1955BC5;
	Wed, 10 Jul 2024 17:40:37 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFC201955BD4;
	Wed, 10 Jul 2024 17:40:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	seanjc@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH v5 5/7] KVM: x86/mmu: Make kvm_mmu_do_page_fault() return mapped level
Date: Wed, 10 Jul 2024 13:40:29 -0400
Message-ID: <20240710174031.312055-6-pbonzini@redhat.com>
In-Reply-To: <20240710174031.312055-1-pbonzini@redhat.com>
References: <20240710174031.312055-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The guest memory population logic will need to know what page size or level
(4K, 2M, ...) is mapped.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Message-ID: <eabc3f3e5eb03b370cadf6e1901ea34d7a020adc.1712785629.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 4 ++--
 arch/x86/kvm/mmu/mmu_internal.h | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8c2c5c0afba1..152b30fa22ad 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4292,7 +4292,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
-				  true, NULL);
+				  true, NULL, NULL);
 
 	/*
 	 * Account fixed page faults, otherwise they'll never be counted, but
@@ -5937,7 +5937,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		vcpu->stat.pf_taken++;
 
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
-					  &emulation_type);
+					  &emulation_type, NULL);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
 	}
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 444f55a5eed7..1721d97743e9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -288,7 +288,8 @@ static inline void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 }
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-					u64 err, bool prefetch, int *emulation_type)
+					u64 err, bool prefetch,
+					int *emulation_type, u8 *level)
 {
 	struct kvm_page_fault fault = {
 		.addr = cr2_or_gpa,
@@ -336,6 +337,8 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 	if (fault.write_fault_to_shadow_pgtable && emulation_type)
 		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
+	if (level)
+		*level = fault.goal_level;
 
 	return r;
 }
-- 
2.43.0



