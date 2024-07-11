Return-Path: <linux-kernel+bounces-249946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919692F1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D2D282BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A391A83D6;
	Thu, 11 Jul 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy8U5di9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FF1A83BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736895; cv=none; b=k2jGO5XT+34Xlr6/tLIM0XvsCDy4jvXOU7tXX0NBR1qQUjaLCiOWykauGRUBjbav5hOepay/bIBmvd4vabVAxAUNOdmaASLiquVkwxOvPGuDpvVeyQhyCCNtWdRp9dDLc+rtz1ErYM8TSZtbsOyIm5UkdWVfOSZPHvHz5I2op/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736895; c=relaxed/simple;
	bh=jxnA+pgnX+Ut2Md50wdncFdtANDPeRmkX6yBgbvo4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUH3pedPUHgMRmyqfeKattBSS4mGxBHYxeZ0/Al6XzqXOHLngGv5Py5kwDGKbJVzANMGrhxQr2pvzjGVUq+3Cv47Q24VZFC263toXBvUZhH1iToLvtdCoD2Dc+lWi4oKLTqUdzhnseiZCjra9Q3CX4lMMkGbUq+kebybf4YPdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy8U5di9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720736893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pFX8OR+FGcVBao93UmqOw/ZJuMdGpLg2ksyXeGLvNGk=;
	b=dy8U5di9B2csoNMT8XSxbDNdVIZErWq2Mi+Q+/R8TmqKEc0pY0hNzappalp5K4Y2WHPxBm
	IvuWZ1mg1PaMEmxVzdfCRSHiINuyk/0t1fbYoZOwT9i8uAxSqDcs1+ZUaqsP1Yn5KjAZDO
	LCuEMNRJjVlbBPEINYtFm0zxZ74DTSk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-VufFI1n3M_ankmHegWRvqg-1; Thu,
 11 Jul 2024 18:28:07 -0400
X-MC-Unique: VufFI1n3M_ankmHegWRvqg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4801819560BA;
	Thu, 11 Jul 2024 22:28:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A776019560AE;
	Thu, 11 Jul 2024 22:28:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH 12/12] KVM: guest_memfd: let kvm_gmem_populate() operate only on private gfns
Date: Thu, 11 Jul 2024 18:27:55 -0400
Message-ID: <20240711222755.57476-13-pbonzini@redhat.com>
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

This check is currently performed by sev_gmem_post_populate(), but it
applies to all callers of kvm_gmem_populate(): the point of the function
is that the memory is being encrypted and some work has to be done
on all the gfns in order to encrypt them.

Therefore, check the KVM_MEMORY_ATTRIBUTE_PRIVATE attribute prior
to invoking the callback, and stop the operation if a shared page
is encountered.  Because CONFIG_KVM_PRIVATE_MEM in principle does
not require attributes, this makes kvm_gmem_populate() depend on
CONFIG_KVM_GENERIC_PRIVATE_MEM (which does require them).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c   |  7 -------
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 397ef9e70182..5a93e554cbb6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2202,13 +2202,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
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
index 456dbdf7aaaf..f7ba665652f3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2445,6 +2445,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
 /**
  * kvm_gmem_populate() - Populate/prepare a GPA range with guest data
  *
@@ -2471,6 +2472,7 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
+#endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 266810bb91c9..7e2c9274fd16 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -609,6 +609,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
@@ -662,11 +663,21 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
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
@@ -678,3 +689,4 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 	return ret && !i ? ret : i;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_populate);
+#endif
-- 
2.43.0


