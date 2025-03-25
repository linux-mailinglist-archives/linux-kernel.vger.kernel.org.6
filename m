Return-Path: <linux-kernel+bounces-575855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8AA70815
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14CA7A6419
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2326280C;
	Tue, 25 Mar 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS3lxu+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48A2627E2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923465; cv=none; b=fDgyIEIDqh9vb5F0SClBg+BewMVyczRXVbMwIWU8E3V8vz7O732wi8/cgd8QmogDPDbygVrUghtRx3BiWkxHezJvdqIb61q26Y3mpA5qRU0P/Quqh+vwiF8KIuNxw1YhNGltaDunZl9TIPmN6GCOeR0OBGsIDw3CAqfZIKo90LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923465; c=relaxed/simple;
	bh=3plMta6SV34gCg4hxGEvoJNswR4Pewdmgy+AquhfFao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iyr6eKV7uHr9WRC9o2G8yR4xOPPccoVOHpe9qhrfmujy3y/cIer5hcMn7iQyjKzTyiQIyrP4LPmjUlnoHG2kjIW+XJEyEq4bkUkCLjy7J3emYz5tR39uIQWO0UkAGibFtDa9jIE4BM5+WjR4COUu/EMXNf5dpvXUb1qY2YYEdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS3lxu+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNj7p5akUefe7MFBWckCoaFQF271l+ai2Y2L65F/Zmc=;
	b=fS3lxu+X313hFxYT5CMxbfNDB31HAtjyP2l7SAGLhqrfJdeDfOS0GpkNT0gLCZc8+Sa5Ec
	1aU8GmPek4k0pss6P7HTNU12ofQiP7jjGCh0tedRzmoM6mBHgVCjoypo+76JF5f6CFSNHl
	qSxlFXVhyEtXBJuy9TISDinUHPgwAPc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-grCqgMQoOu2ZzMY0LBGFBQ-1; Tue,
 25 Mar 2025 13:24:18 -0400
X-MC-Unique: grCqgMQoOu2ZzMY0LBGFBQ-1
X-Mimecast-MFC-AGG-ID: grCqgMQoOu2ZzMY0LBGFBQ_1742923457
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E643D1800349;
	Tue, 25 Mar 2025 17:24:16 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F5A8180A802;
	Tue, 25 Mar 2025 17:24:14 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Mar 2025 13:24:08 -0400
Subject: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
In-Reply-To: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923451; l=3050;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=3plMta6SV34gCg4hxGEvoJNswR4Pewdmgy+AquhfFao=;
 b=RVT7sUNo4JPMqKU6K5afiHqH7PBvn4MhyjHxxQmylyRSMFd6+UjKc8PahHJ9bt/RFquerpaRe
 qrM7mB/qsugBI4ryqA3QVzTcHRQWw9iswNNcY1EbPkd0viPqOEEgedB
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce reference counted allocations for panels to avoid
use-after-free. The patch adds the macro devm_drm_bridge_alloc()
to allocate a new refcounted panel. Followed the documentation for
drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
implementations for this purpose.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_panel.c | 25 +++++++++++++++++++++++++
 include/drm/drm_panel.h     | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c627e42a7ce70459f50eb5095fffc806ca45dabf..bdeab5710ee324dc1742fbc77582250960556308 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -355,6 +355,31 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 }
 EXPORT_SYMBOL(of_drm_find_panel);
 
+void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
+			     const struct drm_panel_funcs *funcs,
+			     int connector_type)
+{
+	void *container;
+	struct drm_panel *panel;
+
+	if (!funcs) {
+		dev_warn(dev, "Missing funcs pointer\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	container = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-ENOMEM);
+
+	panel = container + offset;
+	panel->funcs = funcs;
+
+	drm_panel_init(panel, dev, funcs, connector_type);
+
+	return container;
+}
+EXPORT_SYMBOL(__devm_drm_panel_alloc);
+
 /**
  * of_drm_get_panel_orientation - look up the orientation of the panel through
  * the "rotation" binding from a device tree node
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index a9c042c8dea1a82ef979c7a68204e0b55483fc28..63fb1dbe15a0556e7484bc18737a6b1f4c208b0c 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/kref.h>
 
 struct backlight_device;
 struct dentry;
@@ -268,6 +269,27 @@ struct drm_panel {
 	bool enabled;
 };
 
+void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
+			     const struct drm_panel_funcs *funcs,
+			     int connector_type);
+
+/**
+ * devm_drm_panel_alloc - Allocate and initialize an refcounted panel
+ * @dev: struct device of the panel device
+ * @type: the type of the struct which contains struct &drm_panel
+ * @member: the name of the &drm_panel within @type
+ * @funcs: callbacks for this panel
+ * @connector_type: connector type of the driver
+ * The returned refcount is initialised to 1
+ *
+ * Returns:
+ * Pointer to new panel, or ERR_PTR on failure.
+ */
+#define devm_drm_panel_alloc(dev, type, member, funcs, connector_type) \
+	((type *)__devm_drm_panel_alloc(dev, sizeof(type), \
+					offsetof(type, member), funcs, \
+					connector_type))
+
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs,
 		    int connector_type);

-- 
2.48.1


