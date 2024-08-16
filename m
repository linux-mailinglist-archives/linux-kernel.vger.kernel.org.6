Return-Path: <linux-kernel+bounces-288885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F96954004
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B25B24602
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84175482E4;
	Fri, 16 Aug 2024 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnVKSpVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B351877
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778361; cv=none; b=nVj18ODF0IkRAhqLBiOOO3DwRlMkfznSwSGmP0dBUao90GT7TIJd1/xuaTYKobUHoNSgRWxLkhz657pbRcHxEk7pKYKorLGxZ5VakN4GCbpfoEONhV6GxTQeLosVnNMIBfYAkeRsmVs71TQPm1c7tCUbmbu7VPSGvldFDhafc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778361; c=relaxed/simple;
	bh=ZkQQ4Cn19YreRFLNnok9iQL5GCdwO+jNaxblnhNi22A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o48CkTrpCW5uYRiBzKI14fpDanur/ZLLzwtafMsrzYohbioZpn3pyksQoR61albHsOZ2evh110VPXMyQGryosPrezUOr0YHcrfBqw+WlE2+YnmwSoxINHtwH1B6oBvHKg7jdSc/Mpa2wNG6UbIwIXPuMPglO8HrqzAkzVempeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnVKSpVN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723778358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fZBYM8BcEh6UxLDFpr2Et6wTf1D5qI6MuKpCzNtcKvM=;
	b=MnVKSpVNogsbYs9zn16EiI3CmsgeXqI5L3JTU7IlMzD7F8NsDHtc0praxr8wFrk7EQbc4x
	LKKPFAcIUjcMc5JCnu7z7WXemm3DYpPlg7EWgGmBWLGYvNM6qqkWXGDzrXGjoPF7WrH38O
	Z2Yy+qiapTJRa5L6DrXRZavgkZTvpFI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-18kBQJvbOmubpsBwjKuhGA-1; Thu,
 15 Aug 2024 23:19:17 -0400
X-MC-Unique: 18kBQJvbOmubpsBwjKuhGA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E061955D4C;
	Fri, 16 Aug 2024 03:19:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F044F1955F43;
	Fri, 16 Aug 2024 03:19:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: lingshan.zhu@intel.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH] vhost_vdpa: assign irq bypass producer token correctly
Date: Fri, 16 Aug 2024 11:19:00 +0800
Message-ID: <20240816031900.18013-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We used to call irq_bypass_unregister_producer() in
vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
token pointer is still valid or not.

Actually, we use the eventfd_ctx as the token so the life cycle of the
token should be bound to the VHOST_SET_VRING_CALL instead of
vhost_vdpa_setup_vq_irq() which could be called by set_status().

Fixing this by setting up irq bypass producer's token when handling
VHOST_SET_VRING_CALL and un-registering the producer before calling
vhost_vring_ioctl() to prevent a possible use after free as eventfd
could have been released in vhost_vring_ioctl(). And such registering
and unregistering will only be done if DRIVER_OK is set.

Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since RFC:
- only do the reg/dereg of the producer when DRIVER_OK is set
---
 drivers/vhost/vdpa.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e31ec9ebc4ce..ab441b8ccd2e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	if (irq < 0)
 		return;
 
-	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 	if (!vq->call_ctx.ctx)
 		return;
 
-	vq->call_ctx.producer.token = vq->call_ctx.ctx;
 	vq->call_ctx.producer.irq = irq;
 	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
 	if (unlikely(ret))
@@ -709,6 +707,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			vq->last_avail_idx = vq_state.split.avail_index;
 		}
 		break;
+	case VHOST_SET_VRING_CALL:
+		if (vq->call_ctx.ctx) {
+			if (ops->get_status(vdpa) &
+			    VIRTIO_CONFIG_S_DRIVER_OK)
+				vhost_vdpa_unsetup_vq_irq(v, idx);
+			vq->call_ctx.producer.token = NULL;
+		}
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
@@ -747,13 +753,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			cb.callback = vhost_vdpa_virtqueue_cb;
 			cb.private = vq;
 			cb.trigger = vq->call_ctx.ctx;
+			vq->call_ctx.producer.token = vq->call_ctx.ctx;
+			if (ops->get_status(vdpa) &
+			    VIRTIO_CONFIG_S_DRIVER_OK)
+				vhost_vdpa_setup_vq_irq(v, idx);
 		} else {
 			cb.callback = NULL;
 			cb.private = NULL;
 			cb.trigger = NULL;
 		}
 		ops->set_vq_cb(vdpa, idx, &cb);
-		vhost_vdpa_setup_vq_irq(v, idx);
 		break;
 
 	case VHOST_SET_VRING_NUM:
@@ -1419,6 +1428,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	for (i = 0; i < nvqs; i++) {
 		vqs[i] = &v->vqs[i];
 		vqs[i]->handle_kick = handle_vq_kick;
+		vqs[i]->call_ctx.ctx = NULL;
 	}
 	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
 		       vhost_vdpa_process_iotlb_msg);
-- 
2.31.1


