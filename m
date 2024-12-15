Return-Path: <linux-kernel+bounces-445489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F99F16E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D370B188C5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE0195B37;
	Fri, 13 Dec 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8t/d07N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB718FDC6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119842; cv=none; b=IptDrNAWJGEF0w1GIcSYEpG9weZh0c8K9fy5xajKXWBvB/n2ma6jvJqyVM6olaGjMM+f6PMJa5DiZvJNE+Dj6koF+EX/3uLbE2YfaGbuAR5kF9OWpLPPrssg/pKPFJCIJaEp0Y+L8BmGQm4CA7zw4rUzyCDpPOHcM22NclpMjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119842; c=relaxed/simple;
	bh=DkRV07FEYNqjcT3gDeMA06p3a2j0VKh9L00WDYGckW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3vIkw6auzSfmpJuKaL+dMP7+glGNQ7a744laIXeKnHYlC2mCuVhrjFT720GQcZmNTeYfTMVx/xWwQnVcjI1AKTcLkUV0e1cbDvdrmp4Lu09F4R7XXOUCB2XQowALKkgXyGGkRJfQARIK1yGLQ44mH8YEeRx6wU7qCjyYwxmVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8t/d07N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734119837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Vl8Og+1RleSKuFzZ3RLfiwEM4dsj0NWdmQpY187WUI=;
	b=F8t/d07NFuR5OGFj4W9+RSsJ+1OkplTVDyXov7Z4gZ792+VKFMWwfA5JynZHY64rBfVhPb
	1eAWEAZVW41/AHqawG6QPmqa1EDzsY4W95KNqVllA+b8k6qkye2LU8ZEtQzGzAVv0iUOvE
	69qtUMFDrGEpWG6LMvM30Dee9ZuRuYM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-LphSi2H_NviWXwwppujiAA-1; Fri,
 13 Dec 2024 14:57:16 -0500
X-MC-Unique: LphSi2H_NviWXwwppujiAA-1
X-Mimecast-MFC-AGG-ID: LphSi2H_NviWXwwppujiAA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBE11956046;
	Fri, 13 Dec 2024 19:57:15 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1A441955F40;
	Fri, 13 Dec 2024 19:57:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: yan.y.zhao@intel.com,
	isaku.yamahata@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 01/18] KVM: x86/mmu: Zap invalid roots with mmu_lock holding for write at uninit
Date: Fri, 13 Dec 2024 14:56:54 -0500
Message-ID: <20241213195711.316050-2-pbonzini@redhat.com>
In-Reply-To: <20241213195711.316050-1-pbonzini@redhat.com>
References: <20241213195711.316050-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Add a bool parameter to kvm_tdp_mmu_zap_invalidated_roots() to specify
zapping invalid roots under mmu_lock held for read or write. Hold mmu_lock
for write when kvm_tdp_mmu_zap_invalidated_roots() is called by
kvm_mmu_uninit_tdp_mmu().

kvm_mmu_uninit_tdp_mmu() is invoked either before or after executing any
atomic operations on SPTEs by vCPU threads. Therefore, it will not impact
vCPU threads performance if kvm_tdp_mmu_zap_invalidated_roots() acquires
mmu_lock for write to zap invalid roots.

This is a preparation for future TDX patch which asserts that "Users of
atomic zapping don't operate on mirror roots".

Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <20240718211230.1492011-2-rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c | 16 +++++++++++-----
 arch/x86/kvm/mmu/tdp_mmu.h |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 22e7ad235123..98b94905e231 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6479,7 +6479,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	 * lead to use-after-free.
 	 */
 	if (tdp_mmu_enabled)
-		kvm_tdp_mmu_zap_invalidated_roots(kvm);
+		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
 void kvm_mmu_init_vm(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4508d868f1cd..b0bddcb2f781 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -38,7 +38,7 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	 * ultimately frees all roots.
 	 */
 	kvm_tdp_mmu_invalidate_all_roots(kvm);
-	kvm_tdp_mmu_zap_invalidated_roots(kvm);
+	kvm_tdp_mmu_zap_invalidated_roots(kvm, false);
 
 	WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
@@ -883,11 +883,14 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
  * Zap all invalidated roots to ensure all SPTEs are dropped before the "fast
  * zap" completes.
  */
-void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
+void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm, bool shared)
 {
 	struct kvm_mmu_page *root;
 
-	read_lock(&kvm->mmu_lock);
+	if (shared)
+		read_lock(&kvm->mmu_lock);
+	else
+		write_lock(&kvm->mmu_lock);
 
 	for_each_tdp_mmu_root_yield_safe(kvm, root) {
 		if (!root->tdp_mmu_scheduled_root_to_zap)
@@ -905,7 +908,7 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 		 * that may be zapped, as such entries are associated with the
 		 * ASID on both VMX and SVM.
 		 */
-		tdp_mmu_zap_root(kvm, root, true);
+		tdp_mmu_zap_root(kvm, root, shared);
 
 		/*
 		 * The referenced needs to be put *after* zapping the root, as
@@ -915,7 +918,10 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 		kvm_tdp_mmu_put_root(kvm, root);
 	}
 
-	read_unlock(&kvm->mmu_lock);
+	if (shared)
+		read_unlock(&kvm->mmu_lock);
+	else
+		write_unlock(&kvm->mmu_lock);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index f03ca0dd13d9..6d7cdc462f58 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -23,7 +23,7 @@ bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool flush);
 bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp);
 void kvm_tdp_mmu_zap_all(struct kvm *kvm);
 void kvm_tdp_mmu_invalidate_all_roots(struct kvm *kvm);
-void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm);
+void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm, bool shared);
 
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 
-- 
2.43.5



