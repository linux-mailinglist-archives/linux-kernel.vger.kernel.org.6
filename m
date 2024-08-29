Return-Path: <linux-kernel+bounces-307277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52140964B36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A4B259F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B251B4C52;
	Thu, 29 Aug 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHDrqXUl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD141B4C45
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948012; cv=none; b=cSvC2v1jMFd/MvgP7iGMHTpSPsE18ptEtGqwyaBFgO1/UaQwy+7He48pubkg9ncqa7BlkaHrwkKot5za1DZJFgE9o9PKkwJ3xrXYpoJW6dRZcqsan3LzVxbYeWgNMUzMneFRdNJvlKo7G8UzkMaZxGcLAcM4TdlitvHTTF9P2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948012; c=relaxed/simple;
	bh=xPTFMuxVtPpAym4xaSVVqwn/CComwPllriz2X4FnyM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tddLYwzFu3yDzsCF8hqhK+rvoVwiDD7jKcJlF2uekMgqUL8eGVZSaIMEXogoiv7w8SVRVYL/tDfAWxpGSzLrA56NpWaWhcdKJ4UWFIqT1KO/ZTFbeCEyTtFLsZ9yma7/ezAk8Xh70iB6g/lBGi1+EvTtUyP3ft6wdqAAJsmn0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHDrqXUl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724948010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+u00/1FYth14WBO1XmelUDfBU9Sqo7la7JVqYZPhE8=;
	b=BHDrqXUl4Rj90zu51G1Cj/wX6+CZXedHjWq644hVH04QlN0vTdJZSJ3i8j+SxBnRkq/RB+
	mwB1F0es88aNT1ZPXRFBgkVUoNZ5NexlaaXvf5MIz1ZYMsRtRvuFfYzJHr8zRtYGGkN0wJ
	as29zFskUGbaSL8c/jVejZWMHtu5DC8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-5vDtc5hMOcu9_lv2cUSCaw-1; Thu,
 29 Aug 2024 12:13:26 -0400
X-MC-Unique: 5vDtc5hMOcu9_lv2cUSCaw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A803B1955D45;
	Thu, 29 Aug 2024 16:13:24 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8539C19560AA;
	Thu, 29 Aug 2024 16:13:20 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	treding@nvidia.com,
	vbhadram@nvidia.com,
	jonathanh@nvidia.com,
	mperttunen@nvidia.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	alex.williamson@redhat.com,
	clg@redhat.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: msalter@redhat.com
Subject: [RFC PATCH 3/5] vfio_platform: reset: Introduce new open and close callbacks
Date: Thu, 29 Aug 2024 18:11:07 +0200
Message-ID: <20240829161302.607928-4-eric.auger@redhat.com>
In-Reply-To: <20240829161302.607928-1-eric.auger@redhat.com>
References: <20240829161302.607928-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Some devices may require resources such as clocks and resets
which cannot be handled in the vfio_platform agnostic code. Let's
add 2 new callbacks to handle those resources. Those new callbacks
are optional, as opposed to the reset callback. In case they are
implemented, both need to be.

They are not implemented by the existing reset modules.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/platform/vfio_platform_common.c  | 28 ++++++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h |  6 ++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 3be08e58365b..2174e402dc70 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -228,6 +228,23 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
 	return -EINVAL;
 }
 
+static void vfio_platform_reset_module_close(struct vfio_platform_device *vpdev)
+{
+	if (VFIO_PLATFORM_IS_ACPI(vpdev))
+		return;
+	if (vpdev->reset_ops && vpdev->reset_ops->close)
+		vpdev->reset_ops->close(vpdev);
+}
+
+static int vfio_platform_reset_module_open(struct vfio_platform_device *vpdev)
+{
+	if (VFIO_PLATFORM_IS_ACPI(vpdev))
+		return 0;
+	if (vpdev->reset_ops && vpdev->reset_ops->open)
+		return vpdev->reset_ops->open(vpdev);
+	return 0;
+}
+
 void vfio_platform_close_device(struct vfio_device *core_vdev)
 {
 	struct vfio_platform_device *vdev =
@@ -242,6 +259,7 @@ void vfio_platform_close_device(struct vfio_device *core_vdev)
 			"reset driver is required and reset call failed in release (%d) %s\n",
 			ret, extra_dbg ? extra_dbg : "");
 	}
+	vfio_platform_reset_module_close(vdev);
 	pm_runtime_put(vdev->device);
 	vfio_platform_regions_cleanup(vdev);
 	vfio_platform_irq_cleanup(vdev);
@@ -265,7 +283,13 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
 
 	ret = pm_runtime_get_sync(vdev->device);
 	if (ret < 0)
-		goto err_rst;
+		goto err_rst_open;
+
+	ret = vfio_platform_reset_module_open(vdev);
+	if (ret) {
+		dev_info(vdev->device, "reset module load failed (%d)\n", ret);
+		goto err_rst_open;
+	}
 
 	ret = vfio_platform_call_reset(vdev, &extra_dbg);
 	if (ret && vdev->reset_required) {
@@ -278,6 +302,8 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
 	return 0;
 
 err_rst:
+	vfio_platform_reset_module_close(vdev);
+err_rst_open:
 	pm_runtime_put(vdev->device);
 	vfio_platform_irq_cleanup(vdev);
 err_irq:
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 90c99d2e70f4..528b01c56de6 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -74,9 +74,13 @@ struct vfio_platform_device {
  * struct vfio_platform_reset_ops - reset ops
  *
  * @reset:	reset function (required)
+ * @open:	Called when the first fd is opened for this device (optional)
+ * @close:	Called when the last fd is closed for this device (optional)
  */
 struct vfio_platform_reset_ops {
 	int (*reset)(struct vfio_platform_device *vdev);
+	int (*open)(struct vfio_platform_device *vdev);
+	void (*close)(struct vfio_platform_device *vdev);
 };
 
 
@@ -129,6 +133,8 @@ __vfio_platform_register_reset(&__ops ## _node)
 MODULE_ALIAS("vfio-reset:" compat);				\
 static int __init reset ## _module_init(void)			\
 {								\
+	if (!!ops.open ^ !!ops.close)				\
+		return -EINVAL;					\
 	vfio_platform_register_reset(compat, ops);		\
 	return 0;						\
 };								\
-- 
2.41.0


