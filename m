Return-Path: <linux-kernel+bounces-171742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABD8BE809
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D00B271C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CD16C692;
	Tue,  7 May 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6GYWB8h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F3168AE8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097503; cv=none; b=r5Cz/VkviahH5axjZg0lmD3ECF7aVvHpjrIKEaseCjNj7rGr/m51cJdQxusSVu1gyIuHTh5bBe/98JHeDbH8uFwHI4a3BKK/OTZTQizHkbR3ig1u+m/4APlLUDcXkE1E0B8QKJQ+mOLxvFCLax0tZ1T5QEly/X//TiTVBH5FT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097503; c=relaxed/simple;
	bh=YVVYTXttJ4LkCC584GInQE8V0YjGwyUoQqfsU6EilkQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwV9jHpyO4bMDkzOXSarimdejkhal1R/Nj9+uSWFQkYV5toyz+DHVWmP6FxqawSNtUKOwE3/viA5Zbgs+DtQ5vYBWgDtlVCJPbB7IfxdluNrLqbOQKQpWOLJdB2yd2Prx5G3nKphjOtf9YyW0pz8wjpQ/ks7kJ+6vqZfi/lz6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6GYWB8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52eBoQ222XsSSPXCV6rIxS2omD7NQFg6WZmtpTUgzVs=;
	b=R6GYWB8hM40W5HusOJ6FMhDQJ+SV10O+V+claOe+NZgW1ZDrw5/nb0AVAbuDJCihkqqa3N
	m90jR3yJiN0ABJ0OpkuySk2zuVlrJRYYXQKtfdpH8s7L+b2Ei8IS4OYXVrQ8iJy6ApaKYa
	lzRUtIWdXCT3QtkLjNqM5dioApzOvFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-DQt2rFq4N0O60xCcg4yU4w-1; Tue, 07 May 2024 11:58:19 -0400
X-MC-Unique: DQt2rFq4N0O60xCcg4yU4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 547C81816EC3;
	Tue,  7 May 2024 15:58:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D989200C7E5;
	Tue,  7 May 2024 15:58:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 08/17] KVM: x86/mmu: check for invalid async page faults involving private memory
Date: Tue,  7 May 2024 11:58:08 -0400
Message-ID: <20240507155817.3951344-9-pbonzini@redhat.com>
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

Right now the error code is not used when an async page fault is completed.
This is not a problem in the current code, but it is untidy.  For protected
VMs, we will also need to check that the page attributes match the current
state of the page, because asynchronous page faults can only occur on
shared pages (private pages go through kvm_faultin_pfn_private() instead of
__gfn_to_pfn_memslot()).

Start by piping the error code from kvm_arch_setup_async_pf() to
kvm_arch_async_page_ready() via the architecture-specific async page
fault data.  For now, it can be used to assert that there are no
async page faults on private memory.

Extracted from a patch by Isaku Yamahata.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0dc755a6dc0c..9d6368512be6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1851,6 +1851,7 @@ struct kvm_arch_async_pf {
 	gfn_t gfn;
 	unsigned long cr3;
 	bool direct_map;
+	u64 error_code;
 };
 
 extern u32 __read_mostly kvm_nr_uret_msrs;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index eb041acec2dc..d52794663290 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4207,24 +4207,28 @@ static u32 alloc_apf_token(struct kvm_vcpu *vcpu)
 	return (vcpu->arch.apf.id++ << 12) | vcpu->vcpu_id;
 }
 
-static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-				    gfn_t gfn)
+static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
+				    struct kvm_page_fault *fault)
 {
 	struct kvm_arch_async_pf arch;
 
 	arch.token = alloc_apf_token(vcpu);
-	arch.gfn = gfn;
+	arch.gfn = fault->gfn;
+	arch.error_code = fault->error_code;
 	arch.direct_map = vcpu->arch.mmu->root_role.direct;
 	arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
 
-	return kvm_setup_async_pf(vcpu, cr2_or_gpa,
-				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
+	return kvm_setup_async_pf(vcpu, fault->addr,
+				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
 }
 
 void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 {
 	int r;
 
+	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
+		return;
+
 	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
 	      work->wakeup_all)
 		return;
@@ -4237,7 +4241,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
-	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true, NULL);
+	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code, true, NULL);
 }
 
 static inline u8 kvm_max_level_for_order(int order)
@@ -4334,7 +4338,7 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			trace_kvm_async_pf_repeated_fault(fault->addr, fault->gfn);
 			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
 			return RET_PF_RETRY;
-		} else if (kvm_arch_setup_async_pf(vcpu, fault->addr, fault->gfn)) {
+		} else if (kvm_arch_setup_async_pf(vcpu, fault)) {
 			return RET_PF_RETRY;
 		}
 	}
-- 
2.43.0



