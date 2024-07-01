Return-Path: <linux-kernel+bounces-235559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9D91D69A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C79281732
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAEEEB5;
	Mon,  1 Jul 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/NZt2Gg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D94171C9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804737; cv=none; b=eRrmRqvY+6up3DK1B5Fd7B0zURhZgVCMOZA8qn9pLVn5jbHIb4R1HLv8S0aBlHlG45iRS43HYzAx3o9KOhdKNWj6RJ5EKnrEJxkewbRKcbQRzI5W8BrMtC31AHbJMyuUePdyOb0s+gwsUzOBTrK8yivCu5mGw/vLxf/MIbRcd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804737; c=relaxed/simple;
	bh=qQQjGDoJ0myh77aPdjP+sWJgsk2E2ZsVb0POwmgofvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMAETuuvAOCSKoTy2kXKvGDelKN4n2P5e6YXaPWASqwnO3sw1XjaY2M4kT+MoHvWuygNWHnvKv5OOPgFo1ygSmYmpKZKkknsR6FQwPUCfVSevO0vmyWoSpod1MX/87kz4gp8zE6D5dAXUCtjMrsJvkwJb4qCWPbFZXm5DsE3jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/NZt2Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719804734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lrXIw9w05RWnWwbiO9aOe5v3MpC5DP8zU3Bul/SygzI=;
	b=L/NZt2GgwVFCEW9tpjP2Mg/TGBtzIfrWsRM9AhNBocJLWka/JB9IhonEjteHcj3sKp9df5
	OBBPeJfr55Vw0hCd5xAaH9XLZqdF8b2Z9e+kNMj1NQtagzteO9+ftNz8pToXHsfWONRsGL
	mPwHVTfaw3X9bQjZmdpyGV0+edIbHAg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-dgew17BePSaVyxa7FmGRsg-1; Sun,
 30 Jun 2024 23:32:10 -0400
X-MC-Unique: dgew17BePSaVyxa7FmGRsg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 189DB19560A2;
	Mon,  1 Jul 2024 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.165])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4EBA19560AA;
	Mon,  1 Jul 2024 03:32:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH] vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler
Date: Mon,  1 Jul 2024 11:31:59 +0800
Message-ID: <20240701033159.18133-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

remap_pfn_page() should not be called in the fault handler as it may
change the vma->flags which may trigger lockdep warning since the vma
write lock is not held. Actually there's no need to modify the
vma->flags as it has been set in the mmap(). So this patch switches to
use vmf_insert_pfn() instead.

Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..6b9c12acf438 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1483,13 +1483,7 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	notify = ops->get_vq_notification(vdpa, index);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
-			    PFN_DOWN(notify.addr), PAGE_SIZE,
-			    vma->vm_page_prot))
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
 
 static const struct vm_operations_struct vhost_vdpa_vm_ops = {
-- 
2.31.1


