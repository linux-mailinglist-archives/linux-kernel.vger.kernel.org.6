Return-Path: <linux-kernel+bounces-263650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824E93D8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE0A28897B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F915099D;
	Fri, 26 Jul 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXTl78dq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC6149E1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019933; cv=none; b=ANddvwgUKNuzUshfAe4ltf02/Y1H9WUunCGlK7XBIJsEF/Fs5qmIUxmRI1ez9g5tk3+kA/+7hnoejElTCvU/riO8pCz6k1wE4wjKgyFq+rztZOs3Ino/000JLb3qEHYBFJ1DYtMpf8s3w+jesu3s1K6N5bp4Rzh9YdVzEL/B2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019933; c=relaxed/simple;
	bh=eB5wvMbxqMd2gdO84ZLM6DxbjjXIhV+8XZ9H/PrfdNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6XlkJbNXliCNIYvOhn0qhfhpWgkPNg3tQpFg9F98Un4E4Hx16ueDq/so3D0qZjSD3d3Y2bOagqcVrH9twrjnjmtgQS8AL8qt5J5a0f06Pd5egoD9IPz+O2B3ZiQFRJtRrwubiinYnDmVNqYqtSADT+f5s4Z7VS3S8mu+t4Us+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXTl78dq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqNWXGOZI8rRuyocNScf5f61l7jMBqsk673rmo19d60=;
	b=dXTl78dqc6wMT3fVnVR+I1thkpbAOomeZ6hLsNf4yxdKO0q4LIDZcwGxTbV9tTtSEl8Hw8
	u1/NPuK8bnTskS7mtKSTNR95ZfHQZDg361VDlA27U8dz5iP8qZLTcs+60il/1r3ZU2/oaE
	YfhqkWPOwGgTKTD69C+Wg4rop25XQAM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-uI72tXPuMCyKMdRNKyBE_g-1; Fri,
 26 Jul 2024 14:52:07 -0400
X-MC-Unique: uI72tXPuMCyKMdRNKyBE_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9F731955D47;
	Fri, 26 Jul 2024 18:52:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31D6D3000194;
	Fri, 26 Jul 2024 18:52:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 06/14] KVM: guest_memfd: return locked folio from __kvm_gmem_get_pfn
Date: Fri, 26 Jul 2024 14:51:49 -0400
Message-ID: <20240726185157.72821-7-pbonzini@redhat.com>
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

Allow testing the up-to-date flag in the caller without taking the
lock again.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 76139332f2f3..9271aba9b7b3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -59,6 +59,7 @@ static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct fol
 	return 0;
 }
 
+/* Returns a locked folio on success.  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prepare)
 {
 	struct folio *folio;
@@ -551,6 +552,7 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	fput(file);
 }
 
+/* Returns a locked folio on success.  */
 static struct folio *
 __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 		   gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
@@ -584,7 +586,6 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 	if (max_order)
 		*max_order = 0;
 
-	folio_unlock(folio);
 	return folio;
 }
 
@@ -602,6 +603,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	folio_unlock(folio);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
@@ -647,6 +649,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			break;
 		}
 
+		folio_unlock(folio);
 		if (!IS_ALIGNED(gfn, (1 << max_order)) ||
 		    (npages - i) < (1 << max_order))
 			max_order = 0;
-- 
2.43.0



