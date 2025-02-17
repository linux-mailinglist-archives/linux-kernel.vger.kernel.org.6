Return-Path: <linux-kernel+bounces-513297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B37A34890
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF534188F9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B1EEA36;
	Thu, 13 Feb 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grc/TklO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A31E3DED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461861; cv=none; b=lnNJ34VJedStMSo8QLqmD4oYmuxYZiB/JZGdAwHnGH92OwSGZAAdtPzAdXtDRvM9WTwCnmElRYga8sy7vZUj0wxOKDGTszN3InVvjQa2LAcVEiZeMHE9s727PSfUxVunWqf/GkhfaDpKeDpHYxE1/8zSInNmcvJPKIhzUwXFRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461861; c=relaxed/simple;
	bh=/aoLSKIJznnbsjZ5Jh4GqZ88soBWly62WzaVs9lwiik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXm+ZAjqFxIeKdKOryA/7ZL1Q6mGO8RzBBp4Yao/r0epAIo5Gh+ySJd9YMnskW4STKmKVnGSaVVcP9j4/Angjl48MPJk4Jex5swFRNtZtYAz9A7f0v03Y1ptr5I887zIo/cYoEm68D10Bi3Oj8FinfSGA4/YlPFibi+fd07N8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grc/TklO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjmfsPFlVVF5AWgzzAtVJttyvI0k7JVXMhFtVMQApJc=;
	b=Grc/TklOlm7jeIK20gL4KiSrCYRar2vLZrxgAM6Lioz8lfzGFZH4V23Dk3diyKDydowSsf
	jBJe8GfrR+ah2l0YTidtGabe4+qqp5tc/y8jom6MOGJ2d2Nw/Ud501mFIlSZntLLA6bUfU
	BAHM7MPBDp+87I37NxqJ31VKXj1/7Tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-fWiTjEI6PDuewe8qZoXD2A-1; Thu,
 13 Feb 2025 10:50:54 -0500
X-MC-Unique: fWiTjEI6PDuewe8qZoXD2A-1
X-Mimecast-MFC-AGG-ID: fWiTjEI6PDuewe8qZoXD2A_1739461852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC8641800873;
	Thu, 13 Feb 2025 15:50:51 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 005321800360;
	Thu, 13 Feb 2025 15:50:45 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 13 Feb 2025 16:49:19 +0100
Subject: [PATCH RFC 5/5] drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE
 to params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-virtio-shm-page-size-v1-5-5ee1f9984350@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=slp@redhat.com;
 h=from:subject:message-id; bh=/aoLSKIJznnbsjZ5Jh4GqZ88soBWly62WzaVs9lwiik=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnrhSwhjgi2huewIbD11jfJzeBM0pBvdx+QXdjZ
 3DYvQQ1INGJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ64UsAAKCRD0aSeNLwwC
 NYbtD/9ctHlsRxX0qc3/D6Bh638ZBZMa+fSdL8lFea6UYOw7mU4npndqsYsJPx/wr7U7n83Vaxr
 tUcKqrDkgaw8ya+Vm/2cD1JWs4+37Bf1qUBHArqwpTPzeNuBPJk4Z624Bma7rYalRNE9BHYmttg
 ImMXqognhOLVo3GvnG5GKufzxW6Q56ta8LMoQi3/otB0Lp4bwE/tevyOgBJRInuGjoj1MmKTNR8
 pcEbm65Nhdy1yhGxL1iJKVJCBaofqq2g1oNS8uq/mSaT9onuqhHdr3COGV9tlM5LoTJXN/kuNnk
 nChP1pIDBub/qUL495/Jxj90CDmmCxth/VET+s8B49dpCFNGj3SNzcVwjqj4bikjlObwuPv8NXA
 0FBpGgpFLq3OdCDvd6e3TlrZMZ9MZp1U923btfwXJ7m65WU9MqRf67O4q2Vdw3/bzU1b6hUMR2x
 fULusPSIv6m+k7thSDqtWNrwAFSRQ3x4mrBCJDX2KryPkldQ3Qtj4NZOlnVCYAT+fL/XB7yfY5o
 c8YEStKGghk9W8RXB+Wfcvz2+uA9yPrpx3lZc6kG4W7YwSfciZm4c1upgMPktnF+HT68I65/Ksu
 fcvqVqY/pWDtFQgTriHjX6Xwbu3Uz+sAUwRcmODokFmPENr6xR4zb+qq8y8HB+1OVBvazTtTTej
 b1Xw9a5umUDKO/A==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE as a param that can be read with
VIRTGPU_GETPARAM by userspace applications running in the guest to
obtain the host's page size and find out the right alignment to be used
in shared memory allocations.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c33c057365f85a2ace536f91655c903036827312..4b49635b4fe1d4256f219823341cef8e5fa8f029 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
+	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
+		if (!vgdev->has_host_visible)
+			return -EINVAL;
+		value = vgdev->host_visible_region.page_size;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index c2ce71987e9bb816d13a300679336cb756f1cbcf..72db6b3339e0dcaf550acbf5ac4381a6e5c2216d 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -98,6 +98,7 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
+#define VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE 9 /* Host SHM page size, with format PAGE_SIZE >> 12 */
 
 struct drm_virtgpu_getparam {
 	__u64 param;

-- 
2.48.1


