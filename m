Return-Path: <linux-kernel+bounces-171748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CA8BE81D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657F9288F22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504C16E870;
	Tue,  7 May 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V28GPXXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA8168AFD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097505; cv=none; b=gJ8qcZxbEnjEtK7hHlxR/dOIXxYmoBZCCG2uMYxK+3XlE/vFG1yKzVcGKHjXVQ5j1s9TA1j+WZl6ChkcUPFk5rwg5DfBw+8Q6qmROTBcIMsec5124PUJch6z7OSlFubBWy1y6kRMZvlTSeCE8voa0prw9/bO/tCVuUZlkR8J38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097505; c=relaxed/simple;
	bh=hdJ9aJOg483E4Swl6JUZaT0gB+ec59WGRD45jfApTck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5vbiMmuLIBGpQFjvPaY4wb8H37xXHjSxFzTS+nIrFrzGWSWahrQY6GIHwpuNMCRPUiFavkowR81Cwy4/Mi3o6oSZnP93XD1pNrtmF1rbEO2qMUgNB0w+r6dZsUFzaGyRDGKWtyIxhpGg89Sg1WvcHZo+1dLmMZ4cdEmt59Ggdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V28GPXXe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEi6J0wAbZoZwLHM7rRoVyozmEAotDh+TugUPX8/Nhs=;
	b=V28GPXXeYwirOpCtLd+uv6Ex0LBhXuTvU0RYWC/05Gk4cnEQJXgqAJrB2HJaLVNYTD/KVO
	sTQ9EEs0EBKDdgJyzH4dWcMOxDVozgiOn1BoHnJkwya7cTouClxiXFxRPGlc1Uje+baH0Z
	bGxTTgyQY8vsydHUiCWsUzB27FRdcmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-vozxvGVJPOKufatsk_tYOA-1; Tue, 07 May 2024 11:58:18 -0400
X-MC-Unique: vozxvGVJPOKufatsk_tYOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54415101A525;
	Tue,  7 May 2024 15:58:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 382A9200C7E6;
	Tue,  7 May 2024 15:58:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 02/17] KVM: x86: Remove separate "bit" defines for page fault error code masks
Date: Tue,  7 May 2024 11:58:02 -0400
Message-ID: <20240507155817.3951344-3-pbonzini@redhat.com>
In-Reply-To: <20240507155817.3951344-1-pbonzini@redhat.com>
References: <20240507155817.3951344-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Sean Christopherson <seanjc@google.com>

Open code the bit number directly in the PFERR_* masks and drop the
intermediate PFERR_*_BIT defines, as having to bounce through two macros
just to see which flag corresponds to which bit is quite annoying, as is
having to define two macros just to add recognition of a new flag.

Use ternary operator to derive the bit in permission_fault(), the one
function that actually needs the bit number as part of clever shifting
to avoid conditional branches.  Generally the compiler is able to turn
it into a conditional move, and if not it's not really a big deal.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240228024147.41573-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 32 ++++++++++----------------------
 arch/x86/kvm/mmu.h              |  5 ++---
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9f92bdb78504..a047480da5af 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -254,28 +254,16 @@ enum x86_intercept_stage;
 	KVM_GUESTDBG_INJECT_DB | \
 	KVM_GUESTDBG_BLOCKIRQ)
 
-
-#define PFERR_PRESENT_BIT 0
-#define PFERR_WRITE_BIT 1
-#define PFERR_USER_BIT 2
-#define PFERR_RSVD_BIT 3
-#define PFERR_FETCH_BIT 4
-#define PFERR_PK_BIT 5
-#define PFERR_SGX_BIT 15
-#define PFERR_GUEST_FINAL_BIT 32
-#define PFERR_GUEST_PAGE_BIT 33
-#define PFERR_IMPLICIT_ACCESS_BIT 48
-
-#define PFERR_PRESENT_MASK	BIT(PFERR_PRESENT_BIT)
-#define PFERR_WRITE_MASK	BIT(PFERR_WRITE_BIT)
-#define PFERR_USER_MASK		BIT(PFERR_USER_BIT)
-#define PFERR_RSVD_MASK		BIT(PFERR_RSVD_BIT)
-#define PFERR_FETCH_MASK	BIT(PFERR_FETCH_BIT)
-#define PFERR_PK_MASK		BIT(PFERR_PK_BIT)
-#define PFERR_SGX_MASK		BIT(PFERR_SGX_BIT)
-#define PFERR_GUEST_FINAL_MASK	BIT_ULL(PFERR_GUEST_FINAL_BIT)
-#define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
-#define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
+#define PFERR_PRESENT_MASK	BIT(0)
+#define PFERR_WRITE_MASK	BIT(1)
+#define PFERR_USER_MASK		BIT(2)
+#define PFERR_RSVD_MASK		BIT(3)
+#define PFERR_FETCH_MASK	BIT(4)
+#define PFERR_PK_MASK		BIT(5)
+#define PFERR_SGX_MASK		BIT(15)
+#define PFERR_GUEST_FINAL_MASK	BIT_ULL(32)
+#define PFERR_GUEST_PAGE_MASK	BIT_ULL(33)
+#define PFERR_IMPLICIT_ACCESS	BIT_ULL(48)
 
 #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
 				 PFERR_WRITE_MASK |		\
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 60f21bb4c27b..2343c9f00e31 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -213,7 +213,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	 */
 	u64 implicit_access = access & PFERR_IMPLICIT_ACCESS;
 	bool not_smap = ((rflags & X86_EFLAGS_AC) | implicit_access) == X86_EFLAGS_AC;
-	int index = (pfec + (not_smap << PFERR_RSVD_BIT)) >> 1;
+	int index = (pfec | (not_smap ? PFERR_RSVD_MASK : 0)) >> 1;
 	u32 errcode = PFERR_PRESENT_MASK;
 	bool fault;
 
@@ -234,8 +234,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		pkru_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
 
 		/* clear present bit, replace PFEC.RSVD with ACC_USER_MASK. */
-		offset = (pfec & ~1) +
-			((pte_access & PT_USER_MASK) << (PFERR_RSVD_BIT - PT_USER_SHIFT));
+		offset = (pfec & ~1) | ((pte_access & PT_USER_MASK) ? PFERR_RSVD_MASK : 0);
 
 		pkru_bits &= mmu->pkru_mask >> offset;
 		errcode |= -pkru_bits & PFERR_PK_MASK;
-- 
2.43.0



