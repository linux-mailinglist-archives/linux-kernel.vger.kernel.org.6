Return-Path: <linux-kernel+bounces-263654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C093D8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30029288976
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7B155CA0;
	Fri, 26 Jul 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdN8nWrt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E6152191
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019936; cv=none; b=HSPpj0WnDL/ABRK1wU1uAkQlO567u1DuQP5j9skbzpW+6xPIPA3utMUUv9mkt13I/rKSa0p0+Vg1+mEP7Q7Ls7tuaCtcIMjfxn7kHOHJPt4I/fCZX5OZiuqZLM1mC8pH++cr6yf+Y6xQlUifJ2bkr6GLrObYliJssamETUiCywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019936; c=relaxed/simple;
	bh=0tDBMlV6BdjGUPxLFTdrrnlW+DpzyxiofMfQEx9GPg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lELTwZGKyWAYODO0kcv9yX4BWpPsmTyg8pfsR3rvkyq+5bDkwRzSy6jIOP/IbFUMQluTyjAtuFl1tUHmTLv6N1EJF6+XhFRkKv/mlttj6a7RU04uJQ4ydXa3JYYKtCSU5pV5DhU1r5wAc5inhCKM1vHqd56h7jhRuBWODqPM4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdN8nWrt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHgc0hOcAsIllXWaInTCIOPyM0B3/9AXgNDCDrvkVDw=;
	b=DdN8nWrtI6LzGZhDmwy165um/0lEeCD7px20Ly9q/3uYnVLJMf6z25zxD0M5fxENPep/oI
	CuSbxxQR2xvr+pWHDEJdImqaASfEzuDU8Bt1+AIOZ9ZuBrcV7DW744sXcZ5DVsVjXZh1el
	mlJcaLbO65IEfQ/xcYY5j+u9M3rd47A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-zBbzQOFNNeukgDUPMXIWMw-1; Fri,
 26 Jul 2024 14:52:11 -0400
X-MC-Unique: zBbzQOFNNeukgDUPMXIWMw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 524BC1955D55;
	Fri, 26 Jul 2024 18:52:10 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A015E1955D45;
	Fri, 26 Jul 2024 18:52:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 13/14] KVM: guest_memfd: let kvm_gmem_populate() operate only on private gfns
Date: Fri, 26 Jul 2024 14:51:56 -0400
Message-ID: <20240726185157.72821-14-pbonzini@redhat.com>
In-Reply-To: <20240726185157.72821-1-pbonzini@redhat.com>
References: <20240726185157.72821-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This check is currently performed by sev_gmem_post_populate(), but it
applies to all callers of kvm_gmem_populate(): the point of the function
is that the memory is being encrypted and some work has to be done
on all the gfns in order to encrypt them.

Therefore, check the KVM_MEMORY_ATTRIBUTE_PRIVATE attribute prior
to invoking the callback, and stop the operation if a shared page
is encountered.  Because CONFIG_KVM_PRIVATE_MEM in principle does
not require attributes, this makes kvm_gmem_populate() depend on
CONFIG_KVM_GENERIC_PRIVATE_MEM (which does require them).

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c   |  7 -------
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 752d2fff0f10..532df12b43c5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2279,13 +2279,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
 		bool assigned;
 		int level;
 
-		if (!kvm_mem_is_private(kvm, gfn)) {
-			pr_debug("%s: Failed to ensure GFN 0x%llx has private memory attribute set\n",
-				 __func__, gfn);
-			ret = -EINVAL;
-			goto err;
-		}
-
 		ret = snp_lookup_rmpentry((u64)pfn + i, &assigned, &level);
 		if (ret || assigned) {
 			pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared state, ret: %d assigned: %d\n",
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c223b97df03e..79a6b1a63027 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2449,6 +2449,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
 /**
  * kvm_gmem_populate() - Populate/prepare a GPA range with guest data
  *
@@ -2475,6 +2476,7 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
+#endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 319ec491ca47..95e338a29910 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -612,6 +612,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
@@ -665,11 +666,21 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 		    (npages - i) < (1 << max_order))
 			max_order = 0;
 
+		ret = -EINVAL;
+		while (!kvm_range_has_memory_attributes(kvm, gfn, gfn + (1 << max_order),
+							KVM_MEMORY_ATTRIBUTE_PRIVATE,
+							KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+			if (!max_order)
+				goto put_folio_and_exit;
+			max_order--;
+		}
+
 		p = src ? src + i * PAGE_SIZE : NULL;
 		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
 		if (!ret)
 			folio_mark_uptodate(folio);
 
+put_folio_and_exit:
 		folio_put(folio);
 		if (ret)
 			break;
@@ -681,3 +692,4 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 	return ret && !i ? ret : i;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_populate);
+#endif
-- 
2.43.0



