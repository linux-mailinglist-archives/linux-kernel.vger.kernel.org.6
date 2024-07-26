Return-Path: <linux-kernel+bounces-263644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF293D89F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C74D28779B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F573440;
	Fri, 26 Jul 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ+SvLvu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077139FF2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019927; cv=none; b=Mz3dDV0gqEOteY1sJKTuJBC+2bin/w4vUjb+qhIcsaPR6nDEONhlxe4PRnFB/8pZUVRrpynZk8Zqo2wB8R/P6fw69j+r61+5EwBi7UEfBNKZQzpOfRjMpLsJq4Vk+mLv/Uy12L7kgE4MS2M0DTxxKqO2A/YvWkrWPFrz6F4jSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019927; c=relaxed/simple;
	bh=c9YVzEqDO40zQ3OBBViHTxLIjwogiliy+C5/MF1XVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lo8eDJSEKyQzDUJY7v9f9kMHrFyPALzXjXmJcIAxJvMYOtfL2cR1SXh5X2YuGB1O4hL6NeAte1j3TvOCBGKJra0R+95DsuMgcjmzRfer5AJDBQQEtZWPKbBCFsQJNSD0LxINX86LPKogmtg0LDNgJ7stpvghpqDlrWWa1PkQtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZ+SvLvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9zQ9sNzJEmQ4UZRXCIvhZzfwYgz5vrNz7CYpnOR5vY=;
	b=UZ+SvLvum8Ki/oM5JHE5trQUb0RJFkP8rwQQURXeb46WFI1k7UlBieFArogm0n9rMy/Fvs
	mn6P/+qbNqoU0EN1nqYt4lsFk/dDkFEBmtOJ5G7imCFRPekwYwZpvcEJ1JeRF6Q41Yt7Yp
	HoBlK2qmDG9VpA9eytiNkkt5LaoAnEw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-sDAKDUzLM9-O3CMsdCP6rg-1; Fri,
 26 Jul 2024 14:52:01 -0400
X-MC-Unique: sDAKDUzLM9-O3CMsdCP6rg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F391955D42;
	Fri, 26 Jul 2024 18:52:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D31283000194;
	Fri, 26 Jul 2024 18:51:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 02/14] KVM: guest_memfd: return folio from __kvm_gmem_get_pfn()
Date: Fri, 26 Jul 2024 14:51:45 -0400
Message-ID: <20240726185157.72821-3-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Right now this is simply more consistent and avoids use of pfn_to_page()
and put_page().  It will be put to more use in upcoming patches, to
ensure that the up-to-date flag is set at the very end of both the
kvm_gmem_get_pfn() and kvm_gmem_populate() flows.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1c509c351261..522e1b28e7ae 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -541,34 +541,34 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	fput(file);
 }
 
-static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
-		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
+static struct folio *
+__kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
+		   gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
 {
 	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
 	struct kvm_gmem *gmem = file->private_data;
 	struct folio *folio;
 	struct page *page;
-	int r;
 
 	if (file != slot->gmem.file) {
 		WARN_ON_ONCE(slot->gmem.file);
-		return -EFAULT;
+		return ERR_PTR(-EFAULT);
 	}
 
 	gmem = file->private_data;
 	if (xa_load(&gmem->bindings, index) != slot) {
 		WARN_ON_ONCE(xa_load(&gmem->bindings, index));
-		return -EIO;
+		return ERR_PTR(-EIO);
 	}
 
 	folio = kvm_gmem_get_folio(file_inode(file), index, prepare);
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return folio;
 
 	if (folio_test_hwpoison(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
-		return -EHWPOISON;
+		return ERR_PTR(-EHWPOISON);
 	}
 
 	page = folio_file_page(folio, index);
@@ -577,25 +577,25 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 	if (max_order)
 		*max_order = 0;
 
-	r = 0;
-
 	folio_unlock(folio);
-
-	return r;
+	return folio;
 }
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
 {
 	struct file *file = kvm_gmem_get_file(slot);
-	int r;
+	struct folio *folio;
 
 	if (!file)
 		return -EFAULT;
 
-	r = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, true);
+	folio = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, true);
 	fput(file);
-	return r;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
@@ -625,6 +625,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 
 	npages = min_t(ulong, slot->npages - (start_gfn - slot->base_gfn), npages);
 	for (i = 0; i < npages; i += (1 << max_order)) {
+		struct folio *folio;
 		gfn_t gfn = start_gfn + i;
 		kvm_pfn_t pfn;
 
@@ -633,9 +634,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			break;
 		}
 
-		ret = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, false);
-		if (ret)
+		folio = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, false);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
 			break;
+		}
 
 		if (!IS_ALIGNED(gfn, (1 << max_order)) ||
 		    (npages - i) < (1 << max_order))
@@ -644,7 +647,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 		p = src ? src + i * PAGE_SIZE : NULL;
 		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
 
-		put_page(pfn_to_page(pfn));
+		folio_put(folio);
 		if (ret)
 			break;
 	}
-- 
2.43.0



