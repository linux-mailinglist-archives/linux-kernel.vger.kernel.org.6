Return-Path: <linux-kernel+bounces-425775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750D9DEAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF41B231AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3F198E61;
	Fri, 29 Nov 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVG/fQOs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199819D064
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897396; cv=none; b=fhaxfK6ySo+f2ufCJhx5Lnx1JdMmjhtRiFoVu3dv9ATvB9CxQ5SpaU4q5mFqDa1y+RBhkYdma+Qk9Syo7IZECWZykrdljHKDvoWfuTC0GW2Bqvmf3DRt9D+aHfF8OifB81UMMZigGEsJHsGMYwMaXjEX+rUTQHAVAdG821YPh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897396; c=relaxed/simple;
	bh=HMOYzCNeG947wnPToMGKG2MdOhqnOCue9seqXgpH2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaBLfL+4XexLojtNAqWe0Ta9VS/g66K8zwzRrIFvZ3aN4xfRqGhnlKUdOqT0SqvysAfASlSRDzqLNPyVIxCJpKJ87OXqQthdAgx5Xzui40rP/ChcomP9HKS2HcCkDezBCwbw2e4+o/pvWY2Jtr9MC8IEDY9rs9vctYdJsqjN+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVG/fQOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F93S9jON3uAswTWLAbKIhbx+FXZiIHrE6PHfT6a61ts=;
	b=ZVG/fQOs/1xF3eLgV1NWb4RvJWyM84LdJAsoenRwomYq8x+as8PlYyqT264YS/5MUuRNOK
	QywKm2XorKf7R8eIixdlgkQkGmglARfwMZ4xqJCFqCogwLOIndBYdVW4kb9jAiUyKChVMd
	6QDpq7BqSPEkpmBpHts4nfRrbmhY/JE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-Wc26PsTrN_yIOe25ipdCYw-1; Fri,
 29 Nov 2024 11:23:07 -0500
X-MC-Unique: Wc26PsTrN_yIOe25ipdCYw-1
X-Mimecast-MFC-AGG-ID: Wc26PsTrN_yIOe25ipdCYw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D958C195608C;
	Fri, 29 Nov 2024 16:23:05 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A60C01955F41;
	Fri, 29 Nov 2024 16:23:02 +0000 (UTC)
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
Subject: [PATCH 4/5] drm/i915/gem: export i915_gem_object_map_page/pfn
Date: Fri, 29 Nov 2024 17:20:29 +0100
Message-ID: <20241129162232.7594-5-jfalempe@redhat.com>
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

Prepare the work for drm_panic support. They are used to map the
current framebuffer, so the CPU can access it, and draws the panic
screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 5 +++++
 drivers/gpu/drm/i915/gem/i915_gem_pages.c  | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 3dc61cbd2e11f..3f99d021f9221 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -694,6 +694,11 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
+void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
+				      enum i915_map_type type);
+void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
+				     enum i915_map_type type);
+
 /**
  * i915_gem_object_pin_map - return a contiguous mapping of the entire object
  * @obj: the object to map into kernel address space
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8780aa2431053..76c023d2fbb1f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -268,7 +268,7 @@ int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj)
 }
 
 /* The 'mapping' part of i915_gem_object_pin_map() below */
-static void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
+void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
 				      enum i915_map_type type)
 {
 	unsigned long n_pages = obj->base.size >> PAGE_SHIFT, i;
@@ -325,7 +325,7 @@ static void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
 	return vaddr ?: ERR_PTR(-ENOMEM);
 }
 
-static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
+void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 				     enum i915_map_type type)
 {
 	resource_size_t iomap = obj->mm.region->iomap.base -
-- 
2.47.0


