Return-Path: <linux-kernel+bounces-403516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D89C36B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5CE2812B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870D142E77;
	Mon, 11 Nov 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbY3mOPY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490513A27E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293753; cv=none; b=YMHRcM2F/BTcmAGFwCE+W3cirlh9w6mv1awdto0DV7kDOFkcmYdFMCo4HgUj6xUocG9Eho8r2v8U2Tiku+PXhrP7q6RHY3nTA+dQ9u12+xizivfNB/c5zPZtuNFZT0InODpElBH2Qz+sk2Q5gZ2AA+PAd/Wf641QybkEG/63EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293753; c=relaxed/simple;
	bh=1ZvxRezxJXANBRFOTe55Jek5Kex2eZTOtcEtydvGZOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jno98k/W8vMV/7d5NKFd2WmaisUlaD9eZGgX/UvWMjZyhIOlKnj2L6LfUudAsglKqcutQ64+0ovsz0SNLWrOVh2lP5qNhxQ+UACkzkcPvFS/6nM3DjjVGdATLv+XYNWKCycSYmL0OO6qXBS3q/2U/dAgdAo1BddNKevjpHyO6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbY3mOPY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731293750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+y3vCNcj9tlE1RFyrQIwWNkyVgS7ApkQcRy6pVYNX4E=;
	b=ZbY3mOPYjS/nTh3nmA9F9Kua3OAe42NiQGvds3WFCv1snG0M0gmUw65NYq4I7PreqPMbY9
	CzoUjaHJXZj0+QUZYNglfxTZLz7zLqtKxWZmwJ8dGXiQtNc+Z4IKuLEj94fTOfr96kaaRW
	U+0QMR6WLH1ZuMXi8iMexXMIPtmXs1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-35vZMN0xO-u4pwZIi-lSWw-1; Sun,
 10 Nov 2024 21:55:47 -0500
X-MC-Unique: 35vZMN0xO-u4pwZIi-lSWw-1
X-Mimecast-MFC-AGG-ID: 35vZMN0xO-u4pwZIi-lSWw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C31E195608C;
	Mon, 11 Nov 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 970DA300019E;
	Mon, 11 Nov 2024 02:55:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: skip cpu sync when mapping fails
Date: Mon, 11 Nov 2024 10:55:38 +0800
Message-ID: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There's no need to sync DMA for CPU on mapping errors. So this patch
skips the CPU sync in the error handling path of DMA mapping.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 98 +++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..b422b5fb22db 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -441,8 +441,10 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  */
 
 static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
+					   const struct vring_desc *desc,
+					   bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	if (!vq->do_unmap)
@@ -450,16 +452,18 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
-		       virtio32_to_cpu(vq->vq.vdev, desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	dma_unmap_page_attrs(vring_dma_dev(vq),
+			     virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			     virtio32_to_cpu(vq->vq.vdev, desc->len),
+			     (flags & VRING_DESC_F_WRITE) ?
+			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+			     attrs);
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
 
@@ -469,20 +473,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 		if (!vq->use_dma_api)
 			goto out;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_single_attrs(vring_dma_dev(vq),
+				       extra[i].addr,
+				       extra[i].len,
+				       (flags & VRING_DESC_F_WRITE) ?
+				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				       attrs);
 	} else {
 		if (!vq->do_unmap)
 			goto out;
 
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_page_attrs(vring_dma_dev(vq),
+				     extra[i].addr,
+				     extra[i].len,
+				     (flags & VRING_DESC_F_WRITE) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				     attrs);
 	}
 
 out:
@@ -717,10 +723,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (i == err_idx)
 			break;
 		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
+			vring_unmap_one_split_indirect(vq, &desc[i], true);
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
-			i = vring_unmap_one_split(vq, i);
+			i = vring_unmap_one_split(vq, i, true);
 	}
 
 free_indirect:
@@ -775,12 +781,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, false);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, false);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -804,7 +810,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		if (vq->do_unmap) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split_indirect(vq,
+							&indir_desc[j], false);
 		}
 
 		kfree(indir_desc);
@@ -1221,8 +1228,10 @@ static u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+				     const struct vring_desc_extra *extra,
+				     bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	flags = extra->flags;
@@ -1231,24 +1240,28 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 		if (!vq->use_dma_api)
 			return;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr, extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_single_attrs(vring_dma_dev(vq),
+				       extra->addr, extra->len,
+				       (flags & VRING_DESC_F_WRITE) ?
+				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				       attrs);
 	} else {
 		if (!vq->do_unmap)
 			return;
 
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		dma_unmap_page_attrs(vring_dma_dev(vq),
+				     extra->addr, extra->len,
+				     (flags & VRING_DESC_F_WRITE) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				     attrs);
 	}
 }
 
 static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
+				    const struct vring_packed_desc *desc,
+				    bool skip_sync)
 {
+	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
 	u16 flags;
 
 	if (!vq->do_unmap)
@@ -1256,11 +1269,12 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 
 	flags = le16_to_cpu(desc->flags);
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       le64_to_cpu(desc->addr),
-		       le32_to_cpu(desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	dma_unmap_page_attrs(vring_dma_dev(vq),
+			     le64_to_cpu(desc->addr),
+			     le32_to_cpu(desc->len),
+			     (flags & VRING_DESC_F_WRITE) ?
+			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
+			     attrs);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -1389,7 +1403,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_desc_packed(vq, &desc[i], true);
 
 free_desc:
 	kfree(desc);
@@ -1539,7 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq,
+					 &vq->packed.desc_extra[curr], true);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1619,7 +1634,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+						 &vq->packed.desc_extra[curr],
+						 false);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1636,7 +1652,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_desc_packed(vq, &desc[i], false);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
-- 
2.31.1


