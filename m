Return-Path: <linux-kernel+bounces-573171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8BA6D3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DA7A5B99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D71A2393;
	Mon, 24 Mar 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEYgJ9y5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9318FDAA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795076; cv=none; b=MgpmucxlL5q975h3LKCyGYAP6trWXeP8XJBHvfkEEipyUqdxx6JFTSQ0fNFAiO/oGYB69L9abw32417qaAfIkp8cPpHI2SSJamdDX+XvfqTvbJ2ovrXECLiP6oXnX5lR93sUV7JFArCLaBgooS8tWagFwhzbJ5J/K2vXgEfjrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795076; c=relaxed/simple;
	bh=Sf6aFnUgzweHhcb2/0PHtuJoSe6Bjfda5Yic+XpQMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=m7jeaAJttLGnAxg4ckfLBYfzgdOfkLd6rmtl9ttGipAFtNSRQCG1/VtHO1xTOoZVzWyiwKB32HemD1jgZEfx5noeeV7UjCLSzwONU3Ml17GhF1rn3q8fMmCsrPPy57Tng5JHv6wtHFsGv5M6mTA/oadhnDUbxmBgJ/m89N49/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEYgJ9y5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0Dz30cWhe47jEaYyjKRkvIqGJg1f3hrhd092pA8TM4=;
	b=OEYgJ9y5+B7yDh4EHz5Uex3Nvu1W9UzX3KVyZH2GD2PBUWWkOzSwRePsX4purCiqZLs51I
	LulGLu96fn0gqRS6kSXbnCYOXJyJNaODSHXZQuK1V8adxAvWRF7cC44xYOjSZm+b/Yu4Ll
	G13LkaYLbA4319Nm4DM1PQKL5zOBLQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-goEuFFuWMtanV3RtbPqbHw-1; Mon,
 24 Mar 2025 01:44:29 -0400
X-MC-Unique: goEuFFuWMtanV3RtbPqbHw-1
X-Mimecast-MFC-AGG-ID: goEuFFuWMtanV3RtbPqbHw_1742795069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66C01808868;
	Mon, 24 Mar 2025 05:44:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3B6A180B48E;
	Mon, 24 Mar 2025 05:44:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] virtio_ring: switch to use vring_virtqueue for disable_cb variants
Date: Mon, 24 Mar 2025 13:43:24 +0800
Message-ID: <20250324054333.1954-11-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
References: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index af8ce6e9d892..f754da8c2ac6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -869,10 +869,8 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
 
@@ -888,7 +886,7 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 			vring_used_event(&vq->split.vring) = 0x0;
 		else
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
 }
@@ -1786,10 +1784,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	return ret;
 }
 
-static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
+static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
 
@@ -2538,9 +2534,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->packed_ring)
-		virtqueue_disable_cb_packed(_vq);
+		virtqueue_disable_cb_packed(vq);
 	else
-		virtqueue_disable_cb_split(_vq);
+		virtqueue_disable_cb_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-- 
2.42.0


