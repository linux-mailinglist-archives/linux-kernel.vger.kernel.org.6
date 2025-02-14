Return-Path: <linux-kernel+bounces-514689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84FA35A50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E868F7A23F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10122229B2C;
	Fri, 14 Feb 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUSGK0Vi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D421CA1A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525210; cv=none; b=mzLNJ8wHpJDMVE6lPbA+1PxgUXqbI9CuI/WCm7m3QKaStDhFyC60hKJYU9bIpTMP1VNin1BznuX7Xqd9yIMm5S6XdwalRHSFemL26yz+zvSkd2ZXqrhNH9rthcYNliDmLBOn3py959UqChcqinsOtMQGAiUCpe84KihcZgKdUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525210; c=relaxed/simple;
	bh=7pdd5oxuurCob/RFmaKp0KZkEnXfk+3n7/jmARok0RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo5RHuGv1pk0yImHz4e3SMoYIt1uw2DQFfVPr+42PzE1JuM56x+/uT8Z7W70TNe8BVkVnVnCBKu+vyLiBuNGjDJrzodAuIOFs03ees5RZe0AkI6irCCtYZraMZKIoViWAgI2BWwYYGkS5chRGBtXzOVKgcaCteH7CASvnYkMzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUSGK0Vi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739525205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cljvOunHkcBa9woq0FiiQutQPylQmYDTVJOhtMnpXNw=;
	b=NUSGK0ViXud97zUe7XhkGsnrIrWtRljUT7gS7SNaIQeUIqmcPAQqxNgZ2Px121//n46rPV
	cXUqO6nlO4h5DdmC6d7hpTyy2CMs9IWs8jQ3VdD0YPBXU2HfQA8XSaB+oKkGBm4u0SHM4S
	j5P4sTHggFkI5r117/H+fpQRf8krvC4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-XukAi42oM1CMxtiSixwG_A-1; Fri,
 14 Feb 2025 04:26:40 -0500
X-MC-Unique: XukAi42oM1CMxtiSixwG_A-1
X-Mimecast-MFC-AGG-ID: XukAi42oM1CMxtiSixwG_A_1739525199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4718180087C;
	Fri, 14 Feb 2025 09:26:38 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 711A9180035E;
	Fri, 14 Feb 2025 09:26:35 +0000 (UTC)
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
Subject: [PATCH v5 4/8] drm/i915/gem: Add i915_gem_object_panic_map()
Date: Fri, 14 Feb 2025 10:21:39 +0100
Message-ID: <20250214092608.2555218-5-jfalempe@redhat.com>
In-Reply-To: <20250214092608.2555218-1-jfalempe@redhat.com>
References: <20250214092608.2555218-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Prepare the work for drm_panic support. This is used to map the
current framebuffer, so the CPU can overwrite it with the panic
message.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v5:
 * Use iosys_map for intel_bo_panic_map().

 drivers/gpu/drm/i915/display/intel_bo.c    |  5 ++++
 drivers/gpu/drm/i915/display/intel_bo.h    |  1 +
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_pages.c  | 29 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/intel_bo.c      | 10 ++++++++
 5 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bo.c b/drivers/gpu/drm/i915/display/intel_bo.c
index fbd16d7b58d95..ac904e9ec7d51 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.c
+++ b/drivers/gpu/drm/i915/display/intel_bo.c
@@ -57,3 +57,8 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	i915_debugfs_describe_obj(m, to_intel_bo(obj));
 }
+
+void intel_bo_panic_map(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	i915_gem_object_panic_map(to_intel_bo(obj), map);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_bo.h b/drivers/gpu/drm/i915/display/intel_bo.h
index ea7a2253aaa57..5b6c63d99786a 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.h
+++ b/drivers/gpu/drm/i915/display/intel_bo.h
@@ -23,5 +23,6 @@ struct intel_frontbuffer *intel_bo_set_frontbuffer(struct drm_gem_object *obj,
 						   struct intel_frontbuffer *front);
 
 void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj);
+void intel_bo_panic_map(struct drm_gem_object *obj, struct iosys_map *map);
 
 #endif /* __INTEL_BO__ */
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index a5f34542135ce..b16092707ea5a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -692,6 +692,8 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
+void i915_gem_object_panic_map(struct drm_i915_gem_object *obj, struct iosys_map *map);
+
 /**
  * i915_gem_object_pin_map - return a contiguous mapping of the entire object
  * @obj: the object to map into kernel address space
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8780aa2431053..718bea6474d7f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -355,6 +355,35 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	return vaddr ?: ERR_PTR(-ENOMEM);
 }
 
+/* Map the current framebuffer for CPU access. Called from panic handler, so no
+ * need to pin or cleanup.
+ */
+void i915_gem_object_panic_map(struct drm_i915_gem_object *obj, struct iosys_map *map)
+{
+	enum i915_map_type has_type;
+	void *ptr;
+
+	ptr = page_unpack_bits(obj->mm.mapping, &has_type);
+
+
+	if (!ptr) {
+		if (i915_gem_object_has_struct_page(obj))
+			ptr = i915_gem_object_map_page(obj, I915_MAP_WB);
+		else
+			ptr = i915_gem_object_map_pfn(obj, I915_MAP_WB);
+
+		if (IS_ERR(ptr))
+			return;
+
+		obj->mm.mapping = page_pack_bits(ptr, I915_MAP_WB);
+	}
+
+	if (i915_gem_object_has_iomem(obj))
+		iosys_map_set_vaddr_iomem(map, (void __iomem *) ptr);
+	else
+		iosys_map_set_vaddr(map, ptr);
+}
+
 /* get, pin, and map the pages of the object into kernel space */
 void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
 			      enum i915_map_type type)
diff --git a/drivers/gpu/drm/xe/display/intel_bo.c b/drivers/gpu/drm/xe/display/intel_bo.c
index b463f5bd4eed1..bde276bc896b1 100644
--- a/drivers/gpu/drm/xe/display/intel_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_bo.c
@@ -59,3 +59,13 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	/* FIXME */
 }
+
+void intel_bo_panic_map(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	struct xe_bo *bo = gem_to_xe_bo(obj);
+	int ret;
+
+	ret = ttm_bo_vmap(&bo->ttm, map);
+	if (ret)
+		iosys_map_clear(map);
+}
-- 
2.47.1


