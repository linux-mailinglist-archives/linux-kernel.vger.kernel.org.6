Return-Path: <linux-kernel+bounces-512814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5AA33E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CD93A51C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE02227E91;
	Thu, 13 Feb 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od0e3bRC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339E207641
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446017; cv=none; b=qNlAabAcE2xcYQMJc1zidgtGNIrRXBkO7g/DdJ0rB1wzy3sOCt2LTW1MAKJbNSAuPKK3c+nQwaMTiTh3mcL1qCm9ensJS2kTJ+2PnOBbrnqh8fnqjLrm2xuxY+2tZCKg+AejqF8lN/J92Qg/MWfxiIwlFcveKtnytGm5uCs+bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446017; c=relaxed/simple;
	bh=8HU40VzP7w3APpNnz8LfFtyqQBu1k8l7bJHMGTsnRU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQ4vM2z+o+U/Z4LyWMW9Xia7H+UmPPJ5sseKXJ3rYa9FK+4gsBcT2EAiL7zZvUBgnDPn8ISTlL4J9vfuh0TWckSFTzak1vlL0x+tYEkeTY7ROQnGp3oEMv8BdmgmEkfTbgwK7X1DioB6YDVqKLRy/rzNnFL1f1ce0lst351nIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Od0e3bRC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739446014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tl5LI0+FIqhluWKBWbRi36sKD2a6jwNqxCIOJBL/9uI=;
	b=Od0e3bRCkoVSkbgioY3IdNRyP1uT82CZwlWk8qJbxKYsR93S8fdvRy8KVygctKDr3MkBp4
	5sYmFplAoc7z0zeK98xUmDQ2OgtQW+Qa0mDUyJu13BtRnEeBX/7K6qwqNi4gKshlBWX5tc
	VabM6AbiLsXCZed7PscuaRNYmUU7HMo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-MaCDsvRiO2SIiuvC9_iAzA-1; Thu,
 13 Feb 2025 06:26:51 -0500
X-MC-Unique: MaCDsvRiO2SIiuvC9_iAzA-1
X-Mimecast-MFC-AGG-ID: MaCDsvRiO2SIiuvC9_iAzA_1739446010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25B7218EB2C9;
	Thu, 13 Feb 2025 11:26:50 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 537F0300018D;
	Thu, 13 Feb 2025 11:26:46 +0000 (UTC)
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
Subject: [PATCH v4 4/8] drm/i915/gem: Add i915_gem_object_panic_map()
Date: Thu, 13 Feb 2025 12:19:28 +0100
Message-ID: <20250213112620.1923927-5-jfalempe@redhat.com>
In-Reply-To: <20250213112620.1923927-1-jfalempe@redhat.com>
References: <20250213112620.1923927-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Prepare the work for drm_panic support. This is used to map the
current framebuffer, so the CPU can overwrite it with the panic
message.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_bo.c    | 10 +++++++++
 drivers/gpu/drm/i915/display/intel_bo.h    |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_pages.c  | 25 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/intel_bo.c      | 17 +++++++++++++++
 5 files changed, 56 insertions(+)

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
index bb713e096db28..a303d9696231a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -692,6 +692,8 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
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
index b463f5bd4eed1..7ebc60b23aec4 100644
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
@@ -59,3 +64,15 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	/* FIXME */
 }
+
+void *intel_bo_panic_map(struct drm_gem_object *obj)
+{
+	struct xe_bo *bo = gem_to_xe_bo(obj);
+	struct iosys_map map;
+	int ret;
+
+	ret = ttm_bo_vmap(&bo->ttm, &map);
+	if (ret)
+		return NULL;
+	return map.vaddr;
+}
-- 
2.47.1


