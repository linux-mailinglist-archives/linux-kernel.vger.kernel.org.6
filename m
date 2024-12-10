Return-Path: <linux-kernel+bounces-439230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC79EAC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F411624F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5065212D8D;
	Tue, 10 Dec 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz91GMhp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2282212D76
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823393; cv=none; b=nidx24Lo0+RxxLhMTGXf7JSeGVBIP/ptzgu+MJ8P+Enx4SdlyQ0jPBaUFA/XZ8SASU6t79bgNnE0oR7Xy2tFodPgu24OrKcz+X9OyFxXBjTOlZAl6j73IXq5Ou/3Zughb+CmJNdTT0bszGNkynG0Uxi56U+5i7YOhdieA9ffEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823393; c=relaxed/simple;
	bh=6zpXY34m4D0hA4Pu7K+wki+eBvh0ZX+C5yagqkg2vB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhZ58VcMZKhuTaLxde077GxNXs71UG+oXOI1f/Bgo9ludHtPOhMUOSHuVZ5X33U2Lk/EtoNP81FWLTVLvzcrKs2d9cRhZEGlJ4MKhlqxeAOlPelqIW9sEM7W4prP1mg2/PLxf/G+xWx89SVM0Xls3dScUjExud983nZcaq9RqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qz91GMhp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8GEvw5QpbRp0f45cMt+HrV/NNA4rCDC5F+CWhNaj1U4=;
	b=Qz91GMhphIHGDw3tAVQmZFwWj7+DseJviEfoykAJTuY/NZEFaC0za7zKNexfymhILBsLWp
	jReTF/6YEgsvtZgStnodo85DQWvesuNCaCer06CPwPfGpjqyPfqL5TU+4U/49yYU3B+sy6
	WzWxSNEzyHYk7VVnVOelPszmhMzonHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-TP-uYSDmMgmG4UJdPcH1ZQ-1; Tue,
 10 Dec 2024 04:36:26 -0500
X-MC-Unique: TP-uYSDmMgmG4UJdPcH1ZQ-1
X-Mimecast-MFC-AGG-ID: TP-uYSDmMgmG4UJdPcH1ZQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38131195C258;
	Tue, 10 Dec 2024 09:36:24 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAF411956089;
	Tue, 10 Dec 2024 09:36:20 +0000 (UTC)
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
Subject: [RFC PATCH v3 0/6] drm/i915: Add drm_panic support
Date: Tue, 10 Dec 2024 10:28:40 +0100
Message-ID: <20241210093505.589893-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is a draft of drm_panic support for i915.

I've tested it on the 3 intel laptops I have at my disposal.
one Haswell with 128MB of eDRAM, one Cometlake and one Alderlake.

I tested panic in both fbdev console and gnome desktop.

Best regards,

v2:
 * Add the proper abstractions to build also for Xe.
 * Fix dim checkpatch issues.

v3:
 * Add support for Y-tiled framebuffer when DPT is enabled.

Jocelyn Falempe (6):
  drm/i915/fbdev: Add intel_fbdev_get_vaddr()
  drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
  drm/i915/display: Add a disable_tiling() for skl planes
  drm/i915/gem: Add i915_gem_object_panic_map()
  drm/i915: Add drm_panic support
  drm/i915: Add drm_panic support for Y-tiling with DPT

 drivers/gpu/drm/i915/display/i9xx_plane.c     |  23 +++
 .../gpu/drm/i915/display/intel_atomic_plane.c | 147 +++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_bo.c       |  10 ++
 drivers/gpu/drm/i915/display/intel_bo.h       |   2 +
 .../drm/i915/display/intel_display_types.h    |   2 +
 drivers/gpu/drm/i915/display/intel_fb_pin.c   |   5 +
 drivers/gpu/drm/i915/display/intel_fb_pin.h   |   1 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |   5 +
 drivers/gpu/drm/i915/display/intel_fbdev.h    |   6 +
 .../drm/i915/display/skl_universal_plane.c    |  27 ++++
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |   2 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  25 +++
 drivers/gpu/drm/i915/i915_vma.h               |   5 +
 drivers/gpu/drm/xe/display/intel_bo.c         |  11 ++
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |   5 +
 15 files changed, 275 insertions(+), 1 deletion(-)


base-commit: 919b1458ccfd33ead891fa4ad1e1d06016f5a20c
-- 
2.47.1


