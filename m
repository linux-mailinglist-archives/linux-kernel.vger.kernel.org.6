Return-Path: <linux-kernel+bounces-248036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6592D797
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9850E1F24BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A56195980;
	Wed, 10 Jul 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TILDyx8b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBED194C79
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633241; cv=none; b=TVFFTPJiGAJnOnj/QM5ghGLLdR7dfSEGhKbEDAo5yKi1FrYZVTvKHN/W2xcxb8XEddIvDoaTrhWeq6geebrq/gjieOxGQfzIlEhM9fm1ahXNPiwbInlzYL9Jsa+j3E808j9gcMz6TiQKivPjp5LUGsz9y6RFTHtecqmpPSq70yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633241; c=relaxed/simple;
	bh=Aw27xhy9iLsWfZ7gi/oOuQuOgONYg5oqs+o6yNMv1EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvMeOnPq1UVO6+Y8sLldKsIfIFRr57c5lM3gSH8I+yRRQBzbg+DK0b4nGH1tdJDryz/9pDcX/SSTgsMR6jxAtl+iQt3l7U1zv+znSUfXytBmphUDvWahrlOGUwJLnkS9EDwAYdTNaUPRfWtu3PH11uHOXUKVK/kBdCweIxAbpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TILDyx8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720633238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQnh4CkYgF+Yl9rv3eKPxlWvS5dKXcJgjUkbAzfhZ9s=;
	b=TILDyx8b9UomzxMzXmNbTXpmFwLOQrjs1nQgs7NaeNj+2jOYuQr2rRKOItUZ61cMtAjUgq
	HEGvFdl//Oscdq06LjgGDYZfKZiXLTrwzVFJjnCqJg8jKbatG0pPopedY3C+FiiLjF1DA0
	Xu19I4EUF/btFQD56SYsl9ykWX6ouDI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-RX1JCRKrOLi-Iy3-pRIpTA-1; Wed,
 10 Jul 2024 13:40:37 -0400
X-MC-Unique: RX1JCRKrOLi-Iy3-pRIpTA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1A9319560B1;
	Wed, 10 Jul 2024 17:40:35 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 022201955F3B;
	Wed, 10 Jul 2024 17:40:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	seanjc@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH v5 3/7] KVM: x86/mmu: Bump pf_taken stat only in the "real" page fault handler
Date: Wed, 10 Jul 2024 13:40:27 -0400
Message-ID: <20240710174031.312055-4-pbonzini@redhat.com>
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

From: Sean Christopherson <seanjc@google.com>

Account stat.pf_taken in kvm_mmu_page_fault(), i.e. the actual page fault
handler, instead of conditionally bumping it in kvm_mmu_do_page_fault().
The "real" page fault handler is the only path that should ever increment
the number of taken page faults, as all other paths that "do page fault"
are by definition not handling faults that occurred in the guest.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 2 ++
 arch/x86/kvm/mmu/mmu_internal.h | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8b64f31e13be..aa437aacf55f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5925,6 +5925,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	}
 
 	if (r == RET_PF_INVALID) {
+		vcpu->stat.pf_taken++;
+
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
 					  &emulation_type);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ce2fcd19ba6b..8efd31b3856b 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -318,14 +318,6 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
 	}
 
-	/*
-	 * Async #PF "faults", a.k.a. prefetch faults, are not faults from the
-	 * guest perspective and have already been counted at the time of the
-	 * original fault.
-	 */
-	if (!prefetch)
-		vcpu->stat.pf_taken++;
-
 	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
 		r = kvm_tdp_page_fault(vcpu, &fault);
 	else
-- 
2.43.0



