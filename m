Return-Path: <linux-kernel+bounces-259942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3093A034
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776611C21C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8451514ED;
	Tue, 23 Jul 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlFucuhA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76C14F9E4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735376; cv=none; b=MsG4pMoX3mrv9iMzTzm0XfxJeu3llJMmqdPhdaSH2q+9ED7qF3p+hq7hPzwxg0GiJOe0ZUc6YexaNFZY4521FSNH5ucPs8SktHLWJDDM1GbrIsL8BIlOtI7MIDUH81md828PFohuekzxWRNon/e3JvcyIw9y8tdtWUuBcTK6lKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735376; c=relaxed/simple;
	bh=W20Y5jd8rcOGW4zRWp02ji5VTBe4Z4gZv26VOYRZ4aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9XXh+3sD+PH6cp1RK9rpEWpBU3pqpalSCA8LvnOgqy27y+fhOv+IQ9XUZQFTbEHK7IEGo31mvzYa2OsYh9O2qd3F3I+MPDdBegjCYHdfkYK4bphORE8Pe1Ox+hlehJZmlIsyTKgvu6ZBVBjZ+l4rruYqjdXDYVF6tLrjjODbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlFucuhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721735374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoZ4ac74sAxgJ25UnglgRusvIosH8Eh3J0j/ykgSWV4=;
	b=WlFucuhANg02QvhUdENdphLNrEJ3kJLU6zrNLnLVpWTL6tW6t5xY/YNvRHR0hKhZSUaVeZ
	xjDXiRNUCJIv8HfxlUvb6oaENfqlhqzLX+OZ9cH+07yJqfq3bVo580xwqDVwc9Hdv2qJuf
	1NBSLblSN0HRGtjLGh+Hs1Dcj9PEd/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-eKo4MkR6NYeQ-gBgfmquzw-1; Tue,
 23 Jul 2024 07:49:30 -0400
X-MC-Unique: eKo4MkR6NYeQ-gBgfmquzw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9170B195608A;
	Tue, 23 Jul 2024 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99D9E1955D4A;
	Tue, 23 Jul 2024 11:49:24 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: gurchetansingh@chromium.org,
	tzimmermann@suse.de,
	mripard@kernel.org,
	olvaffe@gmail.com,
	kraxel@redhat.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH 2/2] drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params
Date: Tue, 23 Jul 2024 07:49:14 -0400
Message-ID: <20240723114914.53677-3-slp@redhat.com>
In-Reply-To: <20240723114914.53677-1-slp@redhat.com>
References: <20240723114914.53677-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add VIRTGPU_PARAM_HOST_PAGE_SIZE as a param that can be read with
VIRTGPU_GETPARAM by userspace applications running in the guest to
obtain the host's page size and find out the right alignment to be used
in shared memory allocations.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..c16cdf2d64b4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
+	case VIRTGPU_PARAM_HOST_PAGE_SIZE:
+		if (!vgdev->has_host_page_size)
+			return -EINVAL;
+		value = vgdev->host_page_size;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index c2ce71987e9b..505f87263a15 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -98,6 +98,7 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
+#define VIRTGPU_PARAM_HOST_PAGE_SIZE 9 /* Host's page size */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
-- 
2.45.2


