Return-Path: <linux-kernel+bounces-573182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDFA6D3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2282E18922B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A8194091;
	Mon, 24 Mar 2025 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8khFCS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10C18E76F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796117; cv=none; b=M3+X+6meI4roWdrZ9s0cXeEiRruDzOVJKlKK5tYpE0vRG9OZlGMTLbK8YjQxcmDZqv62iz4jy2g6ghsYq9i9PKbAnQ2cmQgqBKj6MLunUhst7Yk7fCsgou34na8Ly4oUcmd2b+oO5oGcer8ZPLiIN2w2vnxL3RTQIINl75ypc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796117; c=relaxed/simple;
	bh=jN5XfLGRaFEQJIWoPAhVMh4So5cHBtJe2XIHAr/ZYtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=EoGrjhX3OH3Z1dk5NAFl4Xna+ETh8lYhawh+oOd6rOJzqFv+JLwuCKdEGZenTlCpwySWKJroF3DkHZGg0IPDt5b93hg0bxPLQcJBDgGnC5fPv5qC6rTAxnFNynuDH1nEzqgMjTMz5cbRBW+NpTlNOOSQOTTU8gJgv6c9g1sMk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8khFCS/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742796112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lto3GT2+6m1dXRZk05lfOunmZW48wt5nBeWwNQJS0J8=;
	b=D8khFCS/EPsWVxwHFJCeFRP7yyqqoj9Fs1n2fhYYfOBRtWEsJyqcf1wYX9nhE4+EyThNTM
	DDp2MAJuJj1EOpVlnuScj8TVBDPpG17RLHhGr4S5pcmPL4Zh7SYRT7etf8mh/bQkiy4F1H
	VBUmIxb9a4g1QyxE8Yl9AiTXEAufxok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-tWKHv16QNCOXPvp9jDR35A-1; Mon,
 24 Mar 2025 02:01:48 -0400
X-MC-Unique: tWKHv16QNCOXPvp9jDR35A-1
X-Mimecast-MFC-AGG-ID: tWKHv16QNCOXPvp9jDR35A_1742796107
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C64511800260;
	Mon, 24 Mar 2025 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30EBD195609D;
	Mon, 24 Mar 2025 06:01:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] virtio_ring: factor out core logic for updating last_used_idx
Date: Mon, 24 Mar 2025 14:01:24 +0800
Message-ID: <20250324060127.2358-4-jasowang@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Factor out the core logic for updating last_used_idx to be reused by
the packed in order implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fe3e6f3d0f96..bd4faf04862c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1749,6 +1749,30 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
+static void update_last_used_idx_packed(struct vring_virtqueue *vq,
+					u16 id, u16 last_used,
+					u16 used_wrap_counter)
+{
+	last_used += vq->packed.desc_state[id].num;
+	if (unlikely(last_used >= vq->packed.vring.num)) {
+		last_used -= vq->packed.vring.num;
+		used_wrap_counter ^= 1;
+	}
+
+	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+	WRITE_ONCE(vq->last_used_idx, last_used);
+
+	/*
+	 * If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call.
+	 */
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->packed.vring.driver->off_wrap,
+				cpu_to_le16(vq->last_used_idx));
+}
+
 static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
@@ -1792,24 +1816,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	ret = vq->packed.desc_state[id].data;
 	detach_buf_packed(vq, id, ctx);
 
-	last_used += vq->packed.desc_state[id].num;
-	if (unlikely(last_used >= vq->packed.vring.num)) {
-		last_used -= vq->packed.vring.num;
-		used_wrap_counter ^= 1;
-	}
-
-	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
-	WRITE_ONCE(vq->last_used_idx, last_used);
-
-	/*
-	 * If we expect an interrupt for the next entry, tell host
-	 * by writing event index and flush out the write before
-	 * the read in the next get_buf call.
-	 */
-	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
-		virtio_store_mb(vq->weak_barriers,
-				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx));
+	update_last_used_idx_packed(vq, id, last_used, used_wrap_counter);
 
 	LAST_ADD_TIME_INVALID(vq);
 
-- 
2.42.0


