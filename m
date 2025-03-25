Return-Path: <linux-kernel+bounces-575857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E5A70819
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA72B16301B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EC263F4A;
	Tue, 25 Mar 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9gkdwSn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98C263F28
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923470; cv=none; b=odh2SwxD8NzbR77KuHGJhKo3ks9WDyu0uJ3gqX63aHT4X0ZE//IIERCSKbrUYP0MzZ7RqqOcXvx7ZKclEDZcNlkFd2tnLzT8Jf3HXg/0HRmQJWEc6UvgJofj2gakzttzx8rfd67FY5gcJsXI98ZKF0FgRUf9kGG4hGb2M7oRzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923470; c=relaxed/simple;
	bh=o1HBRTXPRYeNBONIQ0BqdgsBaxnckRANpHzMdm/MMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5rPgwyeJx5WbdqwkfvQ3xxet2SzQCO2l/nxQ2PphIMyaSbvqIUUJWKb8M7Kr4i//MsXSTCdZitPl9l2f3Nivviwo2xry5aieMwKddHVksbPEbs+MP16Xa1kS82xB8vaxMkecfn0A28ZdaBqtdNPwA+JR0L9I9Wfic+Q+OYeFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9gkdwSn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HM/1y6ZZeRJGjWVbHgb0Aft5utZNcOq6uww/UkYs2ek=;
	b=Q9gkdwSnnOzxS2QBl4eYPK3+QHQXHyXcbgifCK67Q+eRyHXTya9UuTWOWLDdjTaKxnpGIp
	EzQLjU1XSNmzgDNNrIonOI2cG6nZ01CqftDnkSAVaaSpr/s2kQQAAzX4cXv1m8gvRz2dzi
	Rdyv1NbXDjAkorehrPnDKaSArvLYLsI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-a4ROO-LjNqOUSyNnH8qz_A-1; Tue,
 25 Mar 2025 13:24:23 -0400
X-MC-Unique: a4ROO-LjNqOUSyNnH8qz_A-1
X-Mimecast-MFC-AGG-ID: a4ROO-LjNqOUSyNnH8qz_A_1742923460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8C4C1801A1A;
	Tue, 25 Mar 2025 17:24:19 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D110180A802;
	Tue, 25 Mar 2025 17:24:17 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Mar 2025 13:24:09 -0400
Subject: [PATCH 2/5] drm/panel: Add refcount support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923451; l=4503;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=o1HBRTXPRYeNBONIQ0BqdgsBaxnckRANpHzMdm/MMqE=;
 b=Q3umjhdtJGevsBGv7rPrxhnI2ilHCb+QrrSaBzUDG7PFCFLD8o58H3yX9agZ7tMGHfUtrjOpD
 tdzZiJ7yPCyATV1qa0oH6ah4DnKC5gsMn8uGoKp2PgD//gYsiqa4/UX
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Allocate panel via reference counting.
Add _get() and _put() helper functions
to ensure panel allocations are refcounted.
Avoid use after free by ensuring panel is
valid and can be usable till the last reference
is put. This avoids use-after-free

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_panel.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_panel.h     | 19 ++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index bdeab5710ee324dc1742fbc77582250960556308..079c3c666a2ddc99a0051d1a3c9ba65d986dd003 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -355,24 +355,87 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 }
 EXPORT_SYMBOL(of_drm_find_panel);
 
+static void __drm_panel_free(struct kref *kref)
+{
+	struct drm_panel *panel = container_of(kref, struct drm_panel, refcount);
+
+	kfree(panel->container);
+}
+
+/**
+ * drm_panel_get - Acquire a panel reference
+ * @panel: DRM panel
+ *
+ * This function increments the panel's refcount.
+ *
+ */
+struct drm_panel *drm_panel_get(struct drm_panel *panel)
+{
+	if (!panel)
+		return panel;
+
+	kref_get(&panel->refcount);
+
+	return panel;
+}
+
+/**
+ * drm_panel_put - Release a panel reference
+ * @panel: DRM panel
+ *
+ * This function decrements the panel's reference count and frees the
+ * object if the reference count drops to zero.
+ */
+struct drm_panel *drm_panel_put(struct drm_panel *panel)
+{
+	if (!panel)
+		return panel;
+
+	kref_put(&panel->refcount, __drm_panel_free);
+
+	return panel;
+}
+
+/**
+ * drm_bridge_put_void - wrapper to drm_bridge_put() taking a void pointer
+ *
+ * @data: pointer to @struct drm_bridge, cast to a void pointer
+ *
+ * Wrapper of drm_bridge_put() to be used when a function taking a void
+ * pointer is needed, for example as a devm action.
+ */
+static void drm_panel_put_void(void *data)
+{
+	struct drm_panel *panel = (struct drm_panel *)data;
+
+	drm_panel_put(panel);
+}
+
 void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
 			     const struct drm_panel_funcs *funcs,
 			     int connector_type)
 {
 	void *container;
 	struct drm_panel *panel;
+	int err;
 
 	if (!funcs) {
 		dev_warn(dev, "Missing funcs pointer\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	container = devm_kzalloc(dev, size, GFP_KERNEL);
+	container = kzalloc(size, GFP_KERNEL);
 	if (!container)
 		return ERR_PTR(-ENOMEM);
 
 	panel = container + offset;
+	panel->container = container;
 	panel->funcs = funcs;
+	kref_init(&panel->refcount);
+
+	err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
+	if (err)
+		return ERR_PTR(err);
 
 	drm_panel_init(panel, dev, funcs, connector_type);
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 63fb1dbe15a0556e7484bc18737a6b1f4c208b0c..af81d596f385567a12cf9e08dff9443ce4d97ec0 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -267,6 +267,17 @@ struct drm_panel {
 	 * If true then the panel has been enabled.
 	 */
 	bool enabled;
+
+	/**
+	 * @container: Pointer to the private driver struct embedding this
+	 * @struct drm_panel.
+	 */
+	void *container;
+
+	/**
+	 * @refcount: reference count of users referencing this bridge.
+	 */
+	struct kref refcount;
 };
 
 void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
@@ -280,7 +291,10 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
  * @member: the name of the &drm_panel within @type
  * @funcs: callbacks for this panel
  * @connector_type: connector type of the driver
- * The returned refcount is initialised to 1
+ *
+ * The returned refcount is initialised to 1. This  reference will
+ * be automatically dropped via devm (by calling
+ * drm_bridge_put()) when @dev is removed.
  *
  * Returns:
  * Pointer to new panel, or ERR_PTR on failure.
@@ -294,6 +308,9 @@ void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs,
 		    int connector_type);
 
+struct drm_panel *drm_panel_get(struct drm_panel *panel);
+struct drm_panel *drm_panel_put(struct drm_panel *panel);
+
 void drm_panel_add(struct drm_panel *panel);
 void drm_panel_remove(struct drm_panel *panel);
 

-- 
2.48.1


