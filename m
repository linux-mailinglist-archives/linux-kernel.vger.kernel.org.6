Return-Path: <linux-kernel+bounces-439234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BD9EAC97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C38316969C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DAA2153F3;
	Tue, 10 Dec 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8I6DDvO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4062153C7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823408; cv=none; b=MQcfLQeJvpnEsMXcwkKq4MIF5BO4ZxhSFnZT+h2aZhFiStB2g8+ikixXepfKbGJaaUh9a88YEGj5hDV/RFJ8o4MriyXARNzMYabzPbKVo0uZr1kf0mpuHxaMRDGJtfLchyvwi96amQFMP6/2U+36/Ix/H4v8QarwoTy62IUt8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823408; c=relaxed/simple;
	bh=ms5Uc8LAf++lWOaws/airjvViXaLv32BodTHXY4/0Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPA4QccDKgxJMzLzfa/4CRNa2MgHeCVdBJ8xGTJBSCdwXkNVrcZYJDbeLfpmkLY5hNyuTJ0wSYd3t0yExwPGUotkCMrvhadV/Xcdouzc4kmE6opdNQfsl+M8jTvITHNSRdX5aAv3jPLxvFmWLQJlXZayCHRWrLKLikSjVBX67l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8I6DDvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln7QmybwS+wJD0e1iridJGR/UG992shbcYyS2kThagY=;
	b=K8I6DDvOBo8oo10nu5Re9438Ci5lkhvjeqGy8pORQM4ru13rTktwbUaCL6CulhOVnPm3yC
	ccUMZ6uV7H8W4pp7nkdqStPXAka1xabn6L1Lr21HzxXA3ikHFqOluxBR0tYUicQCeFfjlr
	byLbdyo3ekw9sZgLQnGqOFBn5aguWRE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-vQ23K7rIMcGW4hzrIXJzUQ-1; Tue,
 10 Dec 2024 04:36:41 -0500
X-MC-Unique: vQ23K7rIMcGW4hzrIXJzUQ-1
X-Mimecast-MFC-AGG-ID: vQ23K7rIMcGW4hzrIXJzUQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECDB1955D5A;
	Tue, 10 Dec 2024 09:36:39 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2389C1956089;
	Tue, 10 Dec 2024 09:36:35 +0000 (UTC)
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
Subject: [PATCH v3 4/6] drm/i915/gem: Add i915_gem_object_panic_map()
Date: Tue, 10 Dec 2024 10:28:44 +0100
Message-ID: <20241210093505.589893-5-jfalempe@redhat.com>
In-Reply-To: <20241210093505.589893-1-jfalempe@redhat.com>
References: <20241210093505.589893-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Prepare the work for drm_panic support. This is used to map the
current framebuffer, so the CPU can overwrite it with the panic
message.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_bo.c    | 10 +++++++++
 drivers/gpu/drm/i915/display/intel_bo.h    |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_pages.c  | 25 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/intel_bo.c      | 11 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bo.c b/drivers/gpu/drm/i915/display/intel_bo.c
index fbd16d7b58d95..5eeb3ba827edf 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.c
+++ b/drivers/gpu/drm/i915/display/intel_bo.c
@@ -22,6 +22,11 @@ bool intel_bo_is_shmem(struct drm_gem_object *obj)
 	return i915_gem_object_is_shmem(to_intel_bo(obj));
 }
 
+bool intel_bo_has_iomem(struct drm_gem_object *obj)
+{
+	return i915_gem_object_has_iomem(to_intel_bo(obj));
+}
+
 bool intel_bo_is_protected(struct drm_gem_object *obj)
 {
 	return i915_gem_object_is_protected(to_intel_bo(obj));
@@ -57,3 +62,8 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	i915_debugfs_describe_obj(m, to_intel_bo(obj));
 }
+
+void *intel_bo_panic_map(struct drm_gem_object *obj)
+{
+	return i915_gem_object_panic_map(to_intel_bo(obj));
+}
diff --git a/drivers/gpu/drm/i915/display/intel_bo.h b/drivers/gpu/drm/i915/display/intel_bo.h
index ea7a2253aaa57..0eb084955e9af 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.h
+++ b/drivers/gpu/drm/i915/display/intel_bo.h
@@ -13,6 +13,7 @@ struct vm_area_struct;
 bool intel_bo_is_tiled(struct drm_gem_object *obj);
 bool intel_bo_is_userptr(struct drm_gem_object *obj);
 bool intel_bo_is_shmem(struct drm_gem_object *obj);
+bool intel_bo_has_iomem(struct drm_gem_object *obj);
 bool intel_bo_is_protected(struct drm_gem_object *obj);
 void intel_bo_flush_if_display(struct drm_gem_object *obj);
 int intel_bo_fb_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
@@ -23,5 +24,6 @@ struct intel_frontbuffer *intel_bo_set_frontbuffer(struct drm_gem_object *obj,
 						   struct intel_frontbuffer *front);
 
 void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj);
+void *intel_bo_panic_map(struct drm_gem_object *obj);
 
 #endif /* __INTEL_BO__ */
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 3dc61cbd2e11f..f85326a98aefc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -694,6 +694,8 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
+void *i915_gem_object_panic_map(struct drm_i915_gem_object *obj);
+
 /**
  * i915_gem_object_pin_map - return a contiguous mapping of the entire object
  * @obj: the object to map into kernel address space
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8780aa2431053..07c33169603c9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -355,6 +355,31 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	return vaddr ?: ERR_PTR(-ENOMEM);
 }
 
+/* Map the current framebuffer for CPU access. Called from panic handler, so no
+ * need to pin or cleanup.
+ */
+void *i915_gem_object_panic_map(struct drm_i915_gem_object *obj)
+{
+	enum i915_map_type has_type;
+	void *ptr;
+
+	ptr = page_unpack_bits(obj->mm.mapping, &has_type);
+
+	if (ptr)
+		return ptr;
+
+	if (i915_gem_object_has_struct_page(obj))
+		ptr = i915_gem_object_map_page(obj, I915_MAP_WB);
+	else
+		ptr = i915_gem_object_map_pfn(obj, I915_MAP_WB);
+
+	if (IS_ERR(ptr))
+		return NULL;
+
+	obj->mm.mapping = page_pack_bits(ptr, I915_MAP_WB);
+	return ptr;
+}
+
 /* get, pin, and map the pages of the object into kernel space */
 void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
 			      enum i915_map_type type)
diff --git a/drivers/gpu/drm/xe/display/intel_bo.c b/drivers/gpu/drm/xe/display/intel_bo.c
index 9f54fad0f1c0c..c05feeeec3806 100644
--- a/drivers/gpu/drm/xe/display/intel_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_bo.c
@@ -23,6 +23,11 @@ bool intel_bo_is_shmem(struct drm_gem_object *obj)
 	return false;
 }
 
+bool intel_bo_has_iomem(struct drm_gem_object *obj)
+{
+	return false;
+}
+
 bool intel_bo_is_protected(struct drm_gem_object *obj)
 {
 	return false;
@@ -82,3 +87,9 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	/* FIXME */
 }
+
+void *intel_bo_panic_map(struct drm_gem_object *obj)
+{
+	/* TODO: map the object so CPU can write the panic screen to it */
+	return NULL;
+}
-- 
2.47.1


