Return-Path: <linux-kernel+bounces-523916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27CA3DCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AB47A4CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668211FC0E4;
	Thu, 20 Feb 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs+qGvn+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8B1F7916
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061797; cv=none; b=eVRlIvtumh653EPPnv3Rk8P/l4AzqJGR7nBSSQCDxXiAA5votSRaRVCZKxTbzw1BQtLVt5VmIdvG1oXrs9CNEWReDRTCfgprzn4HyDQhKlpa3plFlZAEnItZqXlH4pvx/hrl2xIbB7gxcSyZmOc04mbRoOSOZNHK8IUCFXf+Ltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061797; c=relaxed/simple;
	bh=mRGswsKourNVCaSODc/n1NTXWr1ln5mIzOK1iDX0YHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkN9G9ccJbW9+kVnWcYFELA5nypIRm1VcyLty7n5QdIcxCGRX/1CWqpv6M0rm1QbrcgXYnrjk3gjcN6YoMsU2fBfAalDthexH9G1Jw43MkYTyMcsv/+wjN6LlDKS5qrbxb+6BCql5GTlNTKgW4qvuIIvTjd3WSEh5Q5DZOK9Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs+qGvn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740061794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KVhFVLcrq0MwE18FSmJzB1oSZy7QOKz+o8BK19VMfs=;
	b=Zs+qGvn+NhoWd9rQaRbZGGv7wO17NNy8Dp7u1+WRgAB2OKgQTa/yskASNtac2TqpQi6rhC
	XuucuI5+hUhgu4HBWhE/IShxtvajzSMDekLbDtQVIP313zX1kdgolQEZC96VWr0q8cBXPZ
	9KWPnWqNk12ca8CPvZtXGPSdiAyfSWY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-KrtYqZbtNOCBhzpFkT8-Zw-1; Thu,
 20 Feb 2025 09:29:50 -0500
X-MC-Unique: KrtYqZbtNOCBhzpFkT8-Zw-1
X-Mimecast-MFC-AGG-ID: KrtYqZbtNOCBhzpFkT8-Zw_1740061788
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB85418EAB38;
	Thu, 20 Feb 2025 14:29:47 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.137])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D36F6180034D;
	Thu, 20 Feb 2025 14:29:40 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 20 Feb 2025 15:28:50 +0100
Subject: [PATCH RFC v3 1/4] virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-virtio-shm-page-size-v3-1-874fff6f3979@redhat.com>
References: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com>
In-Reply-To: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=slp@redhat.com;
 h=from:subject:message-id; bh=mRGswsKourNVCaSODc/n1NTXWr1ln5mIzOK1iDX0YHA=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBntzxIzEoUz1g/wFC1Q//VY+sr+FsTO/3gBLlvw
 mXnRMzGG4uJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ7c8SAAKCRD0aSeNLwwC
 NRqbD/98huBq6YTHgxq5tCDQvIMcqutP4qaM+w6y1tAob3ydraZ9dy5yqOmZ2V3+drotoHacQkC
 S3UMniJUIvIU8Ijjw0EI7epz9N/rkIasoaD88Sbl8juhA9aLgeqbVBgcyEYJIkXf0q8s7kqwM6m
 JzT6KY57u2bpq2fBbsWqrM1/FrUpjQdi1K16rSyXnSVueo5H2Uw+iyfqDZIJsgqQHAXTY6RFJfz
 Cj0e+BrwN6P4YpMU7yi0wHkh6SmSi8jyIpGVECy5NEG9niFDzzQIiOFQXFEhuhmILkgJNxcGvcD
 19NLzb2cNe/7G9se9oxCHPwhbUDHAtFi0KoE/UqCal/8eZI0U3/trln3eyJZpj7da+WcN6ThCfr
 s5+Ok836EHG4u/304mNIzl3pd4EFklnDfSOo5DM+8VekfpvpnmR3/ybesvecPZoKPeIcYFQ9AWK
 StBRYfyT5WbJ4vqfBTFn84GXpJC8fwnVSTAdDdPW0ftK5023Ej1mHDhR6dXC9jzYtOh+Y+Vy/De
 OCz785D5nYo9eb0WV+tdT7Gsu/GK88WWq7bBUgaaUiqnA558t5CoL9exeAmfB7Ml+je7FfgpKSV
 bdzX0+gNSsakWSyOVyTczYMB+SLy8276s7WdFhH8vKrK5Ss6dV/ytk0pdvAA9kiMRQkGyaYK7DY
 dpya/prwpPWTggQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Introduce VIRTIO_F_SHM_PAGE_SIZE, a feature bit which indicates that the
transport provides the page size for SHM regions.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 +++
 drivers/virtio/virtio_ring.c       | 2 ++
 include/uapi/linux/virtio_config.h | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5eaade7578606e4b02af0d66447417ad6aa11064..104ba08f82d4a6268240bbad15385dd44b3a71d6 100644
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


