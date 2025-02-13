Return-Path: <linux-kernel+bounces-513293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EACA348AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E53A60C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD071E0087;
	Thu, 13 Feb 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjIEHs7T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD231DDC33
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461845; cv=none; b=dhs86fJZU1JMKEy5t2UozLPlE+VnZlpWoHwi4MvtLdjf00KlV+FwZGb8P2eBhc94Zm1UMtTQY5zNC+oKJaQ5UFYgR1WbBh1YValUMzQSs4tYZAz9ZxGNnvW+PIUZZQhIjaWsssIC9ENLP2DUZ9phmcjdXDrvzH0YSSCNQZTkVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461845; c=relaxed/simple;
	bh=QFdyFSfT3/4SWG9ZxXlf5iQzWwyJCONhEMZSH8OxQDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTYnLpgYgNciNwEGSkuEOJeuWRJ0vZ/xFxMOuXT0GqcfK/iqF8FbOkAxDhpAxUtA5X4ttLZtZ9AAGK6vAOu/iQ7SBxepZRs84vkw4qVqu4XngvPz+7AcSUr8BcO9a4+yybnEeeoRAv+etJPqALhY4N8+idZhNyZtEOTVkFN7Q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjIEHs7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TQz/AuXSm/jcXE77n/JSiGUw0PfjU842fJdja2/VcI=;
	b=SjIEHs7TRAbm/FHHHtK86P3l4HEJmWaiw78E6KeX0dQYjpMiGe49EAarH85FoDUbrO2esV
	DJCiUV9pgSCemoP7QjypMV5ufZuV6L5heV7cHLBfry2Zf2nNI0gkJP2G+ClPf+bQJ9kc3l
	j8pJYrVLVUExqVrDqhCEVUeqijskb4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-52usUm0fP0qRHnq_Qf1pew-1; Thu,
 13 Feb 2025 10:50:33 -0500
X-MC-Unique: 52usUm0fP0qRHnq_Qf1pew-1
X-Mimecast-MFC-AGG-ID: 52usUm0fP0qRHnq_Qf1pew_1739461831
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AD4818004A7;
	Thu, 13 Feb 2025 15:50:31 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93C9B1800365;
	Thu, 13 Feb 2025 15:50:25 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 13 Feb 2025 16:49:16 +0100
Subject: [PATCH RFC 2/5] virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-virtio-shm-page-size-v1-2-5ee1f9984350@redhat.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
In-Reply-To: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Sergio Lopez <slp@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=slp@redhat.com;
 h=from:subject:message-id; bh=QFdyFSfT3/4SWG9ZxXlf5iQzWwyJCONhEMZSH8OxQDM=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnrhStylNLMTT77Zr70CH3mC0kJqxktuN3LCCsg
 tnCFcVTa3yJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ64UrQAKCRD0aSeNLwwC
 NZqmD/9DXwIcQu7/ILLvZOWvdxn9+Ye3CGeCADk5JnxPU0Z81fskxGRGa5lTCHCY87Gl6QFEQvG
 UINwli3B85/HdKrWo022BePUxPTQLp5FozatRSG+T0//2+1gw0lolaTesnkIjXxfCgXGxh5s4gD
 gon6X0A+PtUWkum0UJokqKyxVxoIHg1SeQGpSYZwBzKNuTx8gNz4CVmaIZIx3lEFL8/UjduIzY6
 aYA+EwkVMrmxdpdNPHRoWvl/qnurDh2eLUqHeHt61PzwaxUmoSZZgxhjxc9/44WZUI4PIJdQtZe
 xFZlFVIGMrMPlEHk98UIIdgre9Np2XB3mhuntMoP+7LEDp8EYOBxvMPxWWQkTL/M/8s0BqAjKjG
 ja3grjYBvXaEPT8F8MJmsRnDKCJb57A2Wi6mQE+YBQ6TKLR0lKp0GzbLm05FuQWigxRhQnDa/qA
 Yztgpc4cpiZRsgqBs37g/+/S4c6sv8EcKtD/M0Wy7SA0yQtKPHVJglGxTwgguF89CqM7rW3Ozg4
 QslBotsRTVlGACVi9qQwHmSKL1Rb/AWw8sz9OviHsYVkGwWpR8J81ToeFq4Zvd8luCRQhlD73kW
 YpvG7lyZEUdPEhyAkRDZaQ4IP4BQlHcQTm4Wu7fedAfdWYWFB1tJYWPx1lonn8AbXvZxppC4Qf3
 TkqlXm2Fs5sykTQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce VIRTIO_F_SHM_PAGE_SIZE, a feature bit which indicates that the
transport provides the page size for SHM regions.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 +++
 drivers/virtio/virtio_ring.c       | 2 ++
 include/uapi/linux/virtio_config.h | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 4e6c28aacd1b5dfc117337a689a25d668805e334..79616ce5057bf3b2b88cae7e8fb7729efa9dd632 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -367,6 +367,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 
 	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
 		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
+
+	if (features & BIT_ULL(VIRTIO_F_SHM_PAGE_SIZE))
+		__virtio_set_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE);
 }
 
 static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fdd2d2b07b5a2aca864bc917306536685afb66a6..d853d5cf7e553be8bbe0ff461dc7312b258c6e58 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2983,6 +2983,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_NOTIFICATION_DATA:
 			break;
+		case VIRTIO_F_SHM_PAGE_SIZE:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce74b4e926c6929322b269252ab6830..3171e3792263c2cd472ac09da18e593ab400751d 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		43
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +120,9 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the transport provides the SHM page size.
+ */
+#define VIRTIO_F_SHM_PAGE_SIZE		42
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */

-- 
2.48.1


