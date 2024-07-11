Return-Path: <linux-kernel+bounces-249942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF192F1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C11D1C22967
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5193D1A3BD1;
	Thu, 11 Jul 2024 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njy6i+2J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12ED1A2C13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736889; cv=none; b=cT96pLKBS8IaS4qcBgdEvAxdacI3hT1CwRYRU/mniJvkak3Yiw03xs1opJLOEcDBVOnkOTYxtFRjug2soMCVPYbMidj9p2MjGxm6fENzbrjrm/hUuWpVyNhXi/W2K6sIcP6Qa2GCYLZIzkScwgVzwX5WgAvrpRbtpHKQwBYBamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736889; c=relaxed/simple;
	bh=+4BkaniAqpfzC0qGYjpuSJW8g5yc40Mynb16Kpmc+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl1QCvh4mNND+31odc8iS8P0VhHbCHhEgvQU0QWNfw8sXjn18v2SwG8BfVGAcq60oyG0lH2YM6DkAoLL6ObD01HCJ67upp0hBzHx7dypofT1xjE2tOXmFVgb2PxgnSkz2ou+BTgOuACKtFfASioX0KWFHfvQhypBDURZfZKAXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Njy6i+2J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720736887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ8PFk8IkSEb2wUJxnz3ahSOOTMj/+fWZ6HPcwrgFLQ=;
	b=Njy6i+2JoBeP+9SjbKbaISD7x9Fy3SpUCOU4KgPxN42iBNPsVKL+8mmVdb7+VpFAkV8VMf
	/34+3GZu283X84TLBaxu3wMLJh6D3utAwT0TFwDeOr73sPDkRMMp15wO3LfypzvAPqfSEe
	ofSN4lJ0SroTLGnIJlI3UKV/6zjRdBY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-Uf8_FIPxNs-tNonAAHTBGQ-1; Thu,
 11 Jul 2024 18:28:04 -0400
X-MC-Unique: Uf8_FIPxNs-tNonAAHTBGQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 193631956095;
	Thu, 11 Jul 2024 22:28:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 325111956046;
	Thu, 11 Jul 2024 22:28:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH 08/12] KVM: remove kvm_arch_gmem_prepare_needed()
Date: Thu, 11 Jul 2024 18:27:51 -0400
Message-ID: <20240711222755.57476-9-pbonzini@redhat.com>
In-Reply-To: <20240711222755.57476-1-pbonzini@redhat.com>
References: <20240711222755.57476-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

It is enough to return 0 if a guest need not do any preparation.
This is in fact how sev_gmem_prepare() works for non-SNP guests,
and it extends naturally to Intel hosts: the x86 callback for
gmem_prepare is optional and returns 0 if not defined.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c       |  5 -----
 include/linux/kvm_host.h |  1 -
 virt/kvm/guest_memfd.c   | 13 +++----------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c85591f92c..4f58423c6148 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13604,11 +13604,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-bool kvm_arch_gmem_prepare_needed(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_SNP_VM;
-}
-
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
 {
 	return static_call(kvm_x86_gmem_prepare)(kvm, pfn, gfn, max_order);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index eb8404e9aa03..f6e11991442d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2443,7 +2443,6 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
-bool kvm_arch_gmem_prepare_needed(struct kvm *kvm);
 #endif
 
 /**
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f4d82719ec19..509360eefea5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -29,16 +29,9 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 				    pgoff_t index, struct folio *folio)
 {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	kvm_pfn_t pfn;
-	gfn_t gfn;
-	int rc;
-
-	if (!kvm_arch_gmem_prepare_needed(kvm))
-		return 0;
-
-	pfn = folio_file_pfn(folio, index);
-	gfn = slot->base_gfn + index - slot->gmem.pgoff;
-	rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
+	kvm_pfn_t pfn = folio_file_pfn(folio, index);
+	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
+	int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
 	if (rc) {
 		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
 				    index, gfn, pfn, rc);
-- 
2.43.0



