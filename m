Return-Path: <linux-kernel+bounces-249938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8E92F1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD561C227C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636211A2C2B;
	Thu, 11 Jul 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNxFUmhn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4D1A0AFB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736887; cv=none; b=IXXH+89pXm8Zqulfehaq7ducpjILK8iaFyliNpi0nfeNnO6bWXbidhNe8xc3puiWYekFrpTHuHVJ97yBNqy9kJfVnBVADavhIkN4RQNtbKV0yTIQZ44hpm46KFEQV53ThMyDW4d1qITQB4RxDZvECwAW7tWzhXLt6bTu96FOg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736887; c=relaxed/simple;
	bh=/0Ic6LMV19RGvo7vaR5tRG57wXbUrKxO49kaG6FCTWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pev+PMXzXOKm63sic7aTFpaGb/aVO1+lPF3O5yxmy8d5LunSqtmLGp2JzyEzbgaVAumJ2YRLiElthqQabGgqTUPHGVOUwYS1gUjNpk7kJ3r8Te5qdUa8BLit7O0Wa4PfKS9yA1ap2JsYd9FHtcPTqzFaiffuq3qrSEx+y29fo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNxFUmhn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720736884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV6wurz3on5LgFg0xx3ZfvMVuEd3TIir8IXtT5zHd0I=;
	b=NNxFUmhnRIuRMZs8ddRQYhDo7mQK6mS0byrbU7zRXf73iesHiwI8JnvVvjCsqemBQ58A7r
	7TXp/FavResX1nNNq/Uvfz+UZ5bf1KkhtIJVY/61B/YfK8L6DB+70HV0SJzH1g7qDcEdIN
	C4wnsY/rEEFrWu/hws+6DjPR6QlZH0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-XaQJg6rjN_uo_8XDQ5SpcA-1; Thu,
 11 Jul 2024 18:28:01 -0400
X-MC-Unique: XaQJg6rjN_uo_8XDQ5SpcA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0B411954B34;
	Thu, 11 Jul 2024 22:28:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDA0519560AE;
	Thu, 11 Jul 2024 22:27:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH 05/12] KVM: guest_memfd: return locked folio from __kvm_gmem_get_pfn
Date: Thu, 11 Jul 2024 18:27:48 -0400
Message-ID: <20240711222755.57476-6-pbonzini@redhat.com>
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

Allow testing the up-to-date flag in the caller without taking the
lock again.

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



