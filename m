Return-Path: <linux-kernel+bounces-523919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B68A3DCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87354421F77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20A1FCF57;
	Thu, 20 Feb 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3xYSpMu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293FA29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061819; cv=none; b=k2upT0akivHTIx/d66soo2y0tcvZfaFIS9wjl065j1ySFDxONZ6QNHJpfvtoRQrA2LuHGgtZw7X48ji7u64cWILSI3+koXaRdicgf3LuanuR7sj2iiglsBXxhga8DNW3pV7mOrlq9+z8AoTW7xRjt5bmKWIezYjjDt7vbzC7CTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061819; c=relaxed/simple;
	bh=1G3lJhhDiOBTd6Kzg5KWNjN2JJNHOjrLtLCcFndtJo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNY4kzc4xr5nUNuPxg9WV5kcsJ5Ta0v63RbDHWdfvFU+C9QJjW+LcXgojzAVTM0k0RcfNtI33Ud4efXC7c9aDMzriG0duzM33/2bt/XWgauLHMC2MTomQx/IsBTsza4ogjDF9mcIVC+rfyiGzKOIKiAVf+vgO5yA3n29teBeajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3xYSpMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740061816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqVSD1LpLSPpPVhZMn461AKEdfZbFpotrJ5hf1JYSzo=;
	b=d3xYSpMuhktfjPPjbjLFgH20sSovwQqic+bcQH/86l7anJrYFqZePnRsK+HpD5wnetHp/R
	xfAy6goRM1zLIUWBY58NIR6HYSgrhHwf4MbU9Rn/itquj+HADVC3/MWXRuu/1VwOuVNKpt
	oAWV0nnyOX4q1l2SpcfiSlgfaiPiAqQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-uf0q_LRMPpG2LoSXgm1CEw-1; Thu,
 20 Feb 2025 09:30:11 -0500
X-MC-Unique: uf0q_LRMPpG2LoSXgm1CEw-1
X-Mimecast-MFC-AGG-ID: uf0q_LRMPpG2LoSXgm1CEw_1740061809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 992AA19039CA;
	Thu, 20 Feb 2025 14:30:09 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.137])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 459031800352;
	Thu, 20 Feb 2025 14:30:03 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 20 Feb 2025 15:28:53 +0100
Subject: [PATCH RFC v3 4/4] drm/virtio: add
 VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-virtio-shm-page-size-v3-4-874fff6f3979@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=slp@redhat.com;
 h=from:subject:message-id; bh=1G3lJhhDiOBTd6Kzg5KWNjN2JJNHOjrLtLCcFndtJo4=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBntzxLxj0atYWb4t3RuFehUqiLushP15onRAQtv
 nBUBU43ivSJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ7c8SwAKCRD0aSeNLwwC
 NU5qD/4oOqN1KMjglbDjdDrCwRwOD9glVvH68wKnXtAWqHnRXuqRYAWeT2VjvkfWBp2+p3snYYu
 WOpjRh4K3/URic2NuHskA+s2Ycl9sGd4YJCEA1U3CWaSuhL7MO3cRark+9Sx/I1tWLLxFQOOf7H
 MI4n3+O2HX0D0mpUuWxvjK/NZobF2sX0xYbrE5NmNnCxxCCjFosxvvJJAqK/8/7OHJOi86kIl18
 qQ5Nu3YhgywDCtFO/SDrARIM/pE5PA3kPYvwg56KkbuBs2L1cT1AcdbU4VwcYMuoUaxkd9cU42P
 A+ep7SleWjhOEIxmkoic4Ug8kiMXGyaG8j02Jp19BYGnTr3154A5DipKBjqfJfsUFOIHochyiU6
 T/fR6JFZcAIqxcR2qjVNegcRC15ZhOq6sNEcf54Hp9hF9GAQ+3W1lzZDw4ipuXL1DMoxdxQGpR0
 PMAt642wB1uVlopZe16qHKrTsfae+8aldacy5IoSy9k/i/gBCvRiTfTQQoryVr/9vO/v0505Q55
 INTFR6Al5hD5+NMqLqfF4Tr9TMi4WKVbqF2ACwRG6a+BrCz5G4zE/tjasmmj/c/AmeimhenAiYI
 yfuA27v0NuaeRSYqNB6IfHZhb6dHMrp+O17fC1kfe5gou9mvTmscIo0sSe9d5sgCkwPay1HyW23
 VkqlvlQWCYSgB0g==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index c33c057365f85a2ace536f91655c903036827312..f112b862c2de4d021fb6a54a080f42ad75034227 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
+	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
+		if (!vgdev->has_host_visible)
+			return -ENOENT;
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


