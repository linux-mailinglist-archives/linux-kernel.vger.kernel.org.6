Return-Path: <linux-kernel+bounces-425772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98B9DEAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E7D163E30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016B149E17;
	Fri, 29 Nov 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKELbSkc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640681B95B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897386; cv=none; b=NBFLFeyiJ+5CnaqkeXH0dgJ6MIViwdxSHZd2xODmY7uLiMTcnYXf/mcTb+sic4wXG3BJssl7Ox6ItbTFvIYxEJiJMdpKiG04xDH6A81PXbAFj0b1GIRvrP43OgY7pSMEHaYslEqgh1/j8OkNq8PHIAlnxi6axcXjdcYFPevoTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897386; c=relaxed/simple;
	bh=zzLfsOZGNd/bGy0NzCKpAp6U4D+u26d3cpbqhqEL30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1BaBxzJrWB6cLxzW+QW2E7eROChbu2CauEyTHxWtRTVjL9FyPTTeRBQhnuYjaAArqBeUoOwy5awcWqt5DJEM7imeh2ii/ou2WrOxM1pFdkrRzNQfLeCb2lZrrNVMd7RqpFhiHCPz8mTESktBGvZEWEJOAA+PhPD517rPysJcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKELbSkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rErA3iZ6143HQltGFMlYu6o31C59/zsAsAqnyNO9lis=;
	b=QKELbSkcI7EKz/ZnjgiJfDAYQ5hMLNsbjWPG9TNqNXOnnuteps8GPONLMdV2VhWvsXbPKZ
	iCKQv5C6GXI6cGZO6D5BTSBcgujRQzW9n8zzf158QN0pQvWVBUWyozUlC5Wu2o4I/Q2vXJ
	jAl6sAckxx2f9Da0TgxALhipU9+UVTA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-8mlKJ0ziMCqNw6mcRe47Fw-1; Fri,
 29 Nov 2024 11:22:58 -0500
X-MC-Unique: 8mlKJ0ziMCqNw6mcRe47Fw-1
X-Mimecast-MFC-AGG-ID: 8mlKJ0ziMCqNw6mcRe47Fw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C20D1936CCB;
	Fri, 29 Nov 2024 16:22:54 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4DEC1955F2F;
	Fri, 29 Nov 2024 16:22:50 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH 1/5] drm/i915/fbdev: Add intel_fbdev_getvaddr()
Date: Fri, 29 Nov 2024 17:20:26 +0100
Message-ID: <20241129162232.7594-2-jfalempe@redhat.com>
In-Reply-To: <20241129162232.7594-1-jfalempe@redhat.com>
References: <20241129162232.7594-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vaddr of the fbdev framebuffer is private to the struct
intel_fbdev, so this function is needed to access it for drm_panic.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_fbdev.c | 5 +++++
 drivers/gpu/drm/i915/display/intel_fbdev.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 00852ff5b2470..9f4acc2d75601 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -695,3 +695,8 @@ struct intel_framebuffer *intel_fbdev_framebuffer(struct intel_fbdev *fbdev)
 
 	return to_intel_framebuffer(fbdev->helper.fb);
 }
+
+void *intel_fbdev_getvaddr(struct intel_fbdev *fbdev)
+{
+	return READ_ONCE(fbdev->vma->iomap);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.h b/drivers/gpu/drm/i915/display/intel_fbdev.h
index 08de2d5b34338..014fa5896af52 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.h
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.h
@@ -17,6 +17,7 @@ struct intel_framebuffer;
 void intel_fbdev_setup(struct drm_i915_private *dev_priv);
 void intel_fbdev_set_suspend(struct drm_device *dev, int state, bool synchronous);
 struct intel_framebuffer *intel_fbdev_framebuffer(struct intel_fbdev *fbdev);
+void *intel_fbdev_getvaddr(struct intel_fbdev *fbdev);
 #else
 static inline void intel_fbdev_setup(struct drm_i915_private *dev_priv)
 {
@@ -30,6 +31,10 @@ static inline struct intel_framebuffer *intel_fbdev_framebuffer(struct intel_fbd
 {
 	return NULL;
 }
+static inline void *intel_fbdev_getvaddr(struct intel_fbdev *fbdev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __INTEL_FBDEV_H__ */
-- 
2.47.0


