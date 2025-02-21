Return-Path: <linux-kernel+bounces-526305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8205A3FD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE547078E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BC24CEE9;
	Fri, 21 Feb 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpKaVx//"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED824BCF0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157623; cv=none; b=XKd8LbcuVpWRKYmoXdy6iM3eJ+WpIwgiwrFFcsL58NGJytNHAOVm/BBGAPrcLEq8klYXwzSRxBjwaRs6Eonjo10i/LYirRtJ9xKCauhjvS1YnUWJ5/ZWaD5NiaZkphYtXlW7aagSFM3Jjw+NtFzd/UDicUir62EznlKDx+BNdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157623; c=relaxed/simple;
	bh=dmXZwGs+K9cXy4OVhaZVpVlHINi/95qyv6S5WYJHnRw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNybu32BRvkON2T2dNszjm4Q2E0wb2X4PtrQEtH6y+Y9P/uHM6GF3pEzVYFRgDKsA8t2C1lftsaO7cvgMy+bQVHOCLLLHcqNZ/5ls7jR+lZIW9PqHyaC6lDJd0kZyQ8aLOM8HJYqr+Nc+4Kuai4jQem3RvtOBSWQNNk0oh/+OY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpKaVx//; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740157620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdFhks9dEBucFBSdGlrdrm2YLeGCqTXN1StzLlcWwlU=;
	b=KpKaVx//jjKZSEXwCXrBk9hezbVM4wyRPsGPyDza0rPJH+zPAWCbsqwdC0RtBCZPg+OnOc
	u+Z1jaStdgbfiqDFFpESR7W2lo407YIw51Wrut3ZiG5tROMPeHmfDTzQoy8LhkR/cpaVB6
	4/YtXc8U4MaoMMYWnhawrZxDo3HpZe4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-m0a4VAWSOIaZmlHfhpDBIA-1; Fri,
 21 Feb 2025 12:06:59 -0500
X-MC-Unique: m0a4VAWSOIaZmlHfhpDBIA-1
X-Mimecast-MFC-AGG-ID: m0a4VAWSOIaZmlHfhpDBIA_1740157617
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A9A61800878;
	Fri, 21 Feb 2025 17:06:57 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA946180087E;
	Fri, 21 Feb 2025 17:06:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	yama@redhat.com,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>
Subject: [RFC v2 4/5] virtiofs: perform DMA operations out of the spinlock
Date: Fri, 21 Feb 2025 18:06:25 +0100
Message-ID: <20250221170626.261687-5-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-1-eperezma@redhat.com>
References: <20250221170626.261687-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is useful for some setups like swiotlb or VDUSE where the DMA
operations are expensive and/or need to be performed with a write lock.

After applying this patch, fio read test goes from 1124MiB/s to 1191MiB/s.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 fs/fuse/virtio_fs.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1344c5782a7c..e19c78f2480e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -836,8 +836,19 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 
 	/* End requests */
 	list_for_each_entry_safe(req, next, &reqs, list) {
+		unsigned int total_sgs = req->out_sgs + req->in_sgs;
+
 		list_del_init(&req->list);
 
+		for (unsigned int i = 0; i < total_sgs; ++i) {
+			enum dma_data_direction dir = (i < req->out_sgs) ?
+				DMA_TO_DEVICE : DMA_FROM_DEVICE;
+			dma_unmap_page(vq->vdev->dev.parent,
+				       sg_dma_address(&req->sg[i]),
+				       sg_dma_len(&req->sg[i]), dir);
+
+		}
+
 		/* blocking async request completes in a worker context */
 		if (req->args->may_block) {
 			struct virtio_fs_req_work *w;
@@ -1426,6 +1437,24 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		sgs[i] = &req->sg[i];
 	WARN_ON(req->out_sgs + req->in_sgs != total_sgs);
 
+	// TODO can we change this ptr out of the lock?
+	vq = fsvq->vq;
+	// TODO handle this and following errors
+	for (i = 0; i < total_sgs; i++) {
+		struct page *page = sg_page(&req->sg[i]);
+		enum dma_data_direction dir = (i < req->out_sgs) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
+		dma_addr_t dma_addr = dma_map_page(vq->vdev->dev.parent, page,
+						   req->sg[i].offset, req->sg[i].length, dir);
+
+		if (dma_mapping_error(vq->vdev->dev.parent, dma_addr)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		sg_dma_address(&req->sg[i]) = dma_addr;
+		sg_dma_len(&req->sg[i]) = req->sg[i].length;
+	}
+
 	spin_lock(&fsvq->lock);
 
 	if (!fsvq->connected) {
@@ -1434,8 +1463,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
-	vq = fsvq->vq;
-	ret = virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req, GFP_ATOMIC);
+	ret = virtqueue_add_sgs_premapped(vq, sgs, req->out_sgs,
+					  req->in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock(&fsvq->lock);
 		goto out;
@@ -1460,6 +1489,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		virtqueue_notify(vq);
 
 out:
+	for (unsigned int j = 0; ret && j < total_sgs; ++j) {
+		enum dma_data_direction dir = (j < req->out_sgs) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
+		dma_unmap_page(vq->vdev->dev.parent,
+			       sg_dma_address(&req->sg[j]),
+			       sg_dma_len(&req->sg[j]), dir);
+	}
 	if (ret < 0 && req->argbuf) {
 		kfree(req->argbuf);
 		req->argbuf = NULL;
-- 
2.48.1


