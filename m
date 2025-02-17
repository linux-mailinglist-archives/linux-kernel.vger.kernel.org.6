Return-Path: <linux-kernel+bounces-513296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07425A34896
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDA1621FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB0159596;
	Thu, 13 Feb 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmaAZsf3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84011EEA36
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461854; cv=none; b=NqIZyN7w8rYqz6WFejNr3qY4rR46GWuXCVFgS8gEGVbKbq8wBxrVI6FUNuG7/FuHLj7PHBqv/QRBMf6blSRo/8Mj6PODeY4oD/kFzZ+qnJDkVJfqV4vxUBlTFjJNiyRPwPFU6B8On0+buIhU6pzGYcF523LEjxxjcTrYPksR/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461854; c=relaxed/simple;
	bh=4BHYqTf3/QJ4WE/gAmQswAKbmL+cD4+SAvyJx3zmY/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cw5PUegR3cJMnO4hSHBrvZbxs2noPqbDYRj27AP+Le4WmRnLnlFC2TNZzscFdfJhtbih/h7WU6E/YhsfbSMB9aA/K0E71hRgCocayl0hhtRqs5Z8P6KnYsl4BvCPkGPzxOy2GELSGVA5vPzZ0j6CCf/bd1kyl3IGXExR2CnxfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmaAZsf3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPDMwS7WtZbaodmU1wGmDq5U/O9YW9budAUbZ3K875k=;
	b=ZmaAZsf3BnyjX42m2BiOBWXd5n4PHSky2DcFBpDSIdEenv6mQ/Je5qiExONI596iVnmXtX
	1HSTo8vsWcypGBOHemI3vOOvcHwmhAyYsR8s2xlfIi1kh/7YiJ/lt/mJ7l0SMK/sGJMDCM
	vxpqWtn5WKZrJZWmk0U+UdoAYtXiUI8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_FzdwdRkNT2W6LkuU2I1vA-1; Thu,
 13 Feb 2025 10:50:47 -0500
X-MC-Unique: _FzdwdRkNT2W6LkuU2I1vA-1
X-Mimecast-MFC-AGG-ID: _FzdwdRkNT2W6LkuU2I1vA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41D03180087A;
	Thu, 13 Feb 2025 15:50:45 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 399FD1800365;
	Thu, 13 Feb 2025 15:50:38 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 13 Feb 2025 16:49:18 +0100
Subject: [PATCH RFC 4/5] virtio-mmio: read shm region page size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-virtio-shm-page-size-v1-4-5ee1f9984350@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=slp@redhat.com;
 h=from:subject:message-id; bh=4BHYqTf3/QJ4WE/gAmQswAKbmL+cD4+SAvyJx3zmY/M=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnrhSvDxI+WiTFN3JL/Qzuc2xiWNP3Mq2/qlssR
 XCntYrlp4eJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ64UrwAKCRD0aSeNLwwC
 NcgyEACLL8igsV/fv85sL628B2GV9AZjCunwvzxWR2iisluQIOSnZCHY+0QygQbUzoiTicAsuDm
 pc1Lt/w68Q2kicl2BPqt00LuLWEJW+dqD6KHg1QL8y81xwyr0o/9TJtcTGMTKpnVKCNUt78FELL
 3p57CcqBHqx1XnB4zA6g55eXVRCLgeFcDQTU+To18nWO/TGBA9tqZ7LGwUQ4xoS9QLnfLTdxKDw
 4uxV2jlWwcM7aF/b9ppSvaysZmSz7u9CRjE1Yj2a2+fuMuIJ0e23kh7Vswkq5XVYKfpRrxqt5S9
 K0BiVzJfXX8tnsw03vVv6O1BoNoLtpCmJF/5tk8XklLuLWl/TPX3vMhTgrPwVWfMHp4wDgyOe92
 ApmaolMa0EFOSkFnBKQChdy8mVndj199Lv6m5VVn84Os8FjryN5U56IxiK1d7BW3spvROFbDSDc
 JHZEDzzTlDwWvBdXaflKCl91v4TEbM/+DCClnJog/We9b7Lc2IjhZOogQByvtLYzuA7gJilev7/
 R4upFNDmmJyR/R0s5BCDFtsD84ksi+zIVGSAfAuWsGhMtH+FgX4QM4YYLwR7VzszydWHVWcraSZ
 wZpZscSrkW3Y58y80OkSFnAEmy1fROyRuNV2eFZJnQsfaWKvEQ7qIYoQgBhEq6K94FZBN13SQkB
 3SflZNBJcWr/tvQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use the newly introduced SHM_PAGE_SIZE register to read the page size
and store it into virtio_shm_region.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_mmio.c     | 13 ++++++++++++-
 include/uapi/linux/virtio_mmio.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index cd0a0407659517e6a318b117ba67258c59f1f983..92590c77901bee453d8c1a1ac60ad9cca90d1b59 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -537,6 +537,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 			      struct virtio_shm_region *region, u8 id)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u16 page_size = 0;
 	u64 len, addr;
 
 	/* Select the region we're interested in */
@@ -560,7 +561,17 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 
 	region->addr = addr;
 
-	region->page_size = 4096 >> 12;
+	/* If supported by the device transport, read the region page size */
+	if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE))
+		page_size = (u16) readl(vm_dev->base + VIRTIO_MMIO_SHM_PAGE_SIZE);
+
+	/* For backwards compatibility, if the device didn't specify a
+	 * page size, assume it to be 4096.
+	 */
+	if (page_size == 0)
+		page_size = 4096 >> 12;
+
+	region->page_size = page_size;
 
 	return true;
 }
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
index 0650f91bea6c70f935764070d825d181a2379afb..c5a1cdad5a1c9bc954d7facfd8c05e2acbb28e96 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -133,6 +133,9 @@
 #define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
 #define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
 
+/* Shared memory region page size, in format PAGE_SIZE >> 12 */
+#define VIRTIO_MMIO_SHM_PAGE_SIZE       0x0c4
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
 

-- 
2.48.1


